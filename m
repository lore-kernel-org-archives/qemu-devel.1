Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CF2C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292A62083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hf6Hk6Fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292A62083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j98QZ-0004Ll-Av
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j98PK-0001kY-Ks
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j98PJ-0006Fq-DB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26691
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j98PJ-0006Fh-8v
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583245224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SN3TdLXEozv3aKuWj82IQWSxiC0o/xgTHn+zkTgCfoM=;
 b=hf6Hk6FwuJwP7+Cm+inFsoxocVGyBrLXhBFLcUXjkOrkcQWz6BohMRf9oBO0LYS06Ux+4e
 BCyP6F6xjilTNHjuOwc3UoXNNbP/UfRFBUmxQcd1QvrKJJiKWcnj2RFuoIjJzBmMDakFJ4
 xiQc3wTjqLzqDmpvGeud1tZGS33RuXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-c2ddP0TsMqSVcnmgBBntAg-1; Tue, 03 Mar 2020 09:20:22 -0500
X-MC-Unique: c2ddP0TsMqSVcnmgBBntAg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FFF18017CC;
 Tue,  3 Mar 2020 14:20:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-113.ams2.redhat.com [10.36.117.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 697B261069;
 Tue,  3 Mar 2020 14:20:02 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 1/4] openpic_kvm: Use kvm_device_ioctl() instead of ioctl()
Date: Tue,  3 Mar 2020 15:19:36 +0100
Message-Id: <20200303141939.352319-2-david@redhat.com>
In-Reply-To: <20200303141939.352319-1-david@redhat.com>
References: <20200303141939.352319-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
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
 hw/intc/openpic_kvm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index e4bf47d885..0d8abc1604 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -70,7 +70,7 @@ static void kvm_openpic_write(void *opaque, hwaddr addr, =
uint64_t val,
     attr.attr =3D addr;
     attr.addr =3D (uint64_t)(unsigned long)&val32;
=20
-    ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
+    ret =3D kvm_device_ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
         qemu_log_mask(LOG_UNIMP, "%s: %s %" PRIx64 "\n", __func__,
                       strerror(errno), attr.attr);
@@ -96,7 +96,7 @@ static uint64_t kvm_openpic_read(void *opaque, hwaddr add=
r, unsigned size)
     attr.attr =3D addr;
     attr.addr =3D (uint64_t)(unsigned long)&val;
=20
-    ret =3D ioctl(opp->fd, KVM_GET_DEVICE_ATTR, &attr);
+    ret =3D kvm_device_ioctl(opp->fd, KVM_GET_DEVICE_ATTR, &attr);
     if (ret < 0) {
         qemu_log_mask(LOG_UNIMP, "%s: %s %" PRIx64 "\n", __func__,
                       strerror(errno), attr.attr);
@@ -145,7 +145,7 @@ static void kvm_openpic_region_add(MemoryListener *list=
ener,
     attr.attr =3D KVM_DEV_MPIC_BASE_ADDR;
     attr.addr =3D (uint64_t)(unsigned long)&reg_base;
=20
-    ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
+    ret =3D kvm_device_ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
         fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
                 strerror(errno), reg_base);
@@ -179,7 +179,7 @@ static void kvm_openpic_region_del(MemoryListener *list=
ener,
     attr.attr =3D KVM_DEV_MPIC_BASE_ADDR;
     attr.addr =3D (uint64_t)(unsigned long)&reg_base;
=20
-    ret =3D ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
+    ret =3D kvm_device_ioctl(opp->fd, KVM_SET_DEVICE_ATTR, &attr);
     if (ret < 0) {
         fprintf(stderr, "%s: %s %" PRIx64 "\n", __func__,
                 strerror(errno), reg_base);
--=20
2.24.1


