Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0919AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC13B20719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnYyba9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC13B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnYS-00061N-Q2
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLnUI-0007rR-R6
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLnUH-0006tV-Ea
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLnUH-0006tI-Bg
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586263073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3MB19gN0vZWLt9OgTn+jP5Qog8pmeTpyEzT/aQfIsMs=;
 b=TnYyba9Oz2B63+0EADEhnFUKH1VFmGcDSY8IRC+kM5BNofSEi8aGd9C8HPKiK4rVEsmHHQ
 DsHQOxn/xid8/V2tq2TWyjb/OUhbampz/AwSrgs5aqlRaHjv5VeThFEbbNpeFYVttvy4ry
 gjDyhoXKK/qrX+qhybXtlTb83iX3jo8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-CfZRONQOO3K2DARdoabNpw-1; Tue, 07 Apr 2020 08:37:47 -0400
X-MC-Unique: CfZRONQOO3K2DARdoabNpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 245061B18BC2;
 Tue,  7 Apr 2020 12:37:46 +0000 (UTC)
Received: from localhost (ovpn-114-84.ams2.redhat.com [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A6A3B19A0;
 Tue,  7 Apr 2020 12:37:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 5/5] xen-block: Fix double qlist remove and request leak
Date: Tue,  7 Apr 2020 14:37:27 +0200
Message-Id: <20200407123727.829933-6-mreitz@redhat.com>
In-Reply-To: <20200407123727.829933-1-mreitz@redhat.com>
References: <20200407123727.829933-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anthony PERARD <anthony.perard@citrix.com>

Commit a31ca6801c02 ("qemu/queue.h: clear linked list pointers on
remove") revealed that a request was removed twice from a list, once
in xen_block_finish_request() and a second time in
xen_block_release_request() when both function are called from
xen_block_complete_aio(). But also, the `requests_inflight' counter is
decreased twice, and thus became negative.

This is a bug that was introduced in bfd0d6366043 ("xen-block: improve
response latency"), where a `finished' list was removed.

That commit also introduced a leak of request in xen_block_do_aio().
That function calls xen_block_finish_request() but the request is
never released after that.

To fix both issue, we do two changes:
- we squash finish_request() and release_request() together as we want
  to remove a request from 'inflight' list to add it to 'freelist'.
- before releasing a request, we need to let the other end know the
  result, thus we should call xen_block_send_response() before
  releasing a request.

The first change fixes the double QLIST_REMOVE() as we remove the extra
call. The second change makes the leak go away because if we want to
call finish_request(), we need to call a function that does all of
finish, send response, and release.

Fixes: bfd0d6366043 ("xen-block: improve response latency")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20200406140217.1441858-1-anthony.perard@citrix.com>
Reviewed-by: Paul Durrant <paul@xen.org>
[mreitz: Amended commit message as per Paul's suggestions]
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 hw/block/dataplane/xen-block.c | 48 ++++++++++++----------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.=
c
index 288a87a814..5f8f15778b 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -64,6 +64,8 @@ struct XenBlockDataPlane {
     AioContext *ctx;
 };
=20
+static int xen_block_send_response(XenBlockRequest *request);
+
 static void reset_request(XenBlockRequest *request)
 {
     memset(&request->req, 0, sizeof(request->req));
@@ -115,23 +117,26 @@ out:
     return request;
 }
=20
-static void xen_block_finish_request(XenBlockRequest *request)
+static void xen_block_complete_request(XenBlockRequest *request)
 {
     XenBlockDataPlane *dataplane =3D request->dataplane;
=20
-    QLIST_REMOVE(request, list);
-    dataplane->requests_inflight--;
-}
+    if (xen_block_send_response(request)) {
+        Error *local_err =3D NULL;
=20
-static void xen_block_release_request(XenBlockRequest *request)
-{
-    XenBlockDataPlane *dataplane =3D request->dataplane;
+        xen_device_notify_event_channel(dataplane->xendev,
+                                        dataplane->event_channel,
+                                        &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
+    }
=20
     QLIST_REMOVE(request, list);
+    dataplane->requests_inflight--;
     reset_request(request);
     request->dataplane =3D dataplane;
     QLIST_INSERT_HEAD(&dataplane->freelist, request, list);
-    dataplane->requests_inflight--;
 }
=20
 /*
@@ -246,7 +251,6 @@ static int xen_block_copy_request(XenBlockRequest *requ=
est)
 }
=20
 static int xen_block_do_aio(XenBlockRequest *request);
-static int xen_block_send_response(XenBlockRequest *request);
=20
 static void xen_block_complete_aio(void *opaque, int ret)
 {
@@ -286,7 +290,6 @@ static void xen_block_complete_aio(void *opaque, int re=
t)
     }
=20
     request->status =3D request->aio_errors ? BLKIF_RSP_ERROR : BLKIF_RSP_=
OKAY;
-    xen_block_finish_request(request);
=20
     switch (request->req.operation) {
     case BLKIF_OP_WRITE:
@@ -306,17 +309,8 @@ static void xen_block_complete_aio(void *opaque, int r=
et)
     default:
         break;
     }
-    if (xen_block_send_response(request)) {
-        Error *local_err =3D NULL;
=20
-        xen_device_notify_event_channel(dataplane->xendev,
-                                        dataplane->event_channel,
-                                        &local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
-    }
-    xen_block_release_request(request);
+    xen_block_complete_request(request);
=20
     if (dataplane->more_work) {
         qemu_bh_schedule(dataplane->bh);
@@ -420,8 +414,8 @@ static int xen_block_do_aio(XenBlockRequest *request)
     return 0;
=20
 err:
-    xen_block_finish_request(request);
     request->status =3D BLKIF_RSP_ERROR;
+    xen_block_complete_request(request);
     return -1;
 }
=20
@@ -575,17 +569,7 @@ static bool xen_block_handle_requests(XenBlockDataPlan=
e *dataplane)
                 break;
             };
=20
-            if (xen_block_send_response(request)) {
-                Error *local_err =3D NULL;
-
-                xen_device_notify_event_channel(dataplane->xendev,
-                                                dataplane->event_channel,
-                                                &local_err);
-                if (local_err) {
-                    error_report_err(local_err);
-                }
-            }
-            xen_block_release_request(request);
+            xen_block_complete_request(request);
             continue;
         }
=20
--=20
2.25.1


