Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE9CC1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5781D20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3wuXd70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5781D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQUq-0007Fy-DG
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jCQSp-0002f5-Ha
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jCQSo-0008Cs-5X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:13:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jCQSo-0008Cg-1I
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584029617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7AoJdkA/vEE2eyNwUtS1zvah6ZFRv1wygcX5sCtbETQ=;
 b=F3wuXd70HnpoujDVaJu+L1ckRLJD/kRFpIznrl2p760U/Zc8Vd/rHhjiYhVbveF4t0hYwm
 fXQa0/MXv82YeYnd4w6v5T3a95RkFTNgEiSaGN7qdEXcRf2m7wg1UT4SB2Vq4e7eKMAQv1
 OkMt1/32+76JBG11CZqveHq4MKiQpt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-qbgfe4NMMluAJnv9obeMRQ-1; Thu, 12 Mar 2020 12:13:32 -0400
X-MC-Unique: qbgfe4NMMluAJnv9obeMRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32F3B108FD5E;
 Thu, 12 Mar 2020 16:13:31 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-131.ams2.redhat.com [10.36.117.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EAC475C1B5;
 Thu, 12 Mar 2020 16:13:00 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv2 2/4] intc/s390_flic_kvm.c: Use kvm_device_ioctl()
 instead of ioctl()
Date: Thu, 12 Mar 2020 17:12:15 +0100
Message-Id: <20200312161217.3590-3-david@redhat.com>
In-Reply-To: <20200312161217.3590-1-david@redhat.com>
References: <20200312161217.3590-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's use the official variant, which will e.g., trace the call.
kvm_device_ioctl() will do the rc -> -errno conversion automatically, so
we can drop that code.

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic_kvm.c | 43 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index a306b26faa..ce05306406 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -66,11 +66,8 @@ static int flic_get_all_irqs(KVMS390FLICState *flic,
         .addr =3D (uint64_t) buf,
         .attr =3D len,
     };
-    int rc;
=20
-    rc =3D ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr);
-
-    return rc =3D=3D -1 ? -errno : rc;
+    return kvm_device_ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr);
 }
=20
 static void flic_enable_pfault(KVMS390FLICState *flic)
@@ -78,11 +75,8 @@ static void flic_enable_pfault(KVMS390FLICState *flic)
     struct kvm_device_attr attr =3D {
         .group =3D KVM_DEV_FLIC_APF_ENABLE,
     };
-    int rc;
-
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
-    if (rc) {
+    if (kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr)) {
         fprintf(stderr, "flic: couldn't enable pfault\n");
     }
 }
@@ -92,11 +86,8 @@ static void flic_disable_wait_pfault(KVMS390FLICState *f=
lic)
     struct kvm_device_attr attr =3D {
         .group =3D KVM_DEV_FLIC_APF_DISABLE_WAIT,
     };
-    int rc;
=20
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
-
-    if (rc) {
+    if (kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr)) {
         fprintf(stderr, "flic: couldn't disable pfault\n");
     }
 }
@@ -111,16 +102,13 @@ static void flic_disable_wait_pfault(KVMS390FLICState=
 *flic)
 static int flic_enqueue_irqs(void *buf, uint64_t len,
                             KVMS390FLICState *flic)
 {
-    int rc;
     struct kvm_device_attr attr =3D {
         .group =3D KVM_DEV_FLIC_ENQUEUE,
         .addr =3D (uint64_t) buf,
         .attr =3D len,
     };
=20
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
-
-    return rc ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
 static void kvm_s390_inject_flic(S390FLICState *fs, struct kvm_s390_irq *i=
rq)
@@ -187,7 +175,6 @@ static int kvm_s390_clear_io_flic(S390FLICState *fs, ui=
nt16_t subchannel_id,
                            uint16_t subchannel_nr)
 {
     KVMS390FLICState *flic =3D s390_get_kvm_flic(fs);
-    int rc;
     uint32_t sid =3D subchannel_id << 16 | subchannel_nr;
     struct kvm_device_attr attr =3D {
         .group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ,
@@ -197,8 +184,7 @@ static int kvm_s390_clear_io_flic(S390FLICState *fs, ui=
nt16_t subchannel_id,
     if (unlikely(!flic->clear_io_supported)) {
         return -ENOSYS;
     }
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
-    return rc ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
 static int kvm_s390_modify_ais_mode(S390FLICState *fs, uint8_t isc,
@@ -218,7 +204,7 @@ static int kvm_s390_modify_ais_mode(S390FLICState *fs, =
uint8_t isc,
         return -ENOSYS;
     }
=20
-    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
 static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
@@ -235,7 +221,7 @@ static int kvm_s390_inject_airq(S390FLICState *fs, uint=
8_t type,
         return -ENOSYS;
     }
=20
-    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
 /**
@@ -285,7 +271,6 @@ static int kvm_s390_register_io_adapter(S390FLICState *=
fs, uint32_t id,
         .flags =3D flags,
     };
     KVMS390FLICState *flic =3D KVM_S390_FLIC(fs);
-    int r;
     struct kvm_device_attr attr =3D {
         .group =3D KVM_DEV_FLIC_ADAPTER_REGISTER,
         .addr =3D (uint64_t)&adapter,
@@ -296,9 +281,7 @@ static int kvm_s390_register_io_adapter(S390FLICState *=
fs, uint32_t id,
         return 0;
     }
=20
-    r =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
-
-    return r ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
 static int kvm_s390_io_adapter_map(S390FLICState *fs, uint32_t id,
@@ -314,15 +297,13 @@ static int kvm_s390_io_adapter_map(S390FLICState *fs,=
 uint32_t id,
         .addr =3D (uint64_t)&req,
     };
     KVMS390FLICState *flic =3D s390_get_kvm_flic(fs);
-    int r;
=20
     if (!kvm_gsi_routing_enabled()) {
         /* nothing to do */
         return 0;
     }
=20
-    r =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
-    return r ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
 static int kvm_s390_add_adapter_routes(S390FLICState *fs,
@@ -519,7 +500,7 @@ static int kvm_flic_ais_post_load(void *opaque, int ver=
sion_id)
         return -ENOSYS;
     }
=20
-    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
 }
=20
 static const VMStateDescription kvm_s390_flic_ais_tmp =3D {
@@ -636,9 +617,9 @@ static void kvm_s390_flic_reset(DeviceState *dev)
         }
     }
=20
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    rc =3D kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (rc) {
-        trace_flic_reset_failed(errno);
+        trace_flic_reset_failed(-rc);
     }
=20
     flic_enable_pfault(flic);
--=20
2.24.1


