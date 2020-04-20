Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD94DC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B1E2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Grt2UG6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B1E2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZDA-0004eJ-Pc
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48372 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZCN-00047x-4r
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:23:07 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jQZCM-0005Gl-PK
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:23:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51994
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jQZCM-0005GC-DQ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587399785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v/7ONRnho5hgL0bAXCXHN41RKW9g1UdKFGuzd/aV3uk=;
 b=Grt2UG6vWgiudfmGwzRgqpPCZYtVFAKJ9R9XlNZZ/IwnsZzEbEGYjAdTMAo4A6h1IXRZgQ
 /N5vLDWUHApk0rFoa1YABvjrXrpHcbPU4rAV63MUnsXDylYoLetZF3Dy1LiZqq2ZtBTIoD
 abt5cljid/fMipTzJl8UY1BFH4xkYF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-zyxPovmgMsuYSEXjd2UsZQ-1; Mon, 20 Apr 2020 12:22:58 -0400
X-MC-Unique: zyxPovmgMsuYSEXjd2UsZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0A57107B274;
 Mon, 20 Apr 2020 16:22:56 +0000 (UTC)
Received: from localhost (ovpn-112-169.ams2.redhat.com [10.36.112.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E9B45DA7C;
 Mon, 20 Apr 2020 16:22:55 +0000 (UTC)
Date: Mon, 20 Apr 2020 17:22:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 5/9] block/io: expand in_flight inc/dec section: simple
 cases
Message-ID: <20200420162255.GE7321@stefanha-x1.localdomain>
References: <20200408093051.9893-1-vsementsov@virtuozzo.com>
 <20200408093051.9893-6-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200408093051.9893-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 09:01:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 12:30:47PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> It's safer to expand in_flight request to start before enter to

Please explain what exeactly "safer" means.  If I understand correctly
this is just a refactoring and does not fix bugs that have been hit in
the real world.

Is this just a generate attempt to avoid accidentally performing
operations that need to happen as part of the request after the dec
call?

> @@ -2718,17 +2746,18 @@ bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVe=
ctor *qiov, int64_t pos,
>              ret =3D drv->bdrv_save_vmstate(bs, qiov, pos);
>          }
>      } else if (bs->file) {
> -        ret =3D bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
> +        bdrv_inc_in_flight(bs->file->bs);
> +        ret =3D bdrv_do_rw_vmstate(bs->file->bs, qiov, pos, is_read);
> +        bdrv_dec_in_flight(bs->file->bs);

Here we inc/dec...

>      }
> =20
> -    bdrv_dec_in_flight(bs);
>      return ret;
>  }
> =20
>  static void coroutine_fn bdrv_co_rw_vmstate_entry(void *opaque)
>  {
>      BdrvVmstateCo *co =3D opaque;
> -    co->ret =3D bdrv_co_rw_vmstate(co->bs, co->qiov, co->pos, co->is_rea=
d);
> +    co->ret =3D bdrv_do_rw_vmstate(co->bs, co->qiov, co->pos, co->is_rea=
d);

...here we don't.  The code is correct, but bdrv_co_rw_vmstate_entry()
should also document that its caller must inc/dec.

> @@ -2950,7 +2994,7 @@ static void coroutine_fn bdrv_flush_co_entry(void *=
opaque)
>  {
>      FlushCo *rwco =3D opaque;
> =20
> -    rwco->ret =3D bdrv_co_flush(rwco->bs);
> +    rwco->ret =3D bdrv_do_flush(rwco->bs);
>      aio_wait_kick();
>  }

This function should also document that the caller must inc/dec.

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6dzF4ACgkQnKSrs4Gr
c8ikQAf+I/Ipo63QbabB6PkX+wgDWdwBEcOqPLGCEq7EEMEIf5vY1MH/twuDJAqH
cfXwgdpKvM75cwLTC/Wd9Bejqtb7I2dbbl6p7M2QNlHWHwgxqCLnomQ35jA6b0mh
wdJY/FOC6iWgOGMV2JovRj/D9hBxrh/970vcDIwrZxGbUQNeuA6u/51IqZ2SwJrb
L7tRuy3WUqa/Qd0BpusZjYo2BPp0qy/ppq//pfSa6HkIzOVsSON/EmQZ5RWAeAvb
0ZRzZdpwD0mklR5LNb5n6R1SfoQbhIf5SSqh1KtlKDCMU2cX531Tkz6srcjBlFMJ
+mNSikXNuE4A/6nEzQRMzIK+RCELtQ==
=Kchi
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--


