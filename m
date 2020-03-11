Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C5AC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EEA21D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6lx5JMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EEA21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1HK-0000yb-26
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jC1E9-0001jX-PK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jC1E8-0007uQ-K6
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:16:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58423
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jC1E8-0007tN-FQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583932608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HKQr9VZsT9WY28hk7QtNvhUZkU4EhLIW9bZ3iOeyXR8=;
 b=a6lx5JMtkwHbz8/Xiww6L5m1HsSkuDzNKsHnKlZY7a9vC8PGYypUP5DpXfcUazchVJbxun
 Fg2AnM4xuIYc/cDugtVh3MxzjFOlfnP99xqVsDPkpLSt/33qYgXDhAvndKfIHhqtW/tnt3
 gYexR1QB6CDWsEw9Bhhrd8t7BUb6jkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-PsdSzhYuMGeKKkxrSPeQYg-1; Wed, 11 Mar 2020 09:16:47 -0400
X-MC-Unique: PsdSzhYuMGeKKkxrSPeQYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F9C7107ACC4;
 Wed, 11 Mar 2020 13:16:45 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A466A84779;
 Wed, 11 Mar 2020 13:16:42 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v5 4/6] target/arm/kvm: Let kvm_arm_vgic_probe() return a
 bitmap
Date: Wed, 11 Mar 2020 14:16:16 +0100
Message-Id: <20200311131618.7187-5-eric.auger@redhat.com>
In-Reply-To: <20200311131618.7187-1-eric.auger@redhat.com>
References: <20200311131618.7187-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Convert kvm_arm_vgic_probe() so that it returns a
bitmap of supported in-kernel emulation VGIC versions instead
of the max version: at the moment values can be v2 and v3.
This allows to expose the case where the host GICv3 also
supports GICv2 emulation. This will be useful to choose the
default version in KVM accelerated mode.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h |  3 +++
 hw/arm/virt.c        | 11 +++++++++--
 target/arm/kvm.c     | 14 ++++++++------
 3 files changed, 20 insertions(+), 8 deletions(-)

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
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e55cafa014..a94bc5ddae 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1554,11 +1554,18 @@ static void finalize_gic_version(VirtMachineState *=
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
--=20
2.20.1


