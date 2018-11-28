Received: from eggs.gnu.org ([2001:4830:134:3::10]:47981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYl-000413-R7
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYk-0004OW-6J
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:51 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYj-0004NP-V1
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:50 -0500
Received: by mail-pl1-x642.google.com with SMTP id g9so4345340plo.3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:32 -0800
Message-Id: <20181128053834.10861-11-richard.henderson@linaro.org>
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 10/12] tcg: Split out more subroutines from
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
Cc: cota@braap.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 27814df882..21668831a1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2417,6 +2417,26 @@ static void la_bb_end(TCGContext *s, int ng, int nt)
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
@@ -2472,15 +2492,9 @@ static void liveness_pass_1(TCGContext *s)
 
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
@@ -2623,10 +2637,7 @@ static void liveness_pass_1(TCGContext *s)
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
