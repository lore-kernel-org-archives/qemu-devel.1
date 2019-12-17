Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC6C2D0C5
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D745221739
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjpEMzfp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D745221739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6QZ-00011u-BO
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:33:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6Jz-0000ko-6a
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Jx-00017t-MR
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31567
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jx-00015Y-FY
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HktqrVv0Tt2FKK/0WSo+4o3EvZ+0VSPvuEV+CM3+v8Q=;
 b=FjpEMzfpn5gogAW/o9J5fIKiSQqqgX5bA1DCubWyW1Y/4b1h29vrHTmGeRd6sue6yHTFAK
 IQpaX8jy5K+Hdw4AxbBr11pt13M2Eidg+ph1T0M3Urr+OzK4BYaKTAl5O7Ra098RxarMM9
 g4HBvV+a0Mxf9PiJvgf49OjHSMtzLz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-LNAD2S6kPjemrBZ5UN-o9A-1; Tue, 17 Dec 2019 01:26:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60796801E77;
 Tue, 17 Dec 2019 06:26:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31A095D9C9;
 Tue, 17 Dec 2019 06:26:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B18221136431; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 33/34] hw/vfio/ap: drop local_err from vfio_ap_realize
Date: Tue, 17 Dec 2019 07:26:50 +0100
Message-Id: <20191217062651.9687-34-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: LNAD2S6kPjemrBZ5UN-o9A-1
X-Mimecast-Spam-Score: 0
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

No reason for local_err here, use errp directly instead.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20191205174635.18758-21-vsementsov@virtuozzo.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/vfio/ap.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index da6a20669d..8fbaa724c2 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -89,14 +89,13 @@ static void vfio_ap_realize(DeviceState *dev, Error **e=
rrp)
 {
     int ret;
     char *mdevid;
-    Error *local_err =3D NULL;
     VFIOGroup *vfio_group;
     APDevice *apdev =3D AP_DEVICE(dev);
     VFIOAPDevice *vapdev =3D VFIO_AP_DEVICE(apdev);
=20
-    vfio_group =3D vfio_ap_get_group(vapdev, &local_err);
+    vfio_group =3D vfio_ap_get_group(vapdev, errp);
     if (!vfio_group) {
-        goto out_err;
+        return;
     }
=20
     vapdev->vdev.ops =3D &vfio_ap_ops;
@@ -113,7 +112,7 @@ static void vfio_ap_realize(DeviceState *dev, Error **e=
rrp)
      */
     vapdev->vdev.balloon_allowed =3D true;
=20
-    ret =3D vfio_get_device(vfio_group, mdevid, &vapdev->vdev, &local_err)=
;
+    ret =3D vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
     if (ret) {
         goto out_get_dev_err;
     }
@@ -123,8 +122,6 @@ static void vfio_ap_realize(DeviceState *dev, Error **e=
rrp)
 out_get_dev_err:
     vfio_ap_put_device(vapdev);
     vfio_put_group(vfio_group);
-out_err:
-    error_propagate(errp, local_err);
 }
=20
 static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
--=20
2.21.0


