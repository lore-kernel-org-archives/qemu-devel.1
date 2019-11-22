Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BAEAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0DF20707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieQw3ETE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0DF20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDqv-0001xl-3A
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:40:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40128)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDip-0001KN-Ud
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDio-0000cL-FN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:59 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56098
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDio-0000bv-9f
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9rjhk/7jHqlU0LM08VfBejpiGVoEQ1gFejwY9kPP/8=;
 b=ieQw3ETEbG9lTvrdUr76XGhsbzd+k02DXftMjMIpX0MlRZgtiXwf1SKUOUpB4tOmb6eqEl
 sgXC9XcudCu++BvZKTlS1UdvtaNs5vhlN8beHMEdM48hlm55JOIVw+7asD9JjKMUm3296g
 F+O0k/0wd8kQf+Hl+FXZn6iVfaxPu8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-V4LzwQZ-MhezUPBWDkZPYg-1; Fri, 22 Nov 2019 13:31:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3D64107ACC5;
 Fri, 22 Nov 2019 18:31:54 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E4B06E712;
 Fri, 22 Nov 2019 18:31:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 16/20] hw/arm/virt-acpi-build: Introduce
 fill_iort_idmap helper
Date: Fri, 22 Nov 2019 19:29:39 +0100
Message-Id: <20191122182943.4656-17-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: V4LzwQZ-MhezUPBWDkZPYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid code duplication, let's introduce an helper that
fills one IORT ID mappings array index.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v8: new
---
 hw/arm/virt-acpi-build.c | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4cd50175e0..825f3a79c0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -368,6 +368,17 @@ static void acpi_dsdt_add_power_button(Aml *scope)
     aml_append(scope, dev);
 }
=20
+static inline void
+fill_iort_idmap(AcpiIortIdMapping *idmap, int i,
+                uint32_t input_base, uint32_t id_count,
+                uint32_t output_base, uint32_t output_reference)
+{
+    idmap[i].input_base =3D cpu_to_le32(input_base);
+    idmap[i].id_count =3D cpu_to_le32(id_count);
+    idmap[i].output_base =3D cpu_to_le32(output_base);
+    idmap[i].output_reference =3D cpu_to_le32(output_reference);
+}
+
 static void
 build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
@@ -426,13 +437,12 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
         smmu->gerr_gsiv =3D cpu_to_le32(irq + 2);
         smmu->sync_gsiv =3D cpu_to_le32(irq + 3);
=20
-        /* Identity RID mapping covering the whole input RID range */
-        idmap =3D &smmu->id_mapping_array[0];
-        idmap->input_base =3D 0;
-        idmap->id_count =3D cpu_to_le32(0xFFFF);
-        idmap->output_base =3D 0;
-        /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
+        /*
+         * Identity RID mapping covering the whole input RID range.
+         * The output IORT node is the ITS group node (the first node).
+         */
+        fill_iort_idmap(smmu->id_mapping_array, 0, 0, 0xffff, 0,
+                        iort_node_offset);
     }
=20
     /* Root Complex Node */
@@ -450,18 +460,17 @@ build_iort(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
     rc->memory_properties.memory_flags =3D 0x3; /* CCA =3D CPM =3D DCAS =
=3D 1 */
     rc->pci_segment_number =3D 0; /* MCFG pci_segment */
=20
-    /* Identity RID mapping covering the whole input RID range */
-    idmap =3D &rc->id_mapping_array[0];
-    idmap->input_base =3D 0;
-    idmap->id_count =3D cpu_to_le32(0xFFFF);
-    idmap->output_base =3D 0;
-
     if (vms->iommu =3D=3D VIRT_IOMMU_SMMUV3) {
-        /* output IORT node is the smmuv3 node */
-        idmap->output_reference =3D cpu_to_le32(smmu_offset);
+        /* Identity RID mapping and output IORT node is the iommu node */
+        fill_iort_idmap(rc->id_mapping_array, 0, 0, 0xFFFF, 0,
+                        smmu_offset);
     } else {
-        /* output IORT node is the ITS group node (the first node) */
-        idmap->output_reference =3D cpu_to_le32(iort_node_offset);
+        /*
+         * Identity RID mapping and the output IORT node is the ITS group
+         * node (the first node).
+         */
+        fill_iort_idmap(rc->id_mapping_array, 0, 0, 0xFFFF, 0,
+                        iort_node_offset);
     }
=20
     /*
--=20
2.20.1


