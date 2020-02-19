Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF14C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2738208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 07:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SkfdTI1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2738208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4JOJ-00044I-UP
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 02:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1j4JNi-0003bN-F5
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1j4JNg-00025O-UV
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:02:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38266
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1j4JNg-000217-QC
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 02:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582095768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bFB6zlnK2j79tfTSS3W6x8nalCK86w/vMI1IKEymT5E=;
 b=SkfdTI1UQju8luJkD8B1fwRmP/sDLZNijdFpM81uMxDuXbn7kP4ERVKjqmP+1bNpBafC/J
 MBG62xxz3tgSlhtt/9TuxR27KVML8RHxqYiPg7eeg+TIGty7Tz4/g/FPzkHDvRljvdQrse
 8ojUt+vF+sogW6/2DI1/WQ6jKliuq2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-CVhk91vWPNandr8Z0MUhwQ-1; Wed, 19 Feb 2020 02:02:44 -0500
X-MC-Unique: CVhk91vWPNandr8Z0MUhwQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 034F21005516;
 Wed, 19 Feb 2020 07:02:43 +0000 (UTC)
Received: from localhost (unknown [10.33.36.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDBE462660;
 Wed, 19 Feb 2020 07:02:36 +0000 (UTC)
Date: Wed, 19 Feb 2020 08:02:35 +0100
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/5] aio-posix: fix use after leaving scope in aio_poll()
Message-ID: <20200219070158.ib3rzi5lci5kxy43@dritchie>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214171712.541358-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cqo5pr5ttwian6kq"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cqo5pr5ttwian6kq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 05:17:08PM +0000, Stefan Hajnoczi wrote:
> epoll_handler is a stack variable and must not be accessed after it goes
> out of scope:
>=20
>       if (aio_epoll_check_poll(ctx, pollfds, npfd, timeout)) {
>           AioHandler epoll_handler;
>           ...
>           add_pollfd(&epoll_handler);
>           ret =3D aio_epoll(ctx, pollfds, npfd, timeout);
>       } ...
>=20
>   ...
>=20
>   /* if we have any readable fds, dispatch event */
>   if (ret > 0) {
>       for (i =3D 0; i < npfd; i++) {
>           nodes[i]->pfd.revents =3D pollfds[i].revents;
>       }
>   }
>=20
> nodes[0] is &epoll_handler, which has already gone out of scope.
>=20
> There is no need to use pollfds[] for epoll.  We don't need an
> AioHandler for the epoll fd.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/aio-posix.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--cqo5pr5ttwian6kq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl5M3YoACgkQ9GknjS8M
AjWnahAAoeViVpa7fqFb4zfrFAjkXGdsc93iuUtY9CWBG9y7DExWZ6KHCLIvt96S
G2x2MwjUhAsdF12prRNzuA8yRLUVxqElou/2shpqnG1C+cDr/Ga23nT/REH3E+Kp
QDLSPdkxi4HAhgsxjBjeSEBiSQMdg6WDau2Tk2GKQp3phhNmfsU+yHxrltAdaVhD
/VwOsmQFSAJfd5GoPLKQG6zLa1IKjrgNmzoiRTGZXfF/rs2pBD8ihQfdaAGeagKi
V3IBKqwZ74ik3WLO7S8O6Kq9Z2GQo29KInCtBpuE7m8TLa/sVWr55Uq69IFiCjA9
tb/0Es7X69uMoP3QCt5t1rYLEUe6KffqmEO/F687mJvft8VbBTuFuTJ63n2818Gx
u9+nkA2j0B9NL6bufBW998B6Mm05B8fjUO1v5a0omf7RUBpTTdxVzdc8lIMjp7Om
YvBVfUuIECeyPs3+25MW6jSq0iMvuuKqiyOoTQ+BumjuIi3+fB1fNO0y8JSy1ick
hOlLxNNnoBkJRMr25XWdHAd1MAD5bn5BhtpPG3bGhkfGlNjEFZ1jy17ROpU/ZGhA
hqH3HkNegZ/EgLz0BjpM2hHwhXPt+WE9ktmwlTmnHy92/13LQJK2BtnSFH9VnTZh
BOz0KKXHTgeTHx6ZFvusXh/3YDnWJJ/+cQrxzvDcq34gmqByeZU=
=BDkW
-----END PGP SIGNATURE-----

--cqo5pr5ttwian6kq--


