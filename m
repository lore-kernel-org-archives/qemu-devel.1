Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39809C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0506A2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mty5E7js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0506A2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sfB-0005JO-5Z
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6seF-0003n2-CT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6seE-0007HJ-7U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6seE-0007G2-3d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582707988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbXYhzT4HdCqyN2iskP5pyuuGP3IhftOdhWxCQdQeVU=;
 b=Mty5E7jsezx9Qoioh5FaLRamRsmopJBSRnppwWsB+c0pRlivEKLf4QJUL5phu3Vtl8SjiQ
 dsSXwnz50+m5Y6zf0TX+H/PFKGdbbSRiACpVtSf4Z21qMojUu25kAZ8uSR9Dg+zCRLY0mk
 gtxhH7lhAEYCjT0NaW4UoBfx12Mzfx8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-ZfL5YEJ_PsemrgidgqvaCg-1; Wed, 26 Feb 2020 04:06:24 -0500
X-MC-Unique: ZfL5YEJ_PsemrgidgqvaCg-1
Received: by mail-wr1-f71.google.com with SMTP id c6so1169153wrm.18
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XWpi8uIuYqDgAxSrNx/dNPfjKOUMUQTkfVlQ2qW7D7Y=;
 b=mL5rwwKAHBqtsdNhl9YgIK2iLiATXKUIdrHG9SMC97ij22+S9Y2bC2nfP5KVSonGux
 IBVIsYHH+yvHXkDm+ZYVY0KuiSC68sIbgnuwaZUWUWD3HnCI8TWJXZxJ+YIgVGk8g+O8
 52ZY4NrzSQ7BKBCGYwe7GACPIdcucobkNJZkQd6nUaBDIHfyuBnVDkZazx2Kcc0UoD8T
 iNseYEq6wzYG3IHpOP0HYzxP3kWs7Mz5+QCq0YGFVhHbWRyLNX08UpALJaiKFQ/x8Hev
 pJlZ8mvPWMwhJcXsA/s8EYgCEjNyBrP417wgK5L1Y5n/TsInS6qla30gzRiXBiy1hFxW
 pqJA==
X-Gm-Message-State: APjAAAVtcR8bhKRqlG0Nw09DrkP6jtKXlcLY1wLqAkbBXcbTULtXprFD
 PU83JZuqyvOrUapNIRO+UvjT9hDsGR0Mx6T9AaHH5ZVh0gMObad9UnWgu3ZRX2HMgOKIDmY85lf
 6kalEAagvjCnMK80=
X-Received: by 2002:adf:828b:: with SMTP id 11mr4209487wrc.169.1582707982923; 
 Wed, 26 Feb 2020 01:06:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9UDAAt2NKHeg9NW+T60H86ud/ZSFSS39fV1U0WLb36bbjn6h8RuH0+/pNqEnmW4siIbn6DA==
X-Received: by 2002:adf:828b:: with SMTP id 11mr4209456wrc.169.1582707982679; 
 Wed, 26 Feb 2020 01:06:22 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 x10sm2217372wrv.60.2020.02.26.01.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:06:22 -0800 (PST)
Date: Wed, 26 Feb 2020 04:06:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/30] vhost-user-blk: convert to new virtio_delete_queue
Message-ID: <20200226090010.708934-11-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Pan Nengyuan <pannengyuan@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

use the new virtio_delete_queue function to cleanup.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200224041336.30790-3-pannengyuan@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-user-blk.h |  3 ++-
 hw/block/vhost-user-blk.c          | 19 +++++++++++--------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/vhost-user-blk.h b/include/hw/virtio/vhost-u=
ser-blk.h
index 108bfadeeb..05ea0ad183 100644
--- a/include/hw/virtio/vhost-user-blk.h
+++ b/include/hw/virtio/vhost-user-blk.h
@@ -36,7 +36,8 @@ typedef struct VHostUserBlk {
     struct vhost_dev dev;
     struct vhost_inflight *inflight;
     VhostUserState vhost_user;
-    struct vhost_virtqueue *vqs;
+    struct vhost_virtqueue *vhost_vqs;
+    VirtQueue **virtqs;
     guint watch;
     bool connected;
 } VHostUserBlk;
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2eba8b9db0..12925a47ec 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -306,7 +306,7 @@ static int vhost_user_blk_connect(DeviceState *dev)
     s->connected =3D true;
=20
     s->dev.nvqs =3D s->num_queues;
-    s->dev.vqs =3D s->vqs;
+    s->dev.vqs =3D s->vhost_vqs;
     s->dev.vq_index =3D 0;
     s->dev.backend_features =3D 0;
=20
@@ -420,13 +420,14 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
     virtio_init(vdev, "virtio-blk", VIRTIO_ID_BLOCK,
                 sizeof(struct virtio_blk_config));
=20
+    s->virtqs =3D g_new(VirtQueue *, s->num_queues);
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_add_queue(vdev, s->queue_size,
-                         vhost_user_blk_handle_output);
+        s->virtqs[i] =3D virtio_add_queue(vdev, s->queue_size,
+                                        vhost_user_blk_handle_output);
     }
=20
     s->inflight =3D g_new0(struct vhost_inflight, 1);
-    s->vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
+    s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
     s->watch =3D 0;
     s->connected =3D false;
=20
@@ -458,11 +459,12 @@ reconnect:
     return;
=20
 virtio_err:
-    g_free(s->vqs);
+    g_free(s->vhost_vqs);
     g_free(s->inflight);
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(s->virtqs[i]);
     }
+    g_free(s->virtqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
@@ -478,12 +480,13 @@ static void vhost_user_blk_device_unrealize(DeviceSta=
te *dev, Error **errp)
                              NULL, NULL, NULL, false);
     vhost_dev_cleanup(&s->dev);
     vhost_dev_free_inflight(s->inflight);
-    g_free(s->vqs);
+    g_free(s->vhost_vqs);
     g_free(s->inflight);
=20
     for (i =3D 0; i < s->num_queues; i++) {
-        virtio_del_queue(vdev, i);
+        virtio_delete_queue(s->virtqs[i]);
     }
+    g_free(s->virtqs);
     virtio_cleanup(vdev);
     vhost_user_cleanup(&s->vhost_user);
 }
--=20
MST


