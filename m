Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F0FC55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3347520729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WHkXgyuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3347520729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafYH-0006Ym-2A
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUM-0001U2-DK
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUI-0003X2-Ta
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXWXnay92VkGKCADVi7aX6mu0TDgFQ6kUiwH/zRRoCM=;
 b=WHkXgyujOB6YAuVOKBsv8l81/DB7Y1+EejUMjg3ceucSud/wMjf8QiYlzalTk26kBos3u3
 amUcY0fRNRiUOAAMshu7MNnq5q9fbu5XzhGL0s2i72lEkdMFnrlIYxZlL70AGMJSfTGfbM
 Y1mBMNUoLZ5LJy3sCfnnunuRbuQ48Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-58uiqNSRNG2DG0KCvWZj4w-1; Thu, 05 Nov 2020 08:39:35 -0500
X-MC-Unique: 58uiqNSRNG2DG0KCvWZj4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 915AA19080AC;
 Thu,  5 Nov 2020 13:39:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D6A455794;
 Thu,  5 Nov 2020 13:39:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9EF4F9D16; Thu,  5 Nov 2020 14:39:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/12] x86: add support for second ioapic
Date: Thu,  5 Nov 2020 14:39:14 +0100
Message-Id: <20201105133923.23821-4-kraxel@redhat.com>
In-Reply-To: <20201105133923.23821-1-kraxel@redhat.com>
References: <20201105133923.23821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add ioapic_init_secondary to initialize it, wire up
in gsi handling and acpi apic table creation.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/ioapic.h          |  1 +
 include/hw/i386/ioapic_internal.h |  2 +-
 include/hw/i386/x86.h             |  3 +++
 hw/i386/acpi-common.c             | 10 ++++++++++
 hw/i386/x86.c                     | 20 ++++++++++++++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/ioapic.h b/include/hw/i386/ioapic.h
index 59fcb158a734..1323b4b8ff6e 100644
--- a/include/hw/i386/ioapic.h
+++ b/include/hw/i386/ioapic.h
@@ -22,6 +22,7 @@
 
 #define IOAPIC_NUM_PINS 24
 #define IO_APIC_DEFAULT_ADDRESS 0xfec00000
+#define IO_APIC_SECONDARY_ADDRESS (IO_APIC_DEFAULT_ADDRESS + 0x10000)
 
 #define TYPE_KVM_IOAPIC "kvm-ioapic"
 #define TYPE_IOAPIC "ioapic"
diff --git a/include/hw/i386/ioapic_internal.h b/include/hw/i386/ioapic_internal.h
index 0ac9e2400d6b..4cebd2e32c9f 100644
--- a/include/hw/i386/ioapic_internal.h
+++ b/include/hw/i386/ioapic_internal.h
@@ -27,7 +27,7 @@
 #include "qemu/notify.h"
 #include "qom/object.h"
 
-#define MAX_IOAPICS                     1
+#define MAX_IOAPICS                     2
 
 #define IOAPIC_LVT_DEST_SHIFT           56
 #define IOAPIC_LVT_DEST_IDX_SHIFT       48
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 739fac50871b..3f9b052cfc34 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -50,6 +50,7 @@ struct X86MachineState {
     ISADevice *rtc;
     FWCfgState *fw_cfg;
     qemu_irq *gsi;
+    DeviceState *ioapic2;
     GMappedFile *initrd_mapped_file;
     HotplugHandler *acpi_dev;
 
@@ -120,10 +121,12 @@ bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
 typedef struct GSIState {
     qemu_irq i8259_irq[ISA_NUM_IRQS];
     qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
+    qemu_irq ioapic2_irq[IOAPIC_NUM_PINS];
 } GSIState;
 
 qemu_irq x86_allocate_cpu_irq(void);
 void gsi_handler(void *opaque, int n, int level);
 void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name);
+DeviceState *ioapic_init_secondary(GSIState *gsi_state);
 
 #endif
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 8a769654060e..91970837bb68 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -103,6 +103,16 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     io_apic->address = cpu_to_le32(IO_APIC_DEFAULT_ADDRESS);
     io_apic->interrupt = cpu_to_le32(0);
 
+    if (x86ms->ioapic2) {
+        AcpiMadtIoApic *io_apic2;
+        io_apic2 = acpi_data_push(table_data, sizeof *io_apic);
+        io_apic2->type = ACPI_APIC_IO;
+        io_apic2->length = sizeof(*io_apic);
+        io_apic2->io_apic_id = ACPI_BUILD_IOAPIC_ID + 1;
+        io_apic2->address = cpu_to_le32(IO_APIC_SECONDARY_ADDRESS);
+        io_apic2->interrupt = cpu_to_le32(24);
+    }
+
     if (x86ms->apic_xrupt_override) {
         intsrcovr = acpi_data_push(table_data, sizeof *intsrcovr);
         intsrcovr->type   = ACPI_APIC_XRUPT_OVERRIDE;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b67e7b789f89..628118e8b410 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -598,6 +598,9 @@ void gsi_handler(void *opaque, int n, int level)
     case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
         qemu_set_irq(s->ioapic_irq[n], level);
         break;
+    case IOAPIC_NUM_PINS ... IOAPIC_NUM_PINS * 2 - 1:
+        qemu_set_irq(s->ioapic2_irq[n - IOAPIC_NUM_PINS], level);
+        break;
     }
 }
 
@@ -624,6 +627,23 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
     }
 }
 
+DeviceState *ioapic_init_secondary(GSIState *gsi_state)
+{
+    DeviceState *dev;
+    SysBusDevice *d;
+    unsigned int i;
+
+    dev = qdev_new(TYPE_IOAPIC);
+    d = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(d, &error_fatal);
+    sysbus_mmio_map(d, 0, IO_APIC_SECONDARY_ADDRESS);
+
+    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
+        gsi_state->ioapic2_irq[i] = qdev_get_gpio_in(dev, i);
+    }
+    return dev;
+}
+
 struct setup_data {
     uint64_t next;
     uint32_t type;
-- 
2.27.0


