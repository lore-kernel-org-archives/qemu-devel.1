Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D47C3F2CE
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE79214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDSJbgsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE79214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8M2z-0003NS-QV
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 05:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1q-0001UD-MN
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1p-0001ki-8x
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:40:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8M1p-0001kV-5E
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583059256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJoSaYvsmUf4fGx2lrmEd69ekJPOQoW9mYbvAXJjlRo=;
 b=hDSJbgsyLT6K26RGOrEl2iLIBoqo+xF8yK0Z8gJ2tvP3czYjyMXjcY/2GmwIS+KijDqTzh
 IsPNU+Y1Ufyg+u4vBsN6hQt1TpwtGUV4R3fBIiQmCHp8GtD61rb1MErj/NY6zdG88NT8jR
 1kGTbpgFHfGPiILMw4jILNSkM8Y0yPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-vaMQ6Gi3MBquCL5-YptMgA-1; Sun, 01 Mar 2020 05:40:55 -0500
X-MC-Unique: vaMQ6Gi3MBquCL5-YptMgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E9E189F760;
 Sun,  1 Mar 2020 10:40:54 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E7EE60C80;
 Sun,  1 Mar 2020 10:40:52 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v2 2/6] hw/arm/virt: Use VIRT_GIC_VERSION defines
Date: Sun,  1 Mar 2020 11:40:36 +0100
Message-Id: <20200301104040.15186-3-eric.auger@redhat.com>
In-Reply-To: <20200301104040.15186-1-eric.auger@redhat.com>
References: <20200301104040.15186-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: maz@kernel.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We plan to introduce yet another value for the gic version (nosel).
As we already use exotic values such as 0 and -1, let's introduce
some defines.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 30 +++++++++++++++---------------
 include/hw/arm/virt.h |  7 ++++++-
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c093f0ab85..b449a445de 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -298,7 +298,7 @@ static void fdt_add_timer_nodes(const VirtMachineState =
*vms)
         irqflags =3D GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
     }
=20
-    if (vms->gic_version =3D=3D 2) {
+    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
         irqflags =3D deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
                              (1 << vms->smp_cpus) - 1);
@@ -439,7 +439,7 @@ static void fdt_add_gic_node(VirtMachineState *vms)
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#address-cells", 0x2);
     qemu_fdt_setprop_cell(vms->fdt, nodename, "#size-cells", 0x2);
     qemu_fdt_setprop(vms->fdt, nodename, "ranges", NULL, 0);
-    if (vms->gic_version =3D=3D 3) {
+    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3) {
         int nb_redist_regions =3D virt_gicv3_redist_region_count(vms);
=20
         qemu_fdt_setprop_string(vms->fdt, nodename, "compatible",
@@ -518,7 +518,7 @@ static void fdt_add_pmu_nodes(const VirtMachineState *v=
ms)
         }
     }
=20
-    if (vms->gic_version =3D=3D 2) {
+    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2) {
         irqflags =3D deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
                              GIC_FDT_IRQ_PPI_CPU_WIDTH,
                              (1 << vms->smp_cpus) - 1);
@@ -1469,7 +1469,7 @@ static uint64_t virt_cpu_mp_affinity(VirtMachineState=
 *vms, int idx)
          * purposes are to make TCG consistent (with 64-bit KVM hosts)
          * and to improve SGI efficiency.
          */
-        if (vms->gic_version =3D=3D 3) {
+        if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3) {
             clustersz =3D GICV3_TARGETLIST_BITS;
         } else {
             clustersz =3D GIC_TARGETLIST_BITS;
@@ -1560,15 +1560,15 @@ static void machvirt_init(MachineState *machine)
     /* We can probe only here because during property set
      * KVM is not available yet
      */
-    if (vms->gic_version <=3D 0) {
-        /* "host" or "max" */
+    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST ||
+        vms->gic_version =3D=3D VIRT_GIC_VERSION_MAX) {
         if (!kvm_enabled()) {
-            if (vms->gic_version =3D=3D 0) {
+            if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST) {
                 error_report("gic-version=3Dhost requires KVM");
                 exit(1);
             } else {
                 /* "max": currently means 3 for TCG */
-                vms->gic_version =3D 3;
+                vms->gic_version =3D VIRT_GIC_VERSION_3;
             }
         } else {
             vms->gic_version =3D kvm_arm_vgic_probe();
@@ -1627,7 +1627,7 @@ static void machvirt_init(MachineState *machine)
     /* The maximum number of CPUs depends on the GIC version, or on how
      * many redistributors we can fit into the memory map.
      */
-    if (vms->gic_version =3D=3D 3) {
+    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3) {
         virt_max_cpus =3D
             vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
         virt_max_cpus +=3D
@@ -1855,7 +1855,7 @@ static void virt_set_its(Object *obj, bool value, Err=
or **errp)
 static char *virt_get_gic_version(Object *obj, Error **errp)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(obj);
-    const char *val =3D vms->gic_version =3D=3D 3 ? "3" : "2";
+    const char *val =3D vms->gic_version =3D=3D VIRT_GIC_VERSION_3 ? "3" :=
 "2";
=20
     return g_strdup(val);
 }
@@ -1865,13 +1865,13 @@ static void virt_set_gic_version(Object *obj, const=
 char *value, Error **errp)
     VirtMachineState *vms =3D VIRT_MACHINE(obj);
=20
     if (!strcmp(value, "3")) {
-        vms->gic_version =3D 3;
+        vms->gic_version =3D VIRT_GIC_VERSION_3;
     } else if (!strcmp(value, "2")) {
-        vms->gic_version =3D 2;
+        vms->gic_version =3D VIRT_GIC_VERSION_2;
     } else if (!strcmp(value, "host")) {
-        vms->gic_version =3D 0; /* Will probe later */
+        vms->gic_version =3D VIRT_GIC_VERSION_HOST; /* Will probe later */
     } else if (!strcmp(value, "max")) {
-        vms->gic_version =3D -1; /* Will probe later */
+        vms->gic_version =3D VIRT_GIC_VERSION_MAX; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
         error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
@@ -2139,7 +2139,7 @@ static void virt_instance_init(Object *obj)
                                     "physical address space above 32 bits"=
,
                                     NULL);
     /* Default GIC type is v2 */
-    vms->gic_version =3D 2;
+    vms->gic_version =3D VIRT_GIC_VERSION_2;
     object_property_add_str(obj, "gic-version", virt_get_gic_version,
                         virt_set_gic_version, NULL);
     object_property_set_description(obj, "gic-version",
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 02f500cb8e..6325b98269 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -95,6 +95,11 @@ typedef enum VirtIOMMUType {
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
=20
+#define VIRT_GIC_VERSION_MAX    (-1)
+#define VIRT_GIC_VERSION_HOST   0
+#define VIRT_GIC_VERSION_2      2
+#define VIRT_GIC_VERSION_3      3
+
 typedef struct MemMapEntry {
     hwaddr base;
     hwaddr size;
@@ -162,7 +167,7 @@ static inline int virt_gicv3_redist_region_count(VirtMa=
chineState *vms)
     uint32_t redist0_capacity =3D
                 vms->memmap[VIRT_GIC_REDIST].size / GICV3_REDIST_SIZE;
=20
-    assert(vms->gic_version =3D=3D 3);
+    assert(vms->gic_version =3D=3D VIRT_GIC_VERSION_3);
=20
     return vms->smp_cpus > redist0_capacity ? 2 : 1;
 }
--=20
2.20.1


