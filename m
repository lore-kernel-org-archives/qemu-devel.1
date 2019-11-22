Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E754BC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FFE020707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fArcGbja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFE020707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDIn-0007Er-0x
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iYD28-0006ZL-CJ
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iYD22-0000l5-QU
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:47:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iYD22-0000kn-KS
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574444864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wbnl9cv1eNZ0WfBDAHBzQgBPlOUXrrR51izXCfE1kdA=;
 b=fArcGbjaRh7zTi3S2f/FxIRhfalyuJ7eq/Flv+58l/+jTF+BEYiyXsDb/XXyZRT+1f58xK
 LWpp/Tu1ThPYa8d+ARGvu/Wf2R3RYo/vmwLJdOXHbICJ5eOGvZLkfiz435kRPCtSrf4dh1
 8qJIq7fcC4BK61hGCylqmDfyYRxlO/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-na00wQCtNr-vORcLvikJ5g-1; Fri, 22 Nov 2019 12:47:42 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82BA1DB20;
 Fri, 22 Nov 2019 17:47:41 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B6C8100EBA7;
 Fri, 22 Nov 2019 17:47:34 +0000 (UTC)
Date: Fri, 22 Nov 2019 17:47:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/4] virtiofsd: Implement blocking posix locks
Message-ID: <20191122174732.GL2785@work-vm>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-5-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205543.1816-5-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: na00wQCtNr-vORcLvikJ5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 miklos@szeredi.hu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vivek Goyal (vgoyal@redhat.com) wrote:
> As of now we don't support fcntl(F_SETLKW) and if we see one, we return
> -EOPNOTSUPP.
>=20
> Change that by accepting these requests and returning a reply immediately
> asking caller to wait. Once lock is available, send a notification to
> the waiter indicating lock is available.
>=20
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  contrib/virtiofsd/fuse_kernel.h    |  7 +++
>  contrib/virtiofsd/fuse_lowlevel.c  | 23 +++++++-
>  contrib/virtiofsd/fuse_lowlevel.h  | 25 ++++++++
>  contrib/virtiofsd/fuse_virtio.c    | 94 ++++++++++++++++++++++++++++--
>  contrib/virtiofsd/passthrough_ll.c | 49 +++++++++++++---
>  5 files changed, 182 insertions(+), 16 deletions(-)
>=20
> diff --git a/contrib/virtiofsd/fuse_kernel.h b/contrib/virtiofsd/fuse_ker=
nel.h
> index 2bdc8b1c88..d4d65c5414 100644
> --- a/contrib/virtiofsd/fuse_kernel.h
> +++ b/contrib/virtiofsd/fuse_kernel.h
> @@ -444,6 +444,7 @@ enum fuse_notify_code {
>  =09FUSE_NOTIFY_STORE =3D 4,
>  =09FUSE_NOTIFY_RETRIEVE =3D 5,
>  =09FUSE_NOTIFY_DELETE =3D 6,
> +=09FUSE_NOTIFY_LOCK =3D 7,
>  =09FUSE_NOTIFY_CODE_MAX,
>  };
> =20
> @@ -836,6 +837,12 @@ struct fuse_notify_retrieve_in {
>  =09uint64_t=09dummy4;
>  };
> =20
> +struct fuse_notify_lock_out {
> +=09uint64_t=09id;
> +=09int32_t=09=09error;
> +=09int32_t=09=09padding;
> +};
> +
>  /* Device ioctls: */
>  #define FUSE_DEV_IOC_CLONE=09_IOR(229, 0, uint32_t)
> =20
> diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_l=
owlevel.c
> index d4a42d9804..f706e440bf 100644
> --- a/contrib/virtiofsd/fuse_lowlevel.c
> +++ b/contrib/virtiofsd/fuse_lowlevel.c
> @@ -183,7 +183,8 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int er=
ror, struct iovec *iov,
>  {
>  =09struct fuse_out_header out;
> =20
> -=09if (error <=3D -1000 || error > 0) {
> +=09/* error =3D 1 has been used to signal client to wait for notificaito=
n */
> +=09if (error <=3D -1000 || error > 1) {
>  =09=09fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n",=09error);
>  =09=09error =3D -ERANGE;
>  =09}
> @@ -291,6 +292,12 @@ int fuse_reply_err(fuse_req_t req, int err)
>  =09return send_reply(req, -err, NULL, 0);
>  }
> =20
> +int fuse_reply_wait(fuse_req_t req)
> +{
> +=09/* TODO: This is a hack. Fix it */
> +=09return send_reply(req, 1, NULL, 0);
> +}
> +
>  void fuse_reply_none(fuse_req_t req)
>  {
>  =09fuse_free_req(req);
> @@ -2207,6 +2214,20 @@ static int send_notify_iov(struct fuse_session *se=
, int notify_code,
>  =09return fuse_send_msg(se, NULL, iov, count);
>  }
> =20
> +int fuse_lowlevel_notify_lock(struct fuse_session *se, uint64_t req_id,
> +=09=09=09      int32_t error)
> +{
> +=09struct fuse_notify_lock_out outarg;
> +=09struct iovec iov[2];
> +
> +=09outarg.id =3D req_id;
> +=09outarg.error =3D -error;
> +
> +=09iov[1].iov_base =3D &outarg;
> +=09iov[1].iov_len =3D sizeof(outarg);
> +=09return send_notify_iov(se, FUSE_NOTIFY_LOCK, iov, 2);
> +}
> +
>  int fuse_lowlevel_notify_poll(struct fuse_pollhandle *ph)
>  {
>  =09if (ph !=3D NULL) {
> diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_l=
owlevel.h
> index e664d2d12d..f0a94683b5 100644
> --- a/contrib/virtiofsd/fuse_lowlevel.h
> +++ b/contrib/virtiofsd/fuse_lowlevel.h
> @@ -1251,6 +1251,22 @@ struct fuse_lowlevel_ops {
>   */
>  int fuse_reply_err(fuse_req_t req, int err);
> =20
> +/**
> + * Ask caller to wait for lock.
> + *
> + * Possible requests:
> + *   setlkw
> + *
> + * If caller sends a blocking lock request (setlkw), then reply to calle=
r
> + * that wait for lock to be available. Once lock is available caller wil=
l
> + * receive a notification with request's unique id. Notification will
> + * carry info whether lock was successfully obtained or not.
> + *
> + * @param req request handle
> + * @return zero for success, -errno for failure to send reply
> + */
> +int fuse_reply_wait(fuse_req_t req);
> +
>  /**
>   * Don't send reply
>   *
> @@ -1704,6 +1720,15 @@ int fuse_lowlevel_notify_delete(struct fuse_sessio=
n *se,
>  int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
>  =09=09=09       off_t offset, struct fuse_bufvec *bufv,
>  =09=09=09       enum fuse_buf_copy_flags flags);
> +/**
> + * Notify event related to previous lock request
> + *
> + * @param se the session object
> + * @param req_id the id of the request which requested setlkw
> + * @param error zero for success, -errno for the failure
> + */
> +int fuse_lowlevel_notify_lock(struct fuse_session *se, uint64_t req_id,
> +=09=09=09      int32_t error);
> =20
>  /* ----------------------------------------------------------- *
>   * Utility functions=09=09=09=09=09       *
> diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_vir=
tio.c
> index 982b6ad0bd..98d27e7642 100644
> --- a/contrib/virtiofsd/fuse_virtio.c
> +++ b/contrib/virtiofsd/fuse_virtio.c
> @@ -215,6 +215,81 @@ static void copy_iov(struct iovec *src_iov, int src_=
count,
>      }
>  }
> =20
> +static int virtio_send_notify_msg(struct fuse_session *se, struct iovec =
*iov,
> +=09=09=09=09  int count)
> +{
> +    struct fv_QueueInfo *qi;
> +    VuDev *dev =3D &se->virtio_dev->dev;
> +    VuVirtq *q;
> +    FVRequest *req;
> +    VuVirtqElement *elem;
> +    unsigned int in_num, bad_in_num =3D 0, bad_out_num =3D 0;
> +    struct fuse_out_header *out =3D iov[0].iov_base;
> +    size_t in_len, tosend_len =3D iov_size(iov, count);
> +    struct iovec *in_sg;
> +    int ret =3D 0;
> +
> +    /* Notifications have unique =3D=3D 0 */
> +    assert (!out->unique);
> +
> +    if (!se->notify_enabled)
> +        return -EOPNOTSUPP;
> +
> +    /* If notifications are enabled, queue index 1 is notification queue=
 */
> +    qi =3D se->virtio_dev->qi[1];
> +    q =3D vu_get_queue(dev, qi->qidx);
> +
> +    pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
> +    pthread_mutex_lock(&qi->vq_lock);
> +    /* Pop an element from queue */
> +    req =3D vu_queue_pop(dev, q, sizeof(FVRequest), &bad_in_num, &bad_ou=
t_num);

You don't need bad_in_num/bad_out_num - just pass NULL for both; they're
only needed if you expect to read/write data that's not mappable (i.e.
in our direct write case).

> +    if (!req) {
> +        /* TODO: Implement some sort of ring buffer and queue notificati=
ons
> +=09 * on that and send these later when notification queue has space
> +=09 * available.
> +=09 */
> +        return -ENOSPC;
> +    }
> +    pthread_mutex_unlock(&qi->vq_lock);
> +    pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
> +
> +    out->len =3D tosend_len;
> +    elem =3D &req->elem;
> +    in_num =3D elem->in_num;
> +    in_sg =3D elem->in_sg;
> +    in_len =3D iov_size(in_sg, in_num);
> +    fuse_log(FUSE_LOG_DEBUG, "%s: elem %d: with %d in desc of length %zd=
\n",
> +             __func__, elem->index, in_num,  in_len);
> +
> +    if (in_len < sizeof(struct fuse_out_header)) {
> +        fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for out_header\n",
> +                 __func__, elem->index);
> +        ret =3D -E2BIG;
> +        goto out;
> +    }
> +
> +    if (in_len < tosend_len) {
> +        fuse_log(FUSE_LOG_ERR, "%s: elem %d too small for data len"
> +                 " %zd\n", __func__, elem->index, tosend_len);
> +        ret =3D -E2BIG;
> +        goto out;
> +    }
> +
> +    /* First copy the header data from iov->in_sg */
> +    copy_iov(iov, count, in_sg, in_num, tosend_len);
> +
> +    /* TODO: Add bad_innum handling */
> +    pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
> +    pthread_mutex_lock(&qi->vq_lock);
> +    vu_queue_push(dev, q, elem, tosend_len);
> +    vu_queue_notify(dev, q);
> +    pthread_mutex_unlock(&qi->vq_lock);
> +    pthread_rwlock_unlock(&qi->virtio_dev->vu_dispatch_rwlock);
> +out:
> +    free(req);
> +    return ret;
> +}
> +
>  /*
>   * Called back by ll whenever it wants to send a reply/message back
>   * The 1st element of the iov starts with the fuse_out_header
> @@ -223,11 +298,11 @@ static void copy_iov(struct iovec *src_iov, int src=
_count,
>  int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
>                      struct iovec *iov, int count)
>  {
> -    FVRequest *req =3D container_of(ch, FVRequest, ch);
> -    struct fv_QueueInfo *qi =3D ch->qi;
> +    FVRequest *req;
> +    struct fv_QueueInfo *qi;
>      VuDev *dev =3D &se->virtio_dev->dev;
> -    VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
> -    VuVirtqElement *elem =3D &req->elem;
> +    VuVirtq *q;
> +    VuVirtqElement *elem;
>      int ret =3D 0;
> =20
>      assert(count >=3D 1);
> @@ -238,8 +313,15 @@ int virtio_send_msg(struct fuse_session *se, struct =
fuse_chan *ch,
> =20
>      size_t tosend_len =3D iov_size(iov, count);
> =20
> -    /* unique =3D=3D 0 is notification, which we don't support */
> -    assert(out->unique);
> +    /* unique =3D=3D 0 is notification */
> +    if (!out->unique)
> +        return virtio_send_notify_msg(se, iov, count);
> +
> +    assert(ch);
> +    req =3D container_of(ch, FVRequest, ch);
> +    elem =3D &req->elem;
> +    qi =3D ch->qi;
> +    q =3D vu_get_queue(dev, qi->qidx);
>      assert(!req->reply_sent);
> =20
>      /* The 'in' part of the elem is to qemu */
> diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
> index 028e7da273..ed52953565 100644
> --- a/contrib/virtiofsd/passthrough_ll.c
> +++ b/contrib/virtiofsd/passthrough_ll.c
> @@ -1925,7 +1925,10 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t in=
o,
>  =09struct lo_data *lo =3D lo_data(req);
>  =09struct lo_inode *inode;
>  =09struct lo_inode_plock *plock;
> -=09int ret, saverr =3D 0;
> +=09int ret, saverr =3D 0, ofd;
> +=09uint64_t unique;
> +=09struct fuse_session *se =3D req->se;
> +=09bool async_lock =3D false;
> =20
>  =09fuse_log(FUSE_LOG_DEBUG, "lo_setlk(ino=3D%" PRIu64 ", flags=3D%d)"
>  =09=09 " cmd=3D%d pid=3D%d owner=3D0x%lx sleep=3D%d l_whence=3D%d"
> @@ -1933,11 +1936,6 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t in=
o,
>  =09=09 lock->l_type, lock->l_pid, fi->lock_owner, sleep,
>  =09=09 lock->l_whence, lock->l_start, lock->l_len);
> =20
> -=09if (sleep) {
> -=09=09fuse_reply_err(req, EOPNOTSUPP);
> -=09=09return;
> -=09}
> -
>  =09inode =3D lo_inode(req, ino);
>  =09if (!inode) {
>  =09=09fuse_reply_err(req, EBADF);
> @@ -1950,21 +1948,54 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t i=
no,
> =20
>  =09if (!plock) {
>  =09=09saverr =3D ret;
> +=09=09pthread_mutex_unlock(&inode->plock_mutex);
>  =09=09goto out;
>  =09}
> =20
> +=09/*
> +=09 * plock is now released when inode is going away. We already have
> +=09 * a reference on inode, so it is guaranteed that plock->fd is
> +=09 * still around even after dropping inode->plock_mutex lock
> +=09 */
> +=09ofd =3D plock->fd;
> +=09pthread_mutex_unlock(&inode->plock_mutex);
> +
> +=09/*
> +=09 * If this lock request can block, request caller to wait for
> +=09 * notification. Do not access req after this. Once lock is
> +=09 * available, send a notification instead.
> +=09 */
> +=09if (sleep && lock->l_type !=3D F_UNLCK) {
> +=09=09/*
> +=09=09 * If notification queue is not enabled, can't support async
> +=09=09 * locks.
> +=09=09 */
> +=09=09if (!se->notify_enabled) {
> +=09=09=09saverr =3D EOPNOTSUPP;
> +=09=09=09goto out;
> +=09=09}
> +=09=09async_lock =3D true;
> +=09=09unique =3D req->unique;
> +=09=09fuse_reply_wait(req);
> +=09}
>  =09/* TODO: Is it alright to modify flock? */
>  =09lock->l_pid =3D 0;
> -=09ret =3D fcntl(plock->fd, F_OFD_SETLK, lock);
> +=09if (async_lock)
> +=09=09ret =3D fcntl(ofd, F_OFD_SETLKW, lock);
> +=09else
> +=09=09ret =3D fcntl(ofd, F_OFD_SETLK, lock);

What happens if the guest is rebooted after it's asked
for, but not been granted a lock?

Dave

>  =09if (ret =3D=3D -1) {
>  =09=09saverr =3D errno;
>  =09}
> =20
>  out:
> -=09pthread_mutex_unlock(&inode->plock_mutex);
>  =09lo_inode_put(lo, &inode);
> =20
> -=09fuse_reply_err(req, saverr);
> +=09if (!async_lock)
> +=09=09fuse_reply_err(req, saverr);
> +=09else {
> +=09=09fuse_lowlevel_notify_lock(se, unique, saverr);
> +=09}
>  }
> =20
>  static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


