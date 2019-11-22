Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C13C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56FCE2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KufSrxz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56FCE2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYE5E-0001W3-JB
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDiz-0001a4-1j
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDix-0000g9-Ij
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30879
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDix-0000fw-78
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4xFawQT2V6zPzd9LUbAi8pc+Qp3elmFlQpDHpoRueTI=;
 b=KufSrxz0cSNTt9y5/nXcVjOccy4uvIhZIcaUV8SpSUncMImctZi15k95DX1ZrmHwLbDpCQ
 sR2iYGWHa6a6lbXdrXKF+ooLxwRgBKEdvFZqREfug+w6OBNGFbxz6cDW5B3DiWaiXCvL00
 /Ayy9nSMfD2KFhS20x1/pkpIUf+85yY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-JC4ZDa6mOye60nSHeAuYKA-1; Fri, 22 Nov 2019 13:32:05 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1726C107ACC5;
 Fri, 22 Nov 2019 18:32:04 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5559D6E712;
 Fri, 22 Nov 2019 18:31:55 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 17/20] hw/arm/virt-acpi-build: Add virtio-iommu
 node in IORT table
Date: Fri, 22 Nov 2019 19:29:40 +0100
Message-Id: <20191122182943.4656-18-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JC4ZDa6mOye60nSHeAuYKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch builds the virtio-iommu node in the ACPI IORT table.

The RID space of the root complex, which spans 0x0-0x10000
maps to streamid space 0x0-0x10000 in the virtio-iommu which in
turn maps to deviceid space 0x0-0x10000 in the ITS group.

The iommu RID is excluded as described in virtio-iommu
specification.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v8 -> v9:
- iommu RID is not fixed anymore

v7 -> v8:
- exclude the iommu RID (0x8) in the root complex ID mapping
---
 hw/arm/virt-acpi-build.c    | 50 ++++++++++++++++++++++++++++++-------
 include/hw/acpi/acpi-defs.h | 21 +++++++++++++++-
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 825f3a79c0..1e22cbbbfd 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -386,14 +386,14 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
     AcpiIortIdMapping *idmap;
     AcpiIortItsGroup *its;
     AcpiIortTable *iort;
-    AcpiIortSmmu3 *smmu;
-    size_t node_size, iort_node_offset, iort_length, smmu_offset =3D 0;
+    size_t node_size, iort_node_offset, iort_length, iommu_offset =3D 0;
     AcpiIortRC *rc;
+    int nb_rc_idmappings =3D 1;
=20
     iort =3D acpi_data_push(table_data, sizeof(*iort));
=20
-    if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3) {
-        nb_nodes =3D 3; /* RC, ITS, SMMUv3 */
+    if (vms->iommu) {
+        nb_nodes =3D 3; /* RC, ITS, IOMMU */
     } else {
         nb_nodes =3D 2; /* RC, ITS */
     }
@@ -419,9 +419,9 @@ build_iort(GArray *table_data, BIOSLinker *linker, Virt=
MachineState *vms)
=20
     if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3) {
         int irq =3D  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
+        AcpiIortSmmu3 *smmu;
=20
-        /* SMMUv3 node */
-        smmu_offset =3D iort_node_offset + node_size;
+        iommu_offset =3D iort_node_offset + node_size;
         node_size =3D sizeof(*smmu) + sizeof(*idmap);
         iort_length +=3D node_size;
         smmu =3D acpi_data_push(table_data, node_size);
@@ -443,16 +443,38 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
          */
         fill_iort_idmap(smmu->id_mapping_array, 0, 0, 0xffff, 0,
                         iort_node_offset);
+    } else if (vms->iommu =3D=3D VIRT_IOMMU_VIRTIO) {
+        AcpiIortPVIommuPCI *iommu;
+
+        nb_rc_idmappings =3D 2;
+        iommu_offset =3D iort_node_offset + node_size;
+        node_size =3D sizeof(*iommu) + 2 * sizeof(*idmap);
+        iort_length +=3D node_size;
+        iommu =3D acpi_data_push(table_data, node_size);
+
+        iommu->type =3D ACPI_IORT_NODE_PARAVIRT;
+        iommu->length =3D cpu_to_le16(node_size);
+        iommu->mapping_count =3D cpu_to_le32(2);
+        iommu->mapping_offset =3D cpu_to_le32(sizeof(*iommu));
+        iommu->devid =3D cpu_to_le32(vms->virtio_iommu_bdf);
+        iommu->model =3D cpu_to_le32(ACPI_IORT_NODE_PV_VIRTIO_IOMMU_PCI);
+
+        /*
+         * Identity RID mapping covering the whole input RID range
+         * output IORT node is the ITS group node (the first node)
+         */
+        fill_iort_idmap(iommu->id_mapping_array, 0, 0, 0xffff, 0,
+                        iort_node_offset);
     }
=20
     /* Root Complex Node */
-    node_size =3D sizeof(*rc) + sizeof(*idmap);
+    node_size =3D sizeof(*rc) + nb_rc_idmappings * sizeof(*idmap);
     iort_length +=3D node_size;
     rc =3D acpi_data_push(table_data, node_size);
=20
     rc->type =3D ACPI_IORT_NODE_PCI_ROOT_COMPLEX;
     rc->length =3D cpu_to_le16(node_size);
-    rc->mapping_count =3D cpu_to_le32(1);
+    rc->mapping_count =3D cpu_to_le32(nb_rc_idmappings);
     rc->mapping_offset =3D cpu_to_le32(sizeof(*rc));
=20
     /* fully coherent device */
@@ -463,7 +485,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vir=
tMachineState *vms)
     if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3) {
         /* Identity RID mapping and output IORT node is the iommu node */
         fill_iort_idmap(rc->id_mapping_array, 0, 0, 0xFFFF, 0,
-                        smmu_offset);
+                        iommu_offset);
+    } else if (vms->iommu =3D=3D VIRT_IOMMU_VIRTIO) {
+        /*
+         * Identity mapping with the IOMMU RID (0x8) excluded. The output
+         * IORT node is the iommu node.
+         */
+        fill_iort_idmap(rc->id_mapping_array, 0, 0, vms->virtio_iommu_bdf,=
 0,
+                        iommu_offset);
+        fill_iort_idmap(rc->id_mapping_array, 1, vms->virtio_iommu_bdf + 1=
,
+                        0xFFFF - vms->virtio_iommu_bdf,
+                        vms->virtio_iommu_bdf + 1, iommu_offset);
     } else {
         /*
          * Identity RID mapping and the output IORT node is the ITS group
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 57a3f58b0c..ba06f41fc0 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -581,7 +581,8 @@ enum {
         ACPI_IORT_NODE_NAMED_COMPONENT =3D 0x01,
         ACPI_IORT_NODE_PCI_ROOT_COMPLEX =3D 0x02,
         ACPI_IORT_NODE_SMMU =3D 0x03,
-        ACPI_IORT_NODE_SMMU_V3 =3D 0x04
+        ACPI_IORT_NODE_SMMU_V3 =3D 0x04,
+        ACPI_IORT_NODE_PARAVIRT =3D 0x80
 };
=20
 struct AcpiIortIdMapping {
@@ -610,6 +611,24 @@ typedef struct AcpiIortItsGroup AcpiIortItsGroup;
=20
 #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE 1
=20
+struct AcpiIortPVIommuPCI {
+    ACPI_IORT_NODE_HEADER_DEF
+    uint32_t devid;
+    uint8_t reserved2[12];
+    uint32_t model;
+    uint32_t flags;
+    uint8_t reserved3[16];
+    AcpiIortIdMapping id_mapping_array[0];
+} QEMU_PACKED;
+typedef struct AcpiIortPVIommuPCI AcpiIortPVIommuPCI;
+
+enum {
+    ACPI_IORT_NODE_PV_VIRTIO_IOMMU     =3D 0x0,
+    ACPI_IORT_NODE_PV_VIRTIO_IOMMU_PCI =3D 0x1,
+};
+
+#define ACPI_IORT_NODE_PV_CACHE_COHERENT    (1 << 0)
+
 struct AcpiIortSmmu3 {
     ACPI_IORT_NODE_HEADER_DEF
     uint64_t base_address;
--=20
2.20.1


