Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47AAC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A017B21739
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OdMRp9WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A017B21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih6QY-0000zB-2h
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:33:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1ih6Jz-0000ky-9m
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1ih6Jx-000159-4I
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ih6Jw-000116-Vy
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576564020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOHQCVeENLcAhPhpCRlU0/QTK4zJGsVHmFYfM/orI7Q=;
 b=OdMRp9WNZTWiqcS7/k74ToUCwlOaGB868SbCN5DI5LRgLoVEixgSgsuHoVNC3m6Wjrt5VU
 3N5a4VDLNvXK41uQw3AQTENamX+Kt/Kcgl4p1Uhe1BhyOxR/BE9ELpVysfMye6PQ/KZXPt
 nRJmfOYCAK8295xy6f7R8WeREPDZQtg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-3k06VOaWM_Kayad0Fg5_9w-1; Tue, 17 Dec 2019 01:26:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49939801E66;
 Tue, 17 Dec 2019 06:26:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CB5B5D9E5;
 Tue, 17 Dec 2019 06:26:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82EB91136423; Tue, 17 Dec 2019 07:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/34] qdev-monitor: make Error **errp const where it is
 appropriate
Date: Tue, 17 Dec 2019 07:26:36 +0100
Message-Id: <20191217062651.9687-20-armbru@redhat.com>
In-Reply-To: <20191217062651.9687-1-armbru@redhat.com>
References: <20191217062651.9687-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 3k06VOaWM_Kayad0Fg5_9w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Mostly, Error ** is for returning error from the function, so the
callee sets it. However qbus_list_bus and qbus_list_dev get already
filled errp parameter. They don't change the pointer itself, only
change the internal state of referenced Error object. So we can make
it Error *const * errp, to stress the behavior. It will also help
coccinelle script (in future) to distinguish such cases from common
errp usage.

While there, rename the functions to
qbus_error_append_bus_list_hint(), qbus_error_append_dev_list_hint().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20191205174635.18758-7-vsementsov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message replaced]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qdev-monitor.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 29ed73e56a..3465a1e2d0 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -328,7 +328,8 @@ static Object *qdev_get_peripheral_anon(void)
     return dev;
 }
=20
-static void qbus_list_bus(DeviceState *dev, Error **errp)
+static void qbus_error_append_bus_list_hint(DeviceState *dev,
+                                            Error *const *errp)
 {
     BusState *child;
     const char *sep =3D " ";
@@ -342,7 +343,8 @@ static void qbus_list_bus(DeviceState *dev, Error **err=
p)
     error_append_hint(errp, "\n");
 }
=20
-static void qbus_list_dev(BusState *bus, Error **errp)
+static void qbus_error_append_dev_list_hint(BusState *bus,
+                                            Error *const *errp)
 {
     BusChild *kid;
     const char *sep =3D " ";
@@ -500,7 +502,7 @@ static BusState *qbus_find(const char *path, Error **er=
rp)
         if (!dev) {
             error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", elem);
-            qbus_list_dev(bus, errp);
+            qbus_error_append_dev_list_hint(bus, errp);
             return NULL;
         }
=20
@@ -518,7 +520,7 @@ static BusState *qbus_find(const char *path, Error **er=
rp)
             if (dev->num_child_bus) {
                 error_setg(errp, "Device '%s' has multiple child buses",
                            elem);
-                qbus_list_bus(dev, errp);
+                qbus_error_append_bus_list_hint(dev, errp);
             } else {
                 error_setg(errp, "Device '%s' has no child bus", elem);
             }
@@ -534,7 +536,7 @@ static BusState *qbus_find(const char *path, Error **er=
rp)
         bus =3D qbus_find_bus(dev, elem);
         if (!bus) {
             error_setg(errp, "Bus '%s' not found", elem);
-            qbus_list_bus(dev, errp);
+            qbus_error_append_bus_list_hint(dev, errp);
             return NULL;
         }
     }
--=20
2.21.0


