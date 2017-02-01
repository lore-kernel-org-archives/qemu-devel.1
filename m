Received: from eggs.gnu.org ([2001:4830:134:3::10]:53141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYtsA-00060F-UR
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts7-0005cU-Au
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:50 -0500
Received: from bran.ispras.ru ([83.149.199.196]:46096 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cYts6-0005cF-Vp
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:18:47 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Wed,  1 Feb 2017 15:18:08 +0300
Message-Id: <1485951502-28774-7-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
References: <1485951502-28774-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2 06/20] tcg: use results of alias analysis in
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
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kirill Batuzov <batuzovk@ispras.ru>

Signed-off-by: Kirill Batuzov <batuzovk@ispras.ru>
---
 tcg/tcg.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 18d97ec..27e5944 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -564,6 +564,11 @@ static intptr_t tcg_type_size(TCGType type)
     }
 }
 
+static intptr_t tcg_temp_size(const TCGTemp *tmp)
+{
+    return tcg_type_size(tmp->type);
+}
+
 int tcg_global_mem_new_internal(TCGType base_type, TCGv_ptr base,
                                 intptr_t offset, const char *name)
 {
@@ -1472,6 +1477,43 @@ static inline void tcg_la_bb_end(TCGContext *s, uint8_t *temp_state)
     }
 }
 
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
@@ -1674,6 +1716,23 @@ static void liveness_pass_1(TCGContext *s, uint8_t *temp_state)
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
@@ -2622,6 +2681,8 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     s->la_time -= profile_getclock();
 #endif
 
+    tcg_alias_analysis(s);
+
     {
         uint8_t *temp_state = tcg_malloc(s->nb_temps + s->nb_indirects);
 
-- 
2.1.4
