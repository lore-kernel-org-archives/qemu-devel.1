Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB5DC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:14:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB7420878
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/ZxFiJp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB7420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrHd-0006Aq-5G
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVrDl-00011S-L7
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:10:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVrDi-0003eY-L1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603437038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eWkdInSjGNjGML1dW+2HIPwAc6XN/W7Ms3osxO/bjYA=;
 b=i/ZxFiJpxLtfiONtw9ozSbpOiDDzJvPVK2dOMwzbAE3a3LN6vx1aw2TLC6Xw5VjCmcij84
 vwGZhy5Y5pR2GvjuBlmkO9S2Ucl0oIOJB5iEmy0O2SqVt72t47Kjil6Z+4mvGoeSAsnMf+
 0lYXCpzey2H9wuC4wrmrnv1yKccjuY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-ddXiReYYOrW7qLJR8VP07Q-1; Fri, 23 Oct 2020 03:10:34 -0400
X-MC-Unique: ddXiReYYOrW7qLJR8VP07Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B81C95F9DA;
 Fri, 23 Oct 2020 07:10:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74CBC5D9CC;
 Fri, 23 Oct 2020 07:10:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4BEA9204A6; Fri, 23 Oct 2020 09:10:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] arm/virt: add acpi dsdt entry for xhci
Date: Fri, 23 Oct 2020 09:10:19 +0200
Message-Id: <20201023071022.24916-6-kraxel@redhat.com>
In-Reply-To: <20201023071022.24916-1-kraxel@redhat.com>
References: <20201023071022.24916-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also tweak xhci_sysbus_build_aml, add _UID and _CCA.
Without _CCA the linux kernel's xhci probe fails on arm.

ASL changes:

         Device (XHCI)
         {
             Name (_HID, EisaId ("PNP0D10") /* XHCI USB Controller with debug */)  // _HID: Hardware ID
+            Name (_UID, Zero)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
             Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
             {
                 Memory32Fixed (ReadWrite,
                     0xFE900000,         // Address Base
                     0x00004000,         // Address Length
                     )
                 Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
                 {
                     0x0000000A,
                 }
             })
         }

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/arm/virt-acpi-build.c | 6 ++++++
 hw/usb/hcd-xhci-sysbus.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9747a6458f0b..147332b37597 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -54,6 +54,7 @@
 #include "kvm_arm.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
+#include "hw/usb/xhci.h"
 
 #define ARM_SPI_BASE 32
 
@@ -631,6 +632,11 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
+    if (machine_usb(MACHINE(vms))) {
+        xhci_sysbus_build_aml(scope, memmap[VIRT_XHCI].base,
+                              irqmap[VIRT_XHCI] + ARM_SPI_BASE);
+    }
+
     acpi_dsdt_add_power_button(scope);
     acpi_dsdt_add_tpm(scope, vms);
 
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 29185d2261fb..fa963a5de4fa 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -79,6 +79,8 @@ void xhci_sysbus_build_aml(Aml *scope, uint32_t mmio, unsigned int irq)
                                   AML_EXCLUSIVE, &irq, 1));
 
     aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0D10")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
     aml_append(dev, aml_name_decl("_CRS", crs));
     aml_append(scope, dev);
 }
-- 
2.27.0


