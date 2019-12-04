Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AABCC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200092073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoA0SXS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200092073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icaEN-00021l-0v
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1ica1G-0002dH-Lr
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:09:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1ica1E-0005Y6-JK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:09:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1ica1A-0005U3-PP
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575486535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8gBRP4c6w19EXcmTWgsrrJ8ke0Lp20aBqG4u2MjHGw=;
 b=BoA0SXS/OOVkijkYPCURl5RS+ZFRely4g5umRXI8JYA7f5atLuh9IHFxeYfNppL/H2pj6y
 oqeGySrwCdySZQA3pOfEirU4Mxh/qzZaqEBQ7fqM6K5hB45Z3bAUzABnF+HRWdy8AMKg/s
 hB2cGcyvrSQnaj1gbo2qTzhABbZpZI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-_14MUJXLP-a19YejEDOd4w-1; Wed, 04 Dec 2019 14:08:53 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE66318A6EF4
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 19:08:52 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA9C860BF3;
 Wed,  4 Dec 2019 19:08:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 35CF3224750; Wed,  4 Dec 2019 14:08:42 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] virtiofsd: Implement blocking posix locks
Date: Wed,  4 Dec 2019 14:08:36 -0500
Message-Id: <20191204190836.31324-6-vgoyal@redhat.com>
In-Reply-To: <20191204190836.31324-1-vgoyal@redhat.com>
References: <20191204190836.31324-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: _14MUJXLP-a19YejEDOd4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: mszeredi@redhat.com, dgilbert@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As of now we don't support fcntl(F_SETLKW) and if we see one, we return
-EOPNOTSUPP.

Change that by accepting these requests and returning a reply immediately
asking caller to wait. Once lock is available, send a notification to
the waiter indicating lock is available.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 contrib/virtiofsd/fuse_kernel.h    |  7 +++
 contrib/virtiofsd/fuse_lowlevel.c  | 23 ++++++-
 contrib/virtiofsd/fuse_lowlevel.h  | 25 ++++++++
 contrib/virtiofsd/fuse_virtio.c    | 97 ++++++++++++++++++++++++++++--
 contrib/virtiofsd/passthrough_ll.c | 49 ++++++++++++---
 5 files changed, 185 insertions(+), 16 deletions(-)

diff --git a/contrib/virtiofsd/fuse_kernel.h b/contrib/virtiofsd/fuse_kerne=
l.h
index 2bdc8b1c88..432eb14d14 100644
--- a/contrib/virtiofsd/fuse_kernel.h
+++ b/contrib/virtiofsd/fuse_kernel.h
@@ -444,6 +444,7 @@ enum fuse_notify_code {
 =09FUSE_NOTIFY_STORE =3D 4,
 =09FUSE_NOTIFY_RETRIEVE =3D 5,
 =09FUSE_NOTIFY_DELETE =3D 6,
+=09FUSE_NOTIFY_LOCK =3D 7,
 =09FUSE_NOTIFY_CODE_MAX,
 };
=20
@@ -836,6 +837,12 @@ struct fuse_notify_retrieve_in {
 =09uint64_t=09dummy4;
 };
=20
+struct fuse_notify_lock_out {
+=09uint64_t=09unique;
+=09int32_t=09=09error;
+=09int32_t=09=09padding;
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_CLONE=09_IOR(229, 0, uint32_t)
=20
diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index d4a42d9804..3d9c289510 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -183,7 +183,8 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int erro=
r, struct iovec *iov,
 {
 =09struct fuse_out_header out;
=20
-=09if (error <=3D -1000 || error > 0) {
+=09/* error =3D 1 has been used to signal client to wait for notificaiton =
*/
+=09if (error <=3D -1000 || error > 1) {
 =09=09fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n",=09error);
 =09=09error =3D -ERANGE;
 =09}
@@ -291,6 +292,12 @@ int fuse_reply_err(fuse_req_t req, int err)
 =09return send_reply(req, -err, NULL, 0);
 }
=20
+int fuse_reply_wait(fuse_req_t req)
+{
+=09/* TODO: This is a hack. Fix it */
+=09return send_reply(req, 1, NULL, 0);
+}
+
 void fuse_reply_none(fuse_req_t req)
 {
 =09fuse_free_req(req);
@@ -2207,6 +2214,20 @@ static int send_notify_iov(struct fuse_session *se, =
int notify_code,
 =09return fuse_send_msg(se, NULL, iov, count);
 }
=20
+int fuse_lowlevel_notify_lock(struct fuse_session *se, uint64_t unique,
+=09=09=09      int32_t error)
+{
+=09struct fuse_notify_lock_out outarg =3D {0};
+=09struct iovec iov[2];
+
+=09outarg.unique =3D unique;
+=09outarg.error =3D -error;
+
+=09iov[1].iov_base =3D &outarg;
+=09iov[1].iov_len =3D sizeof(outarg);
+=09return send_notify_iov(se, FUSE_NOTIFY_LOCK, iov, 2);
+}
+
 int fuse_lowlevel_notify_poll(struct fuse_pollhandle *ph)
 {
 =09if (ph !=3D NULL) {
diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index e664d2d12d..4126b4f967 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -1251,6 +1251,22 @@ struct fuse_lowlevel_ops {
  */
 int fuse_reply_err(fuse_req_t req, int err);
=20
+/**
+ * Ask caller to wait for lock.
+ *
+ * Possible requests:
+ *   setlkw
+ *
+ * If caller sends a blocking lock request (setlkw), then reply to caller
+ * that wait for lock to be available. Once lock is available caller will
+ * receive a notification with request's unique id. Notification will
+ * carry info whether lock was successfully obtained or not.
+ *
+ * @param req request handle
+ * @return zero for success, -errno for failure to send reply
+ */
+int fuse_reply_wait(fuse_req_t req);
+
 /**
  * Don't send reply
  *
@@ -1704,6 +1720,15 @@ int fuse_lowlevel_notify_delete(struct fuse_session =
*se,
 int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
 =09=09=09       off_t offset, struct fuse_bufvec *bufv,
 =09=09=09       enum fuse_buf_copy_flags flags);
+/**
+ * Notify event related to previous lock request
+ *
+ * @param se the session object
+ * @param unique the unique id of the request which requested setlkw
+ * @param error zero for success, -errno for the failure
+ */
+int fuse_lowlevel_notify_lock(struct fuse_session *se, uint64_t unique,
+=09=09=09      int32_t error);
=20
 /* ----------------------------------------------------------- *
  * Utility functions=09=09=09=09=09       *
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index 94cf9b3791..129dd329f6 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -208,6 +208,83 @@ static void copy_iov(struct iovec *src_iov, int src_co=
unt,
     }
 }
=20
+static int virtio_send_notify_msg(struct fuse_session *se, struct iovec *i=
ov,
+=09=09=09=09  int count)
+{
+    struct fv_QueueInfo *qi;
+    VuDev *dev =3D &se->virtio_dev->dev;
+    VuVirtq *q;
+    FVRequest *req;
+    VuVirtqElement *elem;
+    unsigned int in_num;
+    struct fuse_out_header *out =3D iov[0].iov_base;
+    size_t in_len, tosend_len =3D iov_size(iov, count);
+    struct iovec *in_sg;
+    int ret =3D 0;
+
+    /* Notifications have unique =3D=3D 0 */
+    assert (!out->unique);
+
+    if (!se->notify_enabled)
+        return -EOPNOTSUPP;
+
+    /* If notifications are enabled, queue index 1 is notification queue *=
/
+    qi =3D se->virtio_dev->qi[1];
+    q =3D vu_get_queue(dev, qi->qidx);
+
+    pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
+    pthread_mutex_lock(&qi->vq_lock);
+    /* Pop an element from queue */
+    req =3D vu_queue_pop(dev, q, sizeof(FVRequest), NULL, NULL);
+    if (!req) {
+        /* TODO: Implement some sort of ring buffer and queue notification=
s
+=09 * on that and send these later when notification queue has space
+=09 * available.
+=09 */
+        ret =3D -ENOSPC;
+    }
+    pthread_mutex_unlock(&qi->vq_lock);
+    pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
+
+    if (ret)
+        return ret;
+
+    out->len =3D tosend_len;
+    elem =3D &req->elem;
+    in_num =3D elem->in_num;
+    in_sg =3D elem->in_sg;
+    in_len =3D iov_size(in_sg, in_num);
+    fuse_log(FUSE_LOG_DEBUG, "%s: elem %d: with %d in desc of length %zd\n=
",
+             __func__, elem->index, in_num,  in_len);
+
+    if (in_len < sizeof(struct fuse_out_header)) {
+        fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for out_header\n",
+                 __func__, elem->index);
+        ret =3D -E2BIG;
+        goto out;
+    }
+
+    if (in_len < tosend_len) {
+        fuse_log(FUSE_LOG_ERR, "%s: elem %d too small for data len"
+                 " %zd\n", __func__, elem->index, tosend_len);
+        ret =3D -E2BIG;
+        goto out;
+    }
+
+    /* First copy the header data from iov->in_sg */
+    copy_iov(iov, count, in_sg, in_num, tosend_len);
+
+    pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
+    pthread_mutex_lock(&qi->vq_lock);
+    vu_queue_push(dev, q, elem, tosend_len);
+    vu_queue_notify(dev, q);
+    pthread_mutex_unlock(&qi->vq_lock);
+    pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
+out:
+    free(req);
+    return ret;
+}
+
 /*
  * Called back by ll whenever it wants to send a reply/message back
  * The 1st element of the iov starts with the fuse_out_header
@@ -216,11 +293,11 @@ static void copy_iov(struct iovec *src_iov, int src_c=
ount,
 int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
                     struct iovec *iov, int count)
 {
-    FVRequest *req =3D container_of(ch, FVRequest, ch);
-    struct fv_QueueInfo *qi =3D ch->qi;
+    FVRequest *req;
+    struct fv_QueueInfo *qi;
     VuDev *dev =3D &se->virtio_dev->dev;
-    VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
-    VuVirtqElement *elem =3D &req->elem;
+    VuVirtq *q;
+    VuVirtqElement *elem;
     int ret =3D 0;
=20
     assert(count >=3D 1);
@@ -231,8 +308,15 @@ int virtio_send_msg(struct fuse_session *se, struct fu=
se_chan *ch,
=20
     size_t tosend_len =3D iov_size(iov, count);
=20
-    /* unique =3D=3D 0 is notification, which we don't support */
-    assert(out->unique);
+    /* unique =3D=3D 0 is notification */
+    if (!out->unique)
+        return virtio_send_notify_msg(se, iov, count);
+
+    assert(ch);
+    req =3D container_of(ch, FVRequest, ch);
+    elem =3D &req->elem;
+    qi =3D ch->qi;
+    q =3D vu_get_queue(dev, qi->qidx);
     assert(!req->reply_sent);
=20
     /* The 'in' part of the elem is to qemu */
@@ -885,6 +969,7 @@ static int fv_get_config(VuDev *dev, uint8_t *config, u=
int32_t len)
 =09=09struct fuse_notify_delete_out=09=09delete_out;
 =09=09struct fuse_notify_store_out=09=09store_out;
 =09=09struct fuse_notify_retrieve_out=09=09retrieve_out;
+=09=09struct fuse_notify_lock_out=09=09lock_out;
 =09};
=20
 =09notify_size =3D sizeof(struct fuse_out_header) +
diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 6aa56882e8..308fc76530 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1926,7 +1926,10 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino,
 =09struct lo_data *lo =3D lo_data(req);
 =09struct lo_inode *inode;
 =09struct lo_inode_plock *plock;
-=09int ret, saverr =3D 0;
+=09int ret, saverr =3D 0, ofd;
+=09uint64_t unique;
+=09struct fuse_session *se =3D req->se;
+=09bool async_lock =3D false;
=20
 =09fuse_log(FUSE_LOG_DEBUG, "lo_setlk(ino=3D%" PRIu64 ", flags=3D%d)"
 =09=09 " cmd=3D%d pid=3D%d owner=3D0x%lx sleep=3D%d l_whence=3D%d"
@@ -1934,11 +1937,6 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino,
 =09=09 lock->l_type, lock->l_pid, fi->lock_owner, sleep,
 =09=09 lock->l_whence, lock->l_start, lock->l_len);
=20
-=09if (sleep) {
-=09=09fuse_reply_err(req, EOPNOTSUPP);
-=09=09return;
-=09}
-
 =09inode =3D lo_inode(req, ino);
 =09if (!inode) {
 =09=09fuse_reply_err(req, EBADF);
@@ -1951,21 +1949,54 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino=
,
=20
 =09if (!plock) {
 =09=09saverr =3D ret;
+=09=09pthread_mutex_unlock(&inode->plock_mutex);
 =09=09goto out;
 =09}
=20
+=09/*
+=09 * plock is now released when inode is going away. We already have
+=09 * a reference on inode, so it is guaranteed that plock->fd is
+=09 * still around even after dropping inode->plock_mutex lock
+=09 */
+=09ofd =3D plock->fd;
+=09pthread_mutex_unlock(&inode->plock_mutex);
+
+=09/*
+=09 * If this lock request can block, request caller to wait for
+=09 * notification. Do not access req after this. Once lock is
+=09 * available, send a notification instead.
+=09 */
+=09if (sleep && lock->l_type !=3D F_UNLCK) {
+=09=09/*
+=09=09 * If notification queue is not enabled, can't support async
+=09=09 * locks.
+=09=09 */
+=09=09if (!se->notify_enabled) {
+=09=09=09saverr =3D EOPNOTSUPP;
+=09=09=09goto out;
+=09=09}
+=09=09async_lock =3D true;
+=09=09unique =3D req->unique;
+=09=09fuse_reply_wait(req);
+=09}
 =09/* TODO: Is it alright to modify flock? */
 =09lock->l_pid =3D 0;
-=09ret =3D fcntl(plock->fd, F_OFD_SETLK, lock);
+=09if (async_lock)
+=09=09ret =3D fcntl(ofd, F_OFD_SETLKW, lock);
+=09else
+=09=09ret =3D fcntl(ofd, F_OFD_SETLK, lock);
 =09if (ret =3D=3D -1) {
 =09=09saverr =3D errno;
 =09}
=20
 out:
-=09pthread_mutex_unlock(&inode->plock_mutex);
 =09lo_inode_put(lo, &inode);
=20
-=09fuse_reply_err(req, saverr);
+=09if (!async_lock)
+=09=09fuse_reply_err(req, saverr);
+=09else {
+=09=09fuse_lowlevel_notify_lock(se, unique, saverr);
+=09}
 }
=20
 static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
--=20
2.20.1


