Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42CBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68BF208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frakTYAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68BF208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xpb-0005i2-VE
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xkl-0001mK-Lg
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:17:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30540
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k2xkj-000585-4a
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596550634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O+Jdn5rlTkIqQs4IBOaacsbGO+yrRT0GNqOf9hAByzs=;
 b=frakTYAO69THPOXiijP67/wnNAP/d6dz6+0KyY5zRbtmA9qT8xSEvDeeXCXxUHosl6bPd4
 nvVstuHB3Ng6M3vsKkMPAyTFUyNyknhxKur5yqtHfqEDuQgdijyJTcOpKTGg68oKLjarqT
 2rSVdUxn3ig28AdRFtvMqKgQ157qZCM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-dy2NtZSqM52UhRRSSOoFbQ-1; Tue, 04 Aug 2020 10:17:12 -0400
X-MC-Unique: dy2NtZSqM52UhRRSSOoFbQ-1
Received: by mail-qt1-f198.google.com with SMTP id k1so15487771qtp.20
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 07:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O+Jdn5rlTkIqQs4IBOaacsbGO+yrRT0GNqOf9hAByzs=;
 b=fYudTqyDg041LVoWfISabkhhrP8rludspEsk4JELGd/1ZsuMTVtcfK+gFdL2AEHS8w
 1B1RCuqqgvAw6eBhYmI/4TnP4r2Ry4tFzRRUlYSpMvkHEBw1QEAyPKPDw5n5YYuLr36u
 XT5Rk7FNQlDW6ExIt7YzBz3gzDjHDs9lX4FS88mPCCNelTp8+V1WO4QLNnTf7l8BSMj6
 qaYXCQyUGnN6hxiSkAjsU8OgxS5ES+XyUMj/a/ULmrwmP0KyZUKVRnP6CDHfe2USUcpN
 fjSemUoMb/ST/3Ji9ttdigI2cK2ncWtYbsKDpK9Df8GPhxWvIw0Cyc3R6RISiWoxFn18
 XooA==
X-Gm-Message-State: AOAM533aU3Sv55eeIlrWxitZRwho6Bsj1uwlTKjoHYJl61smzdKeSZhN
 oH1O+leVCOIHrCtEXxZp/zufi3uaSbYwkFFdJYSiq+9ckSZTfapFB4ihEnAKckkJjbmJgnV8lAu
 tcpdYHnAycq2lCWc=
X-Received: by 2002:ac8:7b94:: with SMTP id p20mr20512138qtu.312.1596550631979; 
 Tue, 04 Aug 2020 07:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYh1LDiSPGfNHYx7WdfTNpsu2V9uzw8u5oBlOoTS0HrJpDFiv+OX3N4YWnvrvxD2n/fadl6Q==
X-Received: by 2002:ac8:7b94:: with SMTP id p20mr20512114qtu.312.1596550631745; 
 Tue, 04 Aug 2020 07:17:11 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id y14sm10353782qtc.84.2020.08.04.07.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 07:17:11 -0700 (PDT)
Date: Tue, 4 Aug 2020 10:17:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] arm/acpi: fix an out of spec _UID for PCI root
Message-ID: <20200804141640.591031-3-mst@redhat.com>
References: <20200804141640.591031-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804141640.591031-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


