Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F8EC3F2D0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A9E21655
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNmKk0Pt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A9E21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBzPM-0007HB-OS
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 07:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jBzMF-00022G-NW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:17:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jBzME-0000gS-FT
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:17:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jBzME-0000fi-CN
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583925421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWITm29o9F+/2vUiv5hnDt4BR+WmlReK+cyGVcscanc=;
 b=fNmKk0PtEgtmPbDIT9Sb5ocDhFcVV/vJM2qEV1TZBJIhjh6xDgfUSZUiJqsUfiqj8O8B80
 dh+9Q1JFjhlZBokmj3unMWV4mI0FT3Ss/Z3qNUYJZbIQWSHyplz7pla5I0YIJWvELr0gyv
 CsDDb8jaKsoSmCD5INIYOU/MTbOmGUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-L9V3O0n4N0CWWujT1-0JuA-1; Wed, 11 Mar 2020 07:16:58 -0400
X-MC-Unique: L9V3O0n4N0CWWujT1-0JuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03C2A107ACC4;
 Wed, 11 Mar 2020 11:16:57 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6BA191D91;
 Wed, 11 Mar 2020 11:16:50 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v4 5/6] hw/arm/virt: kvm: Restructure finalize_gic_version()
Date: Wed, 11 Mar 2020 12:16:25 +0100
Message-Id: <20200311111626.5705-6-eric.auger@redhat.com>
In-Reply-To: <20200311111626.5705-1-eric.auger@redhat.com>
References: <20200311111626.5705-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: maz@kernel.org, drjones@redhat.com, richard.henderson@linaro.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restructure the finalize_gic_version with switch cases and
clearly separate the following cases:

- KVM mode / in-kernel irqchip
- KVM mode / userspace irqchip
- TCG mode

In KVM mode / in-kernel irqchip , we explictly check whether
the chosen version is supported by the host. If the end-user
explicitly sets v2/v3 and this is not supported by the host,
then the user gets an explicit error message. Note that for
old kernels where the CREATE_DEVICE ioctl doesn't exist then
we will now fail if the user specifically asked for gicv2,
where previously we (probably) would have succeeded.

In KVM mode / userspace irqchip we immediatly output an error
in case the end-user explicitly selected v3. Also we warn the
end-user about the unexpected usage of gic-version=3Dhost in
that case as only userspace GICv2 is supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- introduce a separate switch case for KVM mode / userspace
  irqchip
- don't probe the host GIC version in case of userspace
  GIC
- add error/warning messages in v3/host mode in userspace
  mode
- mention old kernel case with explicit v2/v3 regression

v2 -> v3:
- explictly list V2 and V3 in the switch/case
- fix indent
---
 hw/arm/virt.c | 89 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f798b6ec10..f5ff2d9006 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1543,33 +1543,80 @@ static void virt_set_memmap(VirtMachineState *vms)
  */
 static void finalize_gic_version(VirtMachineState *vms)
 {
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
-            int probe_bitmap =3D kvm_arm_vgic_probe();
+    if (kvm_enabled()) {
+        int probe_bitmap;
=20
-            if (!probe_bitmap) {
+        if (!kvm_irqchip_in_kernel()) {
+            switch (vms->gic_version) {
+            case VIRT_GIC_VERSION_HOST:
+                warn_report(
+                    "gic-version=3Dhost not relevant with kernel-irqchip=
=3Doff "
+                     "as only userspace GICv2 is supported. Using v2 ...")=
;
+                return;
+            case VIRT_GIC_VERSION_MAX:
+            case VIRT_GIC_VERSION_NOSEL:
+                vms->gic_version =3D VIRT_GIC_VERSION_2;
+                return;
+            case VIRT_GIC_VERSION_2:
+                return;
+            case VIRT_GIC_VERSION_3:
                 error_report(
-                    "Unable to determine GIC version supported by host");
+                    "gic-version=3D3 is not supported with kernel-irqchip=
=3Doff");
                 exit(1);
-            } else {
-                if (probe_bitmap & KVM_ARM_VGIC_V3) {
-                    vms->gic_version =3D VIRT_GIC_VERSION_3;
-                } else {
-                    vms->gic_version =3D VIRT_GIC_VERSION_2;
-                }
             }
         }
-    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_NOSEL) {
+
+        probe_bitmap =3D kvm_arm_vgic_probe();
+        if (!probe_bitmap) {
+            error_report(
+                "Unable to determine GIC version supported by host");
+            exit(1);
+        }
+
+        switch (vms->gic_version) {
+        case VIRT_GIC_VERSION_HOST:
+        case VIRT_GIC_VERSION_MAX:
+            if (probe_bitmap & KVM_ARM_VGIC_V3) {
+                vms->gic_version =3D VIRT_GIC_VERSION_3;
+            } else {
+                vms->gic_version =3D VIRT_GIC_VERSION_2;
+            }
+            return;
+        case VIRT_GIC_VERSION_NOSEL:
+            vms->gic_version =3D VIRT_GIC_VERSION_2;
+            break;
+        case VIRT_GIC_VERSION_2:
+        case VIRT_GIC_VERSION_3:
+            break;
+        }
+
+        /* Check chosen version is effectively supported by the host */
+        if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2 &&
+            !(probe_bitmap & KVM_ARM_VGIC_V2)) {
+            error_report("host does not support in-kernel GICv2 emulation"=
);
+            exit(1);
+        } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3 &&
+                   !(probe_bitmap & KVM_ARM_VGIC_V3)) {
+            error_report("host does not support in-kernel GICv3 emulation"=
);
+            exit(1);
+        }
+        return;
+    }
+
+    /* TCG mode */
+    switch (vms->gic_version) {
+    case VIRT_GIC_VERSION_NOSEL:
         vms->gic_version =3D VIRT_GIC_VERSION_2;
+        break;
+    case VIRT_GIC_VERSION_MAX:
+        vms->gic_version =3D VIRT_GIC_VERSION_3;
+        break;
+    case VIRT_GIC_VERSION_HOST:
+        error_report("gic-version=3Dhost requires KVM");
+        exit(1);
+    case VIRT_GIC_VERSION_2:
+    case VIRT_GIC_VERSION_3:
+        break;
     }
 }
=20
--=20
2.20.1


