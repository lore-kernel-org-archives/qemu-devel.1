Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE099C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC9F20706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwU67UvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC9F20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6Zr-0001kT-R9
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:54:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iY6ZF-0001Ll-6J
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iY6ZD-0003gh-Bi
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:53:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iY6ZC-0003g1-Sr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574420013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJjhlnuxjnQWIYrYsubHpbHoq1lTU3RmkdWg++9X1Bo=;
 b=UwU67UvVrcHi5nJrjMHvqFYYkWq+29WAMCS9pRKV6pQUjeHgN2oJCWrxcv9cFLJjKygYQa
 U9Y3tpLNl1QDbXGjB0yP37osFUR6Jj8ebI4vwEtL70t+91rX0gBt6Q6qWRMSp0dzGtrPs6
 GhoOlQlMQLjE7kG3iTPghK2XxL2DJcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-XgHiREysNA-wMx6DyTBePg-1; Fri, 22 Nov 2019 05:53:30 -0500
X-MC-Unique: XgHiREysNA-wMx6DyTBePg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DD0B801FCF;
 Fri, 22 Nov 2019 10:53:29 +0000 (UTC)
Received: from localhost (unknown [10.36.118.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12E9D5D6A3;
 Fri, 22 Nov 2019 10:53:25 +0000 (UTC)
Date: Fri, 22 Nov 2019 10:53:24 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 4/4] virtiofsd: Implement blocking posix locks
Message-ID: <20191122105324.GE464656@stefanha-x1.localdomain>
References: <20191115205543.1816-1-vgoyal@redhat.com>
 <20191115205543.1816-5-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191115205543.1816-5-vgoyal@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
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
Cc: virtio-fs@redhat.com, miklos@szeredi.hu, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 03:55:43PM -0500, Vivek Goyal wrote:
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

What is this?

> +int fuse_lowlevel_notify_lock(struct fuse_session *se, uint64_t req_id,
> +=09=09=09      int32_t error)
> +{
> +=09struct fuse_notify_lock_out outarg;

Missing =3D {} initialization to avoid information leaks to the guest.

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

The rest of the code calls this id "unique":

  + * @param req_unique the unique id of the setlkw request

> +    /* Pop an element from queue */
> +    req =3D vu_queue_pop(dev, q, sizeof(FVRequest), &bad_in_num, &bad_ou=
t_num);
> +    if (!req) {
> +        /* TODO: Implement some sort of ring buffer and queue notificati=
ons
> +=09 * on that and send these later when notification queue has space
> +=09 * available.
> +=09 */
> +        return -ENOSPC;

Ah, I thought the point of the notifications processing thread was
exactly this case.  It could wake any threads waiting for buffers.

This wakeup could be implemented with a condvar - no ring buffer
necessary.

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3XviQACgkQnKSrs4Gr
c8g5LQf+N8ESaD28Mf2cGPPZObPij/PeF22lT7FxU2vFcdg4vgUtR8dZ34jgJYrs
vPZe4V2KVGzWaO9beRGnh7XcCFRGaG3aFcJePYVcPddqdcvnxBRdSTPF0gGrGooZ
2pphDCRfhJmGdB/heRUX3pKy/t++2boypXCLBMos0hbQSbmF52Bbdyo7wvtkU/Sl
2UKMUxmI4REf0UVZ6MHuGbH3GmCxD/8KquCTGZK/+KKnPlgQtYB7AMuvtGiIlVhY
3tYuGLNzysF3M/sTYS0n+KeAdpQDe5MyVJw7b3vOb8tYV6uehNcGxg/7odzJ/OI5
e3h7UHbUqFQrAHkOgVnT91fD0AuQuQ==
=UkZX
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--


