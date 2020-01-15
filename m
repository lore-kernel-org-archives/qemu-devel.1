Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CC3C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C1202465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTHYIjjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1202465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrNs-0006t0-On
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1irrLO-0003T0-SS
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1irrLN-0002R8-Sg
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:40:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1irrLN-0002K3-PQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 17:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579128054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9yw6/LNnvDWadt4xul8KRf2PtWuDEuatVXr8ZmJnkk=;
 b=hTHYIjjw5wC7v62pFRPTKE/mLPsmyM3ASUwK6zD47JJY4bDQUSYw2+kmWWr9KnvPBKaRs7
 uVCfgZvCgNPe/vgmEOnMVOR7N13+XRxfHnJ4GLeSqIgCmVA0pOe+QahRl4WcmNpTHz10Mt
 w88mnmJKVkOtKF8PnqFS0Ta+7NyuU8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-ulfZk2JMPSeVumHLOZQH6Q-1; Wed, 15 Jan 2020 17:40:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CBD7800D41
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 22:40:52 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-204-94.brq.redhat.com
 [10.40.204.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD63182062;
 Wed, 15 Jan 2020 22:40:48 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] virtio-balloon: Reject qmp_balloon during hot-unplug
Date: Wed, 15 Jan 2020 23:40:25 +0100
Message-Id: <20200115224025.538368-3-jusual@redhat.com>
In-Reply-To: <20200115224025.538368-1-jusual@redhat.com>
References: <20200115224025.538368-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ulfZk2JMPSeVumHLOZQH6Q-1
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hot-unplug takes some time due to communication with the guest.
Do not change the device while freeing up resources.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 balloon.c                  | 2 +-
 hw/virtio/virtio-balloon.c | 9 ++++++++-
 include/sysemu/balloon.h   | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/balloon.c b/balloon.c
index f104b42961..998ec53a0f 100644
--- a/balloon.c
+++ b/balloon.c
@@ -119,5 +119,5 @@ void qmp_balloon(int64_t target, Error **errp)
     }
=20
     trace_balloon_event(balloon_opaque, target);
-    balloon_event_fn(balloon_opaque, target);
+    balloon_event_fn(balloon_opaque, target, errp);
 }
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 57f3b9f22d..0fa4e4454b 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -717,12 +717,19 @@ static void virtio_balloon_stat(void *opaque, Balloon=
Info *info)
                                              VIRTIO_BALLOON_PFN_SHIFT);
 }
=20
-static void virtio_balloon_to_target(void *opaque, ram_addr_t target)
+static void virtio_balloon_to_target(void *opaque, ram_addr_t target,
+                                     Error **errp)
 {
+    DeviceState *bus_dev =3D qdev_get_bus_device(DEVICE(opaque));
     VirtIOBalloon *dev =3D VIRTIO_BALLOON(opaque);
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     ram_addr_t vm_ram_size =3D get_current_ram_size();
=20
+    if (bus_dev && bus_dev->pending_deleted_event) {
+        error_setg(errp, "Hot-unplug of %s is in progress", vdev->name);
+        return;
+    }
+
     if (target > vm_ram_size) {
         target =3D vm_ram_size;
     }
diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
index aea0c44985..b3a09ca946 100644
--- a/include/sysemu/balloon.h
+++ b/include/sysemu/balloon.h
@@ -17,7 +17,7 @@
 #include "exec/cpu-common.h"
 #include "qapi/qapi-types-misc.h"
=20
-typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
+typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target, Error **e=
rrp);
 typedef void (QEMUBalloonStatus)(void *opaque, BalloonInfo *info);
=20
 int qemu_add_balloon_handler(QEMUBalloonEvent *event_func,
--=20
2.24.1


