Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DD0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9014B206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z09bGIAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9014B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixClW-0008Ik-MA
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCUA-0005nf-St
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixCU9-0003Eb-IV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixCU9-0003Cn-Cm
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:16:05 -0500
Received: by mail-wm1-x343.google.com with SMTP id p9so4410870wmc.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 08:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mqPGs4XNEvxPX2EtaQrvJmfPijwJDTsAZANFfzH5G5A=;
 b=Z09bGIAJlfDJyyCxeXyPnMAWgPDWnxxCZGqs7adw5mR42gBukizBXxo3obb7DaLjtv
 t8CHNvZfJ5u23CCOwZXJrMP9Lw99ts/XTm69gJC7wwQTHIOq+nWVHNRpr++QimFkYvSH
 kI4pzFyq+rU4RCJj2RANhYWIgChmHN1VHrSX7oGn3XROJr+egPuk0+cMNi2w6nkAvTiz
 Lp3N52wdWOBq97nYKyKfvcpJwn7qcy7iA9juH8Xqcrbjeuxeun3JvbK54qOav64sstvU
 zIFl6NYtEoaeMatzlpd1jlGEyMTAxF+/w4dL2ORB7oVOjUrMct4fbKpknZrrnmRpiNKJ
 p1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mqPGs4XNEvxPX2EtaQrvJmfPijwJDTsAZANFfzH5G5A=;
 b=YjpzQii47IrXUKqiXTmOQT7gCN2bTdl03EKHq6y2GflXRvsBOR3mMTBnehdyc0XPQr
 gCuBCrqHKDFt/0w+R+3rrgdj3GceIYfO7m86nmJShX7uoWzCySFnc3mjUt0Vfo83c3CP
 PaQUOCKepNBkIXklMSK3jW0jmUoB43yg95v7WwZs5Pm8PDpom6IWUeBeGIAZ2k5j3mh4
 GNYYYTKE5kxn5J1PhIUHlI7zDyzA1J+x4tbA2BhdKd/B6tnVZidEDhddgU4G9MZoBKLC
 w69xerXQPzbHfY97bIMevQuF72kXcOBzkQt2ba0bAenuvcs15gE6+uNfAk80uN9F7G8F
 dr9Q==
X-Gm-Message-State: APjAAAXKT79YzbbgrnLCNsYth61GVBCycccNRyc8/GyD1hoZ1n1SdRUA
 KouxisUzVSqssQSie2HKW7vWamsULy1lYw==
X-Google-Smtp-Source: APXvYqxOT6QHWq6RX8rKssGjkiRCfY4N4IO4Z7d4GVJyurrViQorWpC4D5AWUmSKBPZ7EcaHglyCYw==
X-Received: by 2002:a1c:7317:: with SMTP id d23mr6601607wmb.165.1580400963959; 
 Thu, 30 Jan 2020 08:16:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a22sm6994442wmd.20.2020.01.30.08.16.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 08:16:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] target/arm/kvm64: kvm64 cpus have timer registers
Date: Thu, 30 Jan 2020 16:15:30 +0000
Message-Id: <20200130161533.8180-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130161533.8180-1-peter.maydell@linaro.org>
References: <20200130161533.8180-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

From: Andrew Jones <drjones@redhat.com>

Add the missing GENERIC_TIMER feature to kvm64 cpus.

We don't currently use these registers when KVM is enabled, but it's
probably best we add the feature flag for consistency and potential
future use. There's also precedent, as we add the PMU feature flag to
KVM enabled guests, even though we don't use those registers either.

This change was originally posted as a hunk of a different, never
merged patch from Bijan Mottahedeh.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200120101023.16030-4-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 6344113a680..8955d23affd 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -604,6 +604,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     set_feature(&features, ARM_FEATURE_NEON);
     set_feature(&features, ARM_FEATURE_AARCH64);
     set_feature(&features, ARM_FEATURE_PMU);
+    set_feature(&features, ARM_FEATURE_GENERIC_TIMER);
 
     ahcf->features = features;
 
-- 
2.20.1


