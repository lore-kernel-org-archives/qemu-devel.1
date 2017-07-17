Received: from eggs.gnu.org ([2001:4830:134:3::10]:59144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Of-0007vp-RI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oe-0002J7-VI
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Oe-0002Ci-Op
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OU-0003Td-Lr
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:44:58 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:43 +0100
Message-Id: <1500295494-8991-8-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/18] target/arm/translate: ensure gen_goto_tb
 sets exit flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

As the gen_goto_tb function can do both static and dynamic jumps it
should also set the is_jmp field. This matches the behaviour of the
a64 code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-id: 20170713141928.25419-5-alex.bennee@linaro.org
[tweak to multiline comment formatting]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5f2cea8..bbae519 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4158,6 +4158,10 @@ static void gen_goto_ptr(void)
     tcg_temp_free(addr);
 }
 
+/* This will end the TB but doesn't guarantee we'll return to
+ * cpu_loop_exec. Any live exit_requests will be processed as we
+ * enter the next TB.
+ */
 static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
 {
     if (use_goto_tb(s, dest)) {
@@ -4168,6 +4172,7 @@ static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
         gen_set_pc_im(s, dest);
         gen_goto_ptr();
     }
+    s->is_jmp = DISAS_TB_JUMP;
 }
 
 static inline void gen_jmp (DisasContext *s, uint32_t dest)
@@ -4179,7 +4184,6 @@ static inline void gen_jmp (DisasContext *s, uint32_t dest)
         gen_bx_im(s, dest);
     } else {
         gen_goto_tb(s, 0, dest);
-        s->is_jmp = DISAS_TB_JUMP;
     }
 }
 
-- 
2.7.4
