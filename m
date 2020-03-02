Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E62C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B111F2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 11:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMKbcxWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B111F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8inu-00066i-Sv
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 06:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57816)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8ijb-00085W-8B
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8ija-00045V-1o
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:55:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52807
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8ijZ-00045N-U1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583146537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxzzA7ONfUiFpNQxniznGhPZKJfiDxFGwvdTsIDhlts=;
 b=aMKbcxWl3H6Pz9Esq8oZwyMXQUwlkh1dKMFfVNH711tW44jj49HuFUdRc0zJCPIpQm1ArT
 XZESPGbet9Ew1SMe/GzMAhilZsuL8GFFNOL4JJgiXtcoifKkjVv5jkxcLcRBF1azivr5Cn
 sUUOFEZqj4NOB/VQsiahTGK25XhPDHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-GrHsLY2SMwO2us2l3bnyWw-1; Mon, 02 Mar 2020 05:55:35 -0500
X-MC-Unique: GrHsLY2SMwO2us2l3bnyWw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ED42800053;
 Mon,  2 Mar 2020 10:55:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C379F385;
 Mon,  2 Mar 2020 10:55:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v3 5/6] hw/arm/virt: kvm: Check the chosen gic version is
 supported by the host
Date: Mon,  2 Mar 2020 11:55:15 +0100
Message-Id: <20200302105516.5972-6-eric.auger@redhat.com>
In-Reply-To: <20200302105516.5972-1-eric.auger@redhat.com>
References: <20200302105516.5972-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>

---

v2 -> v3:
- explictly list V2 and V3 in the switch/case
- fix indent
---
 hw/arm/virt.c | 77 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eb8c57c85e..aeb6c45e51 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1542,33 +1542,62 @@ static void virt_set_memmap(VirtMachineState *vms)
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


