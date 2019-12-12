Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3051FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD5821655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wta3Y7kF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD5821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifSJI-0007UN-Fs
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWE-0006gh-O4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRWC-0003Ef-GC
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50698
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRWC-0003Dy-BV
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkhckyCPoEugYH+BhktCmuRCvCKkyg2XHUE4U9xmKGA=;
 b=Wta3Y7kFkQU84uY8Ww/plJiJajME6Z/83WA1kMK3Th96Q6yr+E3kKCydD6rIZ4Abrrl3hG
 SCDjky3zeBSkLUzDf4ByjzYohm0DvRijdzF8bfeyNZXnuaX1+KCVKbCXuNcApqTIcW3VSX
 dgzQUmNj7XIptZ45d+VIfjBG9ORg+FA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-HnPoBiDrOTSTajjKpc-fBA-1; Thu, 12 Dec 2019 11:40:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B774107ACCC
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:45 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9150560BE1;
 Thu, 12 Dec 2019 16:40:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 063/104] virtiofsd: Kill threads when queues are stopped
Date: Thu, 12 Dec 2019 16:38:23 +0000
Message-Id: <20191212163904.159893-64-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HnPoBiDrOTSTajjKpc-fBA-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Kill the threads we've started when the queues get stopped.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 37 +++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 3c778b6296..2f11fee46d 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -41,6 +41,7 @@ struct fv_QueueInfo {
     /* Our queue index, corresponds to array position */
     int qidx;
     int kick_fd;
+    int kill_fd; /* For killing the thread */
=20
     /* The element for the command currently being processed */
     VuVirtqElement *qe;
@@ -410,14 +411,17 @@ static void *fv_queue_thread(void *opaque)
     fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __func_=
_,
              qi->qidx, qi->kick_fd);
     while (1) {
-        struct pollfd pf[1];
+        struct pollfd pf[2];
         pf[0].fd =3D qi->kick_fd;
         pf[0].events =3D POLLIN;
         pf[0].revents =3D 0;
+        pf[1].fd =3D qi->kill_fd;
+        pf[1].events =3D POLLIN;
+        pf[1].revents =3D 0;
=20
         fuse_log(FUSE_LOG_DEBUG, "%s: Waiting for Queue %d event\n", __fun=
c__,
                  qi->qidx);
-        int poll_res =3D ppoll(pf, 1, NULL, NULL);
+        int poll_res =3D ppoll(pf, 2, NULL, NULL);
=20
         if (poll_res =3D=3D -1) {
             if (errno =3D=3D EINTR) {
@@ -428,12 +432,23 @@ static void *fv_queue_thread(void *opaque)
             fuse_log(FUSE_LOG_ERR, "fv_queue_thread ppoll: %m\n");
             break;
         }
-        assert(poll_res =3D=3D 1);
+        assert(poll_res >=3D 1);
         if (pf[0].revents & (POLLERR | POLLHUP | POLLNVAL)) {
             fuse_log(FUSE_LOG_ERR, "%s: Unexpected poll revents %x Queue %=
d\n",
                      __func__, pf[0].revents, qi->qidx);
             break;
         }
+        if (pf[1].revents & (POLLERR | POLLHUP | POLLNVAL)) {
+            fuse_log(FUSE_LOG_ERR,
+                     "%s: Unexpected poll revents %x Queue %d killfd\n",
+                     __func__, pf[1].revents, qi->qidx);
+            break;
+        }
+        if (pf[1].revents) {
+            fuse_log(FUSE_LOG_INFO, "%s: kill event on queue %d - quitting=
\n",
+                     __func__, qi->qidx);
+            break;
+        }
         assert(pf[0].revents & POLLIN);
         fuse_log(FUSE_LOG_DEBUG, "%s: Got queue event on Queue %d\n", __fu=
nc__,
                  qi->qidx);
@@ -631,15 +646,29 @@ static void fv_queue_set_started(VuDev *dev, int qidx=
, bool started)
         }
         ourqi =3D vud->qi[qidx];
         ourqi->kick_fd =3D dev->vq[qidx].kick_fd;
+
+        ourqi->kill_fd =3D eventfd(0, EFD_CLOEXEC | EFD_SEMAPHORE);
+        assert(ourqi->kill_fd !=3D -1);
         if (pthread_create(&ourqi->thread, NULL, fv_queue_thread, ourqi)) =
{
             fuse_log(FUSE_LOG_ERR, "%s: Failed to create thread for queue =
%d\n",
                      __func__, qidx);
             assert(0);
         }
     } else {
-        /* TODO: Kill the thread */
+        int ret;
         assert(qidx < vud->nqueues);
         ourqi =3D vud->qi[qidx];
+
+        /* Kill the thread */
+        if (eventfd_write(ourqi->kill_fd, 1)) {
+            fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
+        }
+        ret =3D pthread_join(ourqi->thread, NULL);
+        if (ret) {
+            fuse_log(FUSE_LOG_ERR, "%s: Failed to join thread idx %d err %=
d\n",
+                     __func__, qidx, ret);
+        }
+        close(ourqi->kill_fd);
         ourqi->kick_fd =3D -1;
     }
 }
--=20
2.23.0


