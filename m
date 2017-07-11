Received: from eggs.gnu.org ([2001:4830:134:3::10]:56237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzSr-0002Ud-Nh
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzSo-0005F1-Fp
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:49 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUzSo-0005E6-43
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:46 -0400
Received: by mail-wr0-f180.google.com with SMTP id 77so9557709wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:00:45 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Jul 2017 18:59:35 +0100
Message-Id: <20170711175937.23140-5-alex.bennee@linaro.org>
In-Reply-To: <20170711175937.23140-1-alex.bennee@linaro.org>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/6] target/arm/translate: ensure
 gen_goto_tb sets exit flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

As the gen_goto_tb function can do both static and dynamic jumps it
should also set the is_jmp field. This matches the behaviour of the
a64 code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5f2cea8641..82341ee709 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4158,15 +4158,20 @@ static void gen_goto_ptr(void)
     tcg_temp_free(addr);
 }
 
+/* This will end the TB but doesn't guarantee we'll return to
+ * cpu_loop_exec. Any live exit_requests will be processed as we
+ * enter the next TB. */
 static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
 {
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         gen_set_pc_im(s, dest);
         tcg_gen_exit_tb((uintptr_t)s->tb + n);
+        s->is_jmp = DISAS_TB_JUMP;
     } else {
         gen_set_pc_im(s, dest);
         gen_goto_ptr();
+        s->is_jmp = DISAS_JUMP;
     }
 }
 
@@ -4179,7 +4184,6 @@ static inline void gen_jmp (DisasContext *s, uint32_t dest)
         gen_bx_im(s, dest);
     } else {
         gen_goto_tb(s, 0, dest);
-        s->is_jmp = DISAS_TB_JUMP;
     }
 }
 
-- 
2.13.0
