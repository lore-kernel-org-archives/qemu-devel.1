Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EBEC3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA21215EA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYc5+rs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA21215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4iaz-00082K-NE
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i4iaI-0007Uy-Qw
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i4iaH-0007jM-Ln
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:25:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i4iaH-0007iZ-El
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:25:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id y8so13210716wrn.10
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2019 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=K4D3iMyqi8Uvkblu61q1pV6Cf/JYeNcPZU0eefrQLFw=;
 b=FYc5+rs0KaOTN5IaVjsfk0mG/fPw7CE7JvVjaEkNd7Z3pEj2qZ/0VvRTWcnwOjOOJw
 u3lSViEnMI6Dpq6ACMzwdfah1Jr5ML3UJ7WIpO+84OTH7BCdPTdFNfmSLZGEBToFYL/i
 uSN5nneQxpFlNIMOJzxwsvR7nB4ZpePvitjoakRSgl5Es1DzPxyWA7v+R6gFYQ8+83x0
 owpPEEhxW80eRDnXJouEp+og4oIGYcQjyGbGjfzGgaWzHrXVp7LzR3RJ5enm9JCn2EVl
 vPT4L3sBk2h5k6Qqu8GnofopcfoTUZlgEKvpHmfjX3+uNALmtbZMDly8gh2OOWDlt8g5
 07Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=K4D3iMyqi8Uvkblu61q1pV6Cf/JYeNcPZU0eefrQLFw=;
 b=dk4XdvJ/6eu0PMRPbYBBAO0goRpld18sz0vHY9BaskT4mMHKCHR13k2BGoscRagBDG
 5I2inGMKOJDeJOnJ1cJKCz2S6bT2MskpcTpwHYInSx50+Q5C2W+zTA+7CxMUVHZlA/AW
 b0n4dCYBty62/jhMVhwvDsm0UTWUy7g9HqeXpkubJ86/6+W9d8bgOLpd8/TYv/2FANvX
 aFZru1L5I9reSFXvzUxt4a+PgA2seuFftm7l61iY7Yg+wFqfpb37PScPdl3tWvVNmtKo
 kUd9aHpnFot+te8PwJFreGssYqFeuqdW13bztnq090ReIm+9J8xs1SmfHsjhg1czak+X
 DU6w==
X-Gm-Message-State: APjAAAWKfCaxWaeC5aohz4RwQJagcLSS6O6+sxNzjPub1URtj89IMgJS
 qAUoGV97C7H02EIRSUgTDMk=
X-Google-Smtp-Source: APXvYqzIXgyv8987hz8WpQYJBY+XY3Yt/E7xOnx9GNl53D9xlzNosJ67v/eof9s1l7cEWG5qPbIRRA==
X-Received: by 2002:a5d:6604:: with SMTP id n4mr19899009wru.267.1567416311761; 
 Mon, 02 Sep 2019 02:25:11 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h12sm10138164wrp.51.2019.09.02.02.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 02:25:11 -0700 (PDT)
Date: Mon, 2 Sep 2019 10:25:09 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Andrea Bolognani <abologna@redhat.com>
Message-ID: <20190902092509.GC9069@stefanha-x1.localdomain>
References: <20190829154851.GA26717@stefanha-x1.localdomain>
 <3fce8d5a5fcccbff8f27f681eb685167d2c0845f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <3fce8d5a5fcccbff8f27f681eb685167d2c0845f.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
Subject: Re: [Qemu-devel] git.qemu.org gitweb misrenders on git/ URLs
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Jeff Cody <jeff@codyprime.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2019 at 06:13:34PM +0200, Andrea Bolognani wrote:
> On Thu, 2019-08-29 at 16:48 +0100, Stefan Hajnoczi wrote:
> > Hi Jeff,
> > Philippe noticed that the git HTTPS clone URL
> > https://git.qemu.org/git/libslirp.git renders a gitweb page that looks
> > right but has broken links.  The correct gitweb URL listed on
> > https://git.qemu.org/ is https://git.qemu.org/?p=3Dlibslirp.git;a=3Dsum=
mary,
> > but there's a chance that people will open the HTTPS clone URL in their
> > browser and expect to see gitweb working.
> >=20
> > Is it possible to tweak the Apache configuration so that
> > https://git.qemu.org/git/libslirp.git[/] redirects to the working gitweb
> > URL?
> >=20
> > The tricky part is not breaking HTTPS git clone, which accesses URLs
> > below https://git.qemu.org/git/libslirp.git/ :).
>=20
> I know that's not quite the answer to your question, but if you look
> for example at
>=20
>   https://git.zx2c4.com/cgit
>=20
> you'll see that the same URL can be used both for viewing with a
> browser *and* cloning.
>=20
> Basically with cgit all requests go through the CGI script, and an
> advantage of that is that you don't even need to call
>=20
>   git update-server-info
>=20
> to make the repository accessible via HTTPs. It's also pretty fast
> and extremely easy to setup. Maybe consider switching from gitweb
> to it?

Thanks, switching to cgit is an option.  Let's see what Jeff thinks.

Stefan

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1s3/UACgkQnKSrs4Gr
c8jzaAf/R5YMUvulmHwJOq19ehWSOJIyQqDNN+eRM5kAwM52qqS6S6bq3QruulwH
JS9+TaLGewW5k+DF+Dl0jkq/nV5hePWhm5HGXzctwavBAZnXawtLSdQVU8U9hpSx
H191zVd4bYIjO1n3GYQfRHFwVHSlLA4WXItCdvtSImmGB0xPfnLc2iElXDzfetDS
xKPMR0mh3uxZlZdN366EoOWn5zxVbC5E/rmhPzSbUSxDkMBxitL0mb3ibJpJV5Hj
8sp+sjqs5yDVOyVAOkqrf7Z3DPfr5PBYJumW2fH1f6lX2hzfaHpyOjWUb9av6KAl
uqkk3fFV094q3NElfCWuJ/yAt/+1kQ==
=yu7A
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

