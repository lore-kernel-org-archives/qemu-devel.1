Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C2C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BAF20726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WICaqGP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BAF20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pje-0005U6-Rw
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:01:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41304)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgj-0000OC-On
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgi-0004XF-II
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:21 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgi-0004UH-CU
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id g3so962219wrs.12
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+p2s9N3zCo3UaOQi/uOXcF/XhbniIaFNMwB/Qn1Qo28=;
 b=WICaqGP6mrzfkTePBo+m1JVOLT+bi80f8Zsj/fSTM6IiFyjvj4MsCflrTMFTA1ghhH
 AaMaMxSAITNg94g8T3aETiQOqyxBTlYqTmdtB2D2X7t8czpn8KyYkqEacpNVYFPAelUu
 t/UigsPrBN27GY4aZ/k8vXDv9/nrgMIuKmZwCil4hjqmge/wpKRVrmJyn3UjmAybDLuG
 UsDZGCbaQPNSm6DxkwvZ6FWDT9TpNvwmdrXXemkiSVtq+SAQ40/EuVXP2eY9fYQKT8F9
 w9pjAg3C7/GViGgokNcbLUAhKHObeJuIpDkWBE2na9DYTsKBMHaOED7/M3FWTeCgBBAi
 hCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+p2s9N3zCo3UaOQi/uOXcF/XhbniIaFNMwB/Qn1Qo28=;
 b=i5EqAPYVzgIqSxTRgFJJev/LuMphoJ+R99I46UDde63QRtUjDBSrEWLqfG7WgsvxUf
 1LAb6INQbrtN8MvrP4C6zOv/ZBk2EgJpa0/aEdHpiblOPnJEMlfQIlpKru7LZtLy87Dl
 E1wccxMxoGV36njCJRdlrD9UUZOTNwMNavvnw2bghi9iVNc/JidpzVplWP1p3h+BXZJ2
 DzOC+Fbu7LhhmVlLfVNuNWld7SAOeu0JBqhGlPBl3Kty8cBhs1fk/ngX6LO5lZb8fRVB
 B0a43NY8SlN28qigLIyz5VsGb40EBEbFh1LiXQ9ANwU40LO6m/MQLaFwSNsSDdqIC9jL
 MNEA==
X-Gm-Message-State: APjAAAWD90+qdlwcg7P8ilaSzex5BdWuUmi6ukBzVDtTC+ViioBJBQ7v
 Hoguo0Y5aYGgECKe9Z3BU86HwQ6PpMFxnQ==
X-Google-Smtp-Source: APXvYqw7k4IJutTFbJuiBrPUN5An9Nfz7tcg2v4FVtl76wYcN11BpRH6K4RdjgmblfBfY/wAMv8P2Q==
X-Received: by 2002:adf:b193:: with SMTP id q19mr5362141wra.78.1581166699008; 
 Sat, 08 Feb 2020 04:58:19 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/20] target/arm: Add arm_mmu_idx_is_stage1_of_2
Date: Sat,  8 Feb 2020 12:57:57 +0000
Message-Id: <20200208125816.14954-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use a common predicate for querying stage1-ness.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Rename from arm_mmu_idx_is_stage1 to arm_mmu_idx_is_stage1_of_2
---
 target/arm/internals.h | 18 ++++++++++++++++++
 target/arm/helper.c    |  8 +++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6d4a942bde..1f8ee5f573 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1034,6 +1034,24 @@ static inline ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
 #endif
 
+/**
+ * arm_mmu_idx_is_stage1_of_2:
+ * @mmu_idx: The ARMMMUIdx to test
+ *
+ * Return true if @mmu_idx is a NOTLB mmu_idx that is the
+ * first stage of a two stage regime.
+ */
+static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
+{
+    switch (mmu_idx) {
+    case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E1:
+        return true;
+    default:
+        return false;
+    }
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7d15d5c933..57dc7a307c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3261,8 +3261,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         bool take_exc = false;
 
         if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
-            && (mmu_idx == ARMMMUIdx_Stage1_E1 ||
-                mmu_idx == ARMMMUIdx_Stage1_E0)) {
+            && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
             /*
              * Synchronous stage 2 fault on an access made as part of the
              * translation table walk for AT S1E0* or AT S1E1* insn
@@ -9285,8 +9284,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if ((env->cp15.hcr_el2 & HCR_DC) &&
-        (mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1)) {
+    if ((env->cp15.hcr_el2 & HCR_DC) && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
     }
@@ -9595,7 +9593,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
                                ARMMMUFaultInfo *fi)
 {
-    if ((mmu_idx == ARMMMUIdx_Stage1_E0 || mmu_idx == ARMMMUIdx_Stage1_E1) &&
+    if (arm_mmu_idx_is_stage1_of_2(mmu_idx) &&
         !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
         target_ulong s2size;
         hwaddr s2pa;
-- 
2.20.1


