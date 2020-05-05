Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DAEC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF7F4206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTNys1Xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF7F4206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxwo-0002KX-VB
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr4-0000OH-8M
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jVxr1-0003V5-PG
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xPLSoTFO9NPpXqAmy8mwfJHiKPZDJRAf/4MPfD+zyhY=;
 b=NTNys1XxHTz8MuZpQG640jvOL4ZkSlz7R6wPwEnxtfoRDcmgavKp0t0YBF203DaB5s1A/t
 l17Y02/wfMWqZUgbzoW/o/L62TCkBllqkZ4pLKpDgZFN+sWTZD3u14R3S+chH0JPmimTyO
 VRkMYH+626C70MCUWpphz6uWYj5SzXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-UriqJfQ2PGm5bxSFrbVnOg-1; Tue, 05 May 2020 09:43:20 -0400
X-MC-Unique: UriqJfQ2PGm5bxSFrbVnOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2756D1005510;
 Tue,  5 May 2020 13:43:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC9E71002389;
 Tue,  5 May 2020 13:43:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 413799D56; Tue,  5 May 2020 15:43:06 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/13] microvm: add acpi_dsdt_add_virtio() for x86
Date: Tue,  5 May 2020 15:43:03 +0200
Message-Id: <20200505134305.22666-12-kraxel@redhat.com>
In-Reply-To: <20200505134305.22666-1-kraxel@redhat.com>
References: <20200505134305.22666-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

Makes x86 linux kernel find virtio-mmio devices automatically.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-microvm.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index ce5ab86d642c..4d91ac9360ce 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -21,6 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
=20
 #include "exec/memory.h"
@@ -32,6 +33,7 @@
 #include "hw/boards.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/microvm.h"
+#include "hw/virtio/virtio-mmio.h"
=20
 #include "acpi-common.h"
 #include "acpi-microvm.h"
@@ -45,6 +47,54 @@ static void acpi_dsdt_add_power_button(Aml *scope)
     aml_append(scope, dev);
 }
=20
+static void acpi_dsdt_add_virtio(Aml *scope)
+{
+    gchar *separator;
+    long int index;
+    BusState *bus;
+    BusChild *kid;
+
+    bus =3D sysbus_get_default();
+    QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        DeviceState *dev =3D kid->child;
+        Object *obj =3D object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO)=
;
+
+        if (obj) {
+            VirtIOMMIOProxy *mmio =3D VIRTIO_MMIO(obj);
+            VirtioBusState *mmio_virtio_bus =3D &mmio->bus;
+            BusState *mmio_bus =3D &mmio_virtio_bus->parent_obj;
+
+            if (QTAILQ_EMPTY(&mmio_bus->children)) {
+                continue;
+            }
+            separator =3D g_strrstr(mmio_bus->name, ".");
+            if (!separator) {
+                continue;
+            }
+            if (qemu_strtol(separator + 1, NULL, 10, &index) !=3D 0) {
+                continue;
+            }
+
+            uint32_t irq =3D VIRTIO_IRQ_BASE + index;
+            hwaddr base =3D VIRTIO_MMIO_BASE + index * 512;
+            hwaddr size =3D 512;
+
+            Aml *dev =3D aml_device("VR%02u", (unsigned)index);
+            aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0005")))=
;
+            aml_append(dev, aml_name_decl("_UID", aml_int(index)));
+            aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+            Aml *crs =3D aml_resource_template();
+            aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE)=
);
+            aml_append(crs,
+                       aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_H=
IGH,
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
@@ -69,6 +119,7 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linke=
r,
     build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
+    acpi_dsdt_add_virtio(sb_scope);
     aml_append(dsdt, sb_scope);
=20
     scope =3D aml_scope("\\");
--=20
2.18.4


