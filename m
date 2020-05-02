Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4782C3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 20:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4EE02080C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 20:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ktqu20VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EE02080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUytc-0004LS-S9
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 16:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jUysF-0002rM-Gc
 for qemu-devel@nongnu.org; Sat, 02 May 2020 16:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jUysD-00044e-Hz
 for qemu-devel@nongnu.org; Sat, 02 May 2020 16:36:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jUysC-00043f-28
 for qemu-devel@nongnu.org; Sat, 02 May 2020 16:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588451789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX4JQPiEzAFhnB9ENyMrEpHgnft3fb952sqvA++yGTk=;
 b=Ktqu20VIz6tDxkf7/5NmtMSM97uGmZ607XBdog/TjDId8pbpBPX+r5F7M68NyTEdLpqypg
 HKAsxnZAqnKq4z/jLgs3qSeG06kTi8yeWGT8cqPsnEgI9OHdt8QgQwKN/172w9Fgy5GUBO
 e3dgk2aOAy3cvJ//5Do6QJw6G9PDacM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-xqgOJiRgNNW3gn9MIvlwlg-1; Sat, 02 May 2020 16:36:18 -0400
X-MC-Unique: xqgOJiRgNNW3gn9MIvlwlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E585D1009600;
 Sat,  2 May 2020 20:36:16 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3E691002388;
 Sat,  2 May 2020 20:36:02 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 imammedo@redhat.com, shannon.zhaosl@gmail.com, mst@redhat.com
Subject: [PATCH 2/2] arm/acpi: Add the TPM2.0 device under the DSDT
Date: Sat,  2 May 2020 22:35:36 +0200
Message-Id: <20200502203536.15011-3-eric.auger@redhat.com>
In-Reply-To: <20200502203536.15011-1-eric.auger@redhat.com>
References: <20200502203536.15011-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/02 16:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, gshan@redhat.com,
 lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case it is dynamically instantiated, add the TPM 2.0 device object
under the DSDT table in the ACPI namespace. Its HID is MSFT0101
while its current resource settings (CRS) property is initialized
with the guest physical address and MMIO size of the device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cc5863eaf2..0cb9cdb2ce 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -45,6 +45,7 @@
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
 #include "hw/arm/virt.h"
+#include "hw/platform-bus.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
 #include "sysemu/tpm.h"
@@ -362,6 +363,38 @@ static void acpi_dsdt_add_power_button(Aml *scope)
     aml_append(scope, dev);
 }
=20
+static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
+{
+    hwaddr pbus_base =3D vms->memmap[VIRT_PLATFORM_BUS].base;
+    PlatformBusDevice *pbus =3D PLATFORM_BUS_DEVICE(vms->platform_bus_dev)=
;
+    MemoryRegion *sbdev_mr;
+    SysBusDevice *sbdev;
+    hwaddr tpm_base;
+
+    sbdev =3D (SysBusDevice *)object_dynamic_cast(OBJECT(tpm_find()),
+                                                TYPE_SYS_BUS_DEVICE);
+    if (!sbdev) {
+        return;
+    }
+
+    tpm_base =3D platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    assert(tpm_base !=3D -1);
+
+    tpm_base +=3D pbus_base;
+
+    sbdev_mr =3D sysbus_mmio_get_region(sbdev, 0);
+
+    Aml *dev =3D aml_device("TPM0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+
+    Aml *crs =3D aml_resource_template();
+    aml_append(crs,
+               aml_memory32_fixed(tpm_base, sbdev_mr->size, AML_READ_WRITE=
));
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
@@ -785,6 +818,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, Virt=
MachineState *vms)
     }
=20
     acpi_dsdt_add_power_button(scope);
+    acpi_dsdt_add_tpm(scope, vms);
=20
     aml_append(dsdt, scope);
=20
--=20
2.20.1


