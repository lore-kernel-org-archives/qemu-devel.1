Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA9C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:13:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B7BD207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZRPvmcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7BD207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48261 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MM7-0002EM-T2
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1j4MLX-0001gk-F7
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1j4MLW-0000sF-Iv
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:12:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50222
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1j4MLW-0000rM-Dx
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582107165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0Q25intjI3DQxhOEW+qHO0daxF4Kr/JDBqcD2q6BvQ=;
 b=IZRPvmcJDRCO7UHb+5ymEswQXn8xISpeffEWNH7j6lzK8ILkJctu7B8QrqzswqZ8yHU9LT
 ndcYyD76W7E3U4/2pecgYUyb1En7wcurwwEFIkA+KZBgDv33Ih0hLHjg3Mhs3TAzS9AfI2
 VNoDryh0iegPih1DTMDL5fPN52lIsQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-A9QJmJmrMqKIAfAuCHPjLQ-1; Wed, 19 Feb 2020 05:12:41 -0500
X-MC-Unique: A9QJmJmrMqKIAfAuCHPjLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C0AE18FE888;
 Wed, 19 Feb 2020 10:12:40 +0000 (UTC)
Received: from localhost (unknown [10.33.36.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2DFF60BE1;
 Wed, 19 Feb 2020 10:12:35 +0000 (UTC)
Date: Wed, 19 Feb 2020 11:12:34 +0100
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/5] aio-posix: don't pass ns timeout to epoll_wait()
Message-ID: <20200219101234.pqy4kca5z7ywv2rm@dritchie>
References: <20200214171712.541358-1-stefanha@redhat.com>
 <20200214171712.541358-3-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214171712.541358-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7q2gfjcbmleg5bvx"
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7q2gfjcbmleg5bvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 05:17:09PM +0000, Stefan Hajnoczi wrote:
> Don't pass the nanosecond timeout into epoll_wait(), which expects
> milliseconds.
>=20
> The epoll_wait() timeout value does not matter if qemu_poll_ns()
> determined that the poll fd is ready, but passing a value in the wrong
> units is still ugly.  Pass a 0 timeout to epoll_wait() instead.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/aio-posix.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--7q2gfjcbmleg5bvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl5NCg8ACgkQ9GknjS8M
AjWfHhAAuMJZkHXP93f2bQ7SPjddth1hoF/GRUl+csuZ/73gsEwcVjpY5E+VAsT3
w8mbmg5x84i1tPFcSaVVLjsxNhytOQbRTq3PEMtR9m6jYS/DB8LrfVT/sdi6eetN
LitHT/ehkWBDwsuRkOGBMamOXJON+gH1K7SN5T22gcpLX26axIXjfdBvhBLnElEa
cHWqhyp/ncmcM2tdOy2uDcOn982Y+ff1xCYsY2k6Uf37zh+knMWktFUI2Up3oFDe
4OEGsNr9uaiQtNbsSOSOmnWganYM/4oYoUvUcs3B4l7OEGChwEbBCp2ZJvHsn6d+
SpYVp/24T8mm35NhJeKRL+SPW+L2oOSk7YPUVTjkLhqgD1yIS+jpjVtcIgEYoByH
fA/NX5aZcPwlAUI2llSI5csAoD2vPsmBfkCEwp63Fp3CIKQ4PA3SvmLilETXvL0n
Qd2Ndr1KLiT3V60XkAN7RoDqL+CIbnNs/vxFxWBPa2BjyIjhJzrdtB46daJfai4I
gXeBFVLttOcN8NMxwdXQwuNNXyaMBAsSabqJKHxalyZXqH0Wa+IHTDuVIyQttpNz
nGx4+bQ0BRm7SOHqzcYZz2IN8NF++kXUnomRkBGpVFnxM0zpMtjrqUkjhbGyMdBY
lxToaWGye9Q8hqQZ/89driT7sDQ3/RnvC+WzxridmStHBAtwfgk=
=Tms9
-----END PGP SIGNATURE-----

--7q2gfjcbmleg5bvx--


