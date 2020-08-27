Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6158C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59C6207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrQ/m6/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59C6207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBI9r-0002iv-Ux
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8n-0000tV-5y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kBI8l-0006JJ-5b
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598535630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O+Jdn5rlTkIqQs4IBOaacsbGO+yrRT0GNqOf9hAByzs=;
 b=RrQ/m6/zE8GuypwEc+PAdt6ISnoHFrQg3POR6KMI4JMqvlZJVDHwPS3J6BUPp11B7Tuc6y
 iNu1qiBZuo255wTO2cHkt315OjHC1EYerkpXdY6jywNrN1oc+wUqq6LTQUBuGF+ESUXeO6
 iHnwMLjKQ3Rns6mboi7jxmPaJXhTZLk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-U-ds8ZnrNc-TAe_YBezcgA-1; Thu, 27 Aug 2020 09:40:27 -0400
X-MC-Unique: U-ds8ZnrNc-TAe_YBezcgA-1
Received: by mail-wm1-f72.google.com with SMTP id c198so2144770wme.5
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 06:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O+Jdn5rlTkIqQs4IBOaacsbGO+yrRT0GNqOf9hAByzs=;
 b=Zn+a8IW1bOpb/G843Xo1yzUAg7jdRkqR6AWbxZiR1lh0td3DKK7cQ0pbQ1ADS88vPn
 MfYqUutkHR6RDQRx1UIeXrGXqcbhkTokpedQHUYYnHjeMqe7eBXqJkLTMZpkl/IPDCtG
 EX1tg82s41Yo3l9DhFlD9DlwcSflh5qsbh+Zs1S6fY8eX0WpAZqrlSA6j1FlY+cL+mwH
 2bWCHFarGOx7cI1DC34fgHMMLvKQGqlFYYRbTXfG2+I2hqJhW/f8JqHivzZDTuugk6BK
 3jBCkI7S8tAAoSwWtGRrRBQId5/s96+x6y1YC6Sf3a+P4vocOM50xasGt8JG8rNp3T+4
 Fz3Q==
X-Gm-Message-State: AOAM530Y3xw/ZSGGjd9slzqNu4ovRsmVGZHBsd8kkB/m+cA9BFjMdXpO
 smDAxmGgeWvg4Bzn78ToAzUyqlwjATX9aXy01GuLgTClBjq5kTwOF105FsGnMdbTWQRCFdc/WQs
 s8jQC5rVXaVN+alQ=
X-Received: by 2002:adf:f58e:: with SMTP id f14mr13441169wro.251.1598535626064; 
 Thu, 27 Aug 2020 06:40:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeO1yNHlhNkeNFLrV26p2lSO6onfx+3qz1X8T4LR9OMNB4I7I3jKaQ9XLpa0+nxIqwc2HH0g==
X-Received: by 2002:adf:f58e:: with SMTP id f14mr13441156wro.251.1598535625877; 
 Thu, 27 Aug 2020 06:40:25 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id c10sm5045320wmk.30.2020.08.27.06.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 06:40:25 -0700 (PDT)
Date: Thu, 27 Aug 2020 09:40:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] arm/acpi: fix an out of spec _UID for PCI root
Message-ID: <20200827133954.2118749-4-mst@redhat.com>
References: <20200827133954.2118749-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200827133954.2118749-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vitaly Cheptsov <vit9696@protonmail.com>, qemu-stable@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On ARM/virt machine type QEMU currently reports an incorrect _UID in
ACPI.

The particular node in question is the primary PciRoot (PCI0 in ACPI),
which gets assigned PCI0 in ACPI UID and 0 in the
DevicePath. This is due to the _UID assigned to it by build_dsdt in
hw/arm/virt-acpi-build.c Which does not correspond to the primary PCI
identifier given by pcibus_num in hw/pci/pci.c

In UEFI v2.8, section "10.4.2 Rules with ACPI _HID and _UID" ends with
the paragraph,

    Root PCI bridges will use the plug and play ID of PNP0A03, This will
    be stored in the ACPI Device Path _HID field, or in the Expanded
    ACPI Device Path _CID field to match the ACPI name space. The _UID
    in the ACPI Device Path structure must match the _UID in the ACPI
    name space.

(See especially the last sentence.)

A similar bug has been reported on i386, on that architecture it has
been reported to confuse at least macOS which uses ACPI UIDs to build
the DevicePath for NVRAM boot options, while OVMF firmware gets them via
an internal channel through QEMU.  When UEFI firmware and ACPI have
different values, this makes the underlying operating system unable to
report its boot option.

Cc: qemu-stable@nongnu.org
Reported-by: Vitaly Cheptsov <vit9696@protonmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/arm/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 91f0df7b13..0a482ff6f7 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -170,7 +170,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
     aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
     aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
-    aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
     aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
     aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
 
-- 
MST


