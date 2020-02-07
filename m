Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14721C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF57B214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vE0L+7KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF57B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j052e-0006Im-3F
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iB-0001AO-Ce
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04i9-0003Qc-Jy
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:27 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04i9-0003Q4-CH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:25 -0500
Received: by mail-wm1-x344.google.com with SMTP id c84so3011033wme.4
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JjYyP7RWWnHPNkNaWrncpCUhNmdtAYWQtIovOWWFnzk=;
 b=vE0L+7KXg1lgbQwTwVlLANSjTU/jfHWp6QlKWTrZztPDlZbJ84yEpp7Y32o7v6RD75
 xyMdqmoDTq8nO9dmqboVV9mViQ2VrMJbFKFJxuXGiQFvR4d2q4dCRIeLu2+FrVEY+tTq
 oCVSrWYQ1JXC2aYr4rGNSBM2vvxfnzr2qFNOgyRkv0XrFbNlrqY5nfR/S5va8iul1CUP
 f/JziBTqou48CKDld3b2Ea1gT9ugT4IWk3X3Af2b+LXmj4kzWPVgvByEKbNIKZImlNGE
 fvBLk5QNDJrp6I7om/TX1Pdx3R7CJCYGmyMFZji6ISjOUq61qAKCZ68WVyqOEzZxbmjD
 hcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JjYyP7RWWnHPNkNaWrncpCUhNmdtAYWQtIovOWWFnzk=;
 b=tmaJglFsK8Oh9br2au3cX9Gm00hHfHvK1xUcqzqRWomb0WRoLCjV/uybatZtw6hhX5
 IY9tMxtZ5PwuOGGPDPN6Fo9NcRF9JTY65j+ZJ61m3fs4s81elA2dWw6kxWf9ip5Uf0zc
 qIjATe4uOx+1sGjdDeZmS0RK3I6mqopzo99b1IQ7yDMHUT9plv4EPKOxaOaaKEHcTXc9
 8j0CQF+J8NM194xo+YjYGwKjHrUFsO9MpPfmAgE7/HHef7LJOyoLi0W47Q6ajoqB1glC
 f0O56hyYbCT1G0T+ew+2NbMDk6LaY/xf1VDb9hyQ8VH2hQOa/hG41VsIwILKsjlaB7YN
 YXQw==
X-Gm-Message-State: APjAAAVFmZQDuIVSMCU2Vr9k5YeKG5OIQFS3YD6lomHRMu6KWAqLuqSy
 yF1QHe+l0nBq53xySRMQSQCnjOb3ieM=
X-Google-Smtp-Source: APXvYqzuisfBBFBru0YEDnTAVIkpcRnt+HlsvzekiP1xQMnQpGVh9GVJ4h22w/YP/Lee0PX0+IW9Hg==
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr4526216wmm.97.1581086063982; 
 Fri, 07 Feb 2020 06:34:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/48] target/arm: Update get_a64_user_mem_index for VHE
Date: Fri,  7 Feb 2020 14:33:31 +0000
Message-Id: <20200207143343.30322-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

From: Richard Henderson <richard.henderson@linaro.org>

The EL2&0 translation regime is affected by Load Register (unpriv).

The code structure used here will facilitate later changes in this
area for implementing UAO and NV.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-36-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h           |  9 ++++----
 target/arm/translate.h     |  2 ++
 target/arm/helper.c        | 22 +++++++++++++++++++
 target/arm/translate-a64.c | 44 ++++++++++++++++++++++++--------------
 4 files changed, 57 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d091a7e2e87..2ed2667a170 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3214,10 +3214,10 @@ typedef ARMCPU ArchCPU;
  * |              |     |   TBFLAG_A32   |              |
  * |              |     +-----+----------+  TBFLAG_AM32 |
  * |  TBFLAG_ANY  |           |TBFLAG_M32|              |
- * |              |           +-------------------------|
- * |              |           |       TBFLAG_A64        |
- * +--------------+-----------+-------------------------+
- *  31          20          14                         0
+ * |              |         +-+----------+--------------|
+ * |              |         |         TBFLAG_A64        |
+ * +--------------+---------+---------------------------+
+ *  31          20        15                           0
  *
  * Unless otherwise noted, these bits are cached in env->hflags.
  */
@@ -3283,6 +3283,7 @@ FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
 FIELD(TBFLAG_A64, BT, 9, 1)
 FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
+FIELD(TBFLAG_A64, UNPRIV, 14, 1)
 
 static inline bool bswap_code(bool sctlr_b)
 {
diff --git a/target/arm/translate.h b/target/arm/translate.h
index a32b6b1b3a9..5b167c416a2 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -73,6 +73,8 @@ typedef struct DisasContext {
      * ie A64 LDX*, LDAX*, A32/T32 LDREX*, LDAEX*.
      */
     bool is_ldex;
+    /* True if AccType_UNPRIV should be used for LDTR et al */
+    bool unpriv;
     /* True if v8.3-PAuth is active.  */
     bool pauth_active;
     /* True with v8.5-BTI and SCTLR_ELx.BT* set.  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9627b4aab15..ff2d957b7c6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12011,6 +12011,28 @@ static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
     }
 
+    /* Compute the condition for using AccType_UNPRIV for LDTR et al. */
+    /* TODO: ARMv8.2-UAO */
+    switch (mmu_idx) {
+    case ARMMMUIdx_E10_1:
+    case ARMMMUIdx_SE10_1:
+        /* TODO: ARMv8.3-NV */
+        flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+        break;
+    case ARMMMUIdx_E20_2:
+        /* TODO: ARMv8.4-SecEL2 */
+        /*
+         * Note that E20_2 is gated by HCR_EL2.E2H == 1, but E20_0 is
+         * gated by HCR_EL2.<E2H,TGE> == '11', and so is LDTR.
+         */
+        if (env->cp15.hcr_el2 & HCR_TGE) {
+            flags = FIELD_DP32(flags, TBFLAG_A64, UNPRIV, 1);
+        }
+        break;
+    default:
+        break;
+    }
+
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 3982e1988dc..6e82486884b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -105,25 +105,36 @@ void a64_translate_init(void)
         offsetof(CPUARMState, exclusive_high), "exclusive_high");
 }
 
-static inline int get_a64_user_mem_index(DisasContext *s)
+/*
+ * Return the core mmu_idx to use for A64 "unprivileged load/store" insns
+ */
+static int get_a64_user_mem_index(DisasContext *s)
 {
-    /* Return the core mmu_idx to use for A64 "unprivileged load/store" insns:
-     *  if EL1, access as if EL0; otherwise access at current EL
+    /*
+     * If AccType_UNPRIV is not used, the insn uses AccType_NORMAL,
+     * which is the usual mmu_idx for this cpu state.
      */
-    ARMMMUIdx useridx;
+    ARMMMUIdx useridx = s->mmu_idx;
 
-    switch (s->mmu_idx) {
-    case ARMMMUIdx_E10_1:
-        useridx = ARMMMUIdx_E10_0;
-        break;
-    case ARMMMUIdx_SE10_1:
-        useridx = ARMMMUIdx_SE10_0;
-        break;
-    case ARMMMUIdx_Stage2:
-        g_assert_not_reached();
-    default:
-        useridx = s->mmu_idx;
-        break;
+    if (s->unpriv) {
+        /*
+         * We have pre-computed the condition for AccType_UNPRIV.
+         * Therefore we should never get here with a mmu_idx for
+         * which we do not know the corresponding user mmu_idx.
+         */
+        switch (useridx) {
+        case ARMMMUIdx_E10_1:
+            useridx = ARMMMUIdx_E10_0;
+            break;
+        case ARMMMUIdx_E20_2:
+            useridx = ARMMMUIdx_E20_0;
+            break;
+        case ARMMMUIdx_SE10_1:
+            useridx = ARMMMUIdx_SE10_0;
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
     return arm_to_core_mmu_idx(useridx);
 }
@@ -14171,6 +14182,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pauth_active = FIELD_EX32(tb_flags, TBFLAG_A64, PAUTH_ACTIVE);
     dc->bt = FIELD_EX32(tb_flags, TBFLAG_A64, BT);
     dc->btype = FIELD_EX32(tb_flags, TBFLAG_A64, BTYPE);
+    dc->unpriv = FIELD_EX32(tb_flags, TBFLAG_A64, UNPRIV);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.20.1


