Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A1BC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2757C206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6k0qLR7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2757C206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCU7e-0001as-B3
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjY-0006Rk-98
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjV-0002KL-Tv
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:08 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:33154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjV-0002Js-Ma
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:05 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay11so3082980plb.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8T6BAPTYerDhEKgrzNZE4db0OCIj9s9aznenJNc+c5c=;
 b=M6k0qLR7ObhqR3X80b34xjeqDYhTFxcxpVUXOVaxXXgokUIEGz8Y4hbJM4sJRrH/Ia
 yQCEdAcLmSWE5OSaeoCLZ8NXHZEK4kCENFXnBS5w+H4H2o3qyr/sHBCw2x72khAuJc8D
 Rvoajx8QhI1w+3MTfKHUdyCDzTG7zXGPlKBGmqa+9GPYCIMW6kl6CvobBbTCky4ngTEE
 UatQtjZ32pv9id5Kt/c96H2er1NQp45Cwj3BW/63mJmMdryTCyQSKRoeg1S2ZJ9nX5AV
 4ZCkYUyLjkjc86mRke43MUG8FriCQj+RaP9MXnARhEaqizHUTvQEq4/gU3+pLIIWy41v
 PD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8T6BAPTYerDhEKgrzNZE4db0OCIj9s9aznenJNc+c5c=;
 b=PJMxLHCL1SYoHqe0oxUkjg0nvO9ZEwWmsuVYtSIg+bARB9+cpbvf4HmRanywCIRbxg
 CvAtGHhjgPJ/DzIHek52koQJOU5lcQaT+Jqa844Y0w7aVJhUboPyWlkObgM221RZXBUj
 MX26nHOhiWsZWMJz8Xhc5c4VPGdNMXxrtkEF8sJ7CX99djJOn5SsyQ5TNYZaSIwye6n/
 r66CaodTkGaeZIe4u4Sph9m6ki1RJjIIri/drSr3ERr25FlZoQ/E4kvUhEe41DPA47yH
 5U4jh3xu5v6/k7JkLJ17KkS8LGkKIVDe41tgSkZfbCh4zGRSgBkgGszkCvVn2kvancF/
 5DWw==
X-Gm-Message-State: ANhLgQ3HSQ3WE3eNxQqzmIA8xWnEekRbAoiDnPq1ZhZRAwA2YuC/Yxif
 wVCNr5E3oUCSWD3flhgd+DJV1tFSKAc=
X-Google-Smtp-Source: ADFU+vt5g/LpGkpVG/ZS9ofwyQosx12VGoEpkdvmjYxOzmScmRceEYC5uwIffARpy0mVHsLXC1OzYQ==
X-Received: by 2002:a17:90b:2390:: with SMTP id
 mr16mr5788196pjb.149.1584042184205; 
 Thu, 12 Mar 2020 12:43:04 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 32/42] target/arm: Add mte helpers for sve scalar + int
 stores
Date: Thu, 12 Mar 2020 12:42:09 -0700
Message-Id: <20200312194219.24406-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because the elements are sequential, we can eliminate many tests all
at once when the tag hits TCMA, or if the page(s) are not Tagged.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  47 +++++++++++
 target/arm/sve_helper.c    |  95 ++++++++++++++++------
 target/arm/translate-sve.c | 162 ++++++++++++++++++++++++-------------
 3 files changed, 226 insertions(+), 78 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index af1c6967a6..e81d06b27c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1351,6 +1351,53 @@ DEF_HELPER_FLAGS_4(sve_st1hd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1sd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st1sd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_st1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4hh_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4hh_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4ss_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4ss_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4dd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st2dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st3dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st4dd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1bh_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1bd_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1hs_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hs_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1hd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_st1sd_le_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_st1sd_be_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_6(sve_ldbsu_zsu, TCG_CALL_NO_WG,
                    void, env, ptr, ptr, ptr, tl, i32)
 DEF_HELPER_FLAGS_6(sve_ldhsu_le_zsu, TCG_CALL_NO_WG,
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 0fbf331742..0b8522ff01 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -5187,11 +5187,12 @@ DO_LDFF1_LDNF1_2(dd,  MO_64, MO_64)
  */
 
 static inline QEMU_ALWAYS_INLINE
-void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
-               const uintptr_t retaddr, const int esz,
-               const int msz, const int N,
+void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr,
+               uint32_t desc, const uintptr_t retaddr,
+               const int esz, const int msz, const int N, uint32_t mtedesc,
                sve_ldst1_host_fn *host_fn,
-               sve_ldst1_tlb_fn *tlb_fn)
+               sve_ldst1_tlb_fn *tlb_fn,
+               sve_cont_ldst_mte_check_fn *mte_check_fn)
 {
     const unsigned rd = simd_data(desc);
     const intptr_t reg_max = simd_oprsz(desc);
@@ -5213,7 +5214,14 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
     sve_cont_ldst_watchpoints(&info, env, vg, addr, 1 << esz, N << msz,
                               BP_MEM_WRITE, retaddr);
 
-    /* TODO: MTE check. */
+    /*
+     * Handle mte checks for all active elements.
+     * Since TBI must be set for MTE, !mtedesc => !mte_active.
+     */
+    if (mte_check_fn && mtedesc) {
+        mte_check_fn(&info, env, vg, addr, 1 << esz, N << msz,
+                     mtedesc, retaddr);
+    }
 
     flags = info.page[0].flags | info.page[1].flags;
     if (unlikely(flags != 0)) {
@@ -5307,26 +5315,67 @@ void sve_stN_r(CPUARMState *env, uint64_t *vg, target_ulong addr, uint32_t desc,
     }
 }
 
-#define DO_STN_1(N, NAME, ESZ) \
-void HELPER(sve_st##N##NAME##_r)(CPUARMState *env, void *vg,        \
-                                 target_ulong addr, uint32_t desc)  \
-{                                                                   \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, N,           \
-              sve_st1##NAME##_host, sve_st1##NAME##_tlb);           \
+static inline QEMU_ALWAYS_INLINE
+void sve_stN_r_mte(CPUARMState *env, uint64_t *vg, target_ulong addr,
+                   uint32_t desc, const uintptr_t ra,
+                   const int esz, const int msz, const int N,
+                   sve_ldst1_host_fn *host_fn,
+                   sve_ldst1_tlb_fn *tlb_fn)
+{
+    uint32_t mtedesc = desc >> (SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+    int bit55 = extract64(addr, 55, 1);
+
+    /* Remove mtedesc from the normal sve descriptor. */
+    desc = extract32(desc, 0, SIMD_DATA_SHIFT + SVE_MTEDESC_SHIFT);
+
+    /* Perform gross MTE suppression early. */
+    if (!tbi_check(desc, bit55) ||
+        tcma_check(desc, bit55, allocation_tag_from_addr(addr))) {
+        mtedesc = 0;
+    }
+
+    sve_stN_r(env, vg, addr, desc, ra, esz, msz, N, mtedesc, host_fn, tlb_fn,
+              N == 1 ? sve_cont_ldst_mte_check1 : sve_cont_ldst_mte_checkN);
 }
 
-#define DO_STN_2(N, NAME, ESZ, MSZ) \
-void HELPER(sve_st##N##NAME##_le_r)(CPUARMState *env, void *vg,       \
-                                    target_ulong addr, uint32_t desc) \
-{                                                                     \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,              \
-              sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);       \
-}                                                                     \
-void HELPER(sve_st##N##NAME##_be_r)(CPUARMState *env, void *vg,       \
-                                    target_ulong addr, uint32_t desc) \
-{                                                                     \
-    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,              \
-              sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);       \
+#define DO_STN_1(N, NAME, ESZ)                                          \
+void HELPER(sve_st##N##NAME##_r)(CPUARMState *env, void *vg,            \
+                                 target_ulong addr, uint32_t desc)      \
+{                                                                       \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, N, 0,            \
+              sve_st1##NAME##_host, sve_st1##NAME##_tlb, NULL);         \
+}                                                                       \
+void HELPER(sve_st##N##NAME##_r_mte)(CPUARMState *env, void *vg,        \
+                                     target_ulong addr, uint32_t desc)  \
+{                                                                       \
+    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, N,           \
+                  sve_st1##NAME##_host, sve_st1##NAME##_tlb);           \
+}
+
+#define DO_STN_2(N, NAME, ESZ, MSZ)                                     \
+void HELPER(sve_st##N##NAME##_le_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
+{                                                                       \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N, 0,             \
+              sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb, NULL);   \
+}                                                                       \
+void HELPER(sve_st##N##NAME##_be_r)(CPUARMState *env, void *vg,         \
+                                    target_ulong addr, uint32_t desc)   \
+{                                                                       \
+    sve_stN_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, N, 0,             \
+              sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb, NULL);   \
+}                                                                       \
+void HELPER(sve_st##N##NAME##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,            \
+                  sve_st1##NAME##_le_host, sve_st1##NAME##_le_tlb);     \
+}                                                                       \
+void HELPER(sve_st##N##NAME##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_stN_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, N,            \
+                  sve_st1##NAME##_be_host, sve_st1##NAME##_be_tlb);     \
 }
 
 DO_STN_1(1, bb, MO_8)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e8b9873a4c..8d2a93e7d9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4983,73 +4983,125 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
 static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
                       int msz, int esz, int nreg)
 {
-    static gen_helper_gvec_mem * const fn_single[2][4][4] = {
-        { { gen_helper_sve_st1bb_r,
-            gen_helper_sve_st1bh_r,
-            gen_helper_sve_st1bs_r,
-            gen_helper_sve_st1bd_r },
-          { NULL,
-            gen_helper_sve_st1hh_le_r,
-            gen_helper_sve_st1hs_le_r,
-            gen_helper_sve_st1hd_le_r },
-          { NULL, NULL,
-            gen_helper_sve_st1ss_le_r,
-            gen_helper_sve_st1sd_le_r },
-          { NULL, NULL, NULL,
-            gen_helper_sve_st1dd_le_r } },
-        { { gen_helper_sve_st1bb_r,
-            gen_helper_sve_st1bh_r,
-            gen_helper_sve_st1bs_r,
-            gen_helper_sve_st1bd_r },
-          { NULL,
-            gen_helper_sve_st1hh_be_r,
-            gen_helper_sve_st1hs_be_r,
-            gen_helper_sve_st1hd_be_r },
-          { NULL, NULL,
-            gen_helper_sve_st1ss_be_r,
-            gen_helper_sve_st1sd_be_r },
-          { NULL, NULL, NULL,
-            gen_helper_sve_st1dd_be_r } },
+    static gen_helper_gvec_mem * const fn_single[2][2][4][4] = {
+        { { { gen_helper_sve_st1bb_r,
+              gen_helper_sve_st1bh_r,
+              gen_helper_sve_st1bs_r,
+              gen_helper_sve_st1bd_r },
+            { NULL,
+              gen_helper_sve_st1hh_le_r,
+              gen_helper_sve_st1hs_le_r,
+              gen_helper_sve_st1hd_le_r },
+            { NULL, NULL,
+              gen_helper_sve_st1ss_le_r,
+              gen_helper_sve_st1sd_le_r },
+            { NULL, NULL, NULL,
+              gen_helper_sve_st1dd_le_r } },
+          { { gen_helper_sve_st1bb_r,
+              gen_helper_sve_st1bh_r,
+              gen_helper_sve_st1bs_r,
+              gen_helper_sve_st1bd_r },
+            { NULL,
+              gen_helper_sve_st1hh_be_r,
+              gen_helper_sve_st1hs_be_r,
+              gen_helper_sve_st1hd_be_r },
+            { NULL, NULL,
+              gen_helper_sve_st1ss_be_r,
+              gen_helper_sve_st1sd_be_r },
+            { NULL, NULL, NULL,
+              gen_helper_sve_st1dd_be_r } } },
+
+        { { { gen_helper_sve_st1bb_r_mte,
+              gen_helper_sve_st1bh_r_mte,
+              gen_helper_sve_st1bs_r_mte,
+              gen_helper_sve_st1bd_r_mte },
+            { NULL,
+              gen_helper_sve_st1hh_le_r_mte,
+              gen_helper_sve_st1hs_le_r_mte,
+              gen_helper_sve_st1hd_le_r_mte },
+            { NULL, NULL,
+              gen_helper_sve_st1ss_le_r_mte,
+              gen_helper_sve_st1sd_le_r_mte },
+            { NULL, NULL, NULL,
+              gen_helper_sve_st1dd_le_r_mte } },
+          { { gen_helper_sve_st1bb_r_mte,
+              gen_helper_sve_st1bh_r_mte,
+              gen_helper_sve_st1bs_r_mte,
+              gen_helper_sve_st1bd_r_mte },
+            { NULL,
+              gen_helper_sve_st1hh_be_r_mte,
+              gen_helper_sve_st1hs_be_r_mte,
+              gen_helper_sve_st1hd_be_r_mte },
+            { NULL, NULL,
+              gen_helper_sve_st1ss_be_r_mte,
+              gen_helper_sve_st1sd_be_r_mte },
+            { NULL, NULL, NULL,
+              gen_helper_sve_st1dd_be_r_mte } } },
     };
-    static gen_helper_gvec_mem * const fn_multiple[2][3][4] = {
-        { { gen_helper_sve_st2bb_r,
-            gen_helper_sve_st2hh_le_r,
-            gen_helper_sve_st2ss_le_r,
-            gen_helper_sve_st2dd_le_r },
-          { gen_helper_sve_st3bb_r,
-            gen_helper_sve_st3hh_le_r,
-            gen_helper_sve_st3ss_le_r,
-            gen_helper_sve_st3dd_le_r },
-          { gen_helper_sve_st4bb_r,
-            gen_helper_sve_st4hh_le_r,
-            gen_helper_sve_st4ss_le_r,
-            gen_helper_sve_st4dd_le_r } },
-        { { gen_helper_sve_st2bb_r,
-            gen_helper_sve_st2hh_be_r,
-            gen_helper_sve_st2ss_be_r,
-            gen_helper_sve_st2dd_be_r },
-          { gen_helper_sve_st3bb_r,
-            gen_helper_sve_st3hh_be_r,
-            gen_helper_sve_st3ss_be_r,
-            gen_helper_sve_st3dd_be_r },
-          { gen_helper_sve_st4bb_r,
-            gen_helper_sve_st4hh_be_r,
-            gen_helper_sve_st4ss_be_r,
-            gen_helper_sve_st4dd_be_r } },
+    static gen_helper_gvec_mem * const fn_multiple[2][2][3][4] = {
+        { { { gen_helper_sve_st2bb_r,
+              gen_helper_sve_st2hh_le_r,
+              gen_helper_sve_st2ss_le_r,
+              gen_helper_sve_st2dd_le_r },
+            { gen_helper_sve_st3bb_r,
+              gen_helper_sve_st3hh_le_r,
+              gen_helper_sve_st3ss_le_r,
+              gen_helper_sve_st3dd_le_r },
+            { gen_helper_sve_st4bb_r,
+              gen_helper_sve_st4hh_le_r,
+              gen_helper_sve_st4ss_le_r,
+              gen_helper_sve_st4dd_le_r } },
+          { { gen_helper_sve_st2bb_r,
+              gen_helper_sve_st2hh_be_r,
+              gen_helper_sve_st2ss_be_r,
+              gen_helper_sve_st2dd_be_r },
+            { gen_helper_sve_st3bb_r,
+              gen_helper_sve_st3hh_be_r,
+              gen_helper_sve_st3ss_be_r,
+              gen_helper_sve_st3dd_be_r },
+            { gen_helper_sve_st4bb_r,
+              gen_helper_sve_st4hh_be_r,
+              gen_helper_sve_st4ss_be_r,
+              gen_helper_sve_st4dd_be_r } } },
+        { { { gen_helper_sve_st2bb_r_mte,
+              gen_helper_sve_st2hh_le_r_mte,
+              gen_helper_sve_st2ss_le_r_mte,
+              gen_helper_sve_st2dd_le_r_mte },
+            { gen_helper_sve_st3bb_r_mte,
+              gen_helper_sve_st3hh_le_r_mte,
+              gen_helper_sve_st3ss_le_r_mte,
+              gen_helper_sve_st3dd_le_r_mte },
+            { gen_helper_sve_st4bb_r_mte,
+              gen_helper_sve_st4hh_le_r_mte,
+              gen_helper_sve_st4ss_le_r_mte,
+              gen_helper_sve_st4dd_le_r_mte } },
+          { { gen_helper_sve_st2bb_r_mte,
+              gen_helper_sve_st2hh_be_r_mte,
+              gen_helper_sve_st2ss_be_r_mte,
+              gen_helper_sve_st2dd_be_r_mte },
+            { gen_helper_sve_st3bb_r_mte,
+              gen_helper_sve_st3hh_be_r_mte,
+              gen_helper_sve_st3ss_be_r_mte,
+              gen_helper_sve_st3dd_be_r_mte },
+            { gen_helper_sve_st4bb_r_mte,
+              gen_helper_sve_st4hh_be_r_mte,
+              gen_helper_sve_st4ss_be_r_mte,
+              gen_helper_sve_st4dd_be_r_mte } } },
     };
     gen_helper_gvec_mem *fn;
     int be = s->be_data == MO_BE;
 
     if (nreg == 0) {
         /* ST1 */
-        fn = fn_single[be][msz][esz];
+        fn = fn_single[s->mte_active[0]][be][msz][esz];
+        nreg = 1;
     } else {
         /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
         assert(msz == esz);
-        fn = fn_multiple[be][nreg - 1][msz];
+        fn = fn_multiple[s->mte_active[0]][be][nreg - 1][msz];
     }
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), 0, true, fn);
+    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg, true, fn);
 }
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
-- 
2.20.1


