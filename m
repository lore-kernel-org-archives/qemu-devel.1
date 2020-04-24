Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C31C54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC5C2075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJB/oG1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC5C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS40h-0005gS-F8
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53034)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sW-0003oU-UC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sO-00045l-0v
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25849
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jS3sN-00045H-IR
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587756038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCs/MUWiOabJCVAQ8sLvUQgrb8weKuUkchaXXg61HdM=;
 b=OJB/oG1Tp1FVC5dROHjHZi9vm5snOKT/p39ck10ZiHgLg9CL0X4zZVB6o+kOTXtwL/Rn6K
 bCOc05I8S7jCwzD4sQVxl2Ani1jUpvxrCwX8cfxwaWx203AGyUyCYB7TSN8Ca6gLCaQz6Y
 pW4YJCFasV24A+OL4fBovRJXq2+MeHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-0hfApBy5PNeX1QqpGuxL5A-1; Fri, 24 Apr 2020 15:20:35 -0400
X-MC-Unique: 0hfApBy5PNeX1QqpGuxL5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E07684B8A0;
 Fri, 24 Apr 2020 19:20:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 742121A925;
 Fri, 24 Apr 2020 19:20:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2DB3011358BE; Fri, 24 Apr 2020 21:20:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] xen: Fix and improve handling of device_add usb-host
 errors
Date: Fri, 24 Apr 2020 21:20:18 +0200
Message-Id: <20200424192027.11404-3-armbru@redhat.com>
In-Reply-To: <20200424192027.11404-1-armbru@redhat.com>
References: <20200424192027.11404-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

usbback_portid_add() leaks the error when qdev_device_add() fails.
Fix that.  While there, use the error to improve the error message.

The qemu_opts_from_qdict() similarly leaks on failure.  But any
failure there is a programming error.  Pass &error_abort.

Fixes: 816ac92ef769f9ffc534e49a1bb6177bddce7aa2
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/usb/xen-usb.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/usb/xen-usb.c b/hw/usb/xen-usb.c
index 961190d0f7..42643c3390 100644
--- a/hw/usb/xen-usb.c
+++ b/hw/usb/xen-usb.c
@@ -30,6 +30,7 @@
 #include "hw/usb.h"
 #include "hw/xen/xen-legacy-backend.h"
 #include "monitor/qdev.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
=20
@@ -755,13 +756,15 @@ static void usbback_portid_add(struct usbback_info *u=
sbif, unsigned port,
     qdict_put_int(qdict, "port", port);
     qdict_put_int(qdict, "hostbus", atoi(busid));
     qdict_put_str(qdict, "hostport", portname);
-    opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_=
err);
-    if (local_err) {
-        goto err;
-    }
+    opts =3D qemu_opts_from_qdict(qemu_find_opts("device"), qdict,
+                                &error_abort);
     usbif->ports[port - 1].dev =3D USB_DEVICE(qdev_device_add(opts, &local=
_err));
     if (!usbif->ports[port - 1].dev) {
-        goto err;
+        qobject_unref(qdict);
+        xen_pv_printf(&usbif->xendev, 0,
+                      "device %s could not be opened: %s\n",
+                      busid, error_get_pretty(local_err));
+        error_free(local_err);
     }
     qobject_unref(qdict);
     speed =3D usbif->ports[port - 1].dev->speed;
@@ -793,11 +796,6 @@ static void usbback_portid_add(struct usbback_info *us=
bif, unsigned port,
     usbback_hotplug_enq(usbif, port);
=20
     TR_BUS(&usbif->xendev, "port %d attached\n", port);
-    return;
-
-err:
-    qobject_unref(qdict);
-    xen_pv_printf(&usbif->xendev, 0, "device %s could not be opened\n", bu=
sid);
 }
=20
 static void usbback_process_port(struct usbback_info *usbif, unsigned port=
)
--=20
2.21.1


