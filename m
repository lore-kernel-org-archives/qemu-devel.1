Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAEAC4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED15206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tnw1RJHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED15206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j709B-0007AX-4A
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:06:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j707w-0005Ir-Ps
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:05:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j707v-0003S7-A0
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:05:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j707u-0003Po-2M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582736737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAmtz0PZtJ01TqxO6BuQ6Bgs7TH8sF8IREaBysLJNks=;
 b=Tnw1RJHEAagSgJlIiDsmedA9hCp3SwsSI6HRF47jzOu2IMvNEB3MGt1Uzj74kjK3gzT8m6
 AGSc6ZrFtgzyRhNNhmBeVWANpFWD37/fBiceyPFcW7pGyrP2wt5vLA6DToDyPKUAmweApa
 GOXp//A6JocecqI98epctLRsCtlmC4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-Tjsb-ZXPPcWxyDGidr-stw-1; Wed, 26 Feb 2020 12:05:35 -0500
X-MC-Unique: Tjsb-ZXPPcWxyDGidr-stw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D07518C8C05;
 Wed, 26 Feb 2020 17:05:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8A7660C18;
 Wed, 26 Feb 2020 17:05:19 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Subject: [RFC 2/2] hw/arm/virt: kvm: allow gicv3 by default if host does not
 support v2
Date: Wed, 26 Feb 2020 18:05:00 +0100
Message-Id: <20200226170500.17028-3-eric.auger@redhat.com>
In-Reply-To: <20200226170500.17028-1-eric.auger@redhat.com>
References: <20200226170500.17028-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

At the moment if the end-user does not specify the gic-version along
with KVM acceleration, v2 is set by default. However most of the
systems now have GICv3 and sometimes they do not support GICv2
compatibility. In that case we end up with this error:

qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
qemu-system-aarch64: failed to set irq for PMU
and qemu aborts.

This patch keeps the default v2 selection in all cases except
in the KVM accelerated mode when the host does not support v2.
This case did not work anyway so we do not break any compatibility.
Now we get v3 selected in such a case. Also if the end-user explicitly
sets v2 whereas this latter is not supported, we also are
informed that v2 is not selected by thos host instead of getting the
above PMU related message.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/arm/virt.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/virt.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a196bbf0d5..b37b0c40c1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1554,6 +1554,33 @@ static void machvirt_init(MachineState *machine)
                 }
             }
         }
+    } else if (kvm_enabled()) {
+        int probe_bitmap =3D kvm_arm_vgic_probe();
+
+        if (!probe_bitmap) {
+            error_report(
+                "Unable to determine GIC version supported by host");
+            exit(1);
+        }
+        if (!vms->gic_version_user_selected) {
+            /*
+             * by default v2 is supposed to be chosen: check it is
+             * supported by the host. Otherwise take v3.
+             */
+            if (probe_bitmap & KVM_ARM_VGIC_V2) {
+                vms->gic_version =3D 2;
+            } else if (probe_bitmap & KVM_ARM_VGIC_V3) {
+                vms->gic_version =3D 3;
+            }
+        } else { /* user explicitly set the version to 2 or 3 */
+            if (vms->gic_version =3D=3D 2 && !(probe_bitmap & KVM_ARM_VGIC=
_V2)) {
+                error_report("GICv2 is not supported by the host");
+                exit(1);
+            } else if (vms->gic_version =3D=3D 3 && !(probe_bitmap & KVM_A=
RM_VGIC_V3)) {
+                error_report("GICv3 is not supported by the host");
+                exit(1);
+            }
+        }
     }
=20
     if (!cpu_type_valid(machine->cpu_type)) {
@@ -1840,6 +1867,7 @@ static void virt_set_gic_version(Object *obj, const c=
har *value, Error **errp)
 {
     VirtMachineState *vms =3D VIRT_MACHINE(obj);
=20
+    vms->gic_version_user_selected =3D true;
     if (!strcmp(value, "3")) {
         vms->gic_version =3D 3;
     } else if (!strcmp(value, "2")) {
@@ -1851,6 +1879,7 @@ static void virt_set_gic_version(Object *obj, const c=
har *value, Error **errp)
     } else {
         error_setg(errp, "Invalid gic-version value");
         error_append_hint(errp, "Valid values are 3, 2, host, max.\n");
+        vms->gic_version_user_selected =3D false;
     }
 }
=20
@@ -2103,6 +2132,7 @@ static void virt_instance_init(Object *obj)
                                     NULL);
     /* Default GIC type is v2 */
     vms->gic_version =3D 2;
+    vms->gic_version_user_selected =3D false;
     object_property_add_str(obj, "gic-version", virt_get_gic_version,
                         virt_set_gic_version, NULL);
     object_property_set_description(obj, "gic-version",
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 71508bf40c..e363cde452 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -124,6 +124,7 @@ typedef struct {
     bool its;
     bool virt;
     int32_t gic_version;
+    bool gic_version_user_selected;
     VirtIOMMUType iommu;
     struct arm_boot_info bootinfo;
     MemMapEntry *memmap;
--=20
2.20.1


