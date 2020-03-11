Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEF5C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC1D20873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrtmWX0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC1D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBvFb-0003Xh-KN
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6l-0006Xj-TB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBv6j-00026Y-Kh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:46 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBv6j-00025r-F3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:44:45 -0400
Received: by mail-pg1-x541.google.com with SMTP id t24so635026pgj.7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j19UswlgyGkpUPAbfqRH89tG+gAVqbIVGxthtVV4itA=;
 b=CrtmWX0NIBqwTNOCpdyYTnzEErpf+EQg+JsW/Sv2a7jjjAG5F1LzZJLIq8zeni96rz
 z4fCuaKRU9ANW99qtYHBq5vK3OeZYUy4/crU7iXPTPFuIC1PqGKEVVKXuw1aDFQ0RGZ0
 ldl6/jqFKrH4g3p8AQHi8E3fd66wA78XLLuMZkHukNdWL4EeJFD7IlbmZHSihj4DcR7X
 QqdQI/mwtZwBscZo68mxG0yGy1MyUIo3K4hDxjJujyPtJgAIICvgqRyLP9Q+1dyZo1dt
 xIgEce01eEgsqsOylmCdyivRQlJYCBxx2zTabKZzh2mB74p0zWvw3YHRZqKwjXHlnAKg
 vhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j19UswlgyGkpUPAbfqRH89tG+gAVqbIVGxthtVV4itA=;
 b=j1PLcEgOu3TDjr9dhZZymrMAPEXg7736pXUO5ccpqHT+/4qFk5BZRIJ3HLisIfT3Tv
 Lt81BV4etKAdJZduCA+pB4moKhx+HDr5ghmvAKLo6gC7/jNOcqUnw38vqWaR4sKiChR5
 BeZwcH87fGioFRiVy9TK3Zs2rZz7mG0AK6di7PCqh7GeimqxnTeicHppBelda9pOYa6U
 9Tgxn3EgrpzGcGyHW5puEncfv7tkWRd+ZHHC4T7wa+9AAcHwjy+PB9tdyRWdITt6sZce
 BFDMq1IX6ZUqp2r59j+w8hk13CTMa0KeQdji9jMuc6jqoNvksfRTHmpFaIaGOhrarr+z
 b7dw==
X-Gm-Message-State: ANhLgQ37KnOfmeRGt5orNST7HmyHpuqoZ8eaVNcbalrzhMGNGK6Vwoh1
 2j8KuEPBaB1KOHnzvlw2Ovcq+TEMcyA=
X-Google-Smtp-Source: ADFU+vuJraqm0vVdGSTHT8hV4/ij8d2+cQ6D7a/ztx5Erckk3iEOavFOZ491zm8NJQ0f8Q9VF0wiiA==
X-Received: by 2002:a63:82c2:: with SMTP id w185mr1505089pgd.382.1583909083428; 
 Tue, 10 Mar 2020 23:44:43 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id z3sm50137807pfz.155.2020.03.10.23.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 23:44:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/16] target/arm: Remove sve_memopidx
Date: Tue, 10 Mar 2020 23:44:20 -0700
Message-Id: <20200311064420.30606-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200311064420.30606-1-richard.henderson@linaro.org>
References: <20200311064420.30606-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

None of the sve helpers use TCGMemOpIdx any longer, so we can
stop passing it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     |  5 -----
 target/arm/sve_helper.c    | 14 +++++++-------
 target/arm/translate-sve.c | 17 +++--------------
 3 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index e633aff36e..a833e3941d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -979,11 +979,6 @@ static inline int arm_num_ctx_cmps(ARMCPU *cpu)
     }
 }
 
-/* Note make_memop_idx reserves 4 bits for mmu_idx, and MO_BSWAP is bit 3.
- * Thus a TCGMemOpIdx, without any MO_ALIGN bits, fits in 8 bits.
- */
-#define MEMOPIDX_SHIFT  8
-
 /**
  * v7m_using_psp: Return true if using process stack pointer
  * Return true if the CPU is currently using the process stack
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4ad870f1ee..80453953ad 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4447,7 +4447,7 @@ void sve_ldN_r(CPUARMState *env, uint64_t *vg, const target_ulong addr,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    const unsigned rd = simd_data(desc);
     const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off, reg_last, mem_off;
     SVEContLdSt info;
@@ -4703,7 +4703,7 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
 {
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    const unsigned rd = simd_data(desc);
     void *vd = &env->vfp.zregs[rd];
     const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off, mem_off, reg_last;
@@ -4926,7 +4926,7 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const unsigned rd = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 5);
+    const unsigned rd = simd_data(desc);
     const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off, reg_last, mem_off;
     SVEContLdSt info;
@@ -5132,9 +5132,9 @@ void sve_ld1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     const int mmu_idx = cpu_mmu_index(env, false);
     const intptr_t reg_max = simd_oprsz(desc);
+    const int scale = simd_data(desc);
     ARMVectorReg scratch;
     intptr_t reg_off;
     SVEHostPage info, info2;
@@ -5277,10 +5277,10 @@ void sve_ldff1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                  sve_ldst1_tlb_fn *tlb_fn)
 {
     const int mmu_idx = cpu_mmu_index(env, false);
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
+    const intptr_t reg_max = simd_oprsz(desc);
+    const int scale = simd_data(desc);
     const int esize = 1 << esz;
     const int msize = 1 << msz;
-    const intptr_t reg_max = simd_oprsz(desc);
     intptr_t reg_off;
     SVEHostPage info;
     target_ulong addr, in_page;
@@ -5431,9 +5431,9 @@ void sve_st1_z(CPUARMState *env, void *vd, uint64_t *vg, void *vm,
                sve_ldst1_host_fn *host_fn,
                sve_ldst1_tlb_fn *tlb_fn)
 {
-    const int scale = extract32(desc, SIMD_DATA_SHIFT + MEMOPIDX_SHIFT, 2);
     const int mmu_idx = cpu_mmu_index(env, false);
     const intptr_t reg_max = simd_oprsz(desc);
+    const int scale = simd_data(desc);
     void *host[ARM_MAX_VQ * 4];
     intptr_t reg_off, i;
     SVEHostPage info, info2;
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b35bad245e..7bd7de80e6 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4584,11 +4584,6 @@ static const uint8_t dtype_esz[16] = {
     3, 2, 1, 3
 };
 
-static TCGMemOpIdx sve_memopidx(DisasContext *s, int dtype)
-{
-    return make_memop_idx(s->be_data | dtype_mop[dtype], get_mem_index(s));
-}
-
 static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                        int dtype, gen_helper_gvec_mem *fn)
 {
@@ -4601,9 +4596,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
      * registers as pointers, so encode the regno into the data field.
      * For consistency, do this even for LD1.
      */
-    desc = sve_memopidx(s, dtype);
-    desc |= zt << MEMOPIDX_SHIFT;
-    desc = simd_desc(vsz, vsz, desc);
+    desc = simd_desc(vsz, vsz, zt);
     t_desc = tcg_const_i32(desc);
     t_pg = tcg_temp_new_ptr();
 
@@ -4835,9 +4828,7 @@ static void do_ldrq(DisasContext *s, int zt, int pg, TCGv_i64 addr, int msz)
     int desc, poff;
 
     /* Load the first quadword using the normal predicated load helpers.  */
-    desc = sve_memopidx(s, msz_dtype(s, msz));
-    desc |= zt << MEMOPIDX_SHIFT;
-    desc = simd_desc(16, 16, desc);
+    desc = simd_desc(16, 16, zt);
     t_desc = tcg_const_i32(desc);
 
     poff = pred_full_reg_offset(s, pg);
@@ -5066,9 +5057,7 @@ static void do_mem_zpz(DisasContext *s, int zt, int pg, int zm,
     TCGv_i32 t_desc;
     int desc;
 
-    desc = sve_memopidx(s, msz_dtype(s, msz));
-    desc |= scale << MEMOPIDX_SHIFT;
-    desc = simd_desc(vsz, vsz, desc);
+    desc = simd_desc(vsz, vsz, scale);
     t_desc = tcg_const_i32(desc);
 
     tcg_gen_addi_ptr(t_pg, cpu_env, pred_full_reg_offset(s, pg));
-- 
2.20.1


