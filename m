Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20539C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5ECA20748
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLxAm3S+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5ECA20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOm1-0002Bb-17
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOe8-0001zc-CT
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jbOe5-0000G0-BU
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589980828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Cs+xA9nlQJb+xFVefGhp9a99zyys5aZQFZRxKPaRqOU=;
 b=aLxAm3S+HEY9OWWewY9F/EXTUalq8o4t1GFXXDPwpr4igbx/F5qyENeg66Vga89fhJ1KNU
 baBh2YCrkFa0ajbzMdtjKBQtnmlaRp9q0wAHaoUJrLaBD7uXys3nfiE05yWA7IiXbqaw2Q
 pCJn8Abq/gVf2gzmI1zcmBDqY3VL0AI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-diUIxhKgPyGNqvQqPfzVsg-1; Wed, 20 May 2020 09:20:26 -0400
X-MC-Unique: diUIxhKgPyGNqvQqPfzVsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82DE6835B40;
 Wed, 20 May 2020 13:20:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32D6D19451;
 Wed, 20 May 2020 13:20:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 549FD9D69; Wed, 20 May 2020 15:20:04 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/22] microvm/acpi: add acpi_dsdt_add_virtio() for x86
Date: Wed, 20 May 2020 15:19:58 +0200
Message-Id: <20200520132003.9492-18-kraxel@redhat.com>
In-Reply-To: <20200520132003.9492-1-kraxel@redhat.com>
References: <20200520132003.9492-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 22:48:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
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
---
 hw/i386/acpi-microvm.c | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index d2dd024909cc..12060939ff6c 100644
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
 
     scope = aml_scope("\\");
-- 
2.18.4


