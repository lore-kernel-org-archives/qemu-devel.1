Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEF2C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3689E21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KymcQ2MC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3689E21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1HS-00018U-Ef
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jC1E6-0001di-RL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jC1E5-0007pz-Hc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:16:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jC1E5-0007p4-DF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583932605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBHPtRIRwLldTSKLJc8vPukgKY/hXHwjilghaYtCE/8=;
 b=KymcQ2MCRxQ27omGPWfiBu/Py7WkTN4CxjTZNBDuAkZqW+3uLQFEF6Y3oM+KM81iB0u/NR
 sRaxgucwRV6Qsn7JAn90o3T+723fjUzdVzVW9JhDLUfv+Z2Cl0s5YCpctmhasoPIITNAtl
 eD5lROTKFEX3ggJ5NAD2EKEQVdsq/XQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-ZhJz7zxJNvq5C7EfNdqSfg-1; Wed, 11 Mar 2020 09:16:43 -0400
X-MC-Unique: ZhJz7zxJNvq5C7EfNdqSfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C8F2189F762;
 Wed, 11 Mar 2020 13:16:42 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2185073880;
 Wed, 11 Mar 2020 13:16:38 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v5 3/6] hw/arm/virt: Introduce finalize_gic_version()
Date: Wed, 11 Mar 2020 14:16:15 +0100
Message-Id: <20200311131618.7187-4-eric.auger@redhat.com>
In-Reply-To: <20200311131618.7187-1-eric.auger@redhat.com>
References: <20200311131618.7187-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: maz@kernel.org, drjones@redhat.com, richard.henderson@linaro.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's move the code which freezes which gic-version to
be applied in a dedicated function. We also now set by
default the VIRT_GIC_VERSION_NO_SET. This eventually
turns into the legacy v2 choice in the finalize() function.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>

---

v4 -> v5:
- remove extra space

v2 -> v3:
- add NOTSEL value at the end of the new enum type
---
 include/hw/arm/virt.h |  1 +
 hw/arm/virt.c         | 54 ++++++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c0827cacdf..893796d3b0 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -100,6 +100,7 @@ typedef enum VirtGICType {
     VIRT_GIC_VERSION_HOST,
     VIRT_GIC_VERSION_2,
     VIRT_GIC_VERSION_3,
+    VIRT_GIC_VERSION_NOSEL,
 } VirtGICType;
=20
 typedef struct MemMapEntry {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4ed1f0cb2e..e55cafa014 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1535,6 +1535,37 @@ static void virt_set_memmap(VirtMachineState *vms)
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
@@ -1561,25 +1592,7 @@ static void machvirt_init(MachineState *machine)
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
+    finalize_gic_version(vms);
=20
     if (!cpu_type_valid(machine->cpu_type)) {
         error_report("mach-virt: CPU type %s not supported", machine->cpu_=
type);
@@ -2140,8 +2153,7 @@ static void virt_instance_init(Object *obj)
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
--=20
2.20.1


