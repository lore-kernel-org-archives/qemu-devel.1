Received: from eggs.gnu.org ([2001:4830:134:3::10]:41596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUeGV-00089W-K8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUeGS-00077y-G8
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:22:39 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUeGS-00077S-9i
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 15:22:36 -0400
Received: by mail-wr0-f180.google.com with SMTP id r103so151965621wrb.0
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 12:22:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Jul 2017 20:21:27 +0100
Message-Id: <20170710192128.9048-5-alex.bennee@linaro.org>
In-Reply-To: <20170710192128.9048-1-alex.bennee@linaro.org>
References: <20170710192128.9048-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/5] target/arm: use DISAS_JUMP for ISB
 handling
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

While an ISB will ensure any raised IRQs happen on the next
instruction it doesn't cause any to get raised by itself. We can
therefor use DISAS_JUMP for ISB instructions and rely on the
exit_request check at the top of each TB to deal with exiting if
needed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c |  3 ++-
 target/arm/translate.c     | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 66139b6046..ad46d84efb 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1393,7 +1393,8 @@ static void handle_sync(DisasContext *s, uint32_t insn,
          * a self-modified code correctly and also to take
          * any pending interrupts immediately.
          */
-        s->is_jmp = DISAS_UPDATE;
+        gen_a64_set_pc_im(s->pc);
+        s->is_jmp = DISAS_JUMP;
         return;
     default:
         unallocated_encoding(s);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ccc4768b2e..94aa4bbb4d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1201,6 +1201,15 @@ static inline void gen_lookup_tb(DisasContext *s)
     s->is_jmp = DISAS_EXIT;
 }
 
+/* End the current block and force a TB lookup. We may chain to the
+ * next TB but exit_req will be immediately checked so we will exit to
+ * the main loop if we need to */
+static inline void gen_jump_tb(DisasContext *s)
+{
+    tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
+    s->is_jmp = DISAS_JUMP;
+}
+
 static inline void gen_hlt(DisasContext *s, int imm)
 {
     /* HLT. This has two purposes.
@@ -8165,7 +8174,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * self-modifying code correctly and also to take
                  * any pending interrupts immediately.
                  */
-                gen_lookup_tb(s);
+                gen_jump_tb(s);
                 return;
             default:
                 goto illegal_op;
@@ -10558,7 +10567,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                              * and also to take any pending interrupts
                              * immediately.
                              */
-                            gen_lookup_tb(s);
+                            gen_jump_tb(s);
                             break;
                         default:
                             goto illegal_op;
-- 
2.13.0
