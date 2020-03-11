Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B1C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B982A21655
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0l5RQcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B982A21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1Im-0003Aq-T8
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jC1EM-0002I6-K1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jC1EL-0008Nb-Ft
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:17:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24470
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jC1EL-0008Mb-Aw
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583932621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1eU7BPm/c9T0kTdmTbB7QHipunZUQL/LFlPAkqMmDI=;
 b=U0l5RQcjhlCf77OzLAamCLMfjnkMfgDbu1VHh6buSbcbQql6kWv8xZwEQfz+VZoWLtzXyF
 2/k3QR70dFmZAkirDtYAexfiJ0X60KDst/qtxe+gol2Iilw9+MsdWLbqtx8GLDIeJV4Dsu
 F/GSgiZ1R1E5NFucKC6W2aHE4A18nOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Vk1Gs3q6NJqrvPL7Lp3yKA-1; Wed, 11 Mar 2020 09:16:59 -0400
X-MC-Unique: Vk1Gs3q6NJqrvPL7Lp3yKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B894189F760;
 Wed, 11 Mar 2020 13:16:58 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C1B573880;
 Wed, 11 Mar 2020 13:16:52 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [PATCH v5 6/6] hw/arm/virt: kvm: allow gicv3 by default if v2 cannot
 work
Date: Wed, 11 Mar 2020 14:16:18 +0100
Message-Id: <20200311131618.7187-7-eric.auger@redhat.com>
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
Reviewed-by: Andrew Jones <drjones@redhat.com>

---
v4 -> v5:
- else if (max_cpus > GIC_NCPU)
- Added Drew's R-b

v3 -> v4:
- Deal with the case where v3 is not supported by the host and
  the number of vcpus exceeds 8

v2 -> v3:
- add ()
---
 hw/arm/virt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 90966580a3..94f93dda54 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1543,6 +1543,8 @@ static void virt_set_memmap(VirtMachineState *vms)
  */
 static void finalize_gic_version(VirtMachineState *vms)
 {
+    unsigned int max_cpus =3D MACHINE(vms)->smp.max_cpus;
+
     if (kvm_enabled()) {
         int probe_bitmap;
=20
@@ -1582,7 +1584,20 @@ static void finalize_gic_version(VirtMachineState *v=
ms)
             }
             return;
         case VIRT_GIC_VERSION_NOSEL:
-            vms->gic_version =3D VIRT_GIC_VERSION_2;
+            if ((probe_bitmap & KVM_ARM_VGIC_V2) && max_cpus <=3D GIC_NCPU=
) {
+                vms->gic_version =3D VIRT_GIC_VERSION_2;
+            } else if (probe_bitmap & KVM_ARM_VGIC_V3) {
+                /*
+                 * in case the host does not support v2 in-kernel emulatio=
n or
+                 * the end-user requested more than 8 VCPUs we now default
+                 * to v3. In any case defaulting to v2 would be broken.
+                 */
+                vms->gic_version =3D VIRT_GIC_VERSION_3;
+            } else if (max_cpus > GIC_NCPU) {
+                error_report("host only supports in-kernel GICv2 emulation=
 "
+                             "but more than 8 vcpus are requested");
+                exit(1);
+            }
             break;
         case VIRT_GIC_VERSION_2:
         case VIRT_GIC_VERSION_3:
--=20
2.20.1


