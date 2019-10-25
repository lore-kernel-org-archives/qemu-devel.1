Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CA4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E57206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWd7+Unj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E57206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNu2O-0002lY-CU
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN6-00087b-Pl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtN2-0003F4-T7
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:42578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtMz-0003Ak-UE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id r1so925387wrs.9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vPFAO1P3yheq7LPHs2PUsFCtoO1DNS7CzmpaZxf7x2Y=;
 b=mWd7+Unj/DkuSbKRgcqNqUOpzBCnr4XD+xP5trNpP2dInpeKU/zs7lxpfv8Sbhb4YG
 Z21JRbGVC3pk8pX8WQEO4gXrtijp38lJqzTyrrH/HvyDo3SnqHCSnVvqnzR6ZzejIk/J
 l6Vw6VVNmJOjh0IUlGxNmq0BcPhgjCm2AFyh93rDUyu9Ge8geqHRmq9xFB1oFE9fcot2
 eCWukOCMAWaA3QHXbxOFy6Wi60c6Bm8aXZIrYS+ia2hMCz46IPHeBtrW4HSAc/bJHwii
 VtzQSEhF1EvDkCO2NA5ztYyZoP7MLSmuCZdlWnm+xiLiL0B0XMs5sJXbyNtwvLCpMqSM
 7OMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vPFAO1P3yheq7LPHs2PUsFCtoO1DNS7CzmpaZxf7x2Y=;
 b=H5UHC6gBtqyEYfRrAThNqfotkwDMHPSlrmiwZuZwAKB705y7auA5as2ghijki+2ZHz
 Tuo1Wt86r23VsSzouWkT3Tb8jHpLY0HsuWhhloZlvWpTA3zo0Ut0Dzs/QZF9xyODx+ck
 +BVeH3+IBmbLJJ//lNDZlm3jEF6roXeQ9o9bPdVTfXZwiltsd39LVNzYfqMVZx5zSoCK
 1Gh76Rmj3lr47A/n0k+GyQhxrScCyyoZP+TINCCddLEIngUKpP2o4//71H8bHVx4x4eA
 kIlgXP5edcibsyCrKwdyjuc5uDTr1CIdF7pBd5PTa7WeADnyu7C5uSIiNweThgI/noxG
 epqQ==
X-Gm-Message-State: APjAAAVqS8mZg/S2Exdv4OAGArrQJuA0Sf4YgAdkqVi3llCWWv8voUP9
 LW4KTleX5r+5VK2iq+eGStOKiQ==
X-Google-Smtp-Source: APXvYqydn5/w/UlvQnHcbNrnlhewPYqntylP8wzIp/C0jv6MJwLvNWQM0ui+dDnX28e/0CnEfUqLtw==
X-Received: by 2002:a05:6000:92:: with SMTP id
 m18mr1360524wrx.105.1571985999712; 
 Thu, 24 Oct 2019 23:46:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a186sm1359813wmd.3.2019.10.24.23.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:36 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 61A551FFA6;
 Fri, 25 Oct 2019 07:37:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 18/73] trace: add mmu_index to mem_info
Date: Fri, 25 Oct 2019 07:36:18 +0100
Message-Id: <20191025063713.23374-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to re-use mem_info later for plugins and will need to
track the mmu_idx for softmmu code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 287433d809b..473d7e5a943 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -60,23 +60,26 @@
 #endif
 
 #define ATOMIC_TRACE_RMW do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)          \
+            (SHIFT, false, ATOMIC_MMU_IDX);                             \
                                                                         \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
-        trace_guest_mem_before_exec(env_cpu(env), addr,             \
+        trace_guest_mem_before_exec(env_cpu(env), addr, info);          \
+        trace_guest_mem_before_exec(env_cpu(env), addr,                 \
                                     info | TRACE_MEM_ST);               \
     } while (0)
 
 #define ATOMIC_TRACE_LD do {                                            \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)          \
+            (SHIFT, false, ATOMIC_MMU_IDX);                             \
                                                                         \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
+        trace_guest_mem_before_exec(env_cpu(env), addr, info);          \
     } while (0)
 
-# define ATOMIC_TRACE_ST do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true); \
-                                                                        \
-        trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
+#define ATOMIC_TRACE_ST do {                                           \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)         \
+            (SHIFT, true, ATOMIC_MMU_IDX);                             \
+                                                                       \
+        trace_guest_mem_before_exec(env_cpu(env), addr, info);         \
     } while (0)
 
 /* Define host-endian atomic operations.  Note that END is used within
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index defc8d59292..a8f90695823 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1811,6 +1811,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #define ATOMIC_MMU_DECLS
 #define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr)
 #define ATOMIC_MMU_CLEANUP
+#define ATOMIC_MMU_IDX   get_mmuidx(oi)
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
@@ -1853,6 +1854,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #define DATA_SIZE 8
 #include "atomic_template.h"
 #endif
+#undef ATOMIC_MMU_IDX
 
 /* Code access functions.  */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 71c4bf6477d..8d315a65876 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -751,6 +751,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define ATOMIC_MMU_DECLS do {} while (0)
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
 #define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
+#define ATOMIC_MMU_IDX MMU_USER_IDX
 
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
index 2378f2958c9..93ad532f943 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -73,7 +73,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 #else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+        trace_mem_build_info(SHIFT, false, MO_TE, false, MMU_USER_IDX));
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 #endif
 }
@@ -105,7 +105,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 #else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+        trace_mem_build_info(SHIFT, true, MO_TE, false, MMU_USER_IDX));
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
 #endif
 }
@@ -132,7 +132,7 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
 {
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+        trace_mem_build_info(SHIFT, false, MO_TE, true, MMU_USER_IDX));
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
index e87c327fbf9..1388bd344d3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2795,7 +2795,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+                               addr, trace_mem_get_info(memop, idx, 0));
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2832,7 +2832,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+                               addr, trace_mem_get_info(memop, idx, 1));
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i32();
@@ -2875,7 +2875,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 1, 0);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+                               addr, trace_mem_get_info(memop, idx, 0));
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2923,7 +2923,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+                               addr, trace_mem_get_info(memop, idx, 1));
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i64();
diff --git a/trace-events b/trace-events
index 22133dfd3fa..42107ebc697 100644
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
index 1a010c1b277..0a32aa22ca0 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -14,11 +14,13 @@
 #define TRACE_MEM_SE (1ULL << 4)    /* sign extended (y/n) */
 #define TRACE_MEM_BE (1ULL << 5)    /* big endian (y/n) */
 #define TRACE_MEM_ST (1ULL << 6)    /* store (y/n) */
+#define TRACE_MEM_MMU_SHIFT 8       /* mmu idx */
 
-static inline uint8_t trace_mem_build_info(
-    int size_shift, bool sign_extend, MemOp endianness, bool store)
+static inline uint16_t trace_mem_build_info(
+    int size_shift, bool sign_extend, MemOp endianness,
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
 
-static inline uint8_t trace_mem_get_info(MemOp op, bool store)
+static inline uint16_t trace_mem_get_info(MemOp op,
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
index 8cf213d85b8..9644f592b4f 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -18,15 +18,16 @@
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_get_info(MemOp op, bool store);
+static uint16_t trace_mem_get_info(MemOp op, unsigned int mmu_idx, bool store);
 
 /**
  * trace_mem_build_info:
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_build_info(int size_shift, bool sign_extend,
-                                    MemOp endianness, bool store);
+static uint16_t trace_mem_build_info(int size_shift, bool sign_extend,
+                                     MemOp endianness, bool store,
+                                     unsigned int mmuidx);
 
 
 #include "trace/mem-internal.h"
-- 
2.20.1


