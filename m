Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BACC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF63220848
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDaMf8w5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF63220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j98QJ-0003dV-T1
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j98PM-0001nf-M9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j98PL-0006GQ-9d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43925
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j98PL-0006GE-55
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583245226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/E9HgzB+lV/cMtbYS5Hbxyo5pA+Tb9UQGfmWLIzQvI=;
 b=GDaMf8w5Ta9IvAfCWNHRkzBZoGasf1HoF7OaeMNHnarbmhnCJK4ZhUqBbgd11lJaYpNLLr
 5YdKmbbXqSr92FyT7FALJ0QazQH51QBvj9oJWa26yZnSBfh8KrHkqAa9HqTlcJfG6EnjG1
 t/36Wh+bFQrk2yLCB/8oxfcX9uKR314=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-fbGEd60YOI2Icpw3GjgHqg-1; Tue, 03 Mar 2020 09:20:25 -0500
X-MC-Unique: fbGEd60YOI2Icpw3GjgHqg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 043A6801E76;
 Tue,  3 Mar 2020 14:20:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-113.ams2.redhat.com [10.36.117.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF4C60FC1;
 Tue,  3 Mar 2020 14:20:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 2/4] intc/s390_flic_kvm.c: Use kvm_device_ioctl() instead
 of ioctl()
Date: Tue,  3 Mar 2020 15:19:37 +0100
Message-Id: <20200303141939.352319-3-david@redhat.com>
In-Reply-To: <20200303141939.352319-1-david@redhat.com>
References: <20200303141939.352319-1-david@redhat.com>
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

Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/s390_flic_kvm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index a306b26faa..5151582ba0 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -68,7 +68,7 @@ static int flic_get_all_irqs(KVMS390FLICState *flic,
     };
     int rc;
=20
-    rc =3D ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr);
+    rc =3D kvm_device_ioctl(flic->fd, KVM_GET_DEVICE_ATTR, &attr);
=20
     return rc =3D=3D -1 ? -errno : rc;
 }
@@ -80,7 +80,7 @@ static void flic_enable_pfault(KVMS390FLICState *flic)
     };
     int rc;
=20
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    rc =3D kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
     if (rc) {
         fprintf(stderr, "flic: couldn't enable pfault\n");
@@ -94,7 +94,7 @@ static void flic_disable_wait_pfault(KVMS390FLICState *fl=
ic)
     };
     int rc;
=20
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    rc =3D kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
     if (rc) {
         fprintf(stderr, "flic: couldn't disable pfault\n");
@@ -118,7 +118,7 @@ static int flic_enqueue_irqs(void *buf, uint64_t len,
         .attr =3D len,
     };
=20
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    rc =3D kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
     return rc ? -errno : 0;
 }
@@ -197,7 +197,7 @@ static int kvm_s390_clear_io_flic(S390FLICState *fs, ui=
nt16_t subchannel_id,
     if (unlikely(!flic->clear_io_supported)) {
         return -ENOSYS;
     }
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    rc =3D kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
     return rc ? -errno : 0;
 }
=20
@@ -218,7 +218,7 @@ static int kvm_s390_modify_ais_mode(S390FLICState *fs, =
uint8_t isc,
         return -ENOSYS;
     }
=20
-    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno=
 : 0;
 }
=20
 static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
@@ -235,7 +235,7 @@ static int kvm_s390_inject_airq(S390FLICState *fs, uint=
8_t type,
         return -ENOSYS;
     }
=20
-    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno=
 : 0;
 }
=20
 /**
@@ -296,7 +296,7 @@ static int kvm_s390_register_io_adapter(S390FLICState *=
fs, uint32_t id,
         return 0;
     }
=20
-    r =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    r =3D kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
=20
     return r ? -errno : 0;
 }
@@ -321,7 +321,7 @@ static int kvm_s390_io_adapter_map(S390FLICState *fs, u=
int32_t id,
         return 0;
     }
=20
-    r =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    r =3D kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
     return r ? -errno : 0;
 }
=20
@@ -519,7 +519,7 @@ static int kvm_flic_ais_post_load(void *opaque, int ver=
sion_id)
         return -ENOSYS;
     }
=20
-    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
+    return kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno=
 : 0;
 }
=20
 static const VMStateDescription kvm_s390_flic_ais_tmp =3D {
@@ -636,7 +636,7 @@ static void kvm_s390_flic_reset(DeviceState *dev)
         }
     }
=20
-    rc =3D ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
+    rc =3D kvm_device_ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (rc) {
         trace_flic_reset_failed(errno);
     }
--=20
2.24.1


