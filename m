Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE681C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F49218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daqrNIt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F49218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FlS-0001Ng-TZ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgj-0004Ax-Ae
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgh-0001RY-Sb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:36554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgh-0001M0-KZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:41:55 -0500
Received: by mail-wm1-x32e.google.com with SMTP id p17so7025003wma.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GmFMEgF1fTeT3DdHq7kQLyhzWA5CJUtbhKey5Au3480=;
 b=daqrNIt3h3x46atj8KbW8eEIA2rqZjU296ow02AF3dyR4M2spYuFPicdtdT75p2phv
 N3fK2hn5AFHgzI50pEAguGSfizhtBqKoC8mrsPrCnedtKYvh+wNU7K88JEL7qgngyqyE
 ElE4aJPBeulgivC57KmRzZ9pdxhd6m9SxlqQih3WFxoYXoHDxj/8EzjezcFSb5qKpENF
 M/bjuLHaNq4nw+McPxKhaHghCFnuvaH5YD0gePwT2QlZoxg/PfI0veCW0iG+p7hCsHi2
 eNvtbJWS2+nPZBMySWAADEENEUEIEQj8Hndwk0WfR36iKVejibac6G2VeUMxenAIZ8ip
 gmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GmFMEgF1fTeT3DdHq7kQLyhzWA5CJUtbhKey5Au3480=;
 b=rkQrZbjJO4bjZkQ+YeuSBxs1N7iBcUfLhwl05ybDBUZ7X5PIr8/dKdXMgOJrjeYi2X
 5aY9pQOdrUIN4fPdTPjY7JzCA6k512j0wIw/Y11rWrZ9d96QDY2f4uvlhBqp+i/7+mE2
 fO7DuJBnHdN8PqWn6otc9X4jMhkLAHHkyBiasIDkwaT+3AaA0BCOs4jbdLYV93f3Pdl2
 mOLdInuq7p+ZC4qJVGbzCueSavraqneRmcwgehQg40xZLNrTkSSUfphIVoiM5uDogxvf
 OxhSkyfpQ4UZBY41t6F/eRQsOZSXO8mdNr3o8qpItwHY5OlTW29dgon7iVCum8dIUyFI
 6ZDg==
X-Gm-Message-State: APjAAAXsl34j/AUlvH5KbycAWSd2mw2SZlnl5dAwTuxwh9zIFztSPMh1
 goiz6CLd8DyCeKqYJKg+0eZXDhe+yes=
X-Google-Smtp-Source: APXvYqzsMru86Gdh+uUmBFf4cMofnhAcfSxno0HZ2Mc11D4tVSnb6pxHA0vuH04zETqPEGoqkvtlrQ==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr6250499wmi.35.1581604912311;
 Thu, 13 Feb 2020 06:41:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.41.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:41:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/46] arm/virt/acpi: remove meaningless sub device "RP0" from
 PCI0
Date: Thu, 13 Feb 2020 14:41:03 +0000
Message-Id: <20200213144145.818-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

The sub device "RP0" under PCI0 in ACPI/DSDT does not contain any
method or property other than "_ADR", so it is safe to remove it.

Signed-off-by: Heyi Guo <guoheyi@huawei.com>
Acked-by: "Michael S. Tsirkin" <mst@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20200204014325.16279-3-guoheyi@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt-acpi-build.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index bd5f771e9be..9f4c7d1889c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -317,10 +317,6 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(method, aml_return(buf));
     aml_append(dev, method);
 
-    Aml *dev_rp0 = aml_device("%s", "RP0");
-    aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
-    aml_append(dev, dev_rp0);
-
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
     crs = aml_resource_template();
-- 
2.20.1


