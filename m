Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC20C47258
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF94206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMZ3qdli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF94206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxxz-0003qD-Vp
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxrB-0000YI-1d
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr6-0003bg-St
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sq54SLAHOINc022y0i/GRX54KmFCzWGPnCDVP/mstf0=;
 b=dMZ3qdlii4UXtr78NsvMWguc0WnofakzlmoiPymYfJRqKVfcD5f5d5P7Gu+cfTR8zApio4
 veyX+lCIrpmUbq44JeZXcCXlezHBENjd7WNd6MnLRTfpzte0P4hk84dRVJ3k2Zzt4NEL78
 kGuZQlU/hQxt9qbtpQi/z7Itxc2HHc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-n_CUm5-wNzGW7CMD8rAJSw-1; Tue, 05 May 2020 09:43:26 -0400
X-MC-Unique: n_CUm5-wNzGW7CMD8rAJSw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FABC107ACF2;
 Tue,  5 May 2020 13:43:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8364060BF4;
 Tue,  5 May 2020 13:43:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1E711A1FD; Tue,  5 May 2020 15:43:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/13] acpi: generic event device for x86
Date: Tue,  5 May 2020 15:43:00 +0200
Message-Id: <20200505134305.22666-9-kraxel@redhat.com>
In-Reply-To: <20200505134305.22666-1-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Uses TYPE_ACPI_GED as QOM parent for code reuse.
Add registers for sleep states and reset.
Add powerdown notifier for power button events.
Set AcpiDeviceIfClass->madt_cpu.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/acpi/generic_event_device.h |  10 +++
 hw/i386/generic_event_device_x86.c     | 114 +++++++++++++++++++++++++
 hw/i386/Makefile.objs                  |   1 +
 3 files changed, 125 insertions(+)
 create mode 100644 hw/i386/generic_event_device_x86.c

diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/gener=
ic_event_device.h
index 9eb86ca4fd94..16d1f2b3cd30 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -68,9 +68,19 @@
 #define ACPI_GED(obj) \
     OBJECT_CHECK(AcpiGedState, (obj), TYPE_ACPI_GED)
=20
+#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
+#define ACPI_GED_X86(obj) \
+    OBJECT_CHECK(AcpiGedX86State, (obj), TYPE_ACPI_GED_X86)
+
 #define ACPI_GED_EVT_SEL_OFFSET    0x0
 #define ACPI_GED_EVT_SEL_LEN       0x4
=20
+#define ACPI_GED_X86_REG_SLEEP_CTL 0x00
+#define ACPI_GED_X86_REG_SLEEP_STS 0x01
+#define ACPI_GED_X86_REG_RESET     0x02
+#define   ACPI_GED_X86_RESET_VALUE 0x42
+#define ACPI_GED_X86_REG_COUNT     0x03
+
 #define GED_DEVICE      "GED"
 #define AML_GED_EVT_REG "EREG"
 #define AML_GED_EVT_SEL "ESEL"
diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event_dev=
ice_x86.c
new file mode 100644
index 000000000000..8ae4a63084f3
--- /dev/null
+++ b/hw/i386/generic_event_device_x86.c
@@ -0,0 +1,114 @@
+/*
+ * x86 variant of the generic event device for hw reduced acpi
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/generic_event_device.h"
+#include "hw/i386/pc.h"
+#include "hw/irq.h"
+#include "hw/mem/pc-dimm.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+#include "sysemu/runstate.h"
+
+typedef struct AcpiGedX86State {
+    struct AcpiGedState parent_obj;
+    MemoryRegion regs;
+    Notifier powerdown_req;
+} AcpiGedX86State;
+
+static uint64_t acpi_ged_x86_regs_read(void *opaque, hwaddr addr, unsigned=
 size)
+{
+    return 0;
+}
+
+static void acpi_ged_x86_regs_write(void *opaque, hwaddr addr, uint64_t da=
ta,
+                                    unsigned int size)
+{
+    bool slp_en;
+    int slp_typ;
+
+    switch (addr) {
+    case ACPI_GED_X86_REG_SLEEP_CTL:
+        slp_typ =3D (data >> 2) & 0x07;
+        slp_en  =3D (data >> 5) & 0x01;
+        if (slp_en && slp_typ =3D=3D 5) {
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        }
+        return;
+    case ACPI_GED_X86_REG_SLEEP_STS:
+        return;
+    case ACPI_GED_X86_REG_RESET:
+        if (data =3D=3D ACPI_GED_X86_RESET_VALUE) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        }
+        return;
+    }
+}
+
+static const MemoryRegionOps acpi_ged_x86_regs_ops =3D {
+    .read =3D acpi_ged_x86_regs_read,
+    .write =3D acpi_ged_x86_regs_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 1,
+    },
+};
+
+static void acpi_ged_x86_powerdown_req(Notifier *n, void *opaque)
+{
+    AcpiGedX86State *s =3D container_of(n, AcpiGedX86State, powerdown_req)=
;
+    AcpiDeviceIf *adev =3D ACPI_DEVICE_IF(s);
+    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_GET_CLASS(OBJECT(s));
+
+    adevc->send_event(adev, ACPI_POWER_DOWN_STATUS);
+}
+
+static void acpi_ged_x86_initfn(Object *obj)
+{
+    AcpiGedX86State *s =3D ACPI_GED_X86(obj);
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->regs, obj, &acpi_ged_x86_regs_ops,
+                          obj, "acpi-regs", ACPI_GED_X86_REG_COUNT);
+    sysbus_init_mmio(sbd, &s->regs);
+
+    s->powerdown_req.notify =3D acpi_ged_x86_powerdown_req;
+    qemu_register_powerdown_notifier(&s->powerdown_req);
+}
+
+static void acpi_ged_x86_class_init(ObjectClass *class, void *data)
+{
+    AcpiDeviceIfClass *adevc =3D ACPI_DEVICE_IF_CLASS(class);
+
+    adevc->madt_cpu =3D pc_madt_cpu_entry;
+}
+
+static const TypeInfo acpi_ged_x86_info =3D {
+    .name          =3D TYPE_ACPI_GED_X86,
+    .parent        =3D TYPE_ACPI_GED,
+    .instance_size =3D sizeof(AcpiGedX86State),
+    .instance_init  =3D acpi_ged_x86_initfn,
+    .class_init    =3D acpi_ged_x86_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { TYPE_ACPI_DEVICE_IF },
+        { }
+    }
+};
+
+static void acpi_ged_x86_register_types(void)
+{
+    type_register_static(&acpi_ged_x86_info);
+}
+
+type_init(acpi_ged_x86_register_types)
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 6abc74551a72..622739305882 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -17,4 +17,5 @@ obj-$(CONFIG_PC) +=3D port92.o
=20
 obj-y +=3D kvmvapic.o
 obj-$(CONFIG_ACPI) +=3D acpi-common.o
+obj-$(CONFIG_ACPI_HW_REDUCED) +=3D generic_event_device_x86.o
 obj-$(CONFIG_PC) +=3D acpi-build.o
--=20
2.18.4


