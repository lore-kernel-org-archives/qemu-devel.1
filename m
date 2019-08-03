Return-Path: <SRS0=Oxyb=V7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8A1C433FF
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553BC2073D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Aug 2019 18:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeuwLZaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553BC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htz5y-0008Gi-Lk
	for qemu-devel@archiver.kernel.org; Sat, 03 Aug 2019 14:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60581)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4c-00063Q-T8
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htz4b-00077s-TD
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:10 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42853)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htz4b-00077L-OA
 for qemu-devel@nongnu.org; Sat, 03 Aug 2019 14:48:09 -0400
Received: by mail-pf1-x443.google.com with SMTP id q10so37607192pff.9
 for <qemu-devel@nongnu.org>; Sat, 03 Aug 2019 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hV2eslCkM9+11E22XGBDo1tPxuDz+vxwGvc3iXR5Q+U=;
 b=zeuwLZaLsuKqWvo0H7Lao3Xmq/IJ/PIq5u1FH0Yo7+Ni0P3R68YJHjwxjMrTtuaWjv
 6UIrxJop+hOjmQMKQmGyUtp6T3hEuNYSt7wzQQZMeD4Whyg71621DfHr+ZDL3FNabgcM
 Ei6YZ1Qjm2qvwsPMXDbAodapGHrzDuKJ3WFjUAlA8hwRKF4hZoqaVeY8Cy4Zf5EQD70Q
 toso8YjoLAGaQ0ePImuSya6uKEGRuNX4Z83FoB9B2hX682K7shVPM9hj7y+Jn0ZN4wQE
 8sVIe+ORce9HBYoAAavsZ0O0+Lb03HwTAA2v7x85Sf2HmI6PUWezWG7TUkVOBoRkMEhK
 GWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hV2eslCkM9+11E22XGBDo1tPxuDz+vxwGvc3iXR5Q+U=;
 b=gm5CXamxZzmKFIFap4ZPFWc2mAuJjcqKYvxBE35igQ7PR1wHlBAQ4icG7YwMO65iUo
 guviJeT0CgEFFyEpAySZ2nXQjbwblf1tiRwtowtqACC9MaCWIDWrRpamIO02tp5wyw6r
 SUyNwv0Of8o+/eDTFWi30T4En4ZiYJrDhOr8k3OHl0VQHhg8IEIrCUZq1fm7uKqHEeVI
 7qD8zF1l2GuXEecSyHfD0sNdxwrRpIkzjIvUjRYdnacvmpISX+EKoe+qKMlftEauGgP5
 mVpfzYY81wQ2wHg7do5eSmc80gUq4G+GVvBbGzkmEf/JCpspwf8RofDRPSURZ6RPj/SL
 Oxsg==
X-Gm-Message-State: APjAAAV/nyIJ4/7OsdaTYCwg+53KuMvCKMsFxz+Hr/+RkPHkrFTXruxv
 18UVAwwLb49aYTnNBIXkdojX0T3YAYw=
X-Google-Smtp-Source: APXvYqw50D1tcuFilG+lYYxJAjSIostRpVb5BrDCxdOpOTlicOOpTPm5TWnKVhKHX8m23N4E7EEppA==
X-Received: by 2002:a62:8246:: with SMTP id w67mr67312952pfd.226.1564858088554; 
 Sat, 03 Aug 2019 11:48:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q69sm15405454pjb.0.2019.08.03.11.48.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 03 Aug 2019 11:48:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat,  3 Aug 2019 11:47:31 -0700
Message-Id: <20190803184800.8221-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190803184800.8221-1-richard.henderson@linaro.org>
References: <20190803184800.8221-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v3 05/34] target/arm: Install ASIDs for EL2
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

The VMID is the ASID for the 2nd stage page lookup.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c0dc76ed41..65e3ffbb43 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3452,17 +3452,23 @@ static void vmsa_ttbr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+    int vmid;
 
-    /* Accesses to VTTBR may change the VMID so we must flush the TLB.  */
-    if (raw_read(env, ri) != value) {
-        tlb_flush_by_mmuidx(cs,
-                            ARMMMUIdxBit_S12NSE1 |
-                            ARMMMUIdxBit_S12NSE0 |
-                            ARMMMUIdxBit_S2NS);
-        raw_write(env, ri, value);
-    }
+    raw_write(env, ri, value);
+
+    /*
+     * TODO: with ARMv8.1-VMID16, aarch64 must examine VTCR.VS
+     * (re-evaluating with changes to VTCR) then use bits [63:48].
+     */
+    vmid = extract64(value, 48, 8);
+
+    /*
+     * A change in VMID to the stage2 page table (S2NS) invalidates
+     * the combined stage 1&2 tlbs (S12NSE1 and S12NSE0).
+     */
+    tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_S2NS,
+                            ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0);
 }
 
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
-- 
2.17.1


