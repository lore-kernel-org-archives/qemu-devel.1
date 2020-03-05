Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914BCC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BEA320637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdPTIvPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEA320637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tme-0002rM-Gy
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j9tjk-0005Z0-SE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j9tjj-0007eT-F9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:52:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j9tjj-0007dv-BV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583427158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBMYPQTpT4z9y9NXEy1rgVmObE2q5HUSpKBYsUNnJ7g=;
 b=KdPTIvPczT/naYMqXSBv121usU62OrFQC+BS6X1kDhVyKLaSQ/VYCJ+Fs5L6ohNRTyFuXq
 DUQjX04MN6ed5fg6iY6WDbzj2NbzW7OB1ALBi27cGJfO/zYaEcBfcYVLOtYcv7063x4Bhp
 PXlbNaOx1xd9f+tErSKTlPYd0u1WaPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-PY6qN3bINYqW29hFZnUkIQ-1; Thu, 05 Mar 2020 11:52:35 -0500
X-MC-Unique: PY6qN3bINYqW29hFZnUkIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE25800D50;
 Thu,  5 Mar 2020 16:52:33 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8AC9539A;
 Thu,  5 Mar 2020 16:52:31 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v5 06/10] hw/arm/virt: vTPM support
Date: Thu,  5 Mar 2020 17:51:45 +0100
Message-Id: <20200305165149.618-7-eric.auger@redhat.com>
In-Reply-To: <20200305165149.618-1-eric.auger@redhat.com>
References: <20200305165149.618-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let the TPM TIS SYSBUS device be dynamically instantiable
in ARM virt.  A device tree node is dynamically created
(TPM via MMIO).

The TPM Physical Presence interface (PPI) is not supported.

To run with the swtmp TPM emulator, the qemu command line must
be augmented with:

        -chardev socket,id=3Dchrtpm,path=3Dswtpm-sock \
        -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
        -device tpm-tis-device,tpmdev=3Dtpm0 \

swtpm/libtpms command line example:

swtpm socket --tpm2 -t -d --tpmstate dir=3D/tmp/tpm \
--ctrl type=3Dunixio,path=3Dswtpm-sock

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---

v4 -> v5:
- Move "TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),"
  and add_tpm_tis_fdt_node outside of the CONFIG_LINUX
---
 hw/arm/sysbus-fdt.c | 33 +++++++++++++++++++++++++++++++++
 hw/arm/virt.c       |  7 +++++++
 hw/arm/Kconfig      |  1 +
 3 files changed, 41 insertions(+)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 022fc97ecd..6b6906f4cf 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -30,6 +30,7 @@
 #include "hw/arm/sysbus-fdt.h"
 #include "qemu/error-report.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/tpm.h"
 #include "hw/platform-bus.h"
 #include "hw/vfio/vfio-platform.h"
 #include "hw/vfio/vfio-calxeda-xgmac.h"
@@ -436,6 +437,37 @@ static bool vfio_platform_match(SysBusDevice *sbdev,
=20
 #endif /* CONFIG_LINUX */
=20
+/*
+ * add_tpm_tis_fdt_node: Create a DT node for TPM TIS
+ *
+ * See kernel documentation:
+ * Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
+ * Optional interrupt for command completion is not exposed
+ */
+static int add_tpm_tis_fdt_node(SysBusDevice *sbdev, void *opaque)
+{
+    PlatformBusFDTData *data =3D opaque;
+    PlatformBusDevice *pbus =3D data->pbus;
+    void *fdt =3D data->fdt;
+    const char *parent_node =3D data->pbus_node_name;
+    char *nodename;
+    uint32_t reg_attr[2];
+    uint64_t mmio_base;
+
+    mmio_base =3D platform_bus_get_mmio_addr(pbus, sbdev, 0);
+    nodename =3D g_strdup_printf("%s/tpm_tis@%" PRIx64, parent_node, mmio_=
base);
+    qemu_fdt_add_subnode(fdt, nodename);
+
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "tcg,tpm-tis-mmio=
");
+
+    reg_attr[0] =3D cpu_to_be32(mmio_base);
+    reg_attr[1] =3D cpu_to_be32(0x5000);
+    qemu_fdt_setprop(fdt, nodename, "reg", reg_attr, 2 * sizeof(uint32_t))=
;
+
+    g_free(nodename);
+    return 0;
+}
+
 static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
 {
     return 0;
@@ -456,6 +488,7 @@ static const BindingEntry bindings[] =3D {
     TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
     VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
 #endif
+    TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
 };
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 856808599d..32d865a488 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -48,6 +48,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tpm.h"
 #include "sysemu/kvm.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
@@ -2083,6 +2084,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
     mc->block_default_type =3D IF_VIRTIO;
     mc->no_cdrom =3D 1;
     mc->pci_allow_0_address =3D true;
@@ -2196,6 +2198,11 @@ type_init(machvirt_machine_init);
=20
 static void virt_machine_5_0_options(MachineClass *mc)
 {
+    static GlobalProperty compat[] =3D {
+        { TYPE_TPM_TIS_SYSBUS, "ppi", "false" },
+    };
+
+    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
=20
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 61635f52c4..bc54fd61f9 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -5,6 +5,7 @@ config ARM_VIRT
     imply VFIO_AMD_XGBE
     imply VFIO_PLATFORM
     imply VFIO_XGMAC
+    imply TPM_TIS_SYSBUS
     select A15MPCORE
     select ACPI
     select ARM_SMMUV3
--=20
2.20.1


