Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E905620731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 12:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfaWx+pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E905620731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIA9G-0006kj-2W
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 08:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kI9nr-0005Iy-AN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49581)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kI9na-0007p2-Qz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600171861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4xqrjBt9+K0AYOcFO9PWCCV/shKCcI1emzHoZPL8Jc=;
 b=AfaWx+prRkTp3bjUy/cf91tnmf7xnBWgptmdk9toHhsJtmLBvra1Qw2a0K2EtPrwUOWuNH
 2LNqCHHX6Hdrbt0Owk2GNrcW6bJti1lCExw8b4KPJdoBL6Ou7F/Ss88n+ErF9ZqvG4dDm/
 gZ+oS5wd2GOTQmI0vpWCav9lCvRXI1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-FO519XIRON223aaivj0XvA-1; Tue, 15 Sep 2020 08:09:24 -0400
X-MC-Unique: FO519XIRON223aaivj0XvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F37F1009454;
 Tue, 15 Sep 2020 12:09:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E1FB75138;
 Tue, 15 Sep 2020 12:09:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DF93B40839; Tue, 15 Sep 2020 14:09:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 09/21] microvm/acpi: add acpi_dsdt_add_virtio() for x86
Date: Tue, 15 Sep 2020 14:08:57 +0200
Message-Id: <20200915120909.20838-10-kraxel@redhat.com>
In-Reply-To: <20200915120909.20838-1-kraxel@redhat.com>
References: <20200915120909.20838-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Makes x86 linux kernel find virtio-mmio devices automatically.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-microvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 06ef33949f5f..b9ce3768b263 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 
 #include "exec/memory.h"
@@ -32,10 +33,60 @@
 #include "hw/boards.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/microvm.h"
+#include "hw/virtio/virtio-mmio.h"
 
 #include "acpi-common.h"
 #include "acpi-microvm.h"
 
+static void acpi_dsdt_add_virtio(Aml *scope,
+                                 MicrovmMachineState *mms)
+{
+    gchar *separator;
+    long int index;
+    BusState *bus;
+    BusChild *kid;
+
+    bus = sysbus_get_default();
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev = kid->child;
+        Object *obj = object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO);
+
+        if (obj) {
+            VirtIOMMIOProxy *mmio = VIRTIO_MMIO(obj);
+            VirtioBusState *mmio_virtio_bus = &mmio->bus;
+            BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
+
+            if (QTAILQ_EMPTY(&mmio_bus->children)) {
+                continue;
+            }
+            separator = g_strrstr(mmio_bus->name, ".");
+            if (!separator) {
+                continue;
+            }
+            if (qemu_strtol(separator + 1, NULL, 10, &index) != 0) {
+                continue;
+            }
+
+            uint32_t irq = mms->virtio_irq_base + index;
+            hwaddr base = VIRTIO_MMIO_BASE + index * 512;
+            hwaddr size = 512;
+
+            Aml *dev = aml_device("VR%02u", (unsigned)index);
+            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")));
+            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
+            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+            Aml *crs = aml_resource_template();
+            aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
+            aml_append(crs,
+                       aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                                     AML_EXCLUSIVE, &irq, 1));
+            aml_append(dev, aml_name_decl("_CRS", crs));
+            aml_append(scope, dev);
+        }
+    }
+}
+
 static void
 build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
                    MicrovmMachineState *mms)
@@ -60,6 +111,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
     build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
+    acpi_dsdt_add_virtio(sb_scope, mms);
     aml_append(dsdt, sb_scope);
 
     /* ACPI 5.0: Table 7-209 System State Package */
-- 
2.27.0


