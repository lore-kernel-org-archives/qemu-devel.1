Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E9CC5DF61
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F032087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3o4+zv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F032087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS0tG-0001nr-5a
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 10:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iS0sZ-0001El-Ks
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:36:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iS0sY-0004UU-JX
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 10:36:23 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40116)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iS0sY-0004TR-Cu; Tue, 05 Nov 2019 10:36:22 -0500
Received: by mail-wm1-x343.google.com with SMTP id f3so9539651wmc.5;
 Tue, 05 Nov 2019 07:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=QtTsNlAVGZcYq66E9/OCTuue1OGr/mnlOIQApiiwepM=;
 b=h3o4+zv43p5kAKmbBTPTc17kK2rx4OunzvPPCqhGMrRIqMLjDuXhU0RZ/mTze2KtWB
 cxCwvtwJqLu+Kxm6rXH2/e71wsevSlRzhsr2uXRsEzfW0czmA+LCG4l0fv0jnSvFpyhh
 ehv/2QUFIwB3sNwJ0+GnT72DKmYwWUA9jIFu53xSDqoAFCp8zdk1hMKyqZmHa+aSOKl1
 c9pXkptd7pv/CslmONpqy77OCA+yoMoGWtAhzq1xYUvXNsPl8RfFlox8FpyOSIo2g9PQ
 3uN6z5kXruX95OPEPF944hu8SLqyiPohmqO+/sXStRnBhsXC6yCQClrZkALwadMJIcu7
 5CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=QtTsNlAVGZcYq66E9/OCTuue1OGr/mnlOIQApiiwepM=;
 b=ov4B3+bSvV/gOrCJ5EOOlWhBnuewRHUhV8sM31w6rJ+d1y0UhEFVpuHY/2W1tcCY5K
 kcqvIlKgqhaaHUj09zlMy3zC2Z4jL83RLs36lJnNLyF5vlzleISNbHalJCNHh3AepQ2K
 Ak3U0R4n0J0HVPLs/CplrqOMIQDD0u6XwzwJHNSt9nxPnuSVN4gC4E4vjPspOuq8/u8J
 0HZfFpYeLIK6sOJwn+cN3c7PSJu2Mn6aR9fV6thiDuBWbx0qZQB1iLFcFpKG6Nsp+rdF
 PG1K8MnPP/+CS9w+nDqVqdv8VazOz5tHEypv8n5cK0BUkS/xFTrs5B+wUHbtSv6u159a
 +TvA==
X-Gm-Message-State: APjAAAWp82WnzX6JXTsb5BXBx7ApFVq3hdJYEvdSlTcpkbh3+p0xqzQd
 Kx5iLlqH72nB7TitasRZzEA=
X-Google-Smtp-Source: APXvYqxkzy+6zQz9c7SWYTNYGjzmgXqHVv/ucP218ZGUkG7HhJ1QR+Jkndt5EqQkXymOWG5Apd0S/w==
X-Received: by 2002:a7b:c08c:: with SMTP id r12mr4688589wmh.67.1572968181203; 
 Tue, 05 Nov 2019 07:36:21 -0800 (PST)
Received: from localhost (91.141.1.3.wireless.dyn.drei.com. [91.141.1.3])
 by smtp.gmail.com with ESMTPSA id j66sm15425009wma.19.2019.11.05.07.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 07:36:20 -0800 (PST)
Date: Tue, 5 Nov 2019 16:36:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] image-fuzzer: Use OSerror.strerror instead of tuple
 subscript
Message-ID: <20191105153618.GD166646@stefanha-x1.localdomain>
References: <20191021214117.18091-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Content-Disposition: inline
In-Reply-To: <20191021214117.18091-1-ehabkost@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 06:41:17PM -0300, Eduardo Habkost wrote:
> OSError can't be used like a tuple on Python 3, so change the
> code to use `e.sterror` instead of `e[1]`.
>=20
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  tests/image-fuzzer/runner.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3BlvIACgkQnKSrs4Gr
c8jlvwgAobjME9dFmuDvHX9LES8/SJs23hOc0CHsw1P/ghyIVSUhc2d6ZRypcufr
tTaP9Jr7yad/1bRBeE7vu7tvsA+KXsrrkS6BET4/Vngz6T0Q4F++oDg1gI4K6L89
RonKhUAuKQuHLhho/m1PatMqNrh5t3s5mN1Ghs79B0Whx70DNH+3+acWSvDuagUm
oYKZjlZfEVrzgkVGedBJOgQzDsAvr3Hi315PHg8VILAl5DvtjJ4YCOJEQ4GYQzDp
X0y9KF+vqX0aIFnuSMqUcsrDBaui3sZh1s/PpkMcCPbVZ173NqQ07Og9vLRHFuD2
DTDoMUjobuaxXDadTYMHtCY07t53pw==
=Wusb
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--

