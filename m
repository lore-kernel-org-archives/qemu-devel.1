Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D792C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:55:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8132082F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+oXnFnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8132082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ftf-0003n9-7S
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgk-0004BZ-El
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgj-0001Ut-2r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51272)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgi-0001PE-RN
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:57 -0500
Received: by mail-wm1-x331.google.com with SMTP id t23so6543016wmi.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yohK9fa0GtpK0dTMm8tvPjd2OMeAkG47tGbSwUeB+Fk=;
 b=J+oXnFnBRNGSedUedeFmSvNuAQdP+1GD0qZwVe4yRz/BN7Z/LG7X1ui9LwdRUrU6r+
 gDH+a/c9rMOdaU+r5dCVfksGCYWlhqdf8CmwxKRkXD/+Wqf5Xqg2fZoM8F3+IMQb9+z8
 4cv6g/gxlqOYx2inwgwPUm6chDN6pbUBENbhc7V5O2x2aXTeJ+LbEHiWs6sE/PwuPmvo
 J6Um9nkD0V3hXLaCmnxLY/ckDnfjt4+DOa9PJmySbp+/oe6VfEJ/oG8l18RCTqgc9Is9
 MswuTHhsSZZsTi5DD+lnQ0IdrNs86rL6FP9aredvqbj+M7JWQhOAKRvQ+Kkq60kzqzso
 zDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yohK9fa0GtpK0dTMm8tvPjd2OMeAkG47tGbSwUeB+Fk=;
 b=qeghM/qLY1urm6q8LB9J2CYeDYRVRgtdSvq//VrsBVxq+JG8XLMEnQdKT6hF7V1isq
 KnMnUffH3mRJ6g64nb5f2taGJz1F4uRS4d6DW7yigpTb+6mFlamTMYQkmBUcnXeGx2Q7
 R+e00q5o2q56WZLRzKvJYRWOfVAZYHdLY/O9xZc0EZNuplh0ZrzKlowUpyxXbtClZeOl
 B30DrpJnlwV5oxuj1iOeLQjSycp43g4U6mT93wbdmAHvvVNT+kpx+OPjHWTr52Rd5cky
 xFdov0f28qsrRy8X44N9dn0tGLggLjFG0E87Finp6/VJEY3iColfsBfuZJqkcCNdQW/9
 D2AQ==
X-Gm-Message-State: APjAAAXNudBn0YJvzLuZmXbrcU462iIXJLBNL2i37AlLeSASGjzsH/Fk
 aSrXYieR3krd4SUxHUsrxXFBqdw5v+U=
X-Google-Smtp-Source: APXvYqxI/1IJNDwCQnquqhsoWWSsYBTTdtRhh9pqDGnVx9QzYDRuiSwoWmaKBrgNpVAIp8UXNYZmWQ==
X-Received: by 2002:a05:600c:211:: with SMTP id
 17mr6139910wmi.60.1581604913529; 
 Thu, 13 Feb 2020 06:41:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/46] arm/virt/acpi: remove _ADR from devices identified by
 _HID
Date: Thu, 13 Feb 2020 14:41:04 +0000
Message-Id: <20200213144145.818-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

According to ACPI spec, _ADR should be used for device on a bus that
has a standard enumeration algorithm, but not for device which is on
system bus and must be enumerated by OSPM. And it is not recommended
to contain both _HID and _ADR in a single device.

See ACPI 6.3, section 6.1, top of page 343:

A device object must contain either an _HID object or an _ADR object,
but should not contain both.

(https://uefi.org/sites/default/files/resources/ACPI_6_3_May16.pdf)

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200204014325.16279-4-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9f4c7d1889c..be752c0ad8e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -78,11 +78,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                              AML_EXCLUSIVE, &uart_irq, 1));
     aml_append(dev, aml_name_decl("_CRS", crs));
 
-    /* The _ADR entry is used to link this device to the UART described
-     * in the SPCR table, i.e. SPCR.base_address.address == _ADR.
-     */
-    aml_append(dev, aml_name_decl("_ADR", aml_int(uart_memmap->base)));
-
     aml_append(scope, dev);
 }
 
@@ -170,7 +165,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
     aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
     aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
-    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
     aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
     aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
     aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
@@ -334,7 +328,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
 {
     Aml *dev = aml_device("GPO0");
     aml_append(dev, aml_name_decl("_HID", aml_string("ARMH0061")));
-    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
     aml_append(dev, aml_name_decl("_UID", aml_int(0)));
 
     Aml *crs = aml_resource_template();
@@ -364,7 +357,6 @@ static void acpi_dsdt_add_power_button(Aml *scope)
 {
     Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
     aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
-    aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
     aml_append(dev, aml_name_decl("_UID", aml_int(0)));
     aml_append(scope, dev);
 }
-- 
2.20.1


