Received: from eggs.gnu.org ([2001:4830:134:3::10]:35221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZIU1-0005KY-0D
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITw-0005ON-1G
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:32 -0500
Received: from bran.ispras.ru ([83.149.199.196]:39762 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cZITv-0005NK-Ja
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 09:35:27 -0500
From: Kirill Batuzov <batuzovk@ispras.ru>
Date: Thu,  2 Feb 2017 17:34:41 +0300
Message-Id: <1486046099-17726-4-git-send-email-batuzovk@ispras.ru>
In-Reply-To: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
References: <1486046099-17726-1-git-send-email-batuzovk@ispras.ru>
Subject: [Qemu-devel] [PATCH v2.1 03/21] tcg: support representing vector
 type with smaller vector or scalar types
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

This is not as bad as I thought it would be.
Only two cases: type == base_type and type != base_type.

---
 tcg/tcg.c | 136 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 91 insertions(+), 45 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5e69103..18d97ec 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -523,12 +523,54 @@ TCGv_i64 tcg_global_reg_new_i64(TCGReg reg, const char *name)
     return MAKE_TCGV_I64(idx);
 }
 
-int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
+static TCGType tcg_choose_type(TCGType type)
+{
+    switch (type) {
+    case TCG_TYPE_I64:
+        if (TCG_TARGET_REG_BITS == 64) {
+            return TCG_TYPE_I64;
+        }
+        /* Fallthrough */
+    case TCG_TYPE_I32:
+        return TCG_TYPE_I32;
+    case TCG_TYPE_V128:
+#ifdef TCG_TARGET_HAS_REG128
+        return TCG_TYPE_V128;
+#endif
+        /* Fallthrough */
+    case TCG_TYPE_V64:
+#ifdef TCG_TARGET_HAS_REGV64
+        return TCG_TYPE_V64;
+#else
+        return tcg_choose_type(TCG_TYPE_I64);
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static intptr_t tcg_type_size(TCGType type)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        return 4;
+    case TCG_TYPE_I64:
+    case TCG_TYPE_V64:
+        return 8;
+    case TCG_TYPE_V128:
+        return 16;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+int tcg_global_mem_new_internal(TCGType base_type, TCGv_ptr base,
                                 intptr_t offset, const char *name)
 {
     TCGContext *s = &tcg_ctx;
     TCGTemp *base_ts = &s->temps[GET_TCGV_PTR(base)];
     TCGTemp *ts = tcg_global_alloc(s);
+    TCGType type = tcg_choose_type(base_type);
     int indirect_reg = 0, bigendian = 0;
 #ifdef HOST_WORDS_BIGENDIAN
     bigendian = 1;
@@ -543,47 +585,51 @@ int tcg_global_mem_new_internal(TCGType type, TCGv_ptr base,
         indirect_reg = 1;
     }
 
-    if (TCG_TARGET_REG_BITS == 32 && type == TCG_TYPE_I64) {
-        TCGTemp *ts2 = tcg_global_alloc(s);
-        char buf[64];
-
-        ts->base_type = TCG_TYPE_I64;
-        ts->type = TCG_TYPE_I32;
+    if (type == base_type) {
+        ts->base_type = type;
+        ts->type = type;
         ts->indirect_reg = indirect_reg;
         ts->mem_allocated = 1;
         ts->mem_base = base_ts;
-        ts->mem_offset = offset + bigendian * 4;
-        pstrcpy(buf, sizeof(buf), name);
-        pstrcat(buf, sizeof(buf), "_0");
-        ts->name = strdup(buf);
-
-        tcg_debug_assert(ts2 == ts + 1);
-        ts2->base_type = TCG_TYPE_I64;
-        ts2->type = TCG_TYPE_I32;
-        ts2->indirect_reg = indirect_reg;
-        ts2->mem_allocated = 1;
-        ts2->mem_base = base_ts;
-        ts2->mem_offset = offset + (1 - bigendian) * 4;
-        pstrcpy(buf, sizeof(buf), name);
-        pstrcat(buf, sizeof(buf), "_1");
-        ts2->name = strdup(buf);
+        ts->mem_offset = offset;
+        ts->name = name;
     } else {
-        ts->base_type = type;
+        int i, count = tcg_type_size(base_type) / tcg_type_size(type);
+        TCGTemp *ts2, *ts1 = ts;
+        int cur_offset =
+                bigendian ? tcg_type_size(base_type) - tcg_type_size(type) : 0;
+
+        ts->base_type = base_type;
         ts->type = type;
         ts->indirect_reg = indirect_reg;
         ts->mem_allocated = 1;
         ts->mem_base = base_ts;
-        ts->mem_offset = offset;
-        ts->name = name;
+        ts->mem_offset = offset + cur_offset;
+        ts->name = g_strdup_printf("%s_0", name);
+
+        for (i = 1; i < count; i++) {
+            ts2 = tcg_global_alloc(s);
+            tcg_debug_assert(ts2 == ts1 + 1);
+            cur_offset += (bigendian ? -1 : 1) * tcg_type_size(type);
+            ts2->base_type = base_type;
+            ts2->type = type;
+            ts2->indirect_reg = indirect_reg;
+            ts2->mem_allocated = 1;
+            ts2->mem_base = base_ts;
+            ts2->mem_offset = offset + cur_offset;
+            ts2->name = g_strdup_printf("%s_%d", name, i);
+            ts1 = ts2;
+        }
     }
     return temp_idx(s, ts);
 }
 
-static int tcg_temp_new_internal(TCGType type, int temp_local)
+static int tcg_temp_new_internal(TCGType base_type, int temp_local)
 {
     TCGContext *s = &tcg_ctx;
     TCGTemp *ts;
     int idx, k;
+    TCGType type = tcg_choose_type(base_type);
 
     k = type + (temp_local ? TCG_TYPE_COUNT : 0);
     idx = find_first_bit(s->free_temps[k].l, TCG_MAX_TEMPS);
@@ -593,28 +639,28 @@ static int tcg_temp_new_internal(TCGType type, int temp_local)
 
         ts = &s->temps[idx];
         ts->temp_allocated = 1;
-        tcg_debug_assert(ts->base_type == type);
+        tcg_debug_assert(ts->base_type == base_type);
         tcg_debug_assert(ts->temp_local == temp_local);
     } else {
         ts = tcg_temp_alloc(s);
-        if (TCG_TARGET_REG_BITS == 32 && type == TCG_TYPE_I64) {
-            TCGTemp *ts2 = tcg_temp_alloc(s);
-
-            ts->base_type = type;
-            ts->type = TCG_TYPE_I32;
-            ts->temp_allocated = 1;
-            ts->temp_local = temp_local;
-
-            tcg_debug_assert(ts2 == ts + 1);
-            ts2->base_type = TCG_TYPE_I64;
-            ts2->type = TCG_TYPE_I32;
-            ts2->temp_allocated = 1;
-            ts2->temp_local = temp_local;
-        } else {
-            ts->base_type = type;
-            ts->type = type;
-            ts->temp_allocated = 1;
-            ts->temp_local = temp_local;
+        ts->base_type = base_type;
+        ts->type = type;
+        ts->temp_allocated = 1;
+        ts->temp_local = temp_local;
+
+        if (type != base_type) {
+            int i, count = tcg_type_size(base_type) / tcg_type_size(type);
+            TCGTemp *ts2, *ts1 = ts;
+
+            for (i = 1; i < count; i++) {
+                ts2 = tcg_temp_alloc(s);
+                tcg_debug_assert(ts2 == ts1 + 1);
+                ts2->base_type = base_type;
+                ts2->type = type;
+                ts2->temp_allocated = 1;
+                ts2->temp_local = temp_local;
+                ts1 = ts2;
+            }
         }
         idx = temp_idx(s, ts);
     }
-- 
2.1.4
