Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1726C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F214206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO3j/EbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F214206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4N6p-0000SJ-QX
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1j4N5u-0008Fz-HR
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1j4N5t-00028q-7V
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:00:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1j4N5t-00027x-2M
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:00:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582110040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yne3PauuSKqY9OWEQTNh6ZqEpe0KDFYPuIZTS4K0erA=;
 b=ZO3j/EbRi1gQ2PGdz+fo7SUgp2NblDPF2GVgONlAfd+CJsEApuBgr5bWS15f5abPDPY22k
 qytRX8eF9SkzKciVsF209alZs4UM1+zxx5O/cdH13WQZBPHWCDxfsGEris9Xfb4Z1EaPNZ
 JdQ8Nf0SssL8QdMrYUikIXP/AY5hSvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-juskXs7oOCqDk5BKyoivhw-1; Wed, 19 Feb 2020 06:00:29 -0500
X-MC-Unique: juskXs7oOCqDk5BKyoivhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D9D1800D50;
 Wed, 19 Feb 2020 11:00:28 +0000 (UTC)
Received: from localhost (unknown [10.33.36.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FE135DA60;
 Wed, 19 Feb 2020 11:00:21 +0000 (UTC)
Date: Wed, 19 Feb 2020 12:00:20 +0100
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 5/5] aio-posix: make AioHandler dispatch O(1) with epoll
Message-ID: <20200219110020.skv7p46kuisumtxx@dritchie>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-6-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214171712.541358-6-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fhm6drre23rcwcmn"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fhm6drre23rcwcmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 05:17:12PM +0000, Stefan Hajnoczi wrote:
> File descriptor monitoring is O(1) with epoll(7), but
> aio_dispatch_handlers() still scans all AioHandlers instead of
> dispatching just those that are ready.  This makes aio_poll() O(n) with
> respect to the total number of registered handlers.
>=20
> Add a local ready_list to aio_poll() so that each nested aio_poll()
> builds a list of handlers ready to be dispatched.  Since file descriptor
> polling is level-triggered, nested aio_poll() calls also see fds that
> were ready in the parent but not yet dispatched.  This guarantees that
> nested aio_poll() invocations will dispatch all fds, even those that
> became ready before the nested invocation.
>=20
> Since only handlers ready to be dispatched are placed onto the
> ready_list, the new aio_dispatch_ready_handlers() function provides O(1)
> dispatch.
>=20
> Note that AioContext polling is still O(n) and currently cannot be fully
> disabled.  This still needs to be fixed before aio_poll() is fully O(1).
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/aio-posix.c | 106 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 76 insertions(+), 30 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--fhm6drre23rcwcmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl5NFUMACgkQ9GknjS8M
AjUIPg//WNSjGeatq3LUJixhYcsR5VUZEX6rF+yd2dY4NLdHeJxIapp5ZbNitsxC
sKPoOlaWLgJh+iPjjWFA4GyoCBnCUH9JU6GJ0WVydypNkD1hdhJg5AQ7mfIWocuy
JWZI36feaAOSN8YdVrv3me8hPBSpNAAMbZOASUEkR1EXOWV8K+G2Y/HrHntgwMFz
0p6FFVxlMboSlRbwZGQRErpojsM08xbKF8gXEPlX7chcUtMO9ODhp0PYSat0qNqa
zQGfSgMtbj9y6DfVP55XvuygdCjD0z2eYj0Vxognri7HXI29smFizvMGr5nRAaTz
qvdDWWDSriWyvD2UTxplkbd/gQFmjrmAhftpZ9tm4asVeVSrr+Z2Dk2g96cYEPFO
0AgnyUaTUyx1GYMkOhcw+Gk2t5IRin26gaUxzmuduWW82F6sQmgxIqYR3zM1nDAq
fDF5iI7rH5DBT+BbBdGu916e98nwiscrVrMVYpV/g2n6wf+LAG9uLrHQ22x6Isg/
Lf+MsD+rgG9TOgKo2ZJf31N19HxitKzBUGKflWGYYDg8pV25YcpUgcE5JfBdjSTw
pb3ZQlwk80MJYepPKLd1ogommIdyJyKc4Rr44qTuGzfNAtlnXBoRv5ownK4VXRXH
9nzB/m0Up2CySYzBQi0SYmJ2nb7ZG0G0UJvCh34E3g/O6kjO5Hg=
=Jji+
-----END PGP SIGNATURE-----

--fhm6drre23rcwcmn--


