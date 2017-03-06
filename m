Received: from eggs.gnu.org ([2001:4830:134:3::10]:37366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckvxn-0007XG-K6
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckvxj-0004Ti-Mp
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:58:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ckvxj-0004TP-Dg
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:58:19 -0500
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
	<87r32bif49.fsf@linaro.org>
	<09728335-6fd7-b332-0d86-91c0ded71d90@twiddle.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2065d7a-c22f-2e61-3200-60f266610193@redhat.com>
Date: Mon, 6 Mar 2017 17:58:15 +0100
MIME-Version: 1.0
In-Reply-To: <09728335-6fd7-b332-0d86-91c0ded71d90@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: qemu-devel@nongnu.org, fred.konrad@greensocs.com, crosthwaite.peter@gmail.com



On 06/03/2017 02:34, Richard Henderson wrote:
> On 03/06/2017 08:32 AM, Alex Benn=C3=A9e wrote:
>>> #5  0x000000000046ea2e in tlb_flush (cpu=3D0x164a360) at
>>> qemu.git/cputlb.c:121
>>> #6  0x0000000000538987 in cpu_x86_update_cr4 (env=3D0x16525f0,
>>> new_cr4=3D1784)
>>>     at qemu.git/target/i386/helper.c:660
>>> #7  0x000000000055e318 in cpu_vmexit (env=3D0x16525f0, exit_code=3D78=
,
>>> exit_info_1=3D4, retaddr=3D0)
>>>     at qemu.git/target/i386/svm_helper.c:689
>>> #8  0x000000000055d9b7 in cpu_svm_check_intercept_param (env=3D0x1652=
5f0,
>>> type=3D78, param=3D4, retaddr=3D0)
>>>     at qemu.git/target/i386/svm_helper.c:511
>>> #9  0x0000000000541acf in raise_interrupt2 (env=3D0x16525f0, intno=3D=
14,
>>> is_int=3D0, error_code=3D4, next_eip_addend=3D0, retaddr=3D0)
>>>     at qemu.git/target/i386/excp_helper.c:96
>>> #10 0x0000000000541c0d in raise_exception_err_ra (env=3D0x16525f0,
>>> exception_index=3D14, error_code=3D4, retaddr=3D0)
>>>     at qemu.git/target/i386/excp_helper.c:127
>>> #11 0x00000000005621a9 in tlb_fill (cs=3D0x164a360, addr=3D1245184,
>>> access_type=3DMMU_INST_FETCH, mmu_idx=3D1, retaddr=3D0)
>>>     at qemu.git/target/i386/mem_helper.c:212
>> Richard,
>>
>> So this looks like another path through the SoftMMU code during
>> code-generation (which is why tb_lock() is held in the first place). I=
'm
>> not sure if the correct thing to do is bug out earlier or to defer the
>> exception raising part to async work and exit the loop.
>=20
> My guess is that everything from cpu_svm_check_intercept_param on shoul=
d
> be done from do_interrupt instead of during raise_interrupt.

>From cpu_svm_check_intercept_param, or from cpu_vmexit?  The former seems
to be too early because it will usually not even do anything, but treatin=
g
cpu_vmexit like an exception is a very good idea indeed.  This is my
uncompiled take.

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 12a39d5..ef319cc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -694,6 +694,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
=20
 #define EXCP_SYSCALL    0x100 /* only happens in user only emulation
                                  for syscall instruction */
+#define EXCP_VMEXIT     0x100
=20
 /* i386-specific interrupt pending bits.  */
 #define CPU_INTERRUPT_POLL      CPU_INTERRUPT_TGT_EXT_1
@@ -1626,6 +1627,7 @@ void cpu_svm_check_intercept_param(CPUX86State *env=
1, uint32_t type,
                                    uint64_t param, uintptr_t retaddr);
 void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_inf=
o_1,
                 uintptr_t retaddr);
+void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64 exit_info_1)=
;
=20
 /* seg_helper.c */
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw);
diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
index 5c845dc..0374031 100644
--- a/target/i386/seg_helper.c
+++ b/target/i386/seg_helper.c
@@ -1297,15 +1297,17 @@ void x86_cpu_do_interrupt(CPUState *cs)
     /* successfully delivered */
     env->old_exception =3D -1;
 #else
-    /* simulate a real cpu exception. On i386, it can
-       trigger new exceptions, but we do not handle
-       double or triple faults yet. */
-    do_interrupt_all(cpu, cs->exception_index,
-                     env->exception_is_int,
-                     env->error_code,
-                     env->exception_next_eip, 0);
-    /* successfully delivered */
-    env->old_exception =3D -1;
+    if (cs->exception_index >=3D EXCP_VMEXIT) {
+        assert(env->old_exception =3D=3D -1);
+        do_vmexit(env, cs->exception_index - EXCP_VMEXIT, env->error_cod=
e);
+    } else {
+        do_interrupt_all(cpu, cs->exception_index,
+                         env->exception_is_int,
+                         env->error_code,
+                         env->exception_next_eip, 0);
+        /* successfully delivered */
+        env->old_exception =3D -1;
+    }
 #endif
 }
=20
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 78d8df4..b49cd6d 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -580,12 +580,10 @@ void helper_svm_check_io(CPUX86State *env, uint32_t=
 port, uint32_t param,
     }
 }
=20
-/* Note: currently only 32 bits of exit_code are used */
 void cpu_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info=
_1,
                 uintptr_t retaddr)
 {
     CPUState *cs =3D CPU(x86_env_get_cpu(env));
-    uint32_t int_ctl;
=20
     if (retaddr) {
         cpu_restore_state(cs, retaddr);
@@ -598,6 +596,19 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code=
, uint64_t exit_info_1,
                                                    control.exit_info_2))=
,
                   env->eip);
=20
+    cs->exception_index =3D EXCP_VMEXIT + exit_code;
+    env->error_code =3D exit_info_1;
+
+    /* remove any pending exception */
+    env->old_exception =3D -1;
+    cpu_loop_exit(cs);
+}
+
+void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64 exit_info_1)
+{
+    CPUState *cs =3D CPU(x86_env_get_cpu(env));
+    uint32_t int_ctl;
+
     if (env->hflags & HF_INHIBIT_IRQ_MASK) {
         x86_stl_phys(cs,
                  env->vm_vmcb + offsetof(struct vmcb, control.int_state)=
,
@@ -759,13 +770,6 @@ void cpu_vmexit(CPUX86State *env, uint32_t exit_code=
, uint64_t exit_info_1,
     /* If the host's rIP reloaded by #VMEXIT is outside the limit of the
        host's code segment or non-canonical (in the case of long mode), =
a
        #GP fault is delivered inside the host. */
-
-    /* remove any pending exception */
-    cs->exception_index =3D -1;
-    env->error_code =3D 0;
-    env->old_exception =3D -1;
-
-    cpu_loop_exit(cs);
 }
=20
 #endif
