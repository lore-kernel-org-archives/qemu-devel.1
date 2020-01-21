Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAF9C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8790221569
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7SlsilS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8790221569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittQv-0002kG-R5
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsfy-00021w-NI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsfx-0004Am-Am
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsfx-0004AK-63
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZkwaXMLMUfqn6pNwDIw+RREtjzbDunZT+nKmZAihxk=;
 b=Y7SlsilSyzuSYVASrTDB571xvy4rt5PcAfuSu/pvw/RZd4SQXKYnwaH2hJ9e47MLxOfbSB
 dMuxAB/2A4X0d2g9KLxww83SgejlkCJM5gYa+/rGJd2vnVsjKbTqfHiE+C7xv49N6v3Y2G
 xYS/gQmHg1SqlZBvYzQBd5lBFMuWlV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-M20C_7euP0q0NDiji4of0g-1; Tue, 21 Jan 2020 07:30:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BA1D2F61;
 Tue, 21 Jan 2020 12:30:27 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6872F60BE0;
 Tue, 21 Jan 2020 12:30:25 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 065/109] virtiofsd: Kill threads when queues are stopped
Date: Tue, 21 Jan 2020 12:23:49 +0000
Message-Id: <20200121122433.50803-66-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: M20C_7euP0q0NDiji4of0g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Kill the threads we've started when the queues get stopped.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
With improvements by:
Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 51 ++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 872968f2c8..7a8774a3ee 100644
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
@@ -412,14 +413,17 @@ static void *fv_queue_thread(void *opaque)
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
@@ -430,12 +434,23 @@ static void *fv_queue_thread(void *opaque)
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
@@ -589,6 +604,28 @@ out:
     return NULL;
 }
=20
+static void fv_queue_cleanup_thread(struct fv_VuDev *vud, int qidx)
+{
+    int ret;
+    struct fv_QueueInfo *ourqi;
+
+    assert(qidx < vud->nqueues);
+    ourqi =3D vud->qi[qidx];
+
+    /* Kill the thread */
+    if (eventfd_write(ourqi->kill_fd, 1)) {
+        fuse_log(FUSE_LOG_ERR, "Eventfd_write for queue %d: %s\n",
+                 qidx, strerror(errno));
+    }
+    ret =3D pthread_join(ourqi->thread, NULL);
+    if (ret) {
+        fuse_log(FUSE_LOG_ERR, "%s: Failed to join thread idx %d err %d\n"=
,
+                 __func__, qidx, ret);
+    }
+    close(ourqi->kill_fd);
+    ourqi->kick_fd =3D -1;
+}
+
 /* Callback from libvhost-user on start or stop of a queue */
 static void fv_queue_set_started(VuDev *dev, int qidx, bool started)
 {
@@ -633,16 +670,16 @@ static void fv_queue_set_started(VuDev *dev, int qidx=
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
-        assert(qidx < vud->nqueues);
-        ourqi =3D vud->qi[qidx];
-        ourqi->kick_fd =3D -1;
+        fv_queue_cleanup_thread(vud, qidx);
     }
 }
=20
--=20
2.24.1


