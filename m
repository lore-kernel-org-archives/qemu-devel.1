Received: from eggs.gnu.org ([209.51.188.92]:47918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gxzZz-0008Rm-To
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:36:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gxzZt-00016M-QF
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:36:48 -0500
Received: from mail-it1-x131.google.com ([2607:f8b0:4864:20::131]:36811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gxzZr-0000bN-HW
	for qemu-devel@nongnu.org; Sun, 24 Feb 2019 14:36:44 -0500
Received: by mail-it1-x131.google.com with SMTP id h6so10407504itl.1
	for <qemu-devel@nongnu.org>; Sun, 24 Feb 2019 11:36:13 -0800 (PST)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	u135sm513013ita.1.2019.02.24.11.36.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 24 Feb 2019 11:36:12 -0800 (PST)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <5F2C0013-1D18-44A9-ADAF-F86EC6FD1174@oberlin.edu>
Date: Sun, 24 Feb 2019 14:36:10 -0500
Subject: [Qemu-devel] x86 segment limits enforcement with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

Sorry for the long email. The TL;DR is I'm trying to add x86 segment =
limit checks in TCG and my added code is causing qemu to abort during =
code generation because some registers have become dead.

I have some x86 firmware that refuses to boot unless a variety of x86 =
security mechanisms are enforced. In particular, it checks that the =
general protection fault handler runs if an access to memory is greater =
than a segment limit: it configures a segment with a limit of 3, sets ds =
to the corresponding selector and then tries to load 4 bytes from =
address 3.

I looked through target/i386/translate.c and it looks like in most =
(all?) cases, gen_lea_v_seg is used, either directly or indirectly, to =
compute a linear address by adding the base address of the segment. I =
attempted to modify this to check the segment limit and raise a general =
protection fault if the base address plus the size of the access is =
greater than the limit. The full diff is below, but the main change adds =
this.

        if (s->pe && !CODE64(s)) {
            /*
             * Check that the access is within the segment limit in =
protected
             * mode.
             */
            TCGLabel *label =3D gen_new_label();
            int access_limit =3D (1 << (aflag & MO_SIZE)) - 1;
            tcg_gen_mov_tl(s->A1, a0);
            if (access_limit > 0) {
                tcg_gen_addi_tl(s->A1, s->A1, access_limit);
            }
            tcg_gen_brcond_tl(TCG_COND_LE, s->A1, limit, label);
            gen_exception(s, EXCP0D_GPF, s->pc_start - s->cs_base);
            gen_set_label(label);
        }

With this change, qemu aborts when trying to run tests/pxe-test. I ran =
the test in lldb and it's aborting in the TCG generation (full stack =
trace below).

frame #3: 0x000000010001eac4 =
qemu-system-i386`temp_load(s=3D0x0000000105062600, =
ts=3D0x0000000105063170, desired_regs=3D65535, allocated_regs=3D48, =
preferred_regs=3D0) at tcg.c:3211
   3208         break;
   3209     case TEMP_VAL_DEAD:
   3210     default:
-> 3211         tcg_abort();
   3212     }
   3213     ts->reg =3D reg;
   3214     ts->val_type =3D TEMP_VAL_REG;

because ts->value_type is TEMP_VAL_DEAD.

I tried removing everything except for the tcg_gen_brcond_tl (using a0, =
rather than s->A1) and the gen_set_label and I have the same behavior. =
The operation it aborts on is

(lldb) p *op
(TCGOp) $0 =3D {
  opc =3D INDEX_op_add_i32
  param1 =3D 0
  param2 =3D 0
  life =3D 24
  link =3D {
    tqe_next =3D 0x0000000105055c30
    tqe_circ =3D {
      tql_next =3D 0x0000000105055c30
      tql_prev =3D 0x0000000105055b48
    }
  }
  args =3D ([0] =3D 4378961264, [1] =3D 4378961264, [2] =3D 4378960256, =
[3] =3D 18446744073709486096, [4] =3D 281470681808641, [5] =3D =
4378961880, [6] =3D 4378961880, [7] =3D 0, [8] =3D 18446744069414649855, =
[9] =3D 5, [10] =3D 4379204752)
  output_pref =3D ([0] =3D 65343, [1] =3D 1)
}

which I think is coming from the add for the segment base. Changing the =
condition to TCG_COND_ALWAYS breaks elsewhere.=20

I think that something about adding the tcg_gen_brcond_tl is causing =
values to become dead and then qemu aborts.

My questions are
1. Is this the right place to add segment limit checks? (I guess I don't =
need to check every memory access; catching the majority of them is =
likely fine.)

2. Am I using tcg_gen_brcond_tl (or any of the other TCG functions) =
incorrectly?

3. Is there a way I can see the generated TCG for this test? I've been =
running lldb using
$ QTEST_QEMU_BINARY=3D'tmux split-window lldb -- =
i386-softmmu/qemu-system-i386' QTEST_QEMU_IMG=3Dqemu-img tests/pxe-test =
-m=3Dquick -k --tap
but when I try to add additional options like -d op, the test harness =
aborts: qemu/tests/boot-sector.c:119:boot_sector_init: code should not =
be reached

Any assistance is very much appreciated.

Thank you,

Steve

Stack trace:
  * frame #0: 0x00007fff6b45323e libsystem_kernel.dylib`__pthread_kill + =
10
    frame #1: 0x00007fff6b509c1c libsystem_pthread.dylib`pthread_kill + =
285
    frame #2: 0x00007fff6b3bc1c9 libsystem_c.dylib`abort + 127
    frame #3: 0x000000010001eac4 =
qemu-system-i386`temp_load(s=3D0x0000000105062600, =
ts=3D0x0000000105063170, desired_regs=3D65535, allocated_regs=3D48, =
preferred_regs=3D0) at tcg.c:3211
    frame #4: 0x000000010001af09 =
qemu-system-i386`tcg_reg_alloc_op(s=3D0x0000000105062600, =
op=3D0x0000000104a78300) at tcg.c:3458
    frame #5: 0x00000001000176f2 =
qemu-system-i386`tcg_gen_code(s=3D0x0000000105062600, =
tb=3D0x00000001058f93c0) at tcg.c:3981
    frame #6: 0x00000001000d3972 =
qemu-system-i386`tb_gen_code(cpu=3D0x0000000105043c00, pc=3D787953, =
cs_base=3D786432, flags=3D192, cflags=3D-16252928) at =
translate-all.c:1751
    frame #7: 0x00000001000d1696 =
qemu-system-i386`tb_find(cpu=3D0x0000000105043c00, =
last_tb=3D0x0000000000000000, tb_exit=3D0, cf_mask=3D524288) at =
cpu-exec.c:407
    frame #8: 0x00000001000d0dc1 =
qemu-system-i386`cpu_exec(cpu=3D0x0000000105043c00) at cpu-exec.c:728
    frame #9: 0x000000010006bbf1 =
qemu-system-i386`tcg_cpu_exec(cpu=3D0x0000000105043c00) at cpus.c:1429
    frame #10: 0x000000010006b4b7 =
qemu-system-i386`qemu_tcg_cpu_thread_fn(arg=3D0x0000000105043c00) at =
cpus.c:1733
    frame #11: 0x00000001006223ec =
qemu-system-i386`qemu_thread_start(args=3D0x0000000103d0e770) at =
qemu-thread-posix.c:502
    frame #12: 0x00007fff6b507305 libsystem_pthread.dylib`_pthread_body =
+ 126
    frame #13: 0x00007fff6b50a26f libsystem_pthread.dylib`_pthread_start =
+ 70
    frame #14: 0x00007fff6b506415 libsystem_pthread.dylib`thread_start + =
13

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 49cd298374..6f3682a268 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -76,6 +76,7 @@ static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2;
 static TCGv_i32 cpu_cc_op;
 static TCGv cpu_regs[CPU_NB_REGS];
 static TCGv cpu_seg_base[6];
+static TCGv cpu_seg_limit[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];

@@ -130,6 +131,7 @@ typedef struct DisasContext {
     /* TCG local temps */
     TCGv cc_srcT;
     TCGv A0;
+    TCGv A1;
     TCGv T0;
     TCGv T1;

@@ -448,6 +450,8 @@ static inline void gen_jmp_im(DisasContext *s, =
target_ulong pc)
     gen_op_jmp_v(s->tmp0);
 }

+static void gen_exception(DisasContext *s, int trapno, target_ulong =
cur_eip);
+
 /* Compute SEG:REG into A0.  SEG is selected from the override segment
    (OVR_SEG) and the default segment (DEF_SEG).  OVR_SEG may be -1 to
    indicate no override.  */
@@ -491,6 +495,23 @@ static void gen_lea_v_seg(DisasContext *s, TCGMemOp =
aflag, TCGv a0,

     if (ovr_seg >=3D 0) {
         TCGv seg =3D cpu_seg_base[ovr_seg];
+        TCGv limit =3D cpu_seg_limit[ovr_seg];
+
+        if (s->pe && !CODE64(s)) {
+            /*
+             * Check that the access is within the segment limit in =
protected
+             * mode.
+             */
+            TCGLabel *label =3D gen_new_label();
+            int access_limit =3D (1 << (aflag & MO_SIZE)) - 1;
+            tcg_gen_mov_tl(s->A1, a0);
+            if (access_limit > 0) {
+                tcg_gen_addi_tl(s->A1, s->A1, access_limit);
+            }
+            tcg_gen_brcond_tl(TCG_COND_LE, s->A1, limit, label);
+            gen_exception(s, EXCP0D_GPF, s->pc_start - s->cs_base);
+            gen_set_label(label);
+        }

         if (aflag =3D=3D MO_64) {
             tcg_gen_add_tl(s->A0, a0, seg);
@@ -8382,6 +8403,14 @@ void tcg_x86_init(void)
         [R_GS] =3D "gs_base",
         [R_SS] =3D "ss_base",
     };
+    static const char seg_limit_names[6][9] =3D {
+        [R_CS] =3D "cs_limit",
+        [R_DS] =3D "ds_limit",
+        [R_ES] =3D "es_limit",
+        [R_FS] =3D "fs_limit",
+        [R_GS] =3D "gs_limit",
+        [R_SS] =3D "ss_limit",
+    };
     static const char bnd_regl_names[4][8] =3D {
         "bnd0_lb", "bnd1_lb", "bnd2_lb", "bnd3_lb"
     };
@@ -8410,6 +8439,10 @@ void tcg_x86_init(void)
             =3D tcg_global_mem_new(cpu_env,
                                  offsetof(CPUX86State, segs[i].base),
                                  seg_base_names[i]);
+        cpu_seg_limit[i]
+            =3D tcg_global_mem_new(cpu_env,
+                                 offsetof(CPUX86State, segs[i].limit),
+                                 seg_limit_names[i]);
     }

     for (i =3D 0; i < 4; ++i) {
@@ -8482,6 +8515,7 @@ static void =
i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->T0 =3D tcg_temp_new();
     dc->T1 =3D tcg_temp_new();
     dc->A0 =3D tcg_temp_new();
+    dc->A1 =3D tcg_temp_new();

     dc->tmp0 =3D tcg_temp_new();
     dc->tmp1_i64 =3D tcg_temp_new_i64();

--=20
Stephen Checkoway
