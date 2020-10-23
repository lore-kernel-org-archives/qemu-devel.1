Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2570CC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:13:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C5020878
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 07:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYicyxzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C5020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVrGh-0004kp-FW
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 03:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVrDk-0000xl-4V
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVrDg-0003cd-8Q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 03:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603437035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HewBjwgtaPkmFqtcQM2faeMaE/Qsyyt1Pa0HgLpeH6M=;
 b=SYicyxzFk7H4uPwLURyUcne8BfHYg53F6jf8zRgZ5NS+wPST32SOgl2fJvdj1wDXTsageJ
 o/wtsqxEdn3Sa6PVjEqc8j0Fe9uT8jq1x60PGo/NS3QPZ81MPTq3ajRkHA9ooFnjX9JLKG
 gPhv4Cjb1ZSuNfGi32CLmgWlgfHa+gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-tsZHN1c0NnSnGleXFf6r7w-1; Fri, 23 Oct 2020 03:10:33 -0400
X-MC-Unique: tsZHN1c0NnSnGleXFf6r7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45EB7186DD40;
 Fri, 23 Oct 2020 07:10:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0134F50B44;
 Fri, 23 Oct 2020 07:10:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 386FF1FCF5; Fri, 23 Oct 2020 09:10:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] arm/virt: add support for -machine usb=on
Date: Fri, 23 Oct 2020 09:10:17 +0200
Message-Id: <20201023071022.24916-4-kraxel@redhat.com>
In-Reply-To: <20201023071022.24916-1-kraxel@redhat.com>
References: <20201023071022.24916-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

Wire up sysbus-xhci in case usb is enabled.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 23 +++++++++++++++++++++++
 hw/arm/Kconfig        |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index aad6d698412a..7c745fbf8b19 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -85,6 +85,7 @@ enum {
     VIRT_ACPI_GED,
     VIRT_NVDIMM_ACPI,
     VIRT_PVTIME,
+    VIRT_XHCI,
     VIRT_LOWMEMMAP_LAST,
 };
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e465a988d683..f2b34fd33be4 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -77,6 +77,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
+#include "hw/usb/xhci.h"
 #include "qemu/guest-random.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
@@ -152,6 +153,7 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
     [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
+    [VIRT_XHCI] =               { 0x090b0000, XHCI_LEN_REGS },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
@@ -188,6 +190,7 @@ static const int a15irqmap[] = {
     [VIRT_GPIO] = 7,
     [VIRT_SECURE_UART] = 8,
     [VIRT_ACPI_GED] = 9,
+    [VIRT_XHCI] = 10,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -806,6 +809,22 @@ static void create_rtc(const VirtMachineState *vms)
     g_free(nodename);
 }
 
+static void create_xhci(const VirtMachineState *vms)
+{
+    hwaddr base = base_memmap[VIRT_XHCI].base;
+    int irq = vms->irqmap[VIRT_XHCI];
+    DeviceState *dev;
+
+    dev = qdev_new(TYPE_XHCI_SYSBUS);
+    qdev_prop_set_uint32(dev, "intrs", 1);
+    qdev_prop_set_uint32(dev, "slots", XHCI_MAXSLOTS);
+    qdev_prop_set_uint32(dev, "p2", 8);
+    qdev_prop_set_uint32(dev, "p3", 8);
+    sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(vms->gic, irq));
+}
+
 static DeviceState *gpio_key_dev;
 static void virt_powerdown_req(Notifier *n, void *opaque)
 {
@@ -1981,6 +2000,10 @@ static void machvirt_init(MachineState *machine)
 
     create_pcie(vms);
 
+    if (machine_usb(MACHINE(vms))) {
+        create_xhci(vms);
+    }
+
     if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
         vms->acpi_dev = create_acpi_ged(vms);
     } else {
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7d040827af4f..338ebc6f97d5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -27,6 +27,7 @@ config ARM_VIRT
     select ACPI_HW_REDUCED
     select ACPI_NVDIMM
     select ACPI_APEI
+    select USB_XHCI_SYSBUS
 
 config CHEETAH
     bool
-- 
2.27.0


