Received: from eggs.gnu.org ([2001:4830:134:3::10]:56266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzSt-0002W8-Nx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUzSq-0005Gm-GB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:51 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:34947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUzSq-0005FQ-0V
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:00:48 -0400
Received: by mail-wr0-f174.google.com with SMTP id k67so9435771wrc.2
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 11:00:47 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Jul 2017 18:59:36 +0100
Message-Id: <20170711175937.23140-6-alex.bennee@linaro.org>
In-Reply-To: <20170711175937.23140-1-alex.bennee@linaro.org>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 5/6] target/arm: use gen_goto_tb for ISB
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
therefor use a simple tb exit for ISB instructions and rely on the
exit_request check at the top of each TB to deal with exiting if
needed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 target/arm/translate.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 66139b6046..2ac565eb10 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1393,7 +1393,7 @@ static void handle_sync(DisasContext *s, uint32_t insn,
          * a self-modified code correctly and also to take
          * any pending interrupts immediately.
          */
-        s->is_jmp = DISAS_UPDATE;
+        gen_goto_tb(s, 0, s->pc);
         return;
     default:
         unallocated_encoding(s);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 82341ee709..dbf919cce3 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8169,7 +8169,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                  * self-modifying code correctly and also to take
                  * any pending interrupts immediately.
                  */
-                gen_lookup_tb(s);
+                gen_goto_tb(s, 0, s->pc & ~1);
                 return;
             default:
                 goto illegal_op;
@@ -10562,7 +10562,7 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                              * and also to take any pending interrupts
                              * immediately.
                              */
-                            gen_lookup_tb(s);
+                            gen_goto_tb(s, 0, s->pc & ~1);
                             break;
                         default:
                             goto illegal_op;
-- 
2.13.0
