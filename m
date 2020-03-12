Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F06C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00AE205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 20:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zl+6vzb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00AE205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCUA2-0004uP-Rz
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 16:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTja-0006aS-Uj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jCTjX-0002L5-MS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:10 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:51313)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jCTjX-0002Kj-E1
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 15:43:07 -0400
Received: by mail-pj1-x102a.google.com with SMTP id y7so2969585pjn.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PWBkdYujqc9erslUmjLXmLwSgdLtDZ14Q5pB5Cqc4YI=;
 b=Zl+6vzb5hRcTMprVlPym/s0H8aK3/a2jC1+bFPQ+O+MARpMLOqOBvEDgn4uMhUtGQQ
 pbr+63120HoM3ar0Ztjp9gxU7C8NHglEC9Lf3iP11zBjZrN5zAqQqI+ZAYcBuuRo23VI
 ids8vF/Yk96c0sy1xaGj7Pu8xvf+AugGFlYUqiDNhQt+vrwaK5y48Gsi0hHARdlBjMbe
 G8a4fTz1Q6DhQX6dcqwSUkuVws+0WZxjHK9tFaiv8qnXUvAC1+yzsuFAk9HNWrFR7FKR
 2M4KosfsX+0kH0y3zPYTCZsd9Et2gOJXU32aLqx6RS577thUWHYTnaeV521wf41XRVRM
 iamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PWBkdYujqc9erslUmjLXmLwSgdLtDZ14Q5pB5Cqc4YI=;
 b=hnFHZMCxfRUcm+B66f6TvBCkxRCKNbxUCm9STY3LnJAySxrFF02sbIBwauJycZEF/g
 anROUIrq3pA+RbyG2hYkwMivhCRv9nkKBoCw0PdH+q4BnYd2JcsWFhkvoZVLZp/AxVel
 GTOJ6lnvmsH4dPcIhoyB4Qiqy48ktN2ebOlfnvbhJG+YQPiglKiqdvu2/yiGWHCZ6F5T
 9lRsL/0pbLZ82GJj0IV2zmldfQYXx0K9M97dHshOshpAYjMQ/qUapdD91737KPvYSqj0
 r/AJxJ5mt6dhaMwsOzxW20GXMKqkfMusLRhAawATouQy0HglLf0RIHEv3fKIt5116vZp
 bxag==
X-Gm-Message-State: ANhLgQ2EDCHIMaQzOxqCBKfTDtqyYd8QG9qe4hTA1Dtm6maxkh8KGay7
 TPc5/oBMa12fhnWz5QrgBffYPgyvP24=
X-Google-Smtp-Source: ADFU+vuoOyYS2f0fpW6vAEF3kjBoGUtwpw0HRF0AsFvP1kTnWQvyQNMCvsFdwDCyFz3FyfFlMMIJ2Q==
X-Received: by 2002:a17:902:bc47:: with SMTP id
 t7mr9740845plz.47.1584042185578; 
 Thu, 12 Mar 2020 12:43:05 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id g69sm6824842pje.34.2020.03.12.12.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 12:43:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 33/42] target/arm: Add mte helpers for sve scalar + int
 ff/nf loads
Date: Thu, 12 Mar 2020 12:42:10 -0700
Message-Id: <20200312194219.24406-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194219.24406-1-richard.henderson@linaro.org>
References: <20200312194219.24406-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102a
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
 target/arm/helper-sve.h    |  98 ++++++++++++++++
 target/arm/sve_helper.c    |  98 ++++++++++++++--
 target/arm/translate-sve.c | 232 +++++++++++++++++++++++++------------
 3 files changed, 342 insertions(+), 86 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index e81d06b27c..849478fc76 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1273,6 +1273,55 @@ DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ldff1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1hh_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1hh_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hsu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1hds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1ss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1ss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1sds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldff1dd_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldff1dd_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_ldnf1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
@@ -1304,6 +1353,55 @@ DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 
+DEF_HELPER_FLAGS_4(sve_ldnf1bb_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bsu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bdu_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bhs_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bss_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1bds_r_mte, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1hh_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hsu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1hds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1ss_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sdu_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1sds_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_le_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+DEF_HELPER_FLAGS_4(sve_ldnf1dd_be_r_mte, TCG_CALL_NO_WG,
+                   void, env, ptr, tl, i32)
+
 DEF_HELPER_FLAGS_4(sve_st1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_st3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 0b8522ff01..9e8ffb7062 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -4965,7 +4965,7 @@ static void record_fault(CPUARMState *env, uintptr_t i, uintptr_t oprsz)
  */
 static inline QEMU_ALWAYS_INLINE
 void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
-                   uint32_t desc, const uintptr_t retaddr,
+                   uint32_t desc, const uintptr_t retaddr, uint32_t mtedesc,
                    const int esz, const int msz, const SVEContFault fault,
                    sve_ldst1_host_fn *host_fn,
                    sve_ldst1_tlb_fn *tlb_fn)
@@ -4997,13 +4997,22 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     mem_off = info.mem_off_first[0];
     flags = info.page[0].flags;
 
+    /* Since TBI must be set for MTE, !mtedesc => !mte_active. */
+    if (info.page[0].attrs.target_tlb_bit1) {
+        mtedesc = 0;
+    }
+
     if (fault == FAULT_FIRST) {
+        /* Trapping mte check for the first-fault element.  */
+        if (mtedesc) {
+            mte_check1(env, mtedesc, addr + mem_off, retaddr);
+        }
+
         /*
          * Special handling of the first active element,
          * if it crosses a page boundary or is MMIO.
          */
         bool is_split = mem_off == info.mem_off_split;
-        /* TODO: MTE check. */
         if (unlikely(flags != 0) || unlikely(is_split)) {
             /*
              * Use the slow path for cross-page handling.
@@ -5038,7 +5047,10 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                 /* Watchpoint hit, see below. */
                 goto do_fault;
             }
-            /* TODO: MTE check. */
+            if (mtedesc &&
+                !mte_probe1(env, mtedesc, addr + mem_off, retaddr)) {
+                goto do_fault;
+            }
             /*
              * Use the slow path for cross-page handling.
              * This is RAM, without a watchpoint, and will not trap.
@@ -5081,7 +5093,10 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
                                          1 << msz, BP_MEM_READ)) {
                     goto do_fault;
                 }
-                /* TODO: MTE check. */
+                if (mtedesc &&
+                    !mte_probe1(env, mtedesc, addr + mem_off, retaddr)) {
+                    goto do_fault;
+                }
                 host_fn(vd, reg_off, host + mem_off);
             }
             reg_off += 1 << esz;
@@ -5119,44 +5134,103 @@ void sve_ldnfff1_r(CPUARMState *env, void *vg, const target_ulong addr,
     record_fault(env, reg_off, reg_max);
 }
 
-#define DO_LDFF1_LDNF1_1(PART, ESZ) \
+static inline QEMU_ALWAYS_INLINE
+void sve_ldnfff1_r_mte(CPUARMState *env, void *vg, target_ulong addr,
+                       uint32_t desc, const uintptr_t retaddr,
+                       const int esz, const int msz, const SVEContFault fault,
+                       sve_ldst1_host_fn *host_fn,
+                       sve_ldst1_tlb_fn *tlb_fn)
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
+    sve_ldnfff1_r(env, vg, addr, desc, retaddr, mtedesc,
+                  esz, msz, fault, host_fn, tlb_fn);
+}
+
+#define DO_LDFF1_LDNF1_1(PART, ESZ)                                     \
 void HELPER(sve_ldff1##PART##_r)(CPUARMState *env, void *vg,            \
                                  target_ulong addr, uint32_t desc)      \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_FIRST, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_r)(CPUARMState *env, void *vg,            \
                                  target_ulong addr, uint32_t desc)      \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO,    \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MO_8, FAULT_NO, \
+                  sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_r_mte)(CPUARMState *env, void *vg,        \
+                                     target_ulong addr, uint32_t desc)  \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_FIRST, \
+                      sve_ld1##PART##_host, sve_ld1##PART##_tlb);       \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_r_mte)(CPUARMState *env, void *vg,        \
+                                     target_ulong addr, uint32_t desc)  \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MO_8, FAULT_NO, \
                   sve_ld1##PART##_host, sve_ld1##PART##_tlb);           \
 }
 
-#define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ) \
+#define DO_LDFF1_LDNF1_2(PART, ESZ, MSZ)                                \
 void HELPER(sve_ldff1##PART##_le_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_le_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
                   sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb);     \
 }                                                                       \
 void HELPER(sve_ldff1##PART##_be_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST,  \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_FIRST, \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
 }                                                                       \
 void HELPER(sve_ldnf1##PART##_be_r)(CPUARMState *env, void *vg,         \
                                     target_ulong addr, uint32_t desc)   \
 {                                                                       \
-    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO,     \
+    sve_ldnfff1_r(env, vg, addr, desc, GETPC(), 0, ESZ, MSZ, FAULT_NO,  \
                   sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb);     \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
+                      sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_le_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
+                      sve_ld1##PART##_le_host, sve_ld1##PART##_le_tlb); \
+}                                                                       \
+void HELPER(sve_ldff1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_FIRST, \
+                      sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
+}                                                                       \
+void HELPER(sve_ldnf1##PART##_be_r_mte)(CPUARMState *env, void *vg,     \
+                                        target_ulong addr, uint32_t desc) \
+{                                                                       \
+    sve_ldnfff1_r_mte(env, vg, addr, desc, GETPC(), ESZ, MSZ, FAULT_NO, \
+                      sve_ld1##PART##_be_host, sve_ld1##PART##_be_tlb); \
 }
 
 DO_LDFF1_LDNF1_1(bb,  MO_8)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 8d2a93e7d9..5b399bb005 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4740,104 +4740,188 @@ static bool trans_LD_zpri(DisasContext *s, arg_rpri_load *a)
 
 static bool trans_LDFF1_zprr(DisasContext *s, arg_rprr_load *a)
 {
-    static gen_helper_gvec_mem * const fns[2][16] = {
-        /* Little-endian */
-        { gen_helper_sve_ldff1bb_r,
-          gen_helper_sve_ldff1bhu_r,
-          gen_helper_sve_ldff1bsu_r,
-          gen_helper_sve_ldff1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][2][16] = {
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldff1bb_r,
+            gen_helper_sve_ldff1bhu_r,
+            gen_helper_sve_ldff1bsu_r,
+            gen_helper_sve_ldff1bdu_r,
 
-          gen_helper_sve_ldff1sds_le_r,
-          gen_helper_sve_ldff1hh_le_r,
-          gen_helper_sve_ldff1hsu_le_r,
-          gen_helper_sve_ldff1hdu_le_r,
+            gen_helper_sve_ldff1sds_le_r,
+            gen_helper_sve_ldff1hh_le_r,
+            gen_helper_sve_ldff1hsu_le_r,
+            gen_helper_sve_ldff1hdu_le_r,
 
-          gen_helper_sve_ldff1hds_le_r,
-          gen_helper_sve_ldff1hss_le_r,
-          gen_helper_sve_ldff1ss_le_r,
-          gen_helper_sve_ldff1sdu_le_r,
+            gen_helper_sve_ldff1hds_le_r,
+            gen_helper_sve_ldff1hss_le_r,
+            gen_helper_sve_ldff1ss_le_r,
+            gen_helper_sve_ldff1sdu_le_r,
 
-          gen_helper_sve_ldff1bds_r,
-          gen_helper_sve_ldff1bss_r,
-          gen_helper_sve_ldff1bhs_r,
-          gen_helper_sve_ldff1dd_le_r },
+            gen_helper_sve_ldff1bds_r,
+            gen_helper_sve_ldff1bss_r,
+            gen_helper_sve_ldff1bhs_r,
+            gen_helper_sve_ldff1dd_le_r },
 
-        /* Big-endian */
-        { gen_helper_sve_ldff1bb_r,
-          gen_helper_sve_ldff1bhu_r,
-          gen_helper_sve_ldff1bsu_r,
-          gen_helper_sve_ldff1bdu_r,
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldff1bb_r,
+            gen_helper_sve_ldff1bhu_r,
+            gen_helper_sve_ldff1bsu_r,
+            gen_helper_sve_ldff1bdu_r,
 
-          gen_helper_sve_ldff1sds_be_r,
-          gen_helper_sve_ldff1hh_be_r,
-          gen_helper_sve_ldff1hsu_be_r,
-          gen_helper_sve_ldff1hdu_be_r,
+            gen_helper_sve_ldff1sds_be_r,
+            gen_helper_sve_ldff1hh_be_r,
+            gen_helper_sve_ldff1hsu_be_r,
+            gen_helper_sve_ldff1hdu_be_r,
 
-          gen_helper_sve_ldff1hds_be_r,
-          gen_helper_sve_ldff1hss_be_r,
-          gen_helper_sve_ldff1ss_be_r,
-          gen_helper_sve_ldff1sdu_be_r,
+            gen_helper_sve_ldff1hds_be_r,
+            gen_helper_sve_ldff1hss_be_r,
+            gen_helper_sve_ldff1ss_be_r,
+            gen_helper_sve_ldff1sdu_be_r,
 
-          gen_helper_sve_ldff1bds_r,
-          gen_helper_sve_ldff1bss_r,
-          gen_helper_sve_ldff1bhs_r,
-          gen_helper_sve_ldff1dd_be_r },
+            gen_helper_sve_ldff1bds_r,
+            gen_helper_sve_ldff1bss_r,
+            gen_helper_sve_ldff1bhs_r,
+            gen_helper_sve_ldff1dd_be_r } },
+
+        { /* mte active, little-endian */
+          { gen_helper_sve_ldff1bb_r_mte,
+            gen_helper_sve_ldff1bhu_r_mte,
+            gen_helper_sve_ldff1bsu_r_mte,
+            gen_helper_sve_ldff1bdu_r_mte,
+
+            gen_helper_sve_ldff1sds_le_r_mte,
+            gen_helper_sve_ldff1hh_le_r_mte,
+            gen_helper_sve_ldff1hsu_le_r_mte,
+            gen_helper_sve_ldff1hdu_le_r_mte,
+
+            gen_helper_sve_ldff1hds_le_r_mte,
+            gen_helper_sve_ldff1hss_le_r_mte,
+            gen_helper_sve_ldff1ss_le_r_mte,
+            gen_helper_sve_ldff1sdu_le_r_mte,
+
+            gen_helper_sve_ldff1bds_r_mte,
+            gen_helper_sve_ldff1bss_r_mte,
+            gen_helper_sve_ldff1bhs_r_mte,
+            gen_helper_sve_ldff1dd_le_r_mte },
+
+          /* mte active, big-endian */
+          { gen_helper_sve_ldff1bb_r_mte,
+            gen_helper_sve_ldff1bhu_r_mte,
+            gen_helper_sve_ldff1bsu_r_mte,
+            gen_helper_sve_ldff1bdu_r_mte,
+
+            gen_helper_sve_ldff1sds_be_r_mte,
+            gen_helper_sve_ldff1hh_be_r_mte,
+            gen_helper_sve_ldff1hsu_be_r_mte,
+            gen_helper_sve_ldff1hdu_be_r_mte,
+
+            gen_helper_sve_ldff1hds_be_r_mte,
+            gen_helper_sve_ldff1hss_be_r_mte,
+            gen_helper_sve_ldff1ss_be_r_mte,
+            gen_helper_sve_ldff1sdu_be_r_mte,
+
+            gen_helper_sve_ldff1bds_r_mte,
+            gen_helper_sve_ldff1bss_r_mte,
+            gen_helper_sve_ldff1bhs_r_mte,
+            gen_helper_sve_ldff1dd_be_r_mte } },
     };
 
     if (sve_access_check(s)) {
         TCGv_i64 addr = new_tmp_a64(s);
         tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), dtype_msz(a->dtype));
         tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
-        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 0, false,
-                   fns[s->be_data == MO_BE][a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 1, false,
+                   fns[s->mte_active[0]][s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
 
 static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
 {
-    static gen_helper_gvec_mem * const fns[2][16] = {
-        /* Little-endian */
-        { gen_helper_sve_ldnf1bb_r,
-          gen_helper_sve_ldnf1bhu_r,
-          gen_helper_sve_ldnf1bsu_r,
-          gen_helper_sve_ldnf1bdu_r,
+    static gen_helper_gvec_mem * const fns[2][2][16] = {
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldnf1bb_r,
+            gen_helper_sve_ldnf1bhu_r,
+            gen_helper_sve_ldnf1bsu_r,
+            gen_helper_sve_ldnf1bdu_r,
 
-          gen_helper_sve_ldnf1sds_le_r,
-          gen_helper_sve_ldnf1hh_le_r,
-          gen_helper_sve_ldnf1hsu_le_r,
-          gen_helper_sve_ldnf1hdu_le_r,
+            gen_helper_sve_ldnf1sds_le_r,
+            gen_helper_sve_ldnf1hh_le_r,
+            gen_helper_sve_ldnf1hsu_le_r,
+            gen_helper_sve_ldnf1hdu_le_r,
 
-          gen_helper_sve_ldnf1hds_le_r,
-          gen_helper_sve_ldnf1hss_le_r,
-          gen_helper_sve_ldnf1ss_le_r,
-          gen_helper_sve_ldnf1sdu_le_r,
+            gen_helper_sve_ldnf1hds_le_r,
+            gen_helper_sve_ldnf1hss_le_r,
+            gen_helper_sve_ldnf1ss_le_r,
+            gen_helper_sve_ldnf1sdu_le_r,
 
-          gen_helper_sve_ldnf1bds_r,
-          gen_helper_sve_ldnf1bss_r,
-          gen_helper_sve_ldnf1bhs_r,
-          gen_helper_sve_ldnf1dd_le_r },
+            gen_helper_sve_ldnf1bds_r,
+            gen_helper_sve_ldnf1bss_r,
+            gen_helper_sve_ldnf1bhs_r,
+            gen_helper_sve_ldnf1dd_le_r },
 
-        /* Big-endian */
-        { gen_helper_sve_ldnf1bb_r,
-          gen_helper_sve_ldnf1bhu_r,
-          gen_helper_sve_ldnf1bsu_r,
-          gen_helper_sve_ldnf1bdu_r,
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldnf1bb_r,
+            gen_helper_sve_ldnf1bhu_r,
+            gen_helper_sve_ldnf1bsu_r,
+            gen_helper_sve_ldnf1bdu_r,
 
-          gen_helper_sve_ldnf1sds_be_r,
-          gen_helper_sve_ldnf1hh_be_r,
-          gen_helper_sve_ldnf1hsu_be_r,
-          gen_helper_sve_ldnf1hdu_be_r,
+            gen_helper_sve_ldnf1sds_be_r,
+            gen_helper_sve_ldnf1hh_be_r,
+            gen_helper_sve_ldnf1hsu_be_r,
+            gen_helper_sve_ldnf1hdu_be_r,
 
-          gen_helper_sve_ldnf1hds_be_r,
-          gen_helper_sve_ldnf1hss_be_r,
-          gen_helper_sve_ldnf1ss_be_r,
-          gen_helper_sve_ldnf1sdu_be_r,
+            gen_helper_sve_ldnf1hds_be_r,
+            gen_helper_sve_ldnf1hss_be_r,
+            gen_helper_sve_ldnf1ss_be_r,
+            gen_helper_sve_ldnf1sdu_be_r,
 
-          gen_helper_sve_ldnf1bds_r,
-          gen_helper_sve_ldnf1bss_r,
-          gen_helper_sve_ldnf1bhs_r,
-          gen_helper_sve_ldnf1dd_be_r },
+            gen_helper_sve_ldnf1bds_r,
+            gen_helper_sve_ldnf1bss_r,
+            gen_helper_sve_ldnf1bhs_r,
+            gen_helper_sve_ldnf1dd_be_r } },
+
+        { /* mte inactive, little-endian */
+          { gen_helper_sve_ldnf1bb_r_mte,
+            gen_helper_sve_ldnf1bhu_r_mte,
+            gen_helper_sve_ldnf1bsu_r_mte,
+            gen_helper_sve_ldnf1bdu_r_mte,
+
+            gen_helper_sve_ldnf1sds_le_r_mte,
+            gen_helper_sve_ldnf1hh_le_r_mte,
+            gen_helper_sve_ldnf1hsu_le_r_mte,
+            gen_helper_sve_ldnf1hdu_le_r_mte,
+
+            gen_helper_sve_ldnf1hds_le_r_mte,
+            gen_helper_sve_ldnf1hss_le_r_mte,
+            gen_helper_sve_ldnf1ss_le_r_mte,
+            gen_helper_sve_ldnf1sdu_le_r_mte,
+
+            gen_helper_sve_ldnf1bds_r_mte,
+            gen_helper_sve_ldnf1bss_r_mte,
+            gen_helper_sve_ldnf1bhs_r_mte,
+            gen_helper_sve_ldnf1dd_le_r_mte },
+
+          /* mte inactive, big-endian */
+          { gen_helper_sve_ldnf1bb_r_mte,
+            gen_helper_sve_ldnf1bhu_r_mte,
+            gen_helper_sve_ldnf1bsu_r_mte,
+            gen_helper_sve_ldnf1bdu_r_mte,
+
+            gen_helper_sve_ldnf1sds_be_r_mte,
+            gen_helper_sve_ldnf1hh_be_r_mte,
+            gen_helper_sve_ldnf1hsu_be_r_mte,
+            gen_helper_sve_ldnf1hdu_be_r_mte,
+
+            gen_helper_sve_ldnf1hds_be_r_mte,
+            gen_helper_sve_ldnf1hss_be_r_mte,
+            gen_helper_sve_ldnf1ss_be_r_mte,
+            gen_helper_sve_ldnf1sdu_be_r_mte,
+
+            gen_helper_sve_ldnf1bds_r_mte,
+            gen_helper_sve_ldnf1bss_r_mte,
+            gen_helper_sve_ldnf1bhs_r_mte,
+            gen_helper_sve_ldnf1dd_be_r_mte } },
     };
 
     if (sve_access_check(s)) {
@@ -4847,8 +4931,8 @@ static bool trans_LDNF1_zpri(DisasContext *s, arg_rpri_load *a)
         TCGv_i64 addr = new_tmp_a64(s);
 
         tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn), off);
-        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 0, false,
-                   fns[s->be_data == MO_BE][a->dtype]);
+        do_mem_zpa(s, a->rd, a->pg, addr, a->dtype, 1, false,
+                   fns[s->mte_active[0]][s->be_data == MO_BE][a->dtype]);
     }
     return true;
 }
-- 
2.20.1


