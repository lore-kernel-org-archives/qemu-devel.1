Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FE0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2778205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRorIbYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2778205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhXt-0002NB-Bd
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNgh1-0002D1-DB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNggz-0001p2-Ru
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28021
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNggy-0001lg-U1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571937272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4PjgDwYwVllCjJyAa4O4jV5g3gFoiQ2rK589sd19L8=;
 b=MRorIbYXiZEvIIiGFbCi2FZpN7mu/4EVpu6nH1kLU/VBDgxRcKbe492nWI5cnDJsl6KC4u
 Z7d+Z+hVf1t+jMnEmaWNBIuKCVn0uvP9Qd/C7O45XZrAnYvffW7cuVXYylbWYXa28Q/R7C
 v6T+pwJkociB3U47jopmEHi5NN4HRd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-d9WzHKqiNyCoPTorYWETTQ-1; Thu, 24 Oct 2019 13:14:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5069D107AD31;
 Thu, 24 Oct 2019 17:14:27 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-116-206.ams2.redhat.com
 [10.36.116.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A65C5B681;
 Thu, 24 Oct 2019 17:14:24 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 2/9] virtio: device/driver area size calculation refactor
 for split ring
Date: Thu, 24 Oct 2019 19:13:59 +0200
Message-Id: <20191024171406.12504-3-eperezma@redhat.com>
In-Reply-To: <20191024171406.12504-1-eperezma@redhat.com>
References: <20191024171406.12504-1-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: d9WzHKqiNyCoPTorYWETTQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Xu <wexu@redhat.com>

There is slight size difference between split/packed rings.

This is the refactor of split ring as well as a helper to expanding
device and driver area size calculation for packed ring.

Signed-off-by: Wei Xu <wexu@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Jens Freimann <jfreimann@redhat.com>
---
 hw/virtio/virtio.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fdac203cdf..74cc10fad9 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -159,10 +159,8 @@ static void virtio_init_region_cache(VirtIODevice *vde=
v, int n)
     VRingMemoryRegionCaches *old =3D vq->vring.caches;
     VRingMemoryRegionCaches *new =3D NULL;
     hwaddr addr, size;
-    int event_size;
     int64_t len;
=20
-    event_size =3D virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_I=
DX) ? 2 : 0;
=20
     addr =3D vq->vring.desc;
     if (!addr) {
@@ -177,7 +175,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev=
, int n)
         goto err_desc;
     }
=20
-    size =3D virtio_queue_get_used_size(vdev, n) + event_size;
+    size =3D virtio_queue_get_used_size(vdev, n);
     len =3D address_space_cache_init(&new->used, vdev->dma_as,
                                    vq->vring.used, size, true);
     if (len < size) {
@@ -185,7 +183,7 @@ static void virtio_init_region_cache(VirtIODevice *vdev=
, int n)
         goto err_used;
     }
=20
-    size =3D virtio_queue_get_avail_size(vdev, n) + event_size;
+    size =3D virtio_queue_get_avail_size(vdev, n);
     len =3D address_space_cache_init(&new->avail, vdev->dma_as,
                                    vq->vring.avail, size, false);
     if (len < size) {
@@ -2414,14 +2412,20 @@ hwaddr virtio_queue_get_desc_size(VirtIODevice *vde=
v, int n)
=20
 hwaddr virtio_queue_get_avail_size(VirtIODevice *vdev, int n)
 {
+    int s;
+
+    s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
     return offsetof(VRingAvail, ring) +
-        sizeof(uint16_t) * vdev->vq[n].vring.num;
+        sizeof(uint16_t) * vdev->vq[n].vring.num + s;
 }
=20
 hwaddr virtio_queue_get_used_size(VirtIODevice *vdev, int n)
 {
+    int s;
+
+    s =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
     return offsetof(VRingUsed, ring) +
-        sizeof(VRingUsedElem) * vdev->vq[n].vring.num;
+        sizeof(VRingUsedElem) * vdev->vq[n].vring.num + s;
 }
=20
 uint16_t virtio_queue_get_last_avail_idx(VirtIODevice *vdev, int n)
--=20
2.16.5


