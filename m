Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ED2C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613BA20781
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 11:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GC9HaZ/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613BA20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKxq-0006rM-GC
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 07:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jGKxB-0006L3-Hs
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jGKxA-0006Na-IP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:09:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jGKxA-0006NP-FW
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 07:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584961748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=blq00iX1aL/K1XLYxYsk47OkOM5C1ZH5LjO7+zwER04=;
 b=GC9HaZ/wfym3LzdPbrF0LHp/lQ8QQFPVUo8ZqiZEzqXA+te/XekJLI+RgbRdVFbj5qsc4V
 TxMNdje6eHWZe+sYn8cIIowYEwwm0fkuc/QF1ZKR2s7wlOweuOG4d3C1C6C/WiyIVi2mvj
 hz6YHtCK/tKFfqlJkuCoChpniKxSGB4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-YOU9MXiJPji819Vnsp6vDA-1; Mon, 23 Mar 2020 07:09:04 -0400
X-MC-Unique: YOU9MXiJPji819Vnsp6vDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EEE6101FC68;
 Mon, 23 Mar 2020 11:09:03 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74D4060BE2;
 Mon, 23 Mar 2020 11:09:02 +0000 (UTC)
Date: Mon, 23 Mar 2020 11:08:58 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0] tools/virtiofsd/passthrough_ll: Fix double close()
Message-ID: <20200323110858.GD261260@stefanha-x1.localdomain>
References: <20200321120654.7985-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200321120654.7985-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2020 at 01:06:54PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On success, the fdopendir() call closes fd. Later on the error
> path we try to close an already-closed fd. This can lead to
> use-after-free. Fix by only closing the fd if the fdopendir()
> call failed.
>=20
> Cc: qemu-stable@nongnu.org
> Fixes: 7c6b66027 (Import passthrough_ll from libfuse fuse-3.8.0)
> Reported-by: Coverity (CID 1421933 USE_AFTER_FREE)
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl54mMoACgkQnKSrs4Gr
c8j70Af+MP95sNWQcvToeAeZu/LFTD2cjbs7PM9PXaTDRYI5O3yx6SrSfg4A8xKu
jZJmRPWf9QARwqiFcBF//4utwprR5z+8jigARSTpyJ0KMgeymOH7K4N5zBWwMtmn
Am2jbearXg5eR5bFlmTxsP0ixrIQTMEov2V0yVlRirWshb4THCaFRtxVe4Hb8kSX
P+ccOryyyJ2vo70KYnMVIHaU0Uj+NFjP49ZcAis0NwIlWT+5YBLCm8xHMHJQTUcb
cPOl3eu73vY7Ae6fPd7GAx6EUZUCy7ag4TAchIESKU1yaiJW8kZE00VWeQBX9S8k
e11m+pkkgAoteNGO+Qhwp1xiWFgz/Q==
=wN7S
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--


