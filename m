Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDBC4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B172073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gobkm0WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B172073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCKD-0007Ru-QL
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC3E-0001tS-AT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jUC38-0006fo-U9
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:40 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45206)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jUC38-0006fU-Hb
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:28:34 -0400
Received: by mail-pg1-x542.google.com with SMTP id s18so2963521pgl.12
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9amWqshE7k/NAq9a276bjEryeqReUJxYJNXk6wnm0Gs=;
 b=Gobkm0WNmpMHRxfsTJPPpQe1THDWEuBE4HoqM8uMSu8xFT782Am3ciUb1rl0orFLXw
 tU6M9p2X9ENP9h/7RYl0Czim2z/shB+nTKeEyOsvcMSd5kvBdQdDvwypt8KnPQSAEhA4
 JUex41Z/8Gu1RgSnjF1ExQ7QYmkj+vfMDpRmdCHQrHNmBwEdtQYdgdCGcHSDYc3FmEKU
 ti0kMyY5NyCn9Z6Ylm/Ak+wDwPW6WKyi5VZu/kExqDVc4tuqe3EIt+SlveSvbCcqtJOK
 htKlJuO0N5Upu8+V8YUF8UZsrzlyBJ2Gy8n8k0rFEPTl5NuV44SW5Um5BrEfpbxGHZ/M
 Xbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9amWqshE7k/NAq9a276bjEryeqReUJxYJNXk6wnm0Gs=;
 b=MIx2xKplMK2zcDII7hm795KHF0wGTLQ5pd/1XaPSnQLiZ1jTh452GdWAZTThfxN304
 BmqYiBnbtvWigls1HWdQyPOxpc0xZZctAj/FAW5JYKzQTUKbVNpPu1VK6xomglwmX4GF
 guebJ3qne9SgLAM9UjKL3VU07WqFBs3hKaVftgrRYemP2MbL8vO864NFSiBN7LcrwejF
 ng9dUBptBnhUtTUiMXeOT2btgyHNu0vl/+e7vf2w4dfOZcXQ3ulCE8eZFrauCP/5z/8G
 hSH91gIP/PlJY8Hw1hOzfpEruGvBgLQii+GVKVXO0TqFWs/K8QZIfNfvPfPO1R7kRClf
 FEPA==
X-Gm-Message-State: AGi0PubF4Tv3vG8wWEPKVJNbAFb4bkbVln4CSHGIdLB2thFLECS04S4e
 +X1NR/5mUUkBk4IHR/BReewentyUvXE=
X-Google-Smtp-Source: APiQypJzJ/r0qnlUhPI0BCQcD/Rg7FgF3/XzS+gOPEdbBT3BEn1Dxd83Abwz77rRflDbAy6Ghx2vMA==
X-Received: by 2002:a63:6285:: with SMTP id w127mr3812816pgb.449.1588264112321; 
 Thu, 30 Apr 2020 09:28:32 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id j5sm243514pfh.58.2020.04.30.09.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 09:28:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 12/18] target/arm: Use SVEContLdSt for multi-register
 contiguous loads
Date: Thu, 30 Apr 2020 09:28:07 -0700
Message-Id: <20200430162813.17671-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430162813.17671-1-richard.henderson@linaro.org>
References: <20200430162813.17671-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 223 ++++++++++++++--------------------------
 1 file changed, 79 insertions(+), 144 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 7992a569b0..9365e32646 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4449,27 +4449,28 @@ static inline bool test_host_page(void *host)
 }
 
 /*
- * Common helper for all contiguous one-register predicated loads.
+ * Common helper for all contiguous 1,2,3,4-register predicated stores.
  */
 static inline QEMU_ALWAYS_INLINE
-void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
+void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
                uint32_t desc, const uintptr_t retaddr,
-               const int esz, const int msz,
+               const int esz, const int msz, const int N,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
     const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    void *vd = &env->vfp.zregs[rd];
     const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off, reg_last, mem_off;
     SVEContLdSt info;
     void *host;
-    int flags;
+    int flags, i;
 
     /* Find the active elements.  */
-    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, 1 << msz)) {
+    if (!sve_cont_ldst_elements(&info, addr, vg, reg_max, esz, N << msz)) {
         /* The entire predicate was false; no load occurs.  */
-        memset(vd, 0, reg_max);
+        for (i = 0; i < N; ++i) {
+            memset(&env->vfp.zregs[(rd + i) & 31], 0, reg_max);
+        }
         return;
     }
 
@@ -4477,7 +4478,7 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
     sve_cont_ldst_pages(&info, FAULT_ALL, env, addr, MMU_DATA_LOAD, retaddr);
 
     /* Handle watchpoints for all active elements. */
-    sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, 1 << msz,
+    sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, N << msz,
                               BP_MEM_READ, retaddr);
 
     /* TODO: MTE check. */
@@ -4493,9 +4494,8 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
          * which for ARM will raise SyncExternal.  Perform the load
          * into scratch memory to preserve register state until the end.
          */
-        ARMVectorReg scratch;
+        ARMVectorReg scratch[4] = { };
 
-        memset(&scratch, 0, reg_max);
         mem_off = info.mem_off_first[0];
         reg_off = info.reg_off_first[0];
         reg_last = info.reg_off_last[1];
@@ -4510,21 +4510,29 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
             uint64_t pg = vg[reg_off >> 6];
             do {
                 if ((pg >> (reg_off & 63)) & 1) {
-                    tlb_fn(env, &scratch, reg_off, addr + mem_off, retaddr);
+                    for (i = 0; i < N; ++i) {
+                        tlb_fn(env, &scratch[i], reg_off,
+                               addr + mem_off + (i << msz), retaddr);
+                    }
                 }
                 reg_off += 1 << esz;
-                mem_off += 1 << msz;
+                mem_off += N << msz;
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
 
-        memcpy(vd, &scratch, reg_max);
+        for (i = 0; i < N; ++i) {
+            memcpy(&env->vfp.zregs[(rd + i) & 31], &scratch[i], reg_max);
+        }
         return;
 #endif
     }
 
     /* The entire operation is in RAM, on valid pages. */
 
-    memset(vd, 0, reg_max);
+    for (i = 0; i < N; ++i) {
+        memset(&env->vfp.zregs[(rd + i) & 31], 0, reg_max);
+    }
+
     mem_off = info.mem_off_first[0];
     reg_off = info.reg_off_first[0];
     reg_last = info.reg_off_last[0];
@@ -4534,10 +4542,13 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
         uint64_t pg = vg[reg_off >> 6];
         do {
             if ((pg >> (reg_off & 63)) & 1) {
-                host_fn(vd, reg_off, host + mem_off);
+                for (i = 0; i < N; ++i) {
+                    host_fn(&env->vfp.zregs[(rd + i) & 31], reg_off,
+                            host + mem_off + (i << msz));
+                }
             }
             reg_off += 1 << esz;
-            mem_off += 1 << msz;
+            mem_off += N << msz;
         } while (reg_off <= reg_last && (reg_off & 63));
     }
 
@@ -4547,7 +4558,11 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
      */
     mem_off = info.mem_off_split;
     if (unlikely(mem_off >= 0)) {
-        tlb_fn(env, vd, info.reg_off_split, addr + mem_off, retaddr);
+        reg_off = info.reg_off_split;
+        for (i = 0; i < N; ++i) {
+            tlb_fn(env, &env->vfp.zregs[(rd + i) & 31], reg_off,
+                   addr + mem_off + (i << msz), retaddr);
+        }
     }
 
     mem_off = info.mem_off_first[1];
@@ -4560,10 +4575,13 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
             uint64_t pg = vg[reg_off >> 6];
             do {
                 if ((pg >> (reg_off & 63)) & 1) {
-                    host_fn(vd, reg_off, host + mem_off);
+                    for (i = 0; i < N; ++i) {
+                        host_fn(&env->vfp.zregs[(rd + i) & 31], reg_off,
+                                host + mem_off + (i << msz));
+                    }
                 }
                 reg_off += 1 << esz;
-                mem_off += 1 << msz;
+                mem_off += N << msz;
             } while (reg_off & 63);
         } while (reg_off <= reg_last);
     }
@@ -4573,7 +4591,7 @@ void sve_ld1_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
 void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
                             target_ulong addr, uint32_t desc)  \
 {                                                              \
-    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, 0,            \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, 1,      \
               sve_##NAME##_host, sve_##NAME##_tlb);            \
 }
 
@@ -4581,159 +4599,76 @@ void HELPER(sve_##NAME##_r)(CPUARMState *env, void *vg,        \
 void HELPER(sve_##NAME##_le_r)(CPUARMState *env, void *vg,        \
                                target_ulong addr, uint32_t desc)  \
 {                                                                 \
-    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,          \
               sve_##NAME##_le_host, sve_##NAME##_le_tlb);         \
 }                                                                 \
 void HELPER(sve_##NAME##_be_r)(CPUARMState *env, void *vg,        \
                                target_ulong addr, uint32_t desc)  \
 {                                                                 \
-    sve_ld1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ,             \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, 1,          \
               sve_##NAME##_be_host, sve_##NAME##_be_tlb);         \
 }
 
-DO_LD1_1(ld1bb,  0)
-DO_LD1_1(ld1bhu, 1)
-DO_LD1_1(ld1bhs, 1)
-DO_LD1_1(ld1bsu, 2)
-DO_LD1_1(ld1bss, 2)
-DO_LD1_1(ld1bdu, 3)
-DO_LD1_1(ld1bds, 3)
+DO_LD1_1(ld1bb,  MO_8)
+DO_LD1_1(ld1bhu, MO_16)
+DO_LD1_1(ld1bhs, MO_16)
+DO_LD1_1(ld1bsu, MO_32)
+DO_LD1_1(ld1bss, MO_32)
+DO_LD1_1(ld1bdu, MO_64)
+DO_LD1_1(ld1bds, MO_64)
 
-DO_LD1_2(ld1hh,  1, 1)
-DO_LD1_2(ld1hsu, 2, 1)
-DO_LD1_2(ld1hss, 2, 1)
-DO_LD1_2(ld1hdu, 3, 1)
-DO_LD1_2(ld1hds, 3, 1)
+DO_LD1_2(ld1hh,  MO_16, MO_16)
+DO_LD1_2(ld1hsu, MO_32, MO_16)
+DO_LD1_2(ld1hss, MO_32, MO_16)
+DO_LD1_2(ld1hdu, MO_64, MO_16)
+DO_LD1_2(ld1hds, MO_64, MO_16)
 
-DO_LD1_2(ld1ss,  2, 2)
-DO_LD1_2(ld1sdu, 3, 2)
-DO_LD1_2(ld1sds, 3, 2)
+DO_LD1_2(ld1ss,  MO_32, MO_32)
+DO_LD1_2(ld1sdu, MO_64, MO_32)
+DO_LD1_2(ld1sds, MO_64, MO_32)
 
-DO_LD1_2(ld1dd,  3, 3)
+DO_LD1_2(ld1dd,  MO_64, MO_64)
 
 #undef DO_LD1_1
 #undef DO_LD1_2
 
-/*
- * Common helpers for all contiguous 2,3,4-register predicated loads.
- */
-static void sve_ld2_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, int size, uintptr_t ra,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    ARMVectorReg scratch[2] = { };
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, ra);
-            }
-            i += size, pg >>= size;
-            addr += 2 * size;
-        } while (i & 15);
-    }
-
-    /* Wait until all exceptions have been raised to write back.  */
-    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
-}
-
-static void sve_ld3_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, int size, uintptr_t ra,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    ARMVectorReg scratch[3] = { };
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, ra);
-                tlb_fn(env, &scratch[2], i, addr + 2 * size, ra);
-            }
-            i += size, pg >>= size;
-            addr += 3 * size;
-        } while (i & 15);
-    }
-
-    /* Wait until all exceptions have been raised to write back.  */
-    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 2) & 31], &scratch[2], oprsz);
-}
-
-static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
-                      uint32_t desc, int size, uintptr_t ra,
-                      sve_ldst1_tlb_fn *tlb_fn)
-{
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
-    intptr_t i, oprsz = simd_oprsz(desc);
-    ARMVectorReg scratch[4] = { };
-
-    for (i = 0; i < oprsz; ) {
-        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));
-        do {
-            if (pg & 1) {
-                tlb_fn(env, &scratch[0], i, addr, ra);
-                tlb_fn(env, &scratch[1], i, addr + size, ra);
-                tlb_fn(env, &scratch[2], i, addr + 2 * size, ra);
-                tlb_fn(env, &scratch[3], i, addr + 3 * size, ra);
-            }
-            i += size, pg >>= size;
-            addr += 4 * size;
-        } while (i & 15);
-    }
-
-    /* Wait until all exceptions have been raised to write back.  */
-    memcpy(&env->vfp.zregs[rd], &scratch[0], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 1) & 31], &scratch[1], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 2) & 31], &scratch[2], oprsz);
-    memcpy(&env->vfp.zregs[(rd + 3) & 31], &scratch[3], oprsz);
-}
-
 #define DO_LDN_1(N) \
-void QEMU_FLATTEN HELPER(sve_ld##N##bb_r) \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
-{                                                                   \
-    sve_ld##N##_r(env, vg, addr, desc, 1, GETPC(), sve_ld1bb_tlb);  \
+void HELPER(sve_ld##N##bb_r)(CPUARMState *env, void *vg,        \
+                             target_ulong addr, uint32_t desc)  \
+{                                                               \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), MO_8, MO_8, N,      \
+              sve_ld1bb_host, sve_ld1bb_tlb);                   \
 }
 
-#define DO_LDN_2(N, SUFF, SIZE)                                       \
-void QEMU_FLATTEN HELPER(sve_ld##N##SUFF##_le_r)                      \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+#define DO_LDN_2(N, SUFF, ESZ) \
+void HELPER(sve_ld##N##SUFF##_le_r)(CPUARMState *env, void *vg,       \
+                                    target_ulong addr, uint32_t desc) \
 {                                                                     \
-    sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
-                  sve_ld1##SUFF##_le_tlb);                            \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,              \
+              sve_ld1##SUFF##_le_host, sve_ld1##SUFF##_le_tlb);       \
 }                                                                     \
-void QEMU_FLATTEN HELPER(sve_ld##N##SUFF##_be_r)                      \
-    (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
+void HELPER(sve_ld##N##SUFF##_be_r)(CPUARMState *env, void *vg,       \
+                                    target_ulong addr, uint32_t desc) \
 {                                                                     \
-    sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
-                  sve_ld1##SUFF##_be_tlb);                            \
+    sve_ldN_r(env, vg, addr, desc, GETPC(), ESZ, ESZ, N,              \
+              sve_ld1##SUFF##_be_host, sve_ld1##SUFF##_be_tlb);       \
 }
 
 DO_LDN_1(2)
 DO_LDN_1(3)
 DO_LDN_1(4)
 
-DO_LDN_2(2, hh, 2)
-DO_LDN_2(3, hh, 2)
-DO_LDN_2(4, hh, 2)
+DO_LDN_2(2, hh, MO_16)
+DO_LDN_2(3, hh, MO_16)
+DO_LDN_2(4, hh, MO_16)
 
-DO_LDN_2(2, ss, 4)
-DO_LDN_2(3, ss, 4)
-DO_LDN_2(4, ss, 4)
+DO_LDN_2(2, ss, MO_32)
+DO_LDN_2(3, ss, MO_32)
+DO_LDN_2(4, ss, MO_32)
 
-DO_LDN_2(2, dd, 8)
-DO_LDN_2(3, dd, 8)
-DO_LDN_2(4, dd, 8)
+DO_LDN_2(2, dd, MO_64)
+DO_LDN_2(3, dd, MO_64)
+DO_LDN_2(4, dd, MO_64)
 
 #undef DO_LDN_1
 #undef DO_LDN_2
-- 
2.20.1


