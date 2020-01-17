Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB71C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D3A20730
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7hRgtTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D3A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPZH-0005Av-Ap
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60874)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1isPXg-0003qv-Nz
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:11:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1isPXd-000681-LC
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:11:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32520
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1isPXd-00066r-He
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579259513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DQoeUs8RjX3SvhRvCAQ+pSnjH1DKZnNp7o9RSzUgDyA=;
 b=G7hRgtTK5y2pIWelMWljjMDFkgjELTJ4V/TyY2lQjM+Y8zm0Vfr21e2N67BJvbsLF+0Ve3
 oVs0cAyL2v747OdlbKIHEnm/pZxE/3SkN64LW9kdQC2ADoq5EFlqSmOMT0hTuEKkfij2iC
 XGXUUGsH87kpdRndWe7z2cN0xyIEs28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-dCR3BLhDP2q2wwLUV06e6w-1; Fri, 17 Jan 2020 06:11:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D028C1005516;
 Fri, 17 Jan 2020 11:11:50 +0000 (UTC)
Received: from localhost (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6287F845B2;
 Fri, 17 Jan 2020 11:11:50 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] s390x: adapter routes error handling
Date: Fri, 17 Jan 2020 12:11:47 +0100
Message-Id: <20200117111147.5006-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: dCR3BLhDP2q2wwLUV06e6w-1
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
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the kernel irqchip has been disabled, we don't want the
{add,release}_adapter_routes routines to call any kvm_irqchip_*
interfaces, as they may rely on an irqchip actually having been
created. Just take a quick exit in that case instead.

Also initialize routes->gsi[] with -1 in the virtio-ccw handling,
to make sure we don't trip over other errors, either. (Nobody
else uses the gsi array in that structure.)

Fixes: d426d9fba8ea ("s390x/virtio-ccw: wire up irq routing and irqfds")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

v1->v2:
  - also initialize the gsi array with -1

---
 hw/intc/s390_flic_kvm.c | 8 ++++++++
 hw/s390x/virtio-ccw.c   | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index dddd33ea61c8..44b7960ebcc8 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -331,6 +331,10 @@ static int kvm_s390_add_adapter_routes(S390FLICState *=
fs,
     int ret, i;
     uint64_t ind_offset =3D routes->adapter.ind_offset;
=20
+    if (!kvm_gsi_routing_enabled()) {
+        return -ENOSYS;
+    }
+
     for (i =3D 0; i < routes->num_routes; i++) {
         ret =3D kvm_irqchip_add_adapter_route(kvm_state, &routes->adapter)=
;
         if (ret < 0) {
@@ -358,6 +362,10 @@ static void kvm_s390_release_adapter_routes(S390FLICSt=
ate *fs,
 {
     int i;
=20
+    if (!kvm_gsi_routing_enabled()) {
+        return;
+    }
+
     for (i =3D 0; i < routes->num_routes; i++) {
         if (routes->gsi[i] >=3D 0) {
             kvm_irqchip_release_virq(kvm_state, routes->gsi[i]);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 6580ce5907dd..13f57e7b67f1 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -697,6 +697,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *=
dev, Error **errp)
     CCWDeviceClass *ck =3D CCW_DEVICE_GET_CLASS(ccw_dev);
     SubchDev *sch;
     Error *err =3D NULL;
+    int i;
=20
     sch =3D css_create_sch(ccw_dev->devno, errp);
     if (!sch) {
@@ -717,6 +718,9 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *=
dev, Error **errp)
     ccw_dev->sch =3D sch;
     dev->indicators =3D NULL;
     dev->revision =3D -1;
+    for (i =3D 0; i < ADAPTER_ROUTES_MAX_GSI; i++) {
+        dev->routes.gsi[i] =3D -1;
+    }
     css_sch_build_virtual_schib(sch, 0, VIRTIO_CCW_CHPID_TYPE);
=20
     trace_virtio_ccw_new_device(
--=20
2.21.1


