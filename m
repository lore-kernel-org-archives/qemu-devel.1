Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA8C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA5420801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5ddyzdx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA5420801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tyc-0004cG-F5
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j6ttf-0004oK-UP
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j6tte-0003zh-Kb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j6tte-0003yx-Fr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582712790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A7tK9fGAnXW2msKRe6WVo0L9RclFBp3c9oCciDpfXXk=;
 b=Y5ddyzdxeJQeo6wJ9UY7zJRCe4OL95/+LGJERQ3btpwo69/SkJAdM/ZCJIJZBoDaLW0Pdd
 M//y84Cp97SaHbumTBq1PLjXznFqrH8izA99T2aGiE9FkXD4tUQGwcmzGaSlcrPoHeUd0c
 91CbzilHdYKURZhhpCQDoHnn84F2d88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-Nsdn5a5YPkmbo-iR2dAJFQ-1; Wed, 26 Feb 2020 05:26:28 -0500
X-MC-Unique: Nsdn5a5YPkmbo-iR2dAJFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6517D107ACCA;
 Wed, 26 Feb 2020 10:26:27 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04E5460BE1;
 Wed, 26 Feb 2020 10:26:24 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, stefanb@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v3 06/10] hw/arm/virt: vTPM support
Date: Wed, 26 Feb 2020 11:25:45 +0100
Message-Id: <20200226102549.12158-7-eric.auger@redhat.com>
In-Reply-To: <20200226102549.12158-1-eric.auger@redhat.com>
References: <20200226102549.12158-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

---

v2 -> v3:
- use qemu_fdt_setprop_string()
---
 hw/arm/Kconfig      |  1 +
 hw/arm/sysbus-fdt.c | 33 +++++++++++++++++++++++++++++++++
 hw/arm/virt.c       |  7 +++++++
 3 files changed, 41 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d86691ae0..b6f03f7f53 100644
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
diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 022fc97ecd..f603787b65 100644
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
@@ -434,6 +435,37 @@ static bool vfio_platform_match(SysBusDevice *sbdev,
 #define VFIO_PLATFORM_BINDING(compat, add_fn) \
     {TYPE_VFIO_PLATFORM, (compat), (add_fn), vfio_platform_match}
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
 #endif /* CONFIG_LINUX */
=20
 static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
@@ -455,6 +487,7 @@ static const BindingEntry bindings[] =3D {
     TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_nod=
e),
     TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
     VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
+    TYPE_BINDING(TYPE_TPM_TIS_SYSBUS, add_tpm_tis_fdt_node),
 #endif
     TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
     TYPE_BINDING("", NULL), /* last element */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f788fe27d6..4b967e39d1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -47,6 +47,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/tpm.h"
 #include "sysemu/kvm.h"
 #include "hw/loader.h"
 #include "exec/address-spaces.h"
@@ -2041,6 +2042,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
     mc->block_default_type =3D IF_VIRTIO;
     mc->no_cdrom =3D 1;
     mc->pci_allow_0_address =3D true;
@@ -2153,6 +2155,11 @@ type_init(machvirt_machine_init);
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
--=20
2.20.1


