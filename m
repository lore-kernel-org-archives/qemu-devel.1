Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B561C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4846206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fE37pb4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4846206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrD9-0000ht-5z
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8q-0002E9-Da
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsr8n-0000pc-16
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46242)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsr8i-0000eG-Qi
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:07:46 -0400
Received: by mail-wr1-x443.google.com with SMTP id z1so70279280wru.13
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AexkS+KIZIi617DuYDFY2BBLLVS//3vHoI6KKZ6c7Dk=;
 b=fE37pb4HagnHfPebsD/2E/4jDX5VgWAr8uk0/gFxfhr1gdwulCuL8+seSekmg60X9q
 0nySGwSMoU7fiNeEOPFBlHw6Sf4Zw3wuJEpfWdzRfr7JTOvuVQ5nC5MH8J36Z+8AWnTF
 dmZI/iyLkTb+hrxdtw90DClOaLBHG/3t4o3L5H8RC6asIGomiIJhP+NiEvllMehFzTEF
 gcnch0zmEHL/RJwU4BOhBFUYAfx2P8R+eBNW/QRqGaS+yELpXIlySNKDNzsjvLh1yJ6B
 8Felpt3U47CATL699gDL1oXO027lVqlhmq4cAW91QgLGp5flctlzuFSTfttf1h1RuV1P
 IYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AexkS+KIZIi617DuYDFY2BBLLVS//3vHoI6KKZ6c7Dk=;
 b=KptTEEG2Ncqhs6uKtAmBjqpQMRKVLxWydqnub4QR43FW8y8VyhOc31KPnUdbb3KuUM
 plyaemLLZEBSuiP2kCP1HA2CPlqRvH5VrQ1omFB+l5gwsosKlCsgWG50kFrEUTm1GQvL
 402UEHjcVMGnNp8hTa2ZIYwoMkMqZrshsOM7596MlbSvvNjc0VUydVVBIVcrULKBBFUH
 mnA84yKWmSqjE4yTNDvViJ9O2ELoa/mBzaIgVcJ2vKN2iWUxGHiZHL8wFqd2+cJ016N0
 d8dPwYjrUhYHP3BHgLE2BPW34iFfOcwd1UbBrnhmOgpH17EUwW5dC7ofgHWY2sych/y9
 BX5w==
X-Gm-Message-State: APjAAAU3qhS4PGJqlPLH082aH2meqc0ZD36tq2gXoR/HQO/OOXJbJKg3
 IZ0AkqfLoErxykMU7nxxIDNh/gtD1Mg=
X-Google-Smtp-Source: APXvYqzojp/RM57Z9oEOISILqAZQPblszdO67p49hnu+7jIemlH9AURob6jlTa4EePHUIaNt1FftgA==
X-Received: by 2002:adf:f206:: with SMTP id p6mr63923775wro.216.1564589245376; 
 Wed, 31 Jul 2019 09:07:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k17sm90660728wrq.83.2019.07.31.09.07.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:07:23 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1D8661FF96;
 Wed, 31 Jul 2019 17:07:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:32 +0100
Message-Id: <20190731160719.11396-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH  v4 07/54] trace: add mmu_index to mem_info
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
Cc: Riku Voipio <riku.voipio@iki.fi>, aaron@os.amperecomputing.com,
 cota@braap.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, bobby.prani@gmail.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to re-use mem_info later for plugins and will need to
track the mmu_idx for softmmu code.

[TODO: convert everything to use TCGMemOpIdx?]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/atomic_template.h               |  6 ++---
 accel/tcg/cputlb.c                        |  2 ++
 accel/tcg/user-exec.c                     |  1 +
 include/exec/cpu_ldst_template.h          | 15 +++++------
 include/exec/cpu_ldst_useronly_template.h |  6 ++---
 scripts/tracetool/transform.py            |  1 +
 tcg/tcg-op.c                              |  8 +++---
 trace-events                              |  6 +++--
 trace/mem-internal.h                      | 31 ++++++++++++++++-------
 trace/mem.h                               |  7 ++---
 10 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 5aaf1862539..313a4c7ed97 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -60,7 +60,7 @@
 #endif
 
 #define ATOMIC_TRACE_RMW do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false, ATOMIC_MMU_IDX); \
                                                                         \
         trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
         trace_guest_mem_before_exec(env_cpu(env), addr,             \
@@ -68,13 +68,13 @@
     } while (0)
 
 #define ATOMIC_TRACE_LD do {                                            \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false, ATOMIC_MMU_IDX); \
                                                                         \
         trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
     } while (0)
 
 # define ATOMIC_TRACE_ST do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true); \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true, ATOMIC_MMU_IDX); \
                                                                         \
         trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
     } while (0)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bb9897b25a3..bffdb251580 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1692,6 +1692,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
             memory_notdirty_write_complete(&ndi);       \
         }                                               \
     } while (0)
+#define ATOMIC_MMU_IDX oi
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
@@ -1734,6 +1735,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #define DATA_SIZE 8
 #include "atomic_template.h"
 #endif
+#undef ATOMIC_MMU_IDX
 
 /* Code access functions.  */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 897d1571c4a..bff1934cf1b 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -719,6 +719,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define ATOMIC_MMU_DECLS do {} while (0)
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
 #define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
+#define ATOMIC_MMU_IDX 0
 
 #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
 #define EXTRA_ARGS
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index af7e0b49f2d..5750a26b9ec 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -84,17 +84,16 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     CPUTLBEntry *entry;
     RES_TYPE res;
     target_ulong addr;
-    int mmu_idx;
+    int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+        trace_mem_build_info(SHIFT, false, MO_TE, false, mmu_idx));
 #endif
 
     addr = ptr;
-    mmu_idx = CPU_MMU_INDEX;
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
@@ -123,17 +122,16 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     CPUTLBEntry *entry;
     int res;
     target_ulong addr;
-    int mmu_idx;
+    int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+        trace_mem_build_info(SHIFT, true, MO_TE, false, mmu_idx));
 #endif
 
     addr = ptr;
-    mmu_idx = CPU_MMU_INDEX;
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
@@ -165,17 +163,16 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 {
     CPUTLBEntry *entry;
     target_ulong addr;
-    int mmu_idx;
+    int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+        trace_mem_build_info(SHIFT, false, MO_TE, true, mmu_idx));
 #endif
 
     addr = ptr;
-    mmu_idx = CPU_MMU_INDEX;
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(tlb_addr_write(entry) !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 2378f2958c9..8f7f117ad44 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -73,7 +73,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 #else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+        trace_mem_build_info(SHIFT, false, MO_TE, false, 0));
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 #endif
 }
@@ -105,7 +105,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 #else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+        trace_mem_build_info(SHIFT, true, MO_TE, false, 0));
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
 #endif
 }
@@ -132,7 +132,7 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
 {
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+        trace_mem_build_info(SHIFT, false, MO_TE, true, 0));
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
 }
 
diff --git a/scripts/tracetool/transform.py b/scripts/tracetool/transform.py
index e18b05315ef..2ca9286046d 100644
--- a/scripts/tracetool/transform.py
+++ b/scripts/tracetool/transform.py
@@ -83,6 +83,7 @@ TCG_2_HOST = {
 
 HOST_2_TCG_COMPAT = {
     "uint8_t": "uint32_t",
+    "uint16_t": "uint32_t",
     }
 
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 587d0922384..38e62dcba97 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2795,7 +2795,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+                               addr, trace_mem_get_info(memop, idx, 0));
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2832,7 +2832,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+                               addr, trace_mem_get_info(memop, idx, 1));
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i32();
@@ -2875,7 +2875,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 1, 0);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+                               addr, trace_mem_get_info(memop, idx, 0));
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2923,7 +2923,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, TCGMemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+                               addr, trace_mem_get_info(memop, idx, 1));
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i64();
diff --git a/trace-events b/trace-events
index 63bb192ade6..9f15a0c1fe6 100644
--- a/trace-events
+++ b/trace-events
@@ -152,12 +152,14 @@ vcpu guest_cpu_reset(void)
 #     uint8_t size_shift : 4; /* interpreted as "1 << size_shift" bytes */
 #     bool    sign_extend: 1; /* sign-extended */
 #     uint8_t endianness : 1; /* 0: little, 1: big */
-#     bool    store      : 1; /* wheter it's a store operation */
+#     bool    store      : 1; /* whether it is a store operation */
+#             pad        : 1;
+#     uint8_t mmuidx     : 4; /* mmuidx (softmmu only)  */
 # };
 #
 # Mode: user, softmmu
 # Targets: TCG(all)
-vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
+vcpu tcg guest_mem_before(TCGv vaddr, uint16_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
 
 # linux-user/syscall.c
 # bsd-user/syscall.c
diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index f6efaf6d6b7..35da998c16b 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -14,11 +14,13 @@
 #define TRACE_MEM_SE (1ULL << 3)    /* sign extended (y/n) */
 #define TRACE_MEM_BE (1ULL << 4)    /* big endian (y/n) */
 #define TRACE_MEM_ST (1ULL << 5)    /* store (y/n) */
+#define TRACE_MEM_MMU_SHIFT 8       /* mmu idx */
 
-static inline uint8_t trace_mem_build_info(
-    int size_shift, bool sign_extend, TCGMemOp endianness, bool store)
+static inline uint16_t trace_mem_build_info(
+    int size_shift, bool sign_extend, TCGMemOp endianness,
+    bool store, unsigned int mmu_idx)
 {
-    uint8_t res;
+    uint16_t res;
 
     res = size_shift & TRACE_MEM_SZ_SHIFT_MASK;
     if (sign_extend) {
@@ -30,25 +32,36 @@ static inline uint8_t trace_mem_build_info(
     if (store) {
         res |= TRACE_MEM_ST;
     }
+#ifdef CONFIG_SOFTMMU
+    res |= mmu_idx << TRACE_MEM_MMU_SHIFT;
+#endif
     return res;
 }
 
-static inline uint8_t trace_mem_get_info(TCGMemOp op, bool store)
+static inline uint16_t trace_mem_get_info(TCGMemOp op,
+                                          unsigned int mmu_idx,
+                                          bool store)
 {
     return trace_mem_build_info(op & MO_SIZE, !!(op & MO_SIGN),
-                                op & MO_BSWAP, store);
+                                op & MO_BSWAP, store,
+                                mmu_idx);
 }
 
+/* Used by the atomic helpers */
 static inline
-uint8_t trace_mem_build_info_no_se_be(int size_shift, bool store)
+uint16_t trace_mem_build_info_no_se_be(int size_shift, bool store,
+                                       TCGMemOpIdx oi)
 {
-    return trace_mem_build_info(size_shift, false, MO_BE, store);
+    return trace_mem_build_info(size_shift, false, MO_BE, store,
+                                get_mmuidx(oi));
 }
 
 static inline
-uint8_t trace_mem_build_info_no_se_le(int size_shift, bool store)
+uint16_t trace_mem_build_info_no_se_le(int size_shift, bool store,
+                                       TCGMemOpIdx oi)
 {
-    return trace_mem_build_info(size_shift, false, MO_LE, store);
+    return trace_mem_build_info(size_shift, false, MO_LE, store,
+                                get_mmuidx(oi));
 }
 
 #endif /* TRACE__MEM_INTERNAL_H */
diff --git a/trace/mem.h b/trace/mem.h
index 2b58196e536..0f9cd4862ac 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -18,15 +18,16 @@
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_get_info(TCGMemOp op, bool store);
+static uint16_t trace_mem_get_info(TCGMemOp op, unsigned int mmu_idx, bool store);
 
 /**
  * trace_mem_build_info:
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_build_info(int size_shift, bool sign_extend,
-                                    TCGMemOp endianness, bool store);
+static uint16_t trace_mem_build_info(int size_shift, bool sign_extend,
+                                     TCGMemOp endianness, bool store,
+                                     unsigned int mmuidx);
 
 
 #include "trace/mem-internal.h"
-- 
2.20.1


