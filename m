Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076D320659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PF8Ht7Jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076D320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhKP-0002iu-R6
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38161)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNghb-0002n0-Ai
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNgha-00028c-Ar
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:15:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49957
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNgha-000281-7f
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571937309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0L0Zrn9b9ULLnzAL4jTEe+6gz0IPI+nkF7oR4+uyGRg=;
 b=PF8Ht7JyP/NkWxm4dU5hBrPQclLlT0ySMHEMCWyat6Lf3f/lUqUZShnOIL4UjWxqSnYnMO
 HjsfGNtLg5HwZRI+Eog1nitiExPdossrtNU4+y++FefMOhPCquZorN5t3HwOgXU7E1sW+q
 Y+itUFEuLR4oXXlnKSaCJD2s7D72SVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-V-IW6TI8MzqGLkC5lfYHWg-1; Thu, 24 Oct 2019 13:15:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31B96107AD31;
 Thu, 24 Oct 2019 17:15:05 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-116-206.ams2.redhat.com
 [10.36.116.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F0895D70E;
 Thu, 24 Oct 2019 17:14:59 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 9/9] virtio: Move vdev->broken check to dispatch drop_all
Date: Thu, 24 Oct 2019 19:14:06 +0200
Message-Id: <20191024171406.12504-10-eperezma@redhat.com>
In-Reply-To: <20191024171406.12504-1-eperezma@redhat.com>
References: <20191024171406.12504-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: V-IW6TI8MzqGLkC5lfYHWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Previous commits did the same with others virtqueue_ functions, but this
check was repeated in the split and the packed version.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 hw/virtio/virtio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9195b08da8..828c27de1f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1631,10 +1631,6 @@ static unsigned int virtqueue_packed_drop_all(VirtQu=
eue *vq)
     VirtIODevice *vdev =3D vq->vdev;
     VRingPackedDesc desc;
=20
-    if (unlikely(vdev->broken)) {
-        return 0;
-    }
-
     caches =3D vring_get_region_caches(vq);
     desc_cache =3D &caches->desc;
=20
@@ -1680,10 +1676,6 @@ static unsigned int virtqueue_split_drop_all(VirtQue=
ue *vq)
     VirtIODevice *vdev =3D vq->vdev;
     bool fEventIdx =3D virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_I=
DX);
=20
-    if (unlikely(vdev->broken)) {
-        return 0;
-    }
-
     while (!virtio_queue_empty(vq) && vq->inuse < vq->vring.num) {
         /* works similar to virtqueue_pop but does not map buffers
         * and does not allocate any memory */
@@ -1715,6 +1707,10 @@ unsigned int virtqueue_drop_all(VirtQueue *vq)
 {
     struct VirtIODevice *vdev =3D vq->vdev;
=20
+    if (unlikely(vdev->broken)) {
+        return 0;
+    }
+
     if (virtio_vdev_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
         return virtqueue_packed_drop_all(vq);
     } else {
--=20
2.16.5


