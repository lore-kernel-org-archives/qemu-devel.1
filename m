Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7994CC3F2CE
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 441D2214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 10:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFQRdYej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 441D2214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8M4l-0007Mr-Dp
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 05:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j8M23-0001ws-IV
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j8M22-0001ow-ID
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j8M22-0001om-F4
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 05:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583059270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PfT/l8PmlPfpYXOLH7rb/lsJEybZL4C79XAA00tJhE=;
 b=dFQRdYeju6sMEcbz1KFQahH9K2UHg5xSPlcPRU2KwxqC1B7w3zP5HRL2PQW1e9OLyjp3a3
 j8+ZvIm6kBbjyhBo9wyP+mkyVtblf6vxRW/ETObkkgcse8z0xUNOtuti6TyJECxx6p+6gG
 hxGUQ1hIq+VUql/VQ7qH5ytaFd2Io5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-jskvppMnNkanzehtZpWQ2g-1; Sun, 01 Mar 2020 05:41:06 -0500
X-MC-Unique: jskvppMnNkanzehtZpWQ2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F22B189F760;
 Sun,  1 Mar 2020 10:41:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECA4560C80;
 Sun,  1 Mar 2020 10:41:00 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v2 6/6] hw/arm/virt: kvm: allow gicv3 by default if v2 cannot
 work
Date: Sun,  1 Mar 2020 11:40:40 +0100
Message-Id: <20200301104040.15186-7-eric.auger@redhat.com>
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

At the moment if the end-user does not specify the gic-version along
with KVM acceleration, v2 is set by default. However most of the
systems now have GICv3 and sometimes they do not support GICv2
compatibility.

This patch keeps the default v2 selection in all cases except
in the KVM accelerated mode when either
- the host does not support GICv2 in-kernel emulation or
- number of VCPUS exceeds 8.

Those cases did not work anyway so we do not break any compatibility.
Now we get v3 selected in such a case.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/arm/virt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 610bfc9ee9..2d12a7b0b8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1542,6 +1542,8 @@ static void virt_set_memmap(VirtMachineState *vms)
  */
 static void finalize_gic_version(VirtMachineState *vms)
 {
+    unsigned int max_cpus =3D MACHINE(vms)->smp.max_cpus;
+
     if (kvm_enabled()) {
         int probe_bitmap =3D kvm_arm_vgic_probe();
=20
@@ -1552,7 +1554,17 @@ static void finalize_gic_version(VirtMachineState *v=
ms)
=20
         switch (vms->gic_version) {
         case VIRT_GIC_VERSION_NOSEL:
-            vms->gic_version =3D VIRT_GIC_VERSION_2;
+            if ((probe_bitmap & KVM_ARM_VGIC_V2 && max_cpus <=3D GIC_NCPU)=
 ||
+                !kvm_irqchip_in_kernel()) {
+                vms->gic_version =3D VIRT_GIC_VERSION_2;
+            } else {
+                /*
+                 * in case the host does not support v2 in-kernel emulatio=
n or
+                 * the end-user requested more than 8 VCPUs we now default
+                 * to v3. In any case defaulting to v2 would be broken.
+                 */
+                vms->gic_version =3D VIRT_GIC_VERSION_3;
+            }
             break;
         case VIRT_GIC_VERSION_HOST:
         case VIRT_GIC_VERSION_MAX:
--=20
2.20.1


