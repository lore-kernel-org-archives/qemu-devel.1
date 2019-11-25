Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89500C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D63420863
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RF/79yG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D63420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGam-0007Cv-WA
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iZGXI-0004RA-A8
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iZGXH-0008Oa-3R
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:44:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iZGXG-0008JG-AU
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2B3Z6C1Vmgp40AldSOWALXyN1DANyIpbKswZr33Dlk=;
 b=RF/79yG2fIFVqYmWH2rktLKXmw1zO4U65T0u267ZKNtNU/LGUk0RbHfAVnCSiBgDWZiY/a
 93xF9xLp4pmms1Gi7hQllD8fKKXVzb5h/SMhdiNaBes+CvHgxKIE0mOjG6aOu+2wbfxEAQ
 nWTE2XSehXSDK42TGt/vUwocvclsuUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-98oJT-1ONmqgNt_NarwP1w-1; Mon, 25 Nov 2019 10:44:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A2908C501A;
 Mon, 25 Nov 2019 15:44:19 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A69F010018FF;
 Mon, 25 Nov 2019 15:44:14 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 285E222062B; Mon, 25 Nov 2019 10:44:14 -0500 (EST)
Date: Mon, 25 Nov 2019 10:44:14 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 4/4] virtiofsd: Implement blocking posix locks
Message-ID: <20191125154414.GC13247@redhat.com>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-5-vgoyal@redhat.com>
 <20191122174732.GL2785@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191122174732.GL2785@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 98oJT-1ONmqgNt_NarwP1w-1
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, miklos@szeredi.hu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 05:47:32PM +0000, Dr. David Alan Gilbert wrote:

[..]
> > +static int virtio_send_notify_msg(struct fuse_session *se, struct iove=
c *iov,
> > +=09=09=09=09  int count)
> > +{
> > +    struct fv_QueueInfo *qi;
> > +    VuDev *dev =3D &se->virtio_dev->dev;
> > +    VuVirtq *q;
> > +    FVRequest *req;
> > +    VuVirtqElement *elem;
> > +    unsigned int in_num, bad_in_num =3D 0, bad_out_num =3D 0;
> > +    struct fuse_out_header *out =3D iov[0].iov_base;
> > +    size_t in_len, tosend_len =3D iov_size(iov, count);
> > +    struct iovec *in_sg;
> > +    int ret =3D 0;
> > +
> > +    /* Notifications have unique =3D=3D 0 */
> > +    assert (!out->unique);
> > +
> > +    if (!se->notify_enabled)
> > +        return -EOPNOTSUPP;
> > +
> > +    /* If notifications are enabled, queue index 1 is notification que=
ue */
> > +    qi =3D se->virtio_dev->qi[1];
> > +    q =3D vu_get_queue(dev, qi->qidx);
> > +
> > +    pthread_rwlock_rdlock(&qi->virtio_dev->vu_dispatch_rwlock);
> > +    pthread_mutex_lock(&qi->vq_lock);
> > +    /* Pop an element from queue */
> > +    req =3D vu_queue_pop(dev, q, sizeof(FVRequest), &bad_in_num, &bad_=
out_num);
>=20
> You don't need bad_in_num/bad_out_num - just pass NULL for both; they're
> only needed if you expect to read/write data that's not mappable (i.e.
> in our direct write case).

Will do.

[..]
> > @@ -1950,21 +1948,54 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t=
 ino,
> > =20
> >  =09if (!plock) {
> >  =09=09saverr =3D ret;
> > +=09=09pthread_mutex_unlock(&inode->plock_mutex);
> >  =09=09goto out;
> >  =09}
> > =20
> > +=09/*
> > +=09 * plock is now released when inode is going away. We already have
> > +=09 * a reference on inode, so it is guaranteed that plock->fd is
> > +=09 * still around even after dropping inode->plock_mutex lock
> > +=09 */
> > +=09ofd =3D plock->fd;
> > +=09pthread_mutex_unlock(&inode->plock_mutex);
> > +
> > +=09/*
> > +=09 * If this lock request can block, request caller to wait for
> > +=09 * notification. Do not access req after this. Once lock is
> > +=09 * available, send a notification instead.
> > +=09 */
> > +=09if (sleep && lock->l_type !=3D F_UNLCK) {
> > +=09=09/*
> > +=09=09 * If notification queue is not enabled, can't support async
> > +=09=09 * locks.
> > +=09=09 */
> > +=09=09if (!se->notify_enabled) {
> > +=09=09=09saverr =3D EOPNOTSUPP;
> > +=09=09=09goto out;
> > +=09=09}
> > +=09=09async_lock =3D true;
> > +=09=09unique =3D req->unique;
> > +=09=09fuse_reply_wait(req);
> > +=09}
> >  =09/* TODO: Is it alright to modify flock? */
> >  =09lock->l_pid =3D 0;
> > -=09ret =3D fcntl(plock->fd, F_OFD_SETLK, lock);
> > +=09if (async_lock)
> > +=09=09ret =3D fcntl(ofd, F_OFD_SETLKW, lock);
> > +=09else
> > +=09=09ret =3D fcntl(ofd, F_OFD_SETLK, lock);
>=20
> What happens if the guest is rebooted after it's asked
> for, but not been granted a lock?

I think a regular reboot can't be done till a request is pending, because
virtio-fs can't be unmounted and unmount will wait for all pending
requests to finish.

Destroying qemu will destroy deamon too.

Are there any other reboot paths I have missed.

Thanks
Vivek


