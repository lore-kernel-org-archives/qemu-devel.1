Received: from eggs.gnu.org ([209.51.188.92]:37127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnT-0005s7-Qb
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnS-00013x-Rq
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:11 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:43667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1giqnS-00013e-Mo
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:10 -0500
Received: by mail-pg1-x541.google.com with SMTP id v28so8722866pgk.10
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 17:12:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 12:11:17 +1100
Message-Id: <20190114011122.5995-13-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-1-richard.henderson@linaro.org>
References: <20190114011122.5995-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/17] target/arm: Implement the LDGV and STGV
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |  2 ++
 target/arm/mte_helper.c    | 51 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 34 ++++++++++++++++++++-----
 3 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index ff37c8975a..5bbfe43c13 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -111,3 +111,5 @@ DEF_HELPER_FLAGS_2(gmi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(ldg, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(stg, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(st2g, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(ldgv, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(stgv, TCG_CALL_NO_WG, void, env, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 06fd9c18f9..b125f49258 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -256,3 +256,54 @@ uint64_t HELPER(st2g)(CPUARMState *env, uint64_t ptr)
     /* ??? Do we need a more precise TBI here?  */
     return sextract64(ptr, 0, 55);
 }
+
+uint64_t HELPER(ldgv)(CPUARMState *env, uint64_t ptr)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    uint64_t ret;
+    int rtag, i;
+
+    if (!allocation_tag_access_enabled(env, el, sctlr)) {
+        return 0;
+    }
+
+    ptr = QEMU_ALIGN_DOWN(ptr, 1 << LOG2_TAG_GRANULE);
+    rtag = get_allocation_tag(env, ptr);
+    if (rtag < 0) {
+        /* The entire page does not have tags.  */
+        return 0;
+    }
+
+    i = extract32(ptr, LOG2_TAG_GRANULE, 4);
+    ret = (uint64_t)rtag << i;
+    for (i++; i < 16; i++) {
+        rtag = get_allocation_tag(env, ptr + (i << LOG2_TAG_GRANULE));
+        ret |= (uint64_t)rtag << i;
+    }
+
+    return ret;
+}
+
+void HELPER(stgv)(CPUARMState *env, uint64_t ptr, uint64_t val)
+{
+    int el = arm_current_el(env);
+    uint64_t sctlr = arm_sctlr(env, el);
+    int rtag, i;
+
+    if (!allocation_tag_access_enabled(env, el, sctlr)) {
+        return;
+    }
+
+    rtag = allocation_tag_from_addr(ptr);
+    ptr = QEMU_ALIGN_DOWN(ptr, 1 << LOG2_TAG_GRANULE);
+    if (!set_allocation_tag(env, ptr, rtag)) {
+        /* The entire page does not have tags.  */
+        return;
+    }
+
+    i = extract32(ptr, LOG2_TAG_GRANULE, 4);
+    for (i++; i < 16; i++) {
+        set_allocation_tag(env, ptr + (i << LOG2_TAG_GRANULE), rtag);
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 911d6f06b3..b4226def40 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3612,7 +3612,7 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
     int op2 = extract32(insn, 10, 3);
     int op1 = extract32(insn, 22, 2);
-    bool is_load = false, is_pair = false, is_zero = false;
+    bool is_load = false, is_pair = false, is_zero = false, is_tagv = false;
     int index = 0;
     TCGv_i64 dirty_addr, clean_addr;
 
@@ -3644,17 +3644,29 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
             /* ST2G */
             is_pair = true;
             index = op2 - 2;
-            break;
+        } else {
+            /* STGV */
+            if (s->current_el == 0 || offset != 0) {
+                goto do_unallocated;
+            }
+            is_tagv = true;
+            index = 1;
         }
-        goto do_unallocated;
+        break;
     case 3:
         if (op2 != 0) {
             /* STZ2G */
             is_pair = is_zero = true;
             index = op2 - 2;
-            break;
+        } else {
+            /* LDGV */
+            if (s->current_el == 0 || offset != 0 || rt == rn) {
+                goto do_unallocated;
+            }
+            is_load = is_tagv = true;
+            index = 1;
         }
-        goto do_unallocated;
+        break;
 
     default:
     do_unallocated:
@@ -3669,7 +3681,17 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
     }
 
     clean_addr = tcg_temp_new_i64();
-    if (is_load) {
+    if (is_tagv) {
+        if (is_load) {
+            gen_helper_ldgv(cpu_reg(s, rt), cpu_env, dirty_addr);
+        } else {
+            gen_helper_stgv(cpu_env, dirty_addr, cpu_reg(s, rt));
+        }
+
+        /* Post-increment with dirty = align_up(dirty, 16*TAG_GRANULE).  */
+        tcg_gen_ori_i64(dirty_addr, dirty_addr, (16 << LOG2_TAG_GRANULE) - 1);
+        tcg_gen_addi_i64(dirty_addr, dirty_addr, 1);
+    } else if (is_load) {
         gen_helper_ldg(cpu_reg(s, rt), cpu_env, dirty_addr);
     } else if (is_pair) {
         gen_helper_st2g(clean_addr, cpu_env, dirty_addr);
-- 
2.17.2
