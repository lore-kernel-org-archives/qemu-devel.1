Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E51C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44EB20863
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 15:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9DJ29y/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44EB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGW7-0002Vx-Md
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 10:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33608)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iZGS0-0007Kf-Ro
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iZGRz-0000Ni-DD
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:38:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32948
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iZGRz-0000N5-94
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 10:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574696334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vueCLd2IfoRk1e1hzZmvXxOiXal1PfYRzga8lO1nKOU=;
 b=U9DJ29y/rFrVYVZxNEVEr0zeftpTKBpbAjogo+jTRwawTEmF6hlH+Z9RsUXnSmxlUhVqJa
 47HnYmr4PRd0Q7zCJeLTlCNl3X7yF56hyQmuIydCyET/Io2IZjDOrsL3BYLnbpauHKHFuV
 cKP07s4VgojvvmAlkatKxxVNiebJAUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-M-HZ0h5bMqezLh4V122Obw-1; Mon, 25 Nov 2019 10:38:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC6ED1856A74;
 Mon, 25 Nov 2019 15:38:51 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F05885D6AE;
 Mon, 25 Nov 2019 15:38:45 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 78BC522062B; Mon, 25 Nov 2019 10:38:45 -0500 (EST)
Date: Mon, 25 Nov 2019 10:38:45 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [Virtio-fs] [PATCH 4/4] virtiofsd: Implement blocking posix locks
Message-ID: <20191125153845.GB13247@redhat.com>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-5-vgoyal@redhat.com>
 <20191122105324.GE464656@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191122105324.GE464656@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: M-HZ0h5bMqezLh4V122Obw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org, miklos@szeredi.hu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 22, 2019 at 10:53:24AM +0000, Stefan Hajnoczi wrote:
> On Fri, Nov 15, 2019 at 03:55:43PM -0500, Vivek Goyal wrote:
> > diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse=
_lowlevel.c
> > index d4a42d9804..f706e440bf 100644
> > --- a/contrib/virtiofsd/fuse_lowlevel.c
> > +++ b/contrib/virtiofsd/fuse_lowlevel.c
> > @@ -183,7 +183,8 @@ int fuse_send_reply_iov_nofree(fuse_req_t req, int =
error, struct iovec *iov,
> >  {
> >  =09struct fuse_out_header out;
> > =20
> > -=09if (error <=3D -1000 || error > 0) {
> > +=09/* error =3D 1 has been used to signal client to wait for notificai=
ton */
> > +=09if (error <=3D -1000 || error > 1) {
> >  =09=09fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n",=09error);
> >  =09=09error =3D -ERANGE;
> >  =09}
>=20
> What is this?

When a waiting lock request comes in, we need a way to reply back saying
wait for the notification. So I used value "1" for the
fuse_out_header->error field for this purpose. As of now, 0 is returned
for success and negative values for error code. So positive values seem
to be unused.

>=20
> > +int fuse_lowlevel_notify_lock(struct fuse_session *se, uint64_t req_id=
,
> > +=09=09=09      int32_t error)
> > +{
> > +=09struct fuse_notify_lock_out outarg;
>=20
> Missing =3D {} initialization to avoid information leaks to the guest.

Will do.

>=20
> > @@ -1704,6 +1720,15 @@ int fuse_lowlevel_notify_delete(struct fuse_sess=
ion *se,
> >  int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino=
,
> >  =09=09=09       off_t offset, struct fuse_bufvec *bufv,
> >  =09=09=09       enum fuse_buf_copy_flags flags);
> > +/**
> > + * Notify event related to previous lock request
> > + *
> > + * @param se the session object
> > + * @param req_id the id of the request which requested setlkw
>=20
> The rest of the code calls this id "unique":

Will change it.

>=20
>   + * @param req_unique the unique id of the setlkw request
>=20
> > +    /* Pop an element from queue */
> > +    req =3D vu_queue_pop(dev, q, sizeof(FVRequest), &bad_in_num, &bad_=
out_num);
> > +    if (!req) {
> > +        /* TODO: Implement some sort of ring buffer and queue notifica=
tions
> > +=09 * on that and send these later when notification queue has space
> > +=09 * available.
> > +=09 */
> > +        return -ENOSPC;
>=20
> Ah, I thought the point of the notifications processing thread was
> exactly this case.  It could wake any threads waiting for buffers.
>=20
> This wakeup could be implemented with a condvar - no ring buffer
> necessary.

I was thinking that thread sending notification should not block. It can
just queue the notification reuqest and some other thread (including
notification thread could send it later). Number of pre-allocated buffers
could be of fixed and we will drop notifications if guest is not
responding. This will also take care of concerns w.r.t rogue guest
blocking filesystem code in daemon.

Anyway, this is a TODO item and not implemented yet.=20

Thanks
Vivek


