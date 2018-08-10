Received: from eggs.gnu.org ([2001:4830:134:3::10]:57717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1foEhG-0007co-Fq
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 17:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1foEhB-0002Is-GF
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 17:11:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:38092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1foEhB-0002EH-95
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 17:11:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1foEh9-00071M-EB
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 21:11:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 08AFD2E853B
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 21:11:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Aug 2018 21:03:15 -0000
From: Laurent Vivier <Laurent@vivier.eu>
Reply-To: Bug 1768246 <1768246@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152518111080.22177.382728353135880212.malonedeb@soybean.canonical.com>
Message-Id: <153393499510.28594.9855360846904633490.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1768246] Re: cpu-exec.c:648: cpu_loop_exec_tb:
 Assertion `use_icount' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This change seems to fix the problem:

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 1b9a201d6d..5010b0d349 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -253,7 +253,6 @@ static void gen_goto_tb(DisasContext *ctx, int n, targe=
t_ulong dest)
             tcg_gen_lookup_and_goto_ptr();
         }
     }
-    ctx->base.is_jmp =3D DISAS_NORETURN;
 }
 =

 static void gen_jump(DisasContext * ctx)
@@ -324,7 +323,6 @@ static void gen_delayed_conditional_jump(DisasContext *=
 ctx)
         gen_jump(ctx);
 =

         gen_set_label(l1);
-        ctx->base.is_jmp =3D DISAS_NEXT;
         return;
     }
 =

@@ -1877,6 +1875,7 @@ static void decode_opc(DisasContext * ctx)
         ctx->envflags &=3D ~GUSA_MASK;
 =

         tcg_gen_movi_i32(cpu_flags, ctx->envflags);
+        ctx->base.is_jmp =3D DISAS_NORETURN;
         if (old_flags & DELAY_SLOT_CONDITIONAL) {
            gen_delayed_conditional_jump(ctx);
         } else {

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1768246

Title:
  cpu-exec.c:648: cpu_loop_exec_tb: Assertion `use_icount' failed.

Status in QEMU:
  New

Bug description:
  OpenJDK no longer works on qemu-sh4, it previously did after #1735384
  was fixed.

  Crash indicates an assertion failure:

  (sid-sh4-sbuild)root@nofan:/# java --version
  qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:648: cpu_loop_exec_tb: A=
ssertion `use_icount' failed.
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted
  (sid-sh4-sbuild)root@nofan:/#

  Haven't bi-sected the issue yet, but will do so later.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1768246/+subscriptions
