Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C230CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D62208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDpLqQQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D62208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP1w-0005eW-Mr
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx8-0004cO-MM
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:50681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx6-0005f3-Ri
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id l17so32636679wmj.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=T17rWK5CCU0ZUANk3vqpHki4UbNYDej3t8lSuYskTdY=;
 b=LDpLqQQgCjEL9GPjFpb8U/YkdUKmHKibZZMPFcHOPyj0Qvn0oo9RuVsu9gIIE3XnPw
 /clCffpqEkE1G/XhHNJ9QWxXK/UzzayxrcYnrYtu9OnTmHqp2uUV9ovWmibpNWfZhae1
 +6wUej3mSCKeparKNsqZLOuhwqZKHd0C8Bu7FKF7PPYKwCO016qhezBrfHDgHFqshhT7
 qn5V6lxKhHGEv4O+35+y9xc3TWhZ1bXa18Fo7iUIGolZzbEsJcMcZKDpE+sBzlZrgX12
 53rb7oDX6vH/fBsRkGt2V4pxMwzvWlEOX9XKZJEsOl6x63QY7MSSJ4/zY21xzzxb7GVT
 rcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T17rWK5CCU0ZUANk3vqpHki4UbNYDej3t8lSuYskTdY=;
 b=iLz5FslZmzgk4//zCMQ6YcYBhbaL9cDt6mi/cAjil/T8ufNI/7OnEW/dx+nmv2LG94
 ZOGywFdFcBtfS6ofKFVQ72zVpDMTFRJBziU+/GQvUZ7Z++Fgg3K6dMs+NylwmU4D93lt
 Vydl3UL0Ksf7wi0/jBJCt1QezKmiHq7dYYOBqPoi8M6OCN8ojuDzBRSGHlFPLxioxz3g
 eHPfBzLmldxR1qK3ZFQrcghcmcjyRuJsBn1BU5uFSHq419PR0VPD2IIfcFAn1eSk54Hc
 T0dMWomfUnqQHN/nHIyYiFwPuTo9Om/klrZ8q6PxEv9vhpIdeDsMSoQP+PcMuKtTgot/
 7P7g==
X-Gm-Message-State: AOAM531eJ3uUoe8rvKyHuyyBFkafi06mVnTo92djW72wJH7bmkB1fzYJ
 /trXSwBwSpS9KPFAaKrinrZlaRYhm+jKbA==
X-Google-Smtp-Source: ABdhPJw67F2scitmVzwAEFoLXMbMmj8XZnST7sLroewvmV68dc2WlN1sOvyr3Vr+ZW6xbZg1SOJLXg==
X-Received: by 2002:a7b:c5c4:: with SMTP id n4mr36674691wmk.67.1593795255133; 
 Fri, 03 Jul 2020 09:54:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/34] virtio-iommu-pci: Add array of Interval properties
Date: Fri,  3 Jul 2020 17:53:38 +0100
Message-Id: <20200703165405.17672-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

The machine may need to pass reserved regions to the
virtio-iommu-pci device (such as the MSI window on x86
or the MSI doorbells on ARM).

So let's add an array of Interval properties.

Note: if some reserved regions are already set by the
machine code - which should be the case in general -,
the length of the property array is already set and
prevents the end-user from modifying them. For example,
attempting to use:

-device virtio-iommu-pci,\
 len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:1

would result in the following error message:

qemu-system-aarch64: -device virtio-iommu-pci,addr=0xa,
len-reserved-regions=1,reserved-regions[0]=0xfee00000:0xfeefffff:1:
array size property len-reserved-regions may not be set more than once

Otherwise, for example, adding two reserved regions is achieved
using the following options:

-device virtio-iommu-pci,addr=0xa,len-reserved-regions=2,\
 reserved-regions[0]=0xfee00000:0xfeefffff:1,\
 reserved-regions[1]=0x1000000:100ffff:1

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-id: 20200629070404.10969-5-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/virtio/virtio-iommu-pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 4588361d6b3..592abc9279c 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -33,6 +33,9 @@ struct VirtIOIOMMUPCI {
 
 static Property virtio_iommu_pci_properties[] = {
     DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+    DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
+                      vdev.nb_reserved_regions, vdev.reserved_regions,
+                      qdev_prop_reserved_region, ReservedRegion),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -40,6 +43,7 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOIOMMUPCI *dev = VIRTIO_IOMMU_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
 
     if (!qdev_get_machine_hotplug_handler(DEVICE(vpci_dev))) {
         MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
@@ -54,6 +58,13 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
                           "-no-acpi\n");
         return;
     }
+    for (int i = 0; i < s->nb_reserved_regions; i++) {
+        if (s->reserved_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
+            s->reserved_regions[i].type != VIRTIO_IOMMU_RESV_MEM_T_MSI) {
+            error_setg(errp, "reserved region %d has an invalid type", i);
+            error_append_hint(errp, "Valid values are 0 and 1\n");
+        }
+    }
     object_property_set_link(OBJECT(dev),
                              OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
                              "primary-bus", &error_abort);
-- 
2.20.1


