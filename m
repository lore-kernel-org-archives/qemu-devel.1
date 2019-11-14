Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620CEC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD29206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJLhVasd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD29206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVFxZ-0007Im-KC
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 09:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iVFvE-0005u6-W2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iVFvA-0005kt-5Y
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:16:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48857
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iVFv6-0005dk-9q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 09:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573740982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Euag/sJfImZxY9Zxjc7u6UHKw9IIkmbQtq4GVyiwVKU=;
 b=gJLhVasdw/giSQZ05c4ajZeSHJUbkDNgM3JbkSnbfuyXzW9mMV03lQ80miowfJcHhWd8Sa
 y2Zv0ebcmbaGVp3oASipO9RhtiZxaE64wyrS/JwhrrahAEIcBF7fyUj/2+gxQhLOLArfRR
 VA+ylvQbodT+DEEXeCpH1TwPORhc7e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-abjYyRmBPuW4zpNw08Un_w-1; Thu, 14 Nov 2019 09:16:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8757E1802CED;
 Thu, 14 Nov 2019 14:16:18 +0000 (UTC)
Received: from localhost (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 874806B8E8;
 Thu, 14 Nov 2019 14:16:15 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] net/virtio: fix dev_unplug_pending
Date: Thu, 14 Nov 2019 15:16:10 +0100
Message-Id: <20191114141613.15804-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: abjYyRmBPuW4zpNw08Un_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, dgilbert@redhat.com,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

.dev_unplug_pending is set up by virtio-net code indepent of whether
failover=3Don was set for the device or not. This gives a wrong result when
we check for existing primary devices in migration code.

Fix this by actually calling dev_unplug_pending() instead of just
checking if the function pointer was set. When the feature was not
negotiated dev_unplug_pending() will always return false. This prevents
us from going into the wait-unplug state when there's no primary device
present.

Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
Signed-off-by: Jens Freimann <jfreimann@redhat.com>
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/virtio-net.c | 3 +++
 migration/savevm.c  | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 97a5113f7e..946039c0dc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3124,6 +3124,9 @@ static bool primary_unplug_pending(void *opaque)
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VirtIONet *n =3D VIRTIO_NET(vdev);
=20
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
+        return false;
+    }
     return n->primary_dev ? n->primary_dev->pending_deleted_event : false;
 }
=20
diff --git a/migration/savevm.c b/migration/savevm.c
index 966a9c3bdb..a71b930b91 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1119,7 +1119,8 @@ int qemu_savevm_nr_failover_devices(void)
     int n =3D 0;
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (se->vmsd && se->vmsd->dev_unplug_pending) {
+        if (se->vmsd && se->vmsd->dev_unplug_pending &&
+            se->vmsd->dev_unplug_pending(se->opaque)) {
             n++;
         }
     }
--=20
2.21.0


