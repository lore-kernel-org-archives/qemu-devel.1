Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F35C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D51A24649
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpIzEyeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D51A24649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FlG-000138-6s
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgk-0004Ba-LD
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgj-0001VW-Ek
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:58 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:54377)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgj-0001TY-89
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id g1so6528281wmh.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hsa2S0sFIOl02Bh0pvhS4b/KPw5mItrIiArWOu9Dh0U=;
 b=GpIzEyeSHAE10eNpET5ddNljibe5bJ2nZUvIBXk1pNTcf1Kwu4bmY/armpmhrf683g
 OWiabVQbK32qSDOdrEuNoJlKCn9qYzJFmBB1/6bQGp3IKk6lQIonJ+cMVwLFTIPHXG+N
 dti4kjGp5U6R98O2vm7iL+UGri9i6BHN0bBG5eYixiapvVfwCQVqBCwv3eSKduz03bKX
 jSt7R9ekOTNNWb6FZ+IQwp+8CMlZ+11ZYFIgLHHBPnVbXhsp6cXI7j37JL9MAJ3j+hUJ
 Pi8NQ1zFOdcxy3D5LaWey5z2d8mY69xSkvmpP1U1Tkb9iwi1+4+6fbdf0bf/Yd0yHBXR
 dYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hsa2S0sFIOl02Bh0pvhS4b/KPw5mItrIiArWOu9Dh0U=;
 b=jNYCmIMnbYrWWKviyhDDsd8XpI3CbpE3gCKoz4DV5Re1i3xMpKGM97ujsyT1crfRv/
 9sMDmUfyOAPFV1BZPP2rQt/wAXgqcyXQH9z5xnQukeeyk50k8git0g+NDYcHaYJCjole
 i//em3zgFFkndL/TwR0FT6H7By8awUXpIiVD+SAVLCYNl90EOnCrj20p5nKgJ/EVXNCp
 hEuzFrPb0AXDlPDIGF8oTWluZ91wVVxcFmk0F+t5DFQ1a8TCQpUfcsrnqeFPOjAUUy21
 P419H8zP38xA6NY7te4avX8LfdsjoRlL9PtK95WXQmxhCbqQMNXFkjtm9BgTINaV/cd8
 vtgg==
X-Gm-Message-State: APjAAAWufEowgpQSWnNkLgP/SeFXnPUlWQlajeKhUR4In4R2ausQ2w11
 JDT0fZ+9aFKmpbQZeJojHigE/CvXaGM=
X-Google-Smtp-Source: APXvYqwp9qyV2t5VXnRASbNJ3bWPVgQN+NNt8WlA0HUGkt8LFgsyaq69e78L1lXwL1l22FsiRHUCOg==
X-Received: by 2002:a1c:7317:: with SMTP id d23mr6370674wmb.165.1581604915973; 
 Thu, 13 Feb 2020 06:41:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/46] arm/acpi: fix duplicated _UID of PCI interrupt link
 devices
Date: Thu, 13 Feb 2020 14:41:06 +0000
Message-Id: <20200213144145.818-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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

From: Heyi Guo <guoheyi@huawei.com>

Using _UID of 0 for all PCI interrupt link devices absolutely violates
the spec. Simply increase one by one.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200204014325.16279-6-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 5d157a9dd5e..f3e340b1729 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -189,7 +189,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         uint32_t irqs =  irq + i;
         Aml *dev_gsi = aml_device("GSI%d", i);
         aml_append(dev_gsi, aml_name_decl("_HID", aml_string("PNP0C0F")));
-        aml_append(dev_gsi, aml_name_decl("_UID", aml_int(0)));
+        aml_append(dev_gsi, aml_name_decl("_UID", aml_int(i)));
         crs = aml_resource_template();
         aml_append(crs,
                    aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
-- 
2.20.1


