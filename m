Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296C3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB49F214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKKOhre+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB49F214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8M4C-0006Vq-4Y
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 05:43:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1s-0001Xg-Me
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1r-0001lK-Ib
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60477
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8M1r-0001l5-F0
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583059259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEMzmuyV2juLppS5NQsF4RN5lh06edhDi1oAMTXdTOo=;
 b=GKKOhre+U5ytxAykqXTn85DeTghdSbH7pB7If8HeAE/5kYfWeNRkbgvIWq748X8VcBiNAh
 4K+wBPSyK4bgCCZ5YEprR34/n3D7DCfN1vrph2nBBMrJioZfihUDCvdmS1FeEFEI6QVQDC
 mJ/niJ+A3xmOQfmsivEk/xnCypIvhqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-45Th_9YTMzWU06szO4dmCQ-1; Sun, 01 Mar 2020 05:40:57 -0500
X-MC-Unique: 45Th_9YTMzWU06szO4dmCQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 575D3100550E;
 Sun,  1 Mar 2020 10:40:56 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B1E560C80;
 Sun,  1 Mar 2020 10:40:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v2 3/6] hw/arm/virt: Introduce finalize_gic_version()
Date: Sun,  1 Mar 2020 11:40:37 +0100
Message-Id: <20200301104040.15186-4-eric.auger@redhat.com>
In-Reply-To: <20200301104040.15186-1-eric.auger@redhat.com>
References: <20200301104040.15186-1-eric.auger@redhat.com>
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
Cc: maz@kernel.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's move the code which freezes which gic-version to
be applied in a dedicated function. We also now set by
default the VIRT_GIC_VERSION_NO_SET. This eventually
turns into the legacy v2 choice in the finalize() function.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c         | 54 ++++++++++++++++++++++++++-----------------
 include/hw/arm/virt.h |  1 +
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b449a445de..338d56999f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1534,6 +1534,37 @@ static void virt_set_memmap(VirtMachineState *vms)
     }
 }
=20
+/*
+ * finalize_gic_version - Determines the final gic_version
+ * according to the gic-version property
+ *
+ * Default GIC type is v2
+ */
+static void finalize_gic_version(VirtMachineState *vms)
+{
+    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST ||
+        vms->gic_version =3D=3D VIRT_GIC_VERSION_MAX) {
+        if (!kvm_enabled()) {
+            if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST) {
+                error_report("gic-version=3Dhost requires KVM");
+                exit(1);
+            } else {
+                /* "max": currently means 3 for TCG */
+                vms->gic_version =3D VIRT_GIC_VERSION_3;
+            }
+        } else {
+            vms->gic_version =3D kvm_arm_vgic_probe();
+            if (!vms->gic_version) {
+                error_report(
+                    "Unable to determine GIC version supported by host");
+                exit(1);
+            }
+        }
+    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_NOSEL) {
+        vms->gic_version =3D VIRT_GIC_VERSION_2;
+    }
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(machine);
@@ -1560,25 +1591,7 @@ static void machvirt_init(MachineState *machine)
     /* We can probe only here because during property set
      * KVM is not available yet
      */
-    if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST ||
-        vms->gic_version =3D=3D VIRT_GIC_VERSION_MAX) {
-        if (!kvm_enabled()) {
-            if (vms->gic_version =3D=3D VIRT_GIC_VERSION_HOST) {
-                error_report("gic-version=3Dhost requires KVM");
-                exit(1);
-            } else {
-                /* "max": currently means 3 for TCG */
-                vms->gic_version =3D VIRT_GIC_VERSION_3;
-            }
-        } else {
-            vms->gic_version =3D kvm_arm_vgic_probe();
-            if (!vms->gic_version) {
-                error_report(
-                    "Unable to determine GIC version supported by host");
-                exit(1);
-            }
-        }
-    }
+     finalize_gic_version(vms);
=20
     if (!cpu_type_valid(machine->cpu_type)) {
         error_report("mach-virt: CPU type %s not supported", machine->cpu_=
type);
@@ -2138,8 +2151,7 @@ static void virt_instance_init(Object *obj)
                                     "Set on/off to enable/disable using "
                                     "physical address space above 32 bits"=
,
                                     NULL);
-    /* Default GIC type is v2 */
-    vms->gic_version =3D VIRT_GIC_VERSION_2;
+    vms->gic_version =3D VIRT_GIC_VERSION_NOSEL;
     object_property_add_str(obj, "gic-version", virt_get_gic_version,
                         virt_set_gic_version, NULL);
     object_property_set_description(obj, "gic-version",
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 6325b98269..5785416480 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -95,6 +95,7 @@ typedef enum VirtIOMMUType {
     VIRT_IOMMU_VIRTIO,
 } VirtIOMMUType;
=20
+#define VIRT_GIC_VERSION_NOSEL  (-2)
 #define VIRT_GIC_VERSION_MAX    (-1)
 #define VIRT_GIC_VERSION_HOST   0
 #define VIRT_GIC_VERSION_2      2
--=20
2.20.1


