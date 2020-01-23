Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA4FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:18:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7241B20718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqlnA2B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7241B20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudJE-0008Iv-2W
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAV-00045O-2L
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAT-0006Ng-C6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53251
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAT-0006N3-7F
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yqvAf8xgYOQNZl5eAsbJzD9x3bslYjEazYf5twmm4N4=;
 b=GqlnA2B4yhqjYklhggZoJ2JIvAczvvahGfHKahNwN6EqLtXX5JAKypnZSrffDYdN68LuRa
 9LB9biSMZoGwDGEiKvCOKug2PBBtlYxVOfECHSQRM1GaH4U1LuuyXYUrbz7Xcy71dUGqBp
 hBRwOB2rMcr1k7eRftIi3Id9VdiprHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-13mkFoP_M1CbVu1iKM8aaQ-1; Thu, 23 Jan 2020 07:00:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 685B18018A9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:00:57 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CEA885750;
 Thu, 23 Jan 2020 12:00:54 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 089/111] virtiofsd: prevent fv_queue_thread() vs virtio_loop()
 races
Date: Thu, 23 Jan 2020 11:58:19 +0000
Message-Id: <20200123115841.138849-90-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 13mkFoP_M1CbVu1iKM8aaQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

We call into libvhost-user from the virtqueue handler thread and the
vhost-user message processing thread without a lock.  There is nothing
protecting the virtqueue handler thread if the vhost-user message
processing thread changes the virtqueue or memory table while it is
running.

This patch introduces a read-write lock.  Virtqueue handler threads are
readers.  The vhost-user message processing thread is a writer.  This
will allow concurrency for multiqueue in the future while protecting
against fv_queue_thread() vs virtio_loop() races.

Note that the critical sections could be made smaller but it would be
more invasive and require libvhost-user changes.  Let's start simple and
improve performance later, if necessary.  Another option would be an
RCU-style approach with lighter-weight primitives.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index fb8d6d1379..f6242f9338 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -58,6 +58,18 @@ struct fv_VuDev {
     VuDev dev;
     struct fuse_session *se;
=20
+    /*
+     * Either handle virtqueues or vhost-user protocol messages.  Don't do
+     * both at the same time since that could lead to race conditions if
+     * virtqueues or memory tables change while another thread is accessin=
g
+     * them.
+     *
+     * The assumptions are:
+     * 1. fv_queue_thread() reads/writes to virtqueues and only reads VuDe=
v.
+     * 2. virtio_loop() reads/writes virtqueues and VuDev.
+     */
+    pthread_rwlock_t vu_dispatch_rwlock;
+
     /*
      * The following pair of fields are only accessed in the main
      * virtio_loop
@@ -415,6 +427,8 @@ static void *fv_queue_thread(void *opaque)
              qi->qidx, qi->kick_fd);
     while (1) {
         struct pollfd pf[2];
+        int ret;
+
         pf[0].fd =3D qi->kick_fd;
         pf[0].events =3D POLLIN;
         pf[0].revents =3D 0;
@@ -461,6 +475,9 @@ static void *fv_queue_thread(void *opaque)
             fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
             break;
         }
+        /* Mutual exclusion with virtio_loop() */
+        ret =3D pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock)=
;
+        assert(ret =3D=3D 0); /* there is no possible error case */
         /* out is from guest, in is too guest */
         unsigned int in_bytes, out_bytes;
         vu_queue_get_avail_bytes(dev, q, &in_bytes, &out_bytes, ~0, ~0);
@@ -469,6 +486,7 @@ static void *fv_queue_thread(void *opaque)
                  "%s: Queue %d gave evalue: %zx available: in: %u out: %u\=
n",
                  __func__, qi->qidx, (size_t)evalue, in_bytes, out_bytes);
=20
+
         while (1) {
             bool allocated_bufv =3D false;
             struct fuse_bufvec bufv;
@@ -597,6 +615,8 @@ static void *fv_queue_thread(void *opaque)
             free(elem);
             elem =3D NULL;
         }
+
+        pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
     }
 out:
     pthread_mutex_destroy(&ch.lock);
@@ -711,6 +731,8 @@ int virtio_loop(struct fuse_session *se)
=20
     while (!fuse_session_exited(se)) {
         struct pollfd pf[1];
+        bool ok;
+        int ret;
         pf[0].fd =3D se->vu_socketfd;
         pf[0].events =3D POLLIN;
         pf[0].revents =3D 0;
@@ -735,7 +757,15 @@ int virtio_loop(struct fuse_session *se)
         }
         assert(pf[0].revents & POLLIN);
         fuse_log(FUSE_LOG_DEBUG, "%s: Got VU event\n", __func__);
-        if (!vu_dispatch(&se->virtio_dev->dev)) {
+        /* Mutual exclusion with fv_queue_thread() */
+        ret =3D pthread_rwlock_wrlock(&se->virtio_dev->vu_dispatch_rwlock)=
;
+        assert(ret =3D=3D 0); /* there is no possible error case */
+
+        ok =3D vu_dispatch(&se->virtio_dev->dev);
+
+        pthread_rwlock_unlock(&se->virtio_dev->vu_dispatch_rwlock);
+
+        if (!ok) {
             fuse_log(FUSE_LOG_ERR, "%s: vu_dispatch failed\n", __func__);
             break;
         }
@@ -877,6 +907,7 @@ int virtio_session_mount(struct fuse_session *se)
=20
     se->vu_socketfd =3D data_sock;
     se->virtio_dev->se =3D se;
+    pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
     vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, fv_set_wat=
ch,
             fv_remove_watch, &fv_iface);
=20
@@ -892,6 +923,7 @@ void virtio_session_close(struct fuse_session *se)
     }
=20
     free(se->virtio_dev->qi);
+    pthread_rwlock_destroy(&se->virtio_dev->vu_dispatch_rwlock);
     free(se->virtio_dev);
     se->virtio_dev =3D NULL;
 }
--=20
2.24.1


