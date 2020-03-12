Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5E4C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5935920663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2kSMlJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5935920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCQTZ-0003u6-Br
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1jCQSI-0001gK-OP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1jCQSH-0007n4-MD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:13:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1jCQSH-0007mt-HS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584029585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uwrs/CORLnGGhUdeF1wuS44JPM7elseCQ8oqDPJu/lU=;
 b=h2kSMlJHdhAjOCKGGyrIn4weBP+TZBuSfbpJfSFRryA6btetLeU+DDGLt944VdoOOFQU/+
 J7aRNqhErpLQetkUkIUF67Ma+YpXXaIddVXRo5diycQLGvTwdR+yip3Uu/Oo1CpxhhspWc
 Vls3DIATCeNrm1JHg9KFcwTLTGjJJto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-OVNBp4c8MMy9ejoGfHl9Vw-1; Thu, 12 Mar 2020 12:13:01 -0400
X-MC-Unique: OVNBp4c8MMy9ejoGfHl9Vw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC4CA18B9FC3;
 Thu, 12 Mar 2020 16:12:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-131.ams2.redhat.com [10.36.117.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 049CF5C1B5;
 Thu, 12 Mar 2020 16:12:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFCv2 1/4] openpic_kvm: Use kvm_device_ioctl() instead of
 ioctl()
Date: Thu, 12 Mar 2020 17:12:14 +0100
Message-Id: <20200312161217.3590-2-david@redhat.com>
In-Reply-To: <20200312161217.3590-1-david@redhat.com>
References: <20200312161217.3590-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's use the official variant, which will e.g., trace the call.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/intc/openpic_kvm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index e4bf47d885..a5aa0ce915 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -70,10 +70,10 @@ static void kvm_openpic_write(void *opaque, hwaddr addr=
, uint64_t val,
     attr.attr =3D addr;
     attr.addr =3D (uint64_t)(unsigned long)&val32;
=20
-    ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
+    ret =3D kvm_device_ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
         qemu_log_mask(LOG_UNIMP, "%s: %s %" PRIx64 "\n", __func__,
-                      strerror(errno), attr.attr);
+                      strerror(-ret), attr.attr);
     }
 }
=20
@@ -96,10 +96,10 @@ static uint64_t kvm_openpic_read(void *opaque, hwaddr a=
ddr, unsigned size)
     attr.attr =3D addr;
     attr.addr =3D (uint64_t)(unsigned long)&val;
=20
-    ret =3D ioctl(opp->fd, KVM_GET_DEVICE_ATTR, &attr);
+    ret =3D kvm_device_ioctl(opp->fd, KVM_GET_DEVICE_ATTR, &attr);
     if (ret < 0) {
         qemu_log_mask(LOG_UNIMP, "%s: %s %" PRIx64 "\n", __func__,
-                      strerror(errno), attr.attr);
+                      strerror(-ret), attr.attr);
         return 0;
     }
=20
@@ -145,10 +145,10 @@ static void kvm_openpic_region_add(MemoryListener *li=
stener,
     attr.attr =3D KVM_DEV_MPIC_BASE_ADDR;
     attr.addr =3D (uint64_t)(unsigned long)&reg_base;
=20
-    ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
+    ret =3D kvm_device_ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
         fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
-                strerror(errno), reg_base);
+                strerror(-ret), reg_base);
     }
 }
=20
@@ -179,10 +179,10 @@ static void kvm_openpic_region_del(MemoryListener *li=
stener,
     attr.attr =3D KVM_DEV_MPIC_BASE_ADDR;
     attr.addr =3D (uint64_t)(unsigned long)&reg_base;
=20
-    ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
+    ret =3D kvm_device_ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
         fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
-                strerror(errno), reg_base);
+                strerror(-ret), reg_base);
     }
 }
=20
--=20
2.24.1


