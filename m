Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE40C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C582145D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzUq0XII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C582145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKKQx-0007Pd-EI
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKKG8-0002zP-Gv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:45:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30552
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKKG6-0002bX-33
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600688725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nov3hMfz33U+yqvP0A61L4yla7ySq2UFMPH9rNuTgpg=;
 b=OzUq0XIILqJycXFaAXg44jR4HqGASHUqBXF5QCxCQ+OmmmWEpZ6e+1ioxWNrD0vquBIwDG
 6DKR7Agr1h145DkX7hFdtNWMh4/+B5hnUONg2UEVdzbj3vYRT7WA7STXrJm0es4nlqW0vb
 4pM2IwMGdHFiT/3hxXnIbRkZB8BSLF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-MXtvkae3MGeYzFaL-lEUZQ-1; Mon, 21 Sep 2020 07:45:23 -0400
X-MC-Unique: MXtvkae3MGeYzFaL-lEUZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61E468015FA;
 Mon, 21 Sep 2020 11:45:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DFCA9F70;
 Mon, 21 Sep 2020 11:45:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DBD751750A; Mon, 21 Sep 2020 13:45:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] microvm: add usb support
Date: Mon, 21 Sep 2020 13:45:09 +0200
Message-Id: <20200921114509.14511-3-kraxel@redhat.com>
In-Reply-To: <20200921114509.14511-1-kraxel@redhat.com>
References: <20200921114509.14511-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Wire up "usb=on" machine option.  When enabled add a sysbus xhci
controller with 8 ports.  Declare it in the ACPI DSDT table so the
guest OS finds it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/microvm.h |  5 ++++-
 hw/i386/acpi-microvm.c    | 20 ++++++++++++++++++++
 hw/i386/microvm.c         | 12 ++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 27eadd6c535c..e255e787b6d5 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -40,7 +40,7 @@
  *   7     |  parallel  |
  *   8     |  rtc       | rtc (rtc=on)
  *   9     |  acpi      | acpi (ged)
- *  10     |  pci lnk   |
+ *  10     |  pci lnk   | xhci (usb=on)
  *  11     |  pci lnk   |
  *  12     |  ps2       |
  *  13     |  fpu       |
@@ -59,6 +59,9 @@
 #define GED_MMIO_BASE_REGS    (GED_MMIO_BASE + 0x200)
 #define GED_MMIO_IRQ          9
 
+#define MICROVM_XHCI_BASE     0xfe900000
+#define MICROVM_XHCI_IRQ      10
+
 /* Machine type options */
 #define MICROVM_MACHINE_PIT                 "pit"
 #define MICROVM_MACHINE_PIC                 "pic"
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index df39c5d3bd90..a2b6c4478f3b 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -87,6 +87,25 @@ static void acpi_dsdt_add_virtio(Aml *scope,
     }
 }
 
+static void acpi_dsdt_add_xhci(Aml *scope, MicrovmMachineState *mms)
+{
+    if (!machine_usb(MACHINE(mms))) {
+        return;
+    }
+
+    Aml *dev = aml_device("XHCI");
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0D10")));
+
+    uint32_t irq = MICROVM_XHCI_IRQ;
+    Aml *crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(MICROVM_XHCI_BASE, 0x4000,
+                                       AML_READ_WRITE));
+    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                                  AML_EXCLUSIVE, &irq, 1));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 static void
 build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
                    MicrovmMachineState *mms)
@@ -112,6 +131,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
     acpi_dsdt_add_virtio(sb_scope, mms);
+    acpi_dsdt_add_xhci(sb_scope, mms);
     aml_append(dsdt, sb_scope);
 
     /* ACPI 5.0: Table 7-209 System State Package */
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 60d32722301f..592dc51ce7bf 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -147,6 +147,18 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         x86ms->acpi_dev = HOTPLUG_HANDLER(dev);
     }
 
+    if (x86_machine_is_acpi_enabled(x86ms) && machine_usb(MACHINE(mms))) {
+        DeviceState *dev = qdev_new("sysbus-xhci");
+        qdev_prop_set_uint32(dev, "intrs", 1);
+        qdev_prop_set_uint32(dev, "slots", 64); /* MAXSLOTS */
+        qdev_prop_set_uint32(dev, "p2", 8);
+        qdev_prop_set_uint32(dev, "p3", 8);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MICROVM_XHCI_BASE);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           x86ms->gsi[MICROVM_XHCI_IRQ]);
+    }
+
     if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
         qemu_irq *i8259;
 
-- 
2.27.0


