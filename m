Received: from eggs.gnu.org ([2001:4830:134:3::10]:56928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiL-0004fL-C5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZpiK-0005nE-KZ
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:49 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZpiK-0005n6-GS
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:36:48 -0400
Received: by mail-qk0-x242.google.com with SMTP id q66so11589683qki.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 19:36:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 19:36:10 -0700
Message-Id: <20170725023611.9169-4-rth@twiddle.net>
In-Reply-To: <20170725023611.9169-1-rth@twiddle.net>
References: <20170725023611.9169-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 3/4] target/s390x: Use unwind info in STSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/misc_helper.c | 3 ++-
 target/s390x/translate.c   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index 376dbd68c2..ab8551f605 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -388,7 +388,8 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
     if ((r0 & STSI_LEVEL_MASK) <= STSI_LEVEL_3 &&
         ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK))) {
         /* valid function code, invalid reserved bits */
-        program_interrupt(env, PGM_SPECIFICATION, 2);
+        cpu_restore_state(ENV_GET_CPU(env), GETPC());
+        program_interrupt(env, PGM_SPECIFICATION, ILEN_UNWIND);
     }
 
     sel1 = r0 & STSI_R0_SEL1_MASK;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 9b0c35efa2..57f09154be 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3988,7 +3988,6 @@ static ExitStatus op_stpt(DisasContext *s, DisasOps *o)
 static ExitStatus op_stsi(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    potential_page_fault(s);
     gen_helper_stsi(cc_op, cpu_env, o->in2, regs[0], regs[1]);
     set_cc_static(s);
     return NO_EXIT;
-- 
2.13.3
