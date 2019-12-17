Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46696C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126B3206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="R808v/mB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126B3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4ml-0005YM-Gg
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33155)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hr-0007ug-1d
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hp-0005Bc-Er
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:34 -0500
Received: from ozlabs.org ([203.11.71.1]:47621)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ho-00059L-Fj; Mon, 16 Dec 2019 23:43:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWN0bg8z9sRc; Tue, 17 Dec 2019 15:43:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557808;
 bh=G3RlUE4GGV7WFPkmzMdVQo+5DIerYIqTacCbW7UfBhU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R808v/mBqidFhYvVtDY4uRannnAPpP0G345pDGEVhZhKrP85+i9FQAspsef/7zp8/
 4H23Bk8hFS85C/6FWmJSmpmJu2ZjtRqdCznsARYqbuaB6WPm7ZsDHi5cHiAGzkguwC
 2oM/HVI972Mf1sbx+BHBO1nHjw64LUavbC/zMgP0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/88] ppc/pnv: Add a PNOR model
Date: Tue, 17 Dec 2019 15:41:55 +1100
Message-Id: <20191217044322.351838-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@fr.ibm.com>

On a POWERPC PowerNV system, the host firmware is stored in a PNOR
flash chip which contents is mapped on the LPC bus. This model adds a
simple dummy device to map the contents of a block device in the host
address space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191021131215.3693-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs      |   4 +-
 hw/ppc/pnv.c              |  14 ++++
 hw/ppc/pnv_pnor.c         | 135 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h      |   3 +
 include/hw/ppc/pnv_pnor.h |  25 +++++++
 5 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 hw/ppc/pnv_pnor.c
 create mode 100644 include/hw/ppc/pnv_pnor.h

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 580bb4f0dd..101e9fc591 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -9,7 +9,9 @@ obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
 obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
-obj-$(CONFIG_POWERNV) +=3D pnv_homer.o
+obj-$(CONFIG_POWERNV) +=3D pnv_homer.o pnv_pnor.o
+
+
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
 obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
 endif
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 627c08e5b9..d0c1d42277 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -44,6 +44,7 @@
 #include "hw/ppc/xics.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_pnor.h"
=20
 #include "hw/isa/isa.h"
 #include "hw/boards.h"
@@ -633,6 +634,8 @@ static void pnv_init(MachineState *machine)
     long fw_size;
     int i;
     char *chip_typename;
+    DriveInfo *pnor =3D drive_get(IF_MTD, 0, 0);
+    DeviceState *dev;
=20
     /* allocate RAM */
     if (machine->ram_size < (1 * GiB)) {
@@ -644,6 +647,17 @@ static void pnv_init(MachineState *machine)
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), 0, ram);
=20
+    /*
+     * Create our simple PNOR device
+     */
+    dev =3D qdev_create(NULL, TYPE_PNV_PNOR);
+    if (pnor) {
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor),
+                            &error_abort);
+    }
+    qdev_init_nofail(dev);
+    pnv->pnor =3D PNV_PNOR(dev);
+
     /* load skiboot firmware  */
     if (bios_name =3D=3D NULL) {
         bios_name =3D FW_FILE_NAME;
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
new file mode 100644
index 0000000000..bfb1e92b03
--- /dev/null
+++ b/hw/ppc/pnv_pnor.c
@@ -0,0 +1,135 @@
+/*
+ * QEMU PowerNV PNOR simple model
+ *
+ * Copyright (c) 2015-2019, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/blockdev.h"
+#include "hw/loader.h"
+#include "hw/ppc/pnv_pnor.h"
+#include "hw/qdev-properties.h"
+
+static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvPnor *s =3D PNV_PNOR(opaque);
+    uint64_t ret =3D 0;
+    int i;
+
+    for (i =3D 0; i < size; i++) {
+        ret |=3D (uint64_t) s->storage[addr + i] << (8 * (size - i - 1))=
;
+    }
+
+    return ret;
+}
+
+static void pnv_pnor_update(PnvPnor *s, int offset, int size)
+{
+    int offset_end;
+
+    if (s->blk) {
+        return;
+    }
+
+    offset_end =3D offset + size;
+    offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
+    offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
+
+    blk_pwrite(s->blk, offset, s->storage + offset,
+               offset_end - offset, 0);
+}
+
+static void pnv_pnor_write(void *opaque, hwaddr addr, uint64_t data,
+                           unsigned size)
+{
+    PnvPnor *s =3D PNV_PNOR(opaque);
+    int i;
+
+    for (i =3D 0; i < size; i++) {
+        s->storage[addr + i] =3D (data >> (8 * (size - i - 1))) & 0xFF;
+    }
+    pnv_pnor_update(s, addr, size);
+}
+
+/*
+ * TODO: Check endianness: skiboot is BIG, Aspeed AHB is LITTLE, flash
+ * is BIG.
+ */
+static const MemoryRegionOps pnv_pnor_ops =3D {
+    .read =3D pnv_pnor_read,
+    .write =3D pnv_pnor_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 4,
+    },
+};
+
+static void pnv_pnor_realize(DeviceState *dev, Error **errp)
+{
+    PnvPnor *s =3D PNV_PNOR(dev);
+    int ret;
+
+    if (s->blk) {
+        uint64_t perm =3D BLK_PERM_CONSISTENT_READ |
+                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
+        ret =3D blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
+
+        s->size =3D blk_getlength(s->blk);
+        if (s->size <=3D 0) {
+            error_setg(errp, "failed to get flash size");
+            return;
+        }
+
+        s->storage =3D blk_blockalign(s->blk, s->size);
+
+        if (blk_pread(s->blk, 0, s->storage, s->size) !=3D s->size) {
+            error_setg(errp, "failed to read the initial flash content")=
;
+            return;
+        }
+    } else {
+        s->storage =3D blk_blockalign(NULL, s->size);
+        memset(s->storage, 0xFF, s->size);
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &pnv_pnor_ops, s,
+                          TYPE_PNV_PNOR, s->size);
+}
+
+static Property pnv_pnor_properties[] =3D {
+    DEFINE_PROP_UINT32("size", PnvPnor, size, 128 << 20),
+    DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_pnor_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D pnv_pnor_realize;
+    dc->props =3D pnv_pnor_properties;
+}
+
+static const TypeInfo pnv_pnor_info =3D {
+    .name          =3D TYPE_PNV_PNOR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(PnvPnor),
+    .class_init    =3D pnv_pnor_class_init,
+};
+
+static void pnv_pnor_register_types(void)
+{
+    type_register_static(&pnv_pnor_info);
+}
+
+type_init(pnv_pnor_register_types)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 0b4c722e6b..5ecd3ba6ed 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/ppc/pnv_lpc.h"
+#include "hw/ppc/pnv_pnor.h"
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_homer.h"
@@ -175,6 +176,8 @@ typedef struct PnvMachineState {
=20
     IPMIBmc      *bmc;
     Notifier     powerdown_notifier;
+
+    PnvPnor      *pnor;
 } PnvMachineState;
=20
 static inline bool pnv_chip_is_power9(const PnvChip *chip)
diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
new file mode 100644
index 0000000000..dec811695c
--- /dev/null
+++ b/include/hw/ppc/pnv_pnor.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU PowerNV PNOR simple model
+ *
+ * Copyright (c) 2019, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+#ifndef _PPC_PNV_PNOR_H
+#define _PPC_PNV_PNOR_H
+
+#define TYPE_PNV_PNOR  "pnv-pnor"
+#define PNV_PNOR(obj)  OBJECT_CHECK(PnvPnor, (obj), TYPE_PNV_PNOR)
+
+typedef struct PnvPnor {
+    SysBusDevice   parent_obj;
+
+    BlockBackend   *blk;
+
+    uint8_t        *storage;
+    uint32_t       size;
+    MemoryRegion   mmio;
+} PnvPnor;
+
+#endif /* _PPC_PNV_PNOR_H */
--=20
2.23.0


