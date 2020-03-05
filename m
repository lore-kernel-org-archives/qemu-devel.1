Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3ACC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:51:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D1F2073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 06:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bh62F3Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D1F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9kLy-0004vV-97
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 01:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j9kLJ-0004UG-1V
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:50:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j9kLH-0001tI-Rf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:50:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j9kLH-0001sr-Nk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 01:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583391046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hWxss+r8tjv9gbg0AoPLOLtNg7gHmKp68MzqrxhkTFg=;
 b=Bh62F3AvunQwMheKH/EgI5UgbfxOGCW2TgVsBBwHE+Nbsf5p/ib1GKk67jd9NvnFDgR758
 er2P/T10BbuIl2QNDy6bA6o2+KELsiAdqYPGu8sNNa6cdYxrdB/aQvfUrRPXBIEGvcQ030
 lWZvCszKxw/+4kzOix1LTRkMd+pySjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-DEdpz8gNPXaXqHz4oU7L_g-1; Thu, 05 Mar 2020 01:50:43 -0500
X-MC-Unique: DEdpz8gNPXaXqHz4oU7L_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AAC48010F7;
 Thu,  5 Mar 2020 06:50:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-15.rdu2.redhat.com
 [10.10.123.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46EF973880;
 Thu,  5 Mar 2020 06:50:32 +0000 (UTC)
Date: Thu, 5 Mar 2020 01:50:30 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20200305065030.GA4706@localhost.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <CAFEAcA--Rag8JzvPP+Pvkebv1ifeZkpcx7zSXdDBkpZWmpZwxQ@mail.gmail.com>
 <20200203032700.GA12127@localhost.localdomain>
 <CAFEAcA-h3fJaBm+DSn6VQ=sgdS4x67MT_biyeTohk__JzkACMw@mail.gmail.com>
 <20200207203856.GA17041@localhost.localdomain>
 <CAFEAcA9uodvAUzObR1dS3ecm-sqApO3LFHHfzqG_G+n35w_OXw@mail.gmail.com>
 <CAFEAcA8v9jVODvvqDkZhC9KpRTX1FYBQtHTxiy45UwHLZ73EUg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8v9jVODvvqDkZhC9KpRTX1FYBQtHTxiy45UwHLZ73EUg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
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
Cc: Jeff Nelson <jen@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2020 at 03:27:42PM +0000, Peter Maydell wrote:
>=20
> Hi -- any progress on this front? (Maybe I missed an email; if
> so, sorry about that...)
>=20
> thanks
> -- PMM
>=20

Hi Peter,

Yes, I've made some progress on some of the points raised on the last
email exchanges:

 1) Jobs on non-Linux OS. I've built/setup gitlab-runner for FreeBSD,
    and tested a job:
    - https://gitlab.com/cleber.gnu/qemuci/-/jobs/440379169
   =20
    There are some limitations on a library that gitlab-runner uses to
    manage services (and that has no implementation for FreeBSD "services")=
.
    But, there are workarounds that work allright.

 2) Wrote a script that checks/waits on the pipeline:
    - https://gitlab.com/cleber.gnu/qemuci/-/commit/d90c5cf917c43f06c0724dc=
025205d618521c4cc

 3) Wrote machine setup documentation/scripts.

I'm tidying it all up to send a PR in the next day or two.

Thanks for your patience!
- Cleber.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5goTMACgkQZX6NM6Xy
CfOXJw//Upo5TYX4/Nrhj4y3X/SLt9Rd3C5jACyOxq7wSzoCWSNA7D8T0bmI/T32
cUVLDxHzfmdC8eTMyn5IjIHj2tTEnKJIOmHM/nVQFWX0GNIArid4qGxw/p/n+wAK
5ozY1zAyufT0LwhqxBrotE5ZY8/qqimH73v+he6LqnIAe4m/ULUtQf32jJf232IA
NJDUymd3jn+fsKR9qXtbCqIxDrN6b4FobbktxqVo/J/uOwl1ByhvBl4u7BmuSNfv
/UbvLJ0vh9MZozcawAoOaRVkpGaPwSG8+z8zFpsQHSN4jtPecBU3/CPU72oPS4eq
2fFHAWIIZHym/EgM9WB8fSuyFJKMCpGEF8Vjb/mFdCMuJSEtIxvqiO66K96Abwf1
62e1jdi+yjgRQj2u2pIDFPW/z240qCadoEsf1KwANMiUM+l4od2Uib5SljkN+uf4
DuJixO2NOx2NPry4pvaycAfltR0bk6+zIpeqAqIbO4Jm54WSV5iDPqj4zkdCc9bb
hPGmOxhdw1Yejia4SLsw2uUnF1IsX1a+0/Af6F1IFDKITh1D+iRz7OahqvsxzgOg
zSLhzRGHnUrDBzalsQHLAjOdNiQy0/6sx2pzvuR1adS2POghx8JGePrLIAiAPzJG
s8fWymiG3rGgYS8hWy1B06bVNFHdZcVHOeyWhCgIxs0oYdjGPPQ=
=V+Zj
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


