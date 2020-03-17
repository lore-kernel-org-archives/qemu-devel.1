Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D775C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092CD20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 16:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRgUPiUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092CD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEFGR-0004Gl-4N
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 12:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEFA6-0006q2-Ku
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEFA5-0004il-2a
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:50 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43077)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEFA4-0004dF-TJ
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 12:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584462828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wqB72yCY1p7yCeZkg0uizrFc4d/XuUya1TSV3J9ObRM=;
 b=DRgUPiUwQvbX6et7whYnM1UwZNhrBkUiq40KY3U+IsJgB9GpBITVjibtH8Q8C1F8fFcDal
 6l5wUEKqOBrgJ8ktNR4Nm+8X3RdDDJVnEJg65jJTb1dp4ZrsQIstK6NaCTVo+5KGId9rvH
 ZucsfWI8gl9+tOFCvkY32vJzVetKtF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-RZ1_-SaDO0C8Q-2_uGCGfg-1; Tue, 17 Mar 2020 12:33:46 -0400
X-MC-Unique: RZ1_-SaDO0C8Q-2_uGCGfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59B30800D5B;
 Tue, 17 Mar 2020 16:33:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27ADC9080A;
 Tue, 17 Mar 2020 16:33:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA3CB11366CF; Tue, 17 Mar 2020 17:33:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] xen-block: Use one Error * variable instead of two
Date: Tue, 17 Mar 2020 17:33:42 +0100
Message-Id: <20200317163343.25028-4-armbru@redhat.com>
In-Reply-To: <20200317163343.25028-1-armbru@redhat.com>
References: <20200317163343.25028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While there, tidy up indentation, and add return just for consistency
and robustness.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200313170517.22480-4-armbru@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 hw/block/xen-block.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 3885464513..07bb32e22b 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -998,29 +998,27 @@ static void xen_block_device_destroy(XenBackendInstan=
ce *backend,
     XenBlockVdev *vdev =3D &blockdev->props.vdev;
     XenBlockDrive *drive =3D blockdev->drive;
     XenBlockIOThread *iothread =3D blockdev->iothread;
+    Error *local_err =3D NULL;
=20
     trace_xen_block_device_destroy(vdev->number);
=20
     object_unparent(OBJECT(xendev));
=20
     if (iothread) {
-        Error *local_err =3D NULL;
-
         xen_block_iothread_destroy(iothread, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err,
-                                "failed to destroy iothread: ");
+                                    "failed to destroy iothread: ");
             return;
         }
     }
=20
     if (drive) {
-        Error *local_err =3D NULL;
-
         xen_block_drive_destroy(drive, &local_err);
         if (local_err) {
             error_propagate_prepend(errp, local_err,
-                                "failed to destroy drive: ");
+                                    "failed to destroy drive: ");
+            return;
         }
     }
 }
--=20
2.21.1


