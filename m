Received: from eggs.gnu.org ([2001:4830:134:3::10]:47985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYl-000415-RZ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRsYi-0004N5-T8
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:51 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:34803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRsYi-0004MH-N2
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 00:38:48 -0500
Received: by mail-pl1-x643.google.com with SMTP id f12-v6so16824726plo.1
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 21:38:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 27 Nov 2018 21:38:31 -0800
Message-Id: <20181128053834.10861-10-richard.henderson@linaro.org>
In-Reply-To: <20181128053834.10861-1-richard.henderson@linaro.org>
References: <20181128053834.10861-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/12] tcg: Rename and adjust liveness_pass_1
 helpers
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

No need for a "tcg_" prefix for a static function; we already
have another "la_" prefix for indicating liveness analysis.
Pass in nb_globals and nb_temps, as we will already have them
in registers for other loops within the parent function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 82f9a66d31..27814df882 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2389,10 +2389,8 @@ static void reachable_code_pass(TCGContext *s)
 
 /* liveness analysis: end of function: all temps are dead, and globals
    should be in memory. */
-static void tcg_la_func_end(TCGContext *s)
+static void la_func_end(TCGContext *s, int ng, int nt)
 {
-    int ng = s->nb_globals;
-    int nt = s->nb_temps;
     int i;
 
     for (i = 0; i < ng; ++i) {
@@ -2405,10 +2403,8 @@ static void tcg_la_func_end(TCGContext *s)
 
 /* liveness analysis: end of basic block: all temps are dead, globals
    and local temps should be in memory. */
-static void tcg_la_bb_end(TCGContext *s)
+static void la_bb_end(TCGContext *s, int ng, int nt)
 {
-    int ng = s->nb_globals;
-    int nt = s->nb_temps;
     int i;
 
     for (i = 0; i < ng; ++i) {
@@ -2427,9 +2423,10 @@ static void tcg_la_bb_end(TCGContext *s)
 static void liveness_pass_1(TCGContext *s)
 {
     int nb_globals = s->nb_globals;
+    int nb_temps = s->nb_temps;
     TCGOp *op, *op_prev;
 
-    tcg_la_func_end(s);
+    la_func_end(s, nb_globals, nb_temps);
 
     QTAILQ_FOREACH_REVERSE_SAFE(op, &s->ops, TCGOpHead, link, op_prev) {
         int i, nb_iargs, nb_oargs;
@@ -2624,7 +2621,7 @@ static void liveness_pass_1(TCGContext *s)
 
             /* if end of basic block, update */
             if (def->flags & TCG_OPF_BB_END) {
-                tcg_la_bb_end(s);
+                la_bb_end(s, nb_globals, nb_temps);
             } else if (def->flags & TCG_OPF_SIDE_EFFECTS) {
                 /* globals should be synced to memory */
                 for (i = 0; i < nb_globals; i++) {
-- 
2.17.2
