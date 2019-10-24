Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55754CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:12:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21262205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 18:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJrgUyqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21262205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNhbC-0007fQ-SN
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 14:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eperezma@redhat.com>) id 1iNgh2-0002Dt-Qz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eperezma@redhat.com>) id 1iNgh1-0001rW-IR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59389
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eperezma@redhat.com>) id 1iNgh1-0001qI-Bp
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 13:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571937274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8SAWqFkouDm5WPRgDXUpw1GrKkX+a6ubFyYkDAlOQY=;
 b=HJrgUyqq99s4MEuk1NBsYzgrNH7AdGpxw4ns+CS2V/uOfE8LTgHF3QvDUGElevY4rFMCuL
 RDbGSJgfVU76jKaYQfkFhWwSBeCJUBKKiMzTiCN+6LXg6VcQ67JBNsORFKeh1AH1V2knXZ
 UI/wb8nc2rqxAfM4Z9AszatQcxMKkG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-A_2ltWQOMtKOyVCJ5XRL0A-1; Thu, 24 Oct 2019 13:14:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D114100550E;
 Thu, 24 Oct 2019 17:14:30 +0000 (UTC)
Received: from eperezma.remote.csb (ovpn-116-206.ams2.redhat.com
 [10.36.116.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A853F5EE1D;
 Thu, 24 Oct 2019 17:14:27 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/9] virtio: Free rng and blk virqueues
Date: Thu, 24 Oct 2019 19:14:00 +0200
Message-Id: <20191024171406.12504-4-eperezma@redhat.com>
In-Reply-To: <20191024171406.12504-1-eperezma@redhat.com>
References: <20191024171406.12504-1-eperezma@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: A_2ltWQOMtKOyVCJ5XRL0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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

The function virtio_del_queue was not called at these devices
unrealize() callbacks.

This was detected due to add an allocated element on the next commit
(used_elems) and running address sanitizer memory leak detector.

Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
---
 hw/block/virtio-blk.c  | 5 +++++
 hw/virtio/virtio-rng.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ed2ddebd2b..ba846fe9dc 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1206,9 +1206,14 @@ static void virtio_blk_device_unrealize(DeviceState =
*dev, Error **errp)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIOBlock *s =3D VIRTIO_BLK(dev);
+    VirtIOBlkConf *conf =3D &s->conf;
+    unsigned i;
=20
     virtio_blk_data_plane_destroy(s->dataplane);
     s->dataplane =3D NULL;
+    for (i =3D 0; i < conf->num_queues; i++) {
+        virtio_del_queue(vdev, i);
+    }
     qemu_del_vm_change_state_handler(s->change);
     blockdev_mark_auto_del(s->blk);
     virtio_cleanup(vdev);
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index e93bed020f..b498a20332 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -238,6 +238,7 @@ static void virtio_rng_device_unrealize(DeviceState *de=
v, Error **errp)
     qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_del(vrng->rate_limit_timer);
     timer_free(vrng->rate_limit_timer);
+    virtio_del_queue(vdev, 0);
     virtio_cleanup(vdev);
 }
=20
--=20
2.16.5


