Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202F8C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853DE20724
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 01:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyZqC1WU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853DE20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR4Ls-00032I-6f
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 21:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41d-00026S-BN
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR41b-0002gN-In
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:05 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR41a-0002cQ-4v
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 21:18:03 -0400
Received: by mail-pg1-x543.google.com with SMTP id d17so271097pgo.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 18:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nAoj3X5OTVqp+eKDn7XYP1jFDC+EKazjlRlIVTmBXzM=;
 b=QyZqC1WUWJCtbrWD8ZdJ/fjuzbQve27iE8lU933ip/XTZrHHY12Yt/eLevLHSD3nyk
 VJn2bAqcrm22jvPCjg516xDSSgIyyywn7ARYCIoOxH1sn8dt10Ds+4HBsJC26LLOONhe
 5ZNshvBcjUJnou6xcWfhuvpexcxccphEKfrSzVs7QtojVLSA9FNYavgwUFwzUQc7nuWa
 AbzK0fIWdzbMeaOBnc8+amTS4cnUokrOZJTYhAUAQs6jza3oUA8PlS7Y6+dbjny/ctWC
 fZDnMJGrP1yJ6ti4P8oH3JhXn/xWiqZLb4cru+eyN5ytX8moZdgMo87AlDf9AghEH14r
 i9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nAoj3X5OTVqp+eKDn7XYP1jFDC+EKazjlRlIVTmBXzM=;
 b=m6mAE/bZK9uyEcvC1grCN+PuZyP1mH7EUX3YqcASVS/64Ll9OcZ8T7J0j2HeyZODzF
 jHu0USYgl29YjlvUBXkcVmwsWTFIXJRbCedFK3y1pGrHnxUURSOSfQDCscEUALe9NNs0
 hkCZALCk/OB9NdL5aAknTbkG+3WB84a64iwc6yhHALfd0YSuJPqdiI3108I6A6g+u2eo
 SmRaUR7JAG/xRd6no8K9/qs57lAyGXSPLhgrAH+x5YvmVcItc5iypyI15TRsexHhmZDv
 QANT/y1EUOzT7HR8bRV6h/ftXa2p6auP8gAyExkoBQick+giYm2XbPU7XS2VFNWBIx0T
 hniw==
X-Gm-Message-State: AGi0Pua4AYs5GMtssvVhe3gFH67JFJyx9daq/DupEwzMFnZ/4XAleGB2
 OYl2uN0t7fznJEPiwbkyTV23ls9Rmys=
X-Google-Smtp-Source: APiQypLseS8ccds2C/pBym4/cyQZhZzbdgn2luozJE2MiBjdVfSfmALXXCPKAKF1kKvSX9hTkORkvw==
X-Received: by 2002:aa7:843a:: with SMTP id q26mr17449862pfn.240.1587518279183; 
 Tue, 21 Apr 2020 18:17:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id m4sm3673561pfm.26.2020.04.21.18.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 18:17:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/36] tcg: Implement gvec support for rotate by immediate
Date: Tue, 21 Apr 2020 18:17:14 -0700
Message-Id: <20200422011722.13287-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422011722.13287-1-richard.henderson@linaro.org>
References: <20200422011722.13287-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No host backend support yet, but the interfaces for rotli
are in place.  Canonicalize immediate rotate to the left,
based on a survey of architectures, but provide both left
and right shift interfaces to the translators.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |  5 +++
 include/tcg/tcg-op-gvec.h    |  6 ++++
 include/tcg/tcg-op.h         |  2 ++
 include/tcg/tcg-opc.h        |  1 +
 include/tcg/tcg.h            |  1 +
 tcg/aarch64/tcg-target.h     |  1 +
 tcg/i386/tcg-target.h        |  1 +
 tcg/ppc/tcg-target.h         |  1 +
 accel/tcg/tcg-runtime-gvec.c | 48 +++++++++++++++++++++++++
 tcg/tcg-op-gvec.c            | 68 ++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c             | 12 +++++++
 tcg/tcg.c                    |  2 ++
 tcg/README                   |  3 +-
 13 files changed, 150 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 4fa61b49b4..cf10c8361e 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -259,6 +259,11 @@ DEF_HELPER_FLAGS_3(gvec_sar16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(gvec_sar64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_rotl8i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_rotl16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_rotl32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_rotl64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_shl8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_shl16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_shl32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index cea6497341..1afc3ebf03 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -334,6 +334,10 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_rotri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 
 void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
                        TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
@@ -388,5 +392,7 @@ void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
 void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
 void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
 void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+void tcg_gen_vec_rotl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c);
+void tcg_gen_vec_rotl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c);
 
 #endif
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index b07bf7b524..c624e371d5 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -986,6 +986,8 @@ void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
+void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
 void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
 void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 4a9cbf5426..c46c096c3e 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -245,6 +245,7 @@ DEF(not_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_not_vec))
 DEF(shli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
 DEF(shri_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
 DEF(sari_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_shi_vec))
+DEF(rotli_vec, 1, 1, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_roti_vec))
 
 DEF(shls_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
 DEF(shrs_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_shs_vec))
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index f72530dfda..d2034d9334 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -182,6 +182,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_andc_vec         0
 #define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ca214f6909..225a597f84 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -133,6 +133,7 @@ typedef enum {
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index bfb3f5f6e9..23aabde992 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -183,6 +183,7 @@ extern bool have_avx2;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          1
 #define TCG_TARGET_HAS_shv_vec          have_avx2
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 4fa21f0e71..e57b891aa5 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -161,6 +161,7 @@ extern bool have_vsx;
 #define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          have_isa_3_00
 #define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index ca449702e6..34b1030365 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -716,6 +716,54 @@ void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
+void HELPER(gvec_rotl8i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
+        *(uint8_t *)(d + i) = rol8(*(uint8_t *)(a + i), shift);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl16i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
+        *(uint16_t *)(d + i) = rol16(*(uint16_t *)(a + i), shift);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl32i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
+        *(uint32_t *)(d + i) = rol32(*(uint32_t *)(a + i), shift);
+    }
+    clear_high(d, oprsz, desc);
+}
+
+void HELPER(gvec_rotl64i)(void *d, void *a, uint32_t desc)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+    int shift = simd_data(desc);
+    intptr_t i;
+
+    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
+        *(uint64_t *)(d + i) = rol64(*(uint64_t *)(a + i), shift);
+    }
+    clear_high(d, oprsz, desc);
+}
+
 void HELPER(gvec_shl8v)(void *d, void *a, void *b, uint32_t desc)
 {
     intptr_t oprsz = simd_oprsz(desc);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 049a55e700..25300b1577 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2694,6 +2694,74 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
+void tcg_gen_vec_rotl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t mask = dup_const(MO_8, 0xff << c);
+
+    tcg_gen_shli_i64(d, a, c);
+    tcg_gen_shri_i64(a, a, 8 - c);
+    tcg_gen_andi_i64(d, d, mask);
+    tcg_gen_andi_i64(a, a, ~mask);
+    tcg_gen_or_i64(d, d, a);
+}
+
+void tcg_gen_vec_rotl16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
+{
+    uint64_t mask = dup_const(MO_16, 0xffff << c);
+
+    tcg_gen_shli_i64(d, a, c);
+    tcg_gen_shri_i64(a, a, 16 - c);
+    tcg_gen_andi_i64(d, d, mask);
+    tcg_gen_andi_i64(a, a, ~mask);
+    tcg_gen_or_i64(d, d, a);
+}
+
+void tcg_gen_gvec_rotli(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = { INDEX_op_rotli_vec, 0 };
+    static const GVecGen2i g[4] = {
+        { .fni8 = tcg_gen_vec_rotl8i_i64,
+          .fniv = tcg_gen_rotli_vec,
+          .fno = gen_helper_gvec_rotl8i,
+          .opt_opc = vecop_list,
+          .vece = MO_8 },
+        { .fni8 = tcg_gen_vec_rotl16i_i64,
+          .fniv = tcg_gen_rotli_vec,
+          .fno = gen_helper_gvec_rotl16i,
+          .opt_opc = vecop_list,
+          .vece = MO_16 },
+        { .fni4 = tcg_gen_rotli_i32,
+          .fniv = tcg_gen_rotli_vec,
+          .fno = gen_helper_gvec_rotl32i,
+          .opt_opc = vecop_list,
+          .vece = MO_32 },
+        { .fni8 = tcg_gen_rotli_i64,
+          .fniv = tcg_gen_rotli_vec,
+          .fno = gen_helper_gvec_rotl64i,
+          .opt_opc = vecop_list,
+          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
+          .vece = MO_64 },
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    tcg_debug_assert(shift >= 0 && shift < (8 << vece));
+    if (shift == 0) {
+        tcg_gen_gvec_mov(vece, dofs, aofs, oprsz, maxsz);
+    } else {
+        tcg_gen_gvec_2i(dofs, aofs, oprsz, maxsz, shift, &g[vece]);
+    }
+}
+
+void tcg_gen_gvec_rotri(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        int64_t shift, uint32_t oprsz, uint32_t maxsz)
+{
+    tcg_debug_assert(vece <= MO_64);
+    tcg_debug_assert(shift >= 0 && shift < (8 << vece));
+    tcg_gen_gvec_rotli(vece, dofs, aofs, -shift & ((8 << vece) - 1),
+                       oprsz, maxsz);
+}
+
 /*
  * Specialized generation vector shifts by a non-constant scalar.
  */
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index a9c16d85c5..845cb3de2e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -546,6 +546,18 @@ void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
     do_shifti(INDEX_op_sari_vec, vece, r, a, i);
 }
 
+void tcg_gen_rotli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
+{
+    do_shifti(INDEX_op_rotli_vec, vece, r, a, i);
+}
+
+void tcg_gen_rotri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i)
+{
+    int bits = 8 << vece;
+    tcg_debug_assert(i >= 0 && i < bits);
+    do_shifti(INDEX_op_rotli_vec, vece, r, a, -i & (bits - 1));
+}
+
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece,
                      TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d712d19842..71409073bb 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1697,6 +1697,8 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
         return have_vec && TCG_TARGET_HAS_shv_vec;
+    case INDEX_op_rotli_vec:
+        return have_vec && TCG_TARGET_HAS_roti_vec;
     case INDEX_op_ssadd_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
diff --git a/tcg/README b/tcg/README
index bfa2e4ed24..1e3e4654f4 100644
--- a/tcg/README
+++ b/tcg/README
@@ -605,10 +605,11 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
 
 * shri_vec   v0, v1, i2
 * sari_vec   v0, v1, i2
+* rotli_vec  v0, v1, i2
 * shrs_vec   v0, v1, s2
 * sars_vec   v0, v1, s2
 
-  Similarly for logical and arithmetic right shift.
+  Similarly for logical and arithmetic right shift, and left rotate.
 
 * shlv_vec   v0, v1, v2
 
-- 
2.20.1


