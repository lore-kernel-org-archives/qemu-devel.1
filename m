Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B758DC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:22:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A68C20838
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 23:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4aZfH0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A68C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilLPI-0007vz-4s
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 18:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFe-0004pA-Ks
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilLFc-0005rM-A8
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:06 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilLFc-0005n9-1W
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 18:12:04 -0500
Received: by mail-pj1-x1043.google.com with SMTP id t101so6556836pjb.4
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 15:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NbXcHmPvccOg4ApdYdFLAPaKmhXfD3r1GQk/f9IlktA=;
 b=T4aZfH0j8rWJ0+Q0fkO+IcRgVVxgh5qr/Mgu2wcc/FcwnLV3plk4fvFPlATOpP5Ymm
 zM+O+xd5S4168qALr+HHVpLoE5Rb2fMAKZAQU9RCza3I+8YHxAJJYosyJ66G+VkAPPQe
 NteJ1a3auw7yIeY+UVEvP6/2I8TtvT1zEsiEbS8S7p/y9GcO92IvlUMX+vkM3SWjdsbd
 sMKkfbPSFBgXf3i5DNGEmCMmmg0SdRRAj5KVEhHrxJUc91RRhxh1WCShMHoZqiC3F/cf
 unlwTku3WZj3EWpme9KAomdOXsn1kUAsR9SEUWAtpSj03WGwfeQRRq8OAG1XP0RMM5CU
 SAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NbXcHmPvccOg4ApdYdFLAPaKmhXfD3r1GQk/f9IlktA=;
 b=L9NtgOykYPByLz5gQUOP29loDfzxrEz5BaiTq7Xh+F1byBjEyheJgPm6nr/yNw8vxm
 i37kREwk9lPCMW8ybMJQ3lkxuFIS1YbADPAmA5ecXJndUMl8aPQASxs84pcByLfan/KF
 Ui0adZvpuroXK5nGPuasSogP8F8ySiI50U8BXrM09tlOwR+i/g3fCYAiJKfn51Y5MNJS
 Lmp/vN3knfRnBVbsZsmyCY8awu2fzraOYW/et1t69d9RgAyPhOe5vE0OUujsVMch3xnX
 M75I3zQsR8bSiZkPX+tnrQn3+1s6H4F+RahSl8pW5AxBSx55LUYMk2lkxO4kzuXvjq37
 GUGg==
X-Gm-Message-State: APjAAAVbfjb26B2fXrCk9ztQk2/FHfxeFw36JoRoqKb9bPqdC8Llv2sH
 eLfPI96TxsLBNGti3/aOinvUhawGx8E=
X-Google-Smtp-Source: APXvYqz72gX4VJBdlWq6UUgFyDaCB8moTATgrzk6oz1CH1vKBy4gIb1ANdRlP28/trgyW3idft1sFQ==
X-Received: by 2002:a17:902:b788:: with SMTP id
 e8mr61314544pls.1.1577574722611; 
 Sat, 28 Dec 2019 15:12:02 -0800 (PST)
Received: from localhost.localdomain (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id c18sm21077186pfr.40.2019.12.28.15.12.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2019 15:12:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/29] cputlb: Move body of cpu_ldst_template.h out of line
Date: Sun, 29 Dec 2019 10:11:05 +1100
Message-Id: <20191228231124.18307-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191228231124.18307-1-richard.henderson@linaro.org>
References: <20191228231124.18307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With the tracing hooks, the inline functions are no longer
so simple.  Once out-of-line, the current tlb_entry lookup
is redundant with the one in the main load/store_helper.

This also begins the introduction of a new target facing
interface, with suffix *_mmuidx_ra.  This is not yet
official because the interface is not done for user-only.

Use abi_ptr instead of target_ulong in preparation for
user-only; the two types are identical for softmmu.

What remains in cpu_ldst_template.h are the expansions
for _code, _data, and MMU_MODE<N>_SUFFIX.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h          |  25 ++++++-
 include/exec/cpu_ldst_template.h | 125 +++++++------------------------
 accel/tcg/cputlb.c               | 116 ++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 100 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index fd499f7e2f..cf8af36dbc 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -152,7 +152,7 @@ static inline void clear_helper_retaddr(void)
 
 #else
 
-/* The memory helpers for tcg-generated code need tcg_target_long etc.  */
+/* Needed for TCG_OVERSIZED_GUEST */
 #include "tcg.h"
 
 static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
@@ -185,6 +185,29 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
     return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)];
 }
 
+uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                            int mmu_idx, uintptr_t ra);
+uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                            int mmu_idx, uintptr_t ra);
+uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                           int mmu_idx, uintptr_t ra);
+uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                           int mmu_idx, uintptr_t ra);
+
+int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                       int mmu_idx, uintptr_t ra);
+int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                       int mmu_idx, uintptr_t ra);
+
+void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr);
+void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr);
+void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr);
+void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
+                       int mmu_idx, uintptr_t retaddr);
+
 #ifdef MMU_MODE0_SUFFIX
 #define CPU_MMU_INDEX 0
 #define MEMSUFFIX MMU_MODE0_SUFFIX
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 0ad5de3ef9..ea39e29c19 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -24,13 +24,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#if !defined(SOFTMMU_CODE_ACCESS)
-#include "trace-root.h"
-#endif
-
-#include "qemu/plugin.h"
-#include "trace/mem.h"
-
 #if DATA_SIZE == 8
 #define SUFFIX q
 #define USUFFIX q
@@ -63,56 +56,40 @@
 #define RES_TYPE uint32_t
 #endif
 
+/* generic load/store macros */
+
 #ifdef SOFTMMU_CODE_ACCESS
-#define ADDR_READ addr_code
-#define MMUSUFFIX _cmmu
-#define URETSUFFIX USUFFIX
-#define SRETSUFFIX glue(s, SUFFIX)
-#else
-#define ADDR_READ addr_read
-#define MMUSUFFIX _mmu
-#define URETSUFFIX USUFFIX
-#define SRETSUFFIX glue(s, SUFFIX)
+
+static inline RES_TYPE
+glue(glue(cpu_ld, USUFFIX), _code)(CPUArchState *env, target_ulong ptr)
+{
+    TCGMemOpIdx oi = make_memop_idx(MO_TE | SHIFT, CPU_MMU_INDEX);
+    return glue(glue(helper_ret_ld, USUFFIX), _cmmu)(env, ptr, oi, 0);
+}
+
+#if DATA_SIZE <= 2
+static inline int
+glue(glue(cpu_lds, SUFFIX), _code)(CPUArchState *env, target_ulong ptr)
+{
+    return (DATA_STYPE)glue(glue(cpu_ld, USUFFIX), _code)(env, ptr);
+}
 #endif
 
-/* generic load/store macros */
+#else
 
 static inline RES_TYPE
 glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
                                                   uintptr_t retaddr)
 {
-    CPUTLBEntry *entry;
-    RES_TYPE res;
-    target_ulong addr;
-    int mmu_idx = CPU_MMU_INDEX;
-    MemOp op = MO_TE | SHIFT;
-#if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, false);
-    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-#endif
-
-    addr = ptr;
-    entry = tlb_entry(env, mmu_idx, addr);
-    if (unlikely(entry->ADDR_READ !=
-                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        TCGMemOpIdx oi = make_memop_idx(op, mmu_idx);
-        res = glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, addr,
-                                                               oi, retaddr);
-    } else {
-        uintptr_t hostaddr = addr + entry->addend;
-        res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
-    }
-#ifndef SOFTMMU_CODE_ACCESS
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
-#endif
-    return res;
+    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX,
+                                                   retaddr);
 }
 
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 {
-    return glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(env, ptr, 0);
+    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX, 0);
 }
 
 #if DATA_SIZE <= 2
@@ -121,42 +98,17 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
                                                   uintptr_t retaddr)
 {
-    CPUTLBEntry *entry;
-    int res;
-    target_ulong addr;
-    int mmu_idx = CPU_MMU_INDEX;
-    MemOp op = MO_TE | MO_SIGN | SHIFT;
-#ifndef SOFTMMU_CODE_ACCESS
-    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, false);
-    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-#endif
-
-    addr = ptr;
-    entry = tlb_entry(env, mmu_idx, addr);
-    if (unlikely(entry->ADDR_READ !=
-                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        TCGMemOpIdx oi = make_memop_idx(op & ~MO_SIGN, mmu_idx);
-        res = (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
-                               MMUSUFFIX)(env, addr, oi, retaddr);
-    } else {
-        uintptr_t hostaddr = addr + entry->addend;
-        res = glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
-    }
-#ifndef SOFTMMU_CODE_ACCESS
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
-#endif
-    return res;
+    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX,
+                                                   retaddr);
 }
 
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 {
-    return glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(env, ptr, 0);
+    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX, 0);
 }
 #endif
 
-#ifndef SOFTMMU_CODE_ACCESS
-
 /* generic store macro */
 
 static inline void
@@ -164,36 +116,15 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                  target_ulong ptr,
                                                  RES_TYPE v, uintptr_t retaddr)
 {
-    CPUTLBEntry *entry;
-    target_ulong addr;
-    int mmu_idx = CPU_MMU_INDEX;
-    MemOp op = MO_TE | SHIFT;
-#if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, true);
-    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-#endif
-
-    addr = ptr;
-    entry = tlb_entry(env, mmu_idx, addr);
-    if (unlikely(tlb_addr_write(entry) !=
-                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        TCGMemOpIdx oi = make_memop_idx(op, mmu_idx);
-        glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
-                                                     retaddr);
-    } else {
-        uintptr_t hostaddr = addr + entry->addend;
-        glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
-    }
-#ifndef SOFTMMU_CODE_ACCESS
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
-#endif
+    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX,
+                                           retaddr);
 }
 
 static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
                                       RES_TYPE v)
 {
-    glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(env, ptr, v, 0);
+    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX, 0);
 }
 
 #endif /* !SOFTMMU_CODE_ACCESS */
@@ -204,8 +135,4 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
 #undef SUFFIX
 #undef USUFFIX
 #undef DATA_SIZE
-#undef MMUSUFFIX
-#undef ADDR_READ
-#undef URETSUFFIX
-#undef SRETSUFFIX
 #undef SHIFT
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 98221948d6..ddd19718bf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,6 +34,9 @@
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "translate-all.h"
+#include "trace-root.h"
+#include "qemu/plugin.h"
+#include "trace/mem.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
 #endif
@@ -1625,6 +1628,75 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
     return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
 }
 
+/*
+ * Load helpers for cpu_ldst.h.
+ */
+
+static inline uint64_t cpu_load_helper(CPUArchState *env, abi_ptr addr,
+                                       int mmu_idx, uintptr_t retaddr,
+                                       MemOp op, FullLoadHelper *full_load)
+{
+    uint16_t meminfo;
+    TCGMemOpIdx oi;
+    uint64_t ret;
+
+    meminfo = trace_mem_get_info(op, mmu_idx, false);
+    trace_guest_mem_before_exec(env_cpu(env), addr, meminfo);
+
+    op &= ~MO_SIGN;
+    oi = make_memop_idx(op, mmu_idx);
+    ret = full_load(env, addr, oi, retaddr);
+
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, meminfo);
+
+    return ret;
+}
+
+uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                            int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_UB, full_ldub_mmu);
+}
+
+int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                       int mmu_idx, uintptr_t ra)
+{
+    return (int8_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_SB,
+                                   full_ldub_mmu);
+}
+
+uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                            int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUW,
+                           MO_TE == MO_LE
+                           ? full_le_lduw_mmu : full_be_lduw_mmu);
+}
+
+int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                       int mmu_idx, uintptr_t ra)
+{
+    return (int16_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_TESW,
+                                    MO_TE == MO_LE
+                                    ? full_le_lduw_mmu : full_be_lduw_mmu);
+}
+
+uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                           int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUL,
+                           MO_TE == MO_LE
+                           ? full_le_ldul_mmu : full_be_ldul_mmu);
+}
+
+uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                           int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEQ,
+                           MO_TE == MO_LE
+                           ? helper_le_ldq_mmu : helper_be_ldq_mmu);
+}
+
 /*
  * Store Helpers
  */
@@ -1854,6 +1926,50 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     store_helper(env, addr, val, oi, retaddr, MO_BEQ);
 }
 
+/*
+ * Store Helpers for cpu_ldst.h
+ */
+
+static inline void QEMU_ALWAYS_INLINE
+cpu_store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+                 int mmu_idx, uintptr_t retaddr, MemOp op)
+{
+    TCGMemOpIdx oi;
+    uint16_t meminfo;
+
+    meminfo = trace_mem_get_info(op, mmu_idx, true);
+    trace_guest_mem_before_exec(env_cpu(env), addr, meminfo);
+
+    oi = make_memop_idx(op, mmu_idx);
+    store_helper(env, addr, val, oi, retaddr, op);
+
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, meminfo);
+}
+
+void cpu_stb_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_UB);
+}
+
+void cpu_stw_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUW);
+}
+
+void cpu_stl_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUL);
+}
+
+void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
+                       int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEQ);
+}
+
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
    them callable from other helpers.  */
 
-- 
2.20.1


