Received: from eggs.gnu.org ([2001:4830:134:3::10]:50893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPkf-00038E-P0
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPke-0003sx-KP
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:25 -0500
Received: from bran.ispras.ru ([83.149.199.196]:50116 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cTPke-0003sL-6t
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:08:24 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Tue, 17 Jan 2017 12:07:45 +0300
Message-Id: <1484644078-21312-6-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH 05/18] tcg: use results of alias analysis in
 liveness analysis
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/tcg.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e81d1c4..2f97c13 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1448,6 +1448,58 @@ static inline void tcg_la_bb_end(TCGContext *s, uint8_t *temp_state)
     }
 }
 
+static intptr_t tcg_temp_size(const TCGTemp *tmp)
+{
+    switch (tmp->base_type) {
+    case TCG_TYPE_I32:
+        return 4;
+    case TCG_TYPE_I64:
+    case TCG_TYPE_V64:
+        return 8;
+    case TCG_TYPE_V128:
+        return 16;
+    default:
+        tcg_abort();
+    }
+}
+
+/* Check if memory write completely overwrites temp's memory location.
+   If this is the case then the temp can be considered dead. */
+static int tcg_temp_overwrite(TCGContext *s, const TCGTemp *tmp,
+                               const TCGAliasInfo *ai)
+{
+    if (!(ai->alias_type & TCG_ALIAS_WRITE) || !ai->fixed_offset) {
+        return 0;
+    }
+    if (tmp->mem_base != &s->temps[GET_TCGV_PTR(s->tcg_env)]) {
+        return 0;
+    }
+    if (ai->offset > tmp->mem_offset
+        || ai->offset + ai->size < tmp->mem_offset + tcg_temp_size(tmp)) {
+            return 0;
+    }
+    return 1;
+}
+
+/* Check if memory read or write overlaps with temp's memory location.
+   If this is the case then the temp must be synced to memory. */
+static int tcg_temp_overlap(TCGContext *s, const TCGTemp *tmp,
+                            const TCGAliasInfo *ai)
+{
+    if (!ai->fixed_offset || tmp->fixed_reg) {
+        return 0;
+    }
+    if (tmp->mem_base != &s->temps[GET_TCGV_PTR(s->tcg_env)]) {
+        return 1;
+    }
+    if (ai->offset >= tmp->mem_offset + tcg_temp_size(tmp)
+        || ai->offset + ai->size <= tmp->mem_offset) {
+            return 0;
+    } else {
+        return 1;
+    }
+}
+
 /* Liveness analysis : update the opc_arg_life array to tell if a
    given input arguments is dead. Instructions updating dead
    temporaries are removed. */
@@ -1650,6 +1702,23 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
                     temp_state[arg] = TS_DEAD;
                 }
 
+                /* record if the operation uses some globals' memory location */
+                if (s->alias_info[oi].alias_type != TCG_NOT_ALIAS) {
+                    for (i = 0; i < s->nb_globals; i++) {
+                        if (tcg_temp_overwrite(s, &s->temps[i],
+                                               &s->alias_info[oi])) {
+                            temp_state[i] = TS_DEAD;
+                        } else if (tcg_temp_overlap(s, &s->temps[i],
+                                                    &s->alias_info[oi])) {
+                            if (s->alias_info[oi].alias_type & TCG_ALIAS_READ) {
+                                temp_state[i] = TS_MEM | TS_DEAD;
+                            } else if (!(temp_state[i] & TS_DEAD)) {
+                                temp_state[i] |= TS_MEM;
+                            }
+                        }
+                    }
+                }
+
                 /* if end of basic block, update */
                 if (def->flags & TCG_OPF_BB_END) {
                     tcg_la_bb_end(s, temp_state);
@@ -2591,6 +2660,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     s->la_time -= profile_getclock();
 #endif
 
+    tcg_alias_analysis(s);
+
     {
         uint8_t *temp_state = tcg_malloc(s->nb_temps + s->nb_indirects);
 
-- 
2.1.4
