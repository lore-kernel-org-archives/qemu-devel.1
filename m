Received: from eggs.gnu.org ([2001:4830:134:3::10]:49136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckamp-0006Ie-99
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 13:21:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckamm-0001BU-1c
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 13:21:39 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:51700)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1ckaml-0001AI-MN
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 13:21:35 -0500
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <7005a482-2372-0aaf-eb8b-60cd0a16b002@genode-labs.com>
Date: Sun, 5 Mar 2017 19:21:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] =?utf-8?q?=5BPATCH=C2=B1_SVM_I/O_permission_bitmap_f?=
 =?utf-8?q?or_user-level_=28ring-3=29_code_ignored?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, ehabkost@redhat.com

Hello,

the SVM I/O permission bitmap for user-level (ring-3) VM code running in
SVM seems to be ignored and causes a GP-fault. (Actual the IO permission
was granted by the kernel via the TSS I/O port permission bitmap).

After some debugging the GP code originates from target/i386/translate.c
gen_check_io() within the if(s->pe && (s->cpl > s->iopl || s->vm86))
condition. However, the actual SVM IO permission bitmap is checked after
that condition, which succeeds and would permit the access.

When I exchange the order, first executing the if(s->flags &
HF_SVMI_MASK) block and later on executing the if (s->pe && (s->cpl >
s->iopl || s->vm86)) block my use-case succeeds.

Please check and consider the patch for addition. The patch is based on
17783ac828adc694d986698d2d7014aedfeb48c6 qemu master.

Thanks,

--=20
Alexander Boettcher
Genode Labs

http://www.genode-labs.com - http://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth


qemu-system-x86_64 -s -no-kvm -display sdl -m 512 -cpu phenom -nographic
-cdrom ...

...
[init -> log_terminal] NOVA Microhypervisor v7-2436fe2 (x86_32): Feb 25
2017 17:58:48 [gcc 4.9.2]
[init -> log_terminal] [ 0] CORE:0:0:0 10:2:3:0 [0] AMD Phenom(tm) 9550
Quad-Core Processor
[init -> log_terminal] [ 0] Killed EC:0xc002c160 SC:0xc002d100 V:0xd
CS:0x1b EIP:0x14455e CR2:0xe0004004 ERR:0x0 (PT not found) Pd::root




>From 4a66a5f21085625c770e53cef4968607b897e432 Mon Sep 17 00:00:00 2001
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Date: Sun, 5 Mar 2017 18:55:32 +0100
Subject: [PATCH] svm: check io permission bitmap in VMCB first

Signed-off-by: Alexander Boettcher <alexander.boettcher@genode-labs.com>
---
 target/i386/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 72c1b03..b59ca3b 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -606,6 +606,16 @@ static void gen_check_io(DisasContext *s, TCGMemOp
ot, target_ulong cur_eip,
 {
     target_ulong next_eip;

+    if(s->flags & HF_SVMI_MASK) {
+        gen_update_cc_op(s);
+        gen_jmp_im(cur_eip);
+        svm_flags |=3D (1 << (4 + ot));
+        next_eip =3D s->pc - s->cs_base;
+        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
+        gen_helper_svm_check_io(cpu_env, cpu_tmp2_i32,
+                                tcg_const_i32(svm_flags),
+                                tcg_const_i32(next_eip - cur_eip));
+    }
     if (s->pe && (s->cpl > s->iopl || s->vm86)) {
         tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
         switch (ot) {
@@ -622,16 +632,6 @@ static void gen_check_io(DisasContext *s, TCGMemOp
ot, target_ulong cur_eip,
             tcg_abort();
         }
     }
-    if(s->flags & HF_SVMI_MASK) {
-        gen_update_cc_op(s);
-        gen_jmp_im(cur_eip);
-        svm_flags |=3D (1 << (4 + ot));
-        next_eip =3D s->pc - s->cs_base;
-        tcg_gen_trunc_tl_i32(cpu_tmp2_i32, cpu_T0);
-        gen_helper_svm_check_io(cpu_env, cpu_tmp2_i32,
-                                tcg_const_i32(svm_flags),
-                                tcg_const_i32(next_eip - cur_eip));
-    }
 }

 static inline void gen_movs(DisasContext *s, TCGMemOp ot)
--=20
2.7.4
