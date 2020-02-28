Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72405C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFD762467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 17:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U75JsSpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD762467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7j4l-0001nL-Tn
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 12:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifR-00083L-SS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifQ-00022s-QK
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:13 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:36851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifP-00021W-K8
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:12 -0500
Received: by mail-wm1-x32a.google.com with SMTP id g83so1709756wme.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OBBHRjdd80h8GtLACN+1yFyC+k5vRKdVFPA1E7huKbI=;
 b=U75JsSpQT1vVB3OOXFAOHq6euP/J+fYRnOqpPa8FQSXG2fF/MiydB+qIwEvqCuanvt
 TLG4g/pMYlrF/DkDOtdYRVZXxviBLJf3/V0DypgS2edUjuSyFkcfpQ4rXYA/1kErUbGI
 b609CsLPqTOQdXOY3ifQkv0/6glv8DKNTp7+xoQlxqN7jnQiCUl4q+jEvnLQwwHq4axI
 kCmx739Wgo7r/ysvuV65Y59475fL0IADpql4LKtsf8jOvKllTRy0GvdiWzO0H+RqvGJ4
 Lyg0nUOVQLxWvxErR0uOIjYltcZ2z+3KSlKeTik1FuYqDbNyvuhjSXqnyfEgzzvVhYab
 bn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OBBHRjdd80h8GtLACN+1yFyC+k5vRKdVFPA1E7huKbI=;
 b=KxDG6RsGz7x/xXd2CwMflNkkFLY4+6AWqueB2OOFMUwkHl61cnSZzgQQpkk9YZ/xTF
 lDxj+e/BkUVc///GbFJC4vyZugrrkCMc9Q7yCJc0PdkhxbkRMf3we0uZvwfwFu1a2Feu
 6KiI77Mzxm0ZXhPCwH9GTaZlt1Swb45YwVbi93oJUHo9Ht8uxV/GTtl5ismaJK7/PHzu
 952ziW0vn865YPKe64SKqf4LYe3A7SywS5eLQFIhI4IhhuQv5uCIjcN4bO0wWgJDPXZ1
 dEc9x/6T9e2XO6GLYvZ+QkxGB+p6wp+my2YjYbqeeXaDMJkOPjtZtFf1Rq9dgjhxcdbS
 sKrg==
X-Gm-Message-State: APjAAAVt10iYrVvrdhxbw+TMTBvFPfP5E/ntadTJhRetMSQII797eMsl
 FFd9pykSetkWp+VQF7rQMZKZLAicVSfu8w==
X-Google-Smtp-Source: APXvYqwF8AR7LyDXP84gYasKjIsrc5E3BFRmgLhvzQthdDZcpB6Nt+We8Wst4WonzMY1TMW6MbFqHw==
X-Received: by 2002:a1c:2504:: with SMTP id l4mr5770429wml.72.1582907950410;
 Fri, 28 Feb 2020 08:39:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/33] hw/usb/hcd-ehci-sysbus: Remove obsolete xlnx,
 ps7-usb class
Date: Fri, 28 Feb 2020 16:38:31 +0000
Message-Id: <20200228163840.23585-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
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

From: Guenter Roeck <linux@roeck-us.net>

Xilinx USB devices are now instantiated through TYPE_CHIPIDEA,
and xlnx support in the EHCI code is no longer needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20200215122354.13706-3-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/usb/hcd-ehci-sysbus.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index b22fb258be7..5b7991cffe4 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -115,22 +115,6 @@ static const TypeInfo ehci_platform_type_info = {
     .class_init    = ehci_platform_class_init,
 };
 
-static void ehci_xlnx_class_init(ObjectClass *oc, void *data)
-{
-    SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    set_bit(DEVICE_CATEGORY_USB, dc->categories);
-    sec->capsbase = 0x100;
-    sec->opregbase = 0x140;
-}
-
-static const TypeInfo ehci_xlnx_type_info = {
-    .name          = "xlnx,ps7-usb",
-    .parent        = TYPE_SYS_BUS_EHCI,
-    .class_init    = ehci_xlnx_class_init,
-};
-
 static void ehci_exynos4210_class_init(ObjectClass *oc, void *data)
 {
     SysBusEHCIClass *sec = SYS_BUS_EHCI_CLASS(oc);
@@ -267,7 +251,6 @@ static void ehci_sysbus_register_types(void)
 {
     type_register_static(&ehci_type_info);
     type_register_static(&ehci_platform_type_info);
-    type_register_static(&ehci_xlnx_type_info);
     type_register_static(&ehci_exynos4210_type_info);
     type_register_static(&ehci_tegra2_type_info);
     type_register_static(&ehci_ppc4xx_type_info);
-- 
2.20.1


