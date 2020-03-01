Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55FC3F2CE
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79814214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYjxOgdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79814214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8M49-0006QD-Mi
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 05:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1u-0001c1-Gu
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1t-0001lt-EM
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44647
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8M1t-0001ll-Am
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583059261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbMJWaSMveCKH0fxbinwHNcIfj7hkCYL8NMTeMzPqU8=;
 b=XYjxOgdT8ZMn0Y7afPM+OW27pxPUVzDlD4+IhrZC+nQ2OWUjd2uyh3mGad8kFtVLmtXk6/
 7hpff8isuHbkxdqIof1Oue+qx9qmTX76VaxuvlakH4kPBknfO0qMQatCqdi5HQpj7C2W26
 EGHSY/m0MIB6/EINoGJ1MN94F/2J/lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-0SUvEUVMNN-kt1aup0sybw-1; Sun, 01 Mar 2020 05:40:59 -0500
X-MC-Unique: 0SUvEUVMNN-kt1aup0sybw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73DF6800D5A;
 Sun,  1 Mar 2020 10:40:58 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEC8C60C80;
 Sun,  1 Mar 2020 10:40:56 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v2 4/6] target/arm/kvm: Let kvm_arm_vgic_probe() return a
 bitmap
Date: Sun,  1 Mar 2020 11:40:38 +0100
Message-Id: <20200301104040.15186-5-eric.auger@redhat.com>
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

Convert kvm_arm_vgic_probe() so that it returns a
bitmap of supported in-kernel emulation VGIC versions instead
of the max version: at the moment values can be v2 and v3.
This allows to expose the case where the host GICv3 also
supports GICv2 emulation. This will be useful to choose the
default version in KVM accelerated mode.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c        | 11 +++++++++--
 target/arm/kvm.c     | 14 ++++++++------
 target/arm/kvm_arm.h |  3 +++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 338d56999f..eb8c57c85e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1553,11 +1553,18 @@ static void finalize_gic_version(VirtMachineState *=
vms)
                 vms->gic_version =3D VIRT_GIC_VERSION_3;
             }
         } else {
-            vms->gic_version =3D kvm_arm_vgic_probe();
-            if (!vms->gic_version) {
+            int probe_bitmap =3D kvm_arm_vgic_probe();
+
+            if (!probe_bitmap) {
                 error_report(
                     "Unable to determine GIC version supported by host");
                 exit(1);
+            } else {
+                if (probe_bitmap & KVM_ARM_VGIC_V3) {
+                    vms->gic_version =3D VIRT_GIC_VERSION_3;
+                } else {
+                    vms->gic_version =3D VIRT_GIC_VERSION_2;
+                }
             }
         }
     } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_NOSEL) {
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 85860e6f95..390077c518 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -874,15 +874,17 @@ int kvm_arch_irqchip_create(KVMState *s)
=20
 int kvm_arm_vgic_probe(void)
 {
+    int val =3D 0;
+
     if (kvm_create_device(kvm_state,
                           KVM_DEV_TYPE_ARM_VGIC_V3, true) =3D=3D 0) {
-        return 3;
-    } else if (kvm_create_device(kvm_state,
-                                 KVM_DEV_TYPE_ARM_VGIC_V2, true) =3D=3D 0)=
 {
-        return 2;
-    } else {
-        return 0;
+        val |=3D KVM_ARM_VGIC_V3;
     }
+    if (kvm_create_device(kvm_state,
+                          KVM_DEV_TYPE_ARM_VGIC_V2, true) =3D=3D 0) {
+        val |=3D KVM_ARM_VGIC_V2;
+    }
+    return val;
 }
=20
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level)
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ae9e075d75..48bf5e16d5 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -15,6 +15,9 @@
 #include "exec/memory.h"
 #include "qemu/error-report.h"
=20
+#define KVM_ARM_VGIC_V2   (1 << 0)
+#define KVM_ARM_VGIC_V3   (1 << 1)
+
 /**
  * kvm_arm_vcpu_init:
  * @cs: CPUState
--=20
2.20.1


