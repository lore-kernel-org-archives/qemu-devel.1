Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CBAC3F2CE
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F04E214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOpAbX5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F04E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8M34-0003bH-H3
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 05:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1z-0001mS-Td
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8M1y-0001oA-Pz
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55376
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8M1y-0001o0-Mm
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583059266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=or+pwHOdBKJ1Y8fuxHbiGTGb/Xj7RPu4QnwCSHvcEkY=;
 b=YOpAbX5LtAwdAFcC3oePRtKPOVW71jKLRbu3TOE/w+OeeWlpgE2fmCyHC3Z5cMjq7OfeV3
 +SnMRgLSkvpUTHDUhUp4U+yF20uQehNJhrCI//Uv6wDOPcSDs2VoJd77IMcxR3NI7fSxU8
 iyfu/VdCtJVyRIVKQqupABok63QYwp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-iglKXyYyPP2rqsIh2ny30Q-1; Sun, 01 Mar 2020 05:41:01 -0500
X-MC-Unique: iglKXyYyPP2rqsIh2ny30Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E26800D4E;
 Sun,  1 Mar 2020 10:41:00 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC4DD60C80;
 Sun,  1 Mar 2020 10:40:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v2 5/6] hw/arm/virt: kvm: Check the chosen gic version is
 supported by the host
Date: Sun,  1 Mar 2020 11:40:39 +0100
Message-Id: <20200301104040.15186-6-eric.auger@redhat.com>
In-Reply-To: <20200301104040.15186-1-eric.auger@redhat.com>
References: <20200301104040.15186-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: maz@kernel.org, drjones@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restructure the finalize_gic_version with switch cases and, in
KVM mode, explictly check whether the chosen version is supported
by the host.

if the end-user explicitly sets v2/v3 and this is not supported by
the host, then the user gets an explicit error message.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 76 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eb8c57c85e..610bfc9ee9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1542,33 +1542,61 @@ static void virt_set_memmap(VirtMachineState *vms)
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
+        int probe_bitmap =3D kvm_arm_vgic_probe();
=20
-            if (!probe_bitmap) {
-                error_report(
-                    "Unable to determine GIC version supported by host");
-                exit(1);
-            } else {
-                if (probe_bitmap & KVM_ARM_VGIC_V3) {
-                    vms->gic_version =3D VIRT_GIC_VERSION_3;
-                } else {
-                    vms->gic_version =3D VIRT_GIC_VERSION_2;
-                }
-            }
+        if (!probe_bitmap) {
+            error_report("Unable to determine GIC version supported by hos=
t");
+            exit(1);
         }
-    } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_NOSEL) {
+
+        switch (vms->gic_version) {
+        case VIRT_GIC_VERSION_NOSEL:
+            vms->gic_version =3D VIRT_GIC_VERSION_2;
+            break;
+        case VIRT_GIC_VERSION_HOST:
+        case VIRT_GIC_VERSION_MAX:
+            if (probe_bitmap & KVM_ARM_VGIC_V3) {
+                vms->gic_version =3D VIRT_GIC_VERSION_3;
+            } else {
+                vms->gic_version =3D VIRT_GIC_VERSION_2;
+            }
+            return;
+        case VIRT_GIC_VERSION_2:
+        case VIRT_GIC_VERSION_3:
+            break;
+        }
+
+        if (!kvm_irqchip_in_kernel()) {
+            return;
+        }
+
+        /* Check chosen version is effectively supported by the host */
+        if (vms->gic_version =3D=3D VIRT_GIC_VERSION_2 &&
+               !(probe_bitmap & KVM_ARM_VGIC_V2)) {
+                error_report("host does not support in-kernel GICv2 emulat=
ion");
+                exit(1);
+        } else if (vms->gic_version =3D=3D VIRT_GIC_VERSION_3 &&
+               !(probe_bitmap & KVM_ARM_VGIC_V3)) {
+                error_report("host does not support in-kernel GICv3 emulat=
ion");
+                exit(1);
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
+    default: /* explicit V2/V3 are left untouched */
+        break;
     }
 }
=20
--=20
2.20.1


