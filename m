Received: from eggs.gnu.org ([2001:4830:134:3::10]:48537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVeyr-00053E-I1
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVeyq-0007Bn-DN
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:37 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVeyq-0007AV-6U
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:36 -0400
Received: by mail-wr0-f179.google.com with SMTP id r103so53943315wrb.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:20:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 13 Jul 2017 15:19:26 +0100
Message-Id: <20170713141928.25419-5-alex.bennee@linaro.org>
In-Reply-To: <20170713141928.25419-1-alex.bennee@linaro.org>
References: <20170713141928.25419-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 4/6] target/arm/translate: ensure
 gen_goto_tb sets exit flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As the gen_goto_tb function can do both static and dynamic jumps it
should also set the is_jmp field. This matches the behaviour of the
a64 code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>

--
v4
  - set s->is_jmp = DISAS_TB_JUMP in both cases
---
 target/arm/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5f2cea8641..493a7b424a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4158,6 +4158,9 @@ static void gen_goto_ptr(void)
     tcg_temp_free(addr);
 }
 
+/* This will end the TB but doesn't guarantee we'll return to
+ * cpu_loop_exec. Any live exit_requests will be processed as we
+ * enter the next TB. */
 static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
 {
     if (use_goto_tb(s, dest)) {
@@ -4168,6 +4171,7 @@ static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
         gen_set_pc_im(s, dest);
         gen_goto_ptr();
     }
+    s->is_jmp = DISAS_TB_JUMP;
 }
 
 static inline void gen_jmp (DisasContext *s, uint32_t dest)
@@ -4179,7 +4183,6 @@ static inline void gen_jmp (DisasContext *s, uint32_t dest)
         gen_bx_im(s, dest);
     } else {
         gen_goto_tb(s, 0, dest);
-        s->is_jmp = DISAS_TB_JUMP;
     }
 }
 
-- 
2.13.0
