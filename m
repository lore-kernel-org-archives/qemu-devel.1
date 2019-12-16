Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C37C33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D0A24682
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDK0z/Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D0A24682
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyow-00060P-IX
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igybf-0005om-Qx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igybd-0007nK-Q3
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:47 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46795)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igybd-0007n1-Hy
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:45 -0500
Received: by mail-pf1-x443.google.com with SMTP id y14so6360908pfm.13
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n91Cd7yYniXXXBEuAFOxxPa0/GBVEYFAD0qxW/Wckas=;
 b=xDK0z/AvKh4V4BGzpnj/qqMcPRt/sE9U0bcyQDRf33ntpcXBvFhq5ygN28JxFpPItI
 R/dOxqkO0RVoXFBqC37LytGEXyVM2bWFn8Wbnmvfy2+pM4rNsHFj4dsj3lsY7lIMmxV4
 /qQntb26TgStnpMIDOqZ7FC2Q4keqxZFmxMoJn7xPxn1Qjs/oGzaAAFgYFs3BcDV7mY2
 /gEzxcc8UA9M05Ftc0fuUzCdcsCgWCdJ7yRxFy9GysV/6jBRqBxXidOO7W86M0FD8brC
 y//1sKFM74UMZ8US8Rv3tcHSsYIi3Rr8FlnC9m/PdQArr0U5qvQt+1CrDHvNSKe15u8r
 H9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n91Cd7yYniXXXBEuAFOxxPa0/GBVEYFAD0qxW/Wckas=;
 b=V8qTSW1CBLbTfyrymIsNHFNcG2ntmK3Y75EC6L8XJQai3x/1Fmu4yTF1Aa3u+wZ3oj
 jhBOPmf5T1o/hBJrBuazUAJ7jHysvP2msjcJ72mD/PRTfa2qkQgAflum57lvYH9GwQ9O
 zwCDojudcJXMxjOEUNJLgtJg/zyfzRhvEpTA25aMHxWlgLVqxVmK5EGkijoVkj5ji2LT
 aXW+YsjpNMHcuhlXQz6qvPFs5QH4j/6UDGyu0LcFLRqWlJg9tFJTo5PWZY3EhKXtJqvx
 J/2pt0OurZaBJ1gY0ssEPffg/PkX0iF5fNCbTsdooxbwM5b+lB8aYaZHRAjn/yAOxbsf
 AxZg==
X-Gm-Message-State: APjAAAWj8ouoxyCD+SoE94u4GxlSwCMWaCzlni28YPo5VBaoP5z/oAM3
 JfaIEjRIhsNbhLYax/Vjuxo7ZlRW4U0=
X-Google-Smtp-Source: APXvYqzpsZJfBS7uFykti/HXsSOlvnCOXnO01Mu+fpunJrKQK1GMelvjzmgjymLb+8+ZU1cozPWalw==
X-Received: by 2002:a65:58ce:: with SMTP id e14mr21172438pgu.153.1576534364154; 
 Mon, 16 Dec 2019 14:12:44 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/28] cputlb: Expand cpu_ldst_template.h in cputlb.c
Date: Mon, 16 Dec 2019 12:11:58 -1000
Message-Id: <20191216221158.29572-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reduce the amount of preprocessor obfuscation by expanding
the text of each of the functions generated.  The result is
only slightly smaller than the original.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h          |  67 +++++++-----------
 include/exec/cpu_ldst_template.h | 117 -------------------------------
 accel/tcg/cputlb.c               | 107 +++++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 161 deletions(-)
 delete mode 100644 include/exec/cpu_ldst_template.h

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index cf4652bf48..62f38d5a22 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -94,32 +94,6 @@ typedef target_ulong abi_ptr;
 #define TARGET_ABI_FMT_ptr TARGET_ABI_FMT_lx
 #endif
 
-#if defined(CONFIG_USER_ONLY)
-
-extern __thread uintptr_t helper_retaddr;
-
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-    helper_retaddr = ra;
-    /*
-     * Ensure that this write is visible to the SIGSEGV handler that
-     * may be invoked due to a subsequent invalid memory operation.
-     */
-    signal_barrier();
-}
-
-static inline void clear_helper_retaddr(void)
-{
-    /*
-     * Ensure that previous memory operations have succeeded before
-     * removing the data visible to the signal handler.
-     */
-    signal_barrier();
-    helper_retaddr = 0;
-}
-
-/* In user-only mode we provide only the _code and _data accessors. */
-
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
 uint32_t cpu_lduw_data(CPUArchState *env, abi_ptr ptr);
 uint32_t cpu_ldl_data(CPUArchState *env, abi_ptr ptr);
@@ -148,6 +122,30 @@ void cpu_stl_data_ra(CPUArchState *env, abi_ptr ptr,
 void cpu_stq_data_ra(CPUArchState *env, abi_ptr ptr,
                      uint64_t val, uintptr_t retaddr);
 
+#if defined(CONFIG_USER_ONLY)
+
+extern __thread uintptr_t helper_retaddr;
+
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    signal_barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    signal_barrier();
+    helper_retaddr = 0;
+}
+
 /*
  * Provide the same *_mmuidx_ra interface as for softmmu.
  * The mmu_idx argument is ignored.
@@ -271,23 +269,6 @@ void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
 void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
                        int mmu_idx, uintptr_t retaddr);
 
-/* these access are slower, they must be as rare as possible */
-#define CPU_MMU_INDEX (cpu_mmu_index(env, false))
-#define MEMSUFFIX _data
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-
 #endif /* defined(CONFIG_USER_ONLY) */
 
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
deleted file mode 100644
index e400979f23..0000000000
--- a/include/exec/cpu_ldst_template.h
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- *  Software MMU support
- *
- * Generate inline load/store functions for one MMU mode and data
- * size.
- *
- * Generate a store function as well as signed and unsigned loads.
- *
- * Not used directly but included from cpu_ldst.h.
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#if DATA_SIZE == 8
-#define SUFFIX q
-#define USUFFIX q
-#define DATA_TYPE uint64_t
-#define SHIFT 3
-#elif DATA_SIZE == 4
-#define SUFFIX l
-#define USUFFIX l
-#define DATA_TYPE uint32_t
-#define SHIFT 2
-#elif DATA_SIZE == 2
-#define SUFFIX w
-#define USUFFIX uw
-#define DATA_TYPE uint16_t
-#define DATA_STYPE int16_t
-#define SHIFT 1
-#elif DATA_SIZE == 1
-#define SUFFIX b
-#define USUFFIX ub
-#define DATA_TYPE uint8_t
-#define DATA_STYPE int8_t
-#define SHIFT 0
-#else
-#error unsupported data size
-#endif
-
-#if DATA_SIZE == 8
-#define RES_TYPE uint64_t
-#else
-#define RES_TYPE uint32_t
-#endif
-
-/* generic load/store macros */
-
-static inline RES_TYPE
-glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
-                                                  uintptr_t retaddr)
-{
-    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX,
-                                                   retaddr);
-}
-
-static inline RES_TYPE
-glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
-{
-    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX, 0);
-}
-
-#if DATA_SIZE <= 2
-static inline int
-glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
-                                                  uintptr_t retaddr)
-{
-    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX,
-                                                   retaddr);
-}
-
-static inline int
-glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
-{
-    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX, 0);
-}
-#endif
-
-/* generic store macro */
-
-static inline void
-glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                 target_ulong ptr,
-                                                 RES_TYPE v, uintptr_t retaddr)
-{
-    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX,
-                                           retaddr);
-}
-
-static inline void
-glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
-                                      RES_TYPE v)
-{
-    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX, 0);
-}
-
-#undef RES_TYPE
-#undef DATA_TYPE
-#undef DATA_STYPE
-#undef SUFFIX
-#undef USUFFIX
-#undef DATA_SIZE
-#undef SHIFT
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index f0e4b0aee4..a991ea2964 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -35,7 +35,6 @@
 #include "qemu/atomic128.h"
 #include "translate-all.h"
 #include "trace-root.h"
-#include "qemu/plugin.h"
 #include "trace/mem.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
@@ -1697,6 +1696,68 @@ uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                            ? helper_le_ldq_mmu : helper_be_ldq_mmu);
 }
 
+uint32_t cpu_ldub_data_ra(CPUArchState *env, target_ulong ptr,
+                          uintptr_t retaddr)
+{
+    return cpu_ldub_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+int cpu_ldsb_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldsb_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint32_t cpu_lduw_data_ra(CPUArchState *env, target_ulong ptr,
+                          uintptr_t retaddr)
+{
+    return cpu_lduw_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+int cpu_ldsw_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldsw_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint32_t cpu_ldl_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldl_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint64_t cpu_ldq_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldq_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint32_t cpu_ldub_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldub_data_ra(env, ptr, 0);
+}
+
+int cpu_ldsb_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldsb_data_ra(env, ptr, 0);
+}
+
+uint32_t cpu_lduw_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_lduw_data_ra(env, ptr, 0);
+}
+
+int cpu_ldsw_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldsw_data_ra(env, ptr, 0);
+}
+
+uint32_t cpu_ldl_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldl_data_ra(env, ptr, 0);
+}
+
+uint64_t cpu_ldq_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldq_data_ra(env, ptr, 0);
+}
+
 /*
  * Store Helpers
  */
@@ -1970,6 +2031,50 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
     cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEQ);
 }
 
+void cpu_stb_data_ra(CPUArchState *env, target_ulong ptr,
+                     uint32_t val, uintptr_t retaddr)
+{
+    cpu_stb_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stw_data_ra(CPUArchState *env, target_ulong ptr,
+                     uint32_t val, uintptr_t retaddr)
+{
+    cpu_stw_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stl_data_ra(CPUArchState *env, target_ulong ptr,
+                     uint32_t val, uintptr_t retaddr)
+{
+    cpu_stl_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stq_data_ra(CPUArchState *env, target_ulong ptr,
+                     uint64_t val, uintptr_t retaddr)
+{
+    cpu_stq_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stb_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+{
+    cpu_stb_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stw_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+{
+    cpu_stw_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stl_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+{
+    cpu_stl_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stq_data(CPUArchState *env, target_ulong ptr, uint64_t val)
+{
+    cpu_stq_data_ra(env, ptr, val, 0);
+}
+
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
    them callable from other helpers.  */
 
-- 
2.20.1


