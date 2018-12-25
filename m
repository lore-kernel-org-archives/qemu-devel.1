Received: from eggs.gnu.org ([208.118.235.92]:50922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbto7-0000Bk-KQ
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbto4-00020T-G3
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:07 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:40559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbto4-0001ze-AH
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 16:00:04 -0500
Received: by mail-pl1-x635.google.com with SMTP id u18so6803614plq.7
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 13:00:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 26 Dec 2018 07:55:26 +1100
Message-Id: <20181225205529.10874-40-richard.henderson@linaro.org>
In-Reply-To: <20181225205529.10874-1-richard.henderson@linaro.org>
References: <20181225205529.10874-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 39/42] tcg: Split out more subroutines from
 liveness_pass_1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 0afc6ba1e6..4f0acf8863 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2395,6 +2395,26 @@ static void la_bb_end(TCGContext *s, int ng, int nt)
     }
 }
 
+/* liveness analysis: sync globals back to memory.  */
+static void la_global_sync(TCGContext *s, int ng)
+{
+    int i;
+
+    for (i = 0; i < ng; ++i) {
+        s->temps[i].state |= TS_MEM;
+    }
+}
+
+/* liveness analysis: sync globals back to memory and kill.  */
+static void la_global_kill(TCGContext *s, int ng)
+{
+    int i;
+
+    for (i = 0; i < ng; i++) {
+        s->temps[i].state = TS_DEAD | TS_MEM;
+    }
+}
+
 /* Liveness analysis : update the opc_arg_life array to tell if a
    given input arguments is dead. Instructions updating dead
    temporaries are removed. */
@@ -2450,15 +2470,9 @@ static void liveness_pass_1(TCGContext *s)
 
                 if (!(call_flags & (TCG_CALL_NO_WRITE_GLOBALS |
                                     TCG_CALL_NO_READ_GLOBALS))) {
-                    /* globals should go back to memory */
-                    for (i = 0; i < nb_globals; i++) {
-                        s->temps[i].state = TS_DEAD | TS_MEM;
-                    }
+                    la_global_kill(s, nb_globals);
                 } else if (!(call_flags & TCG_CALL_NO_READ_GLOBALS)) {
-                    /* globals should be synced to memory */
-                    for (i = 0; i < nb_globals; i++) {
-                        s->temps[i].state |= TS_MEM;
-                    }
+                    la_global_sync(s, nb_globals);
                 }
 
                 /* record arguments that die in this helper */
@@ -2601,10 +2615,7 @@ static void liveness_pass_1(TCGContext *s)
             if (def->flags & TCG_OPF_BB_END) {
                 la_bb_end(s, nb_globals, nb_temps);
             } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
-                /* globals should be synced to memory */
-                for (i = 0; i < nb_globals; i++) {
-                    s->temps[i].state |= TS_MEM;
-                }
+                la_global_sync(s, nb_globals);
             }
 
             /* record arguments that die in this opcode */
-- 
2.17.2
