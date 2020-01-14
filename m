Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5C5C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A6C24656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAM3GoJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A6C24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irP5d-0003gA-3K
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irP3v-0002j7-9c
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irP3u-0005H1-3u
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:29:03 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39573)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1irP3t-0005Fl-T1; Tue, 14 Jan 2020 11:29:02 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so12809835wrt.6;
 Tue, 14 Jan 2020 08:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hZ0dAu06YTeL4GnA5ycIpjXaPaGVq2wKErkJX2gIqmI=;
 b=eAM3GoJqT22bB/Gb9F/rUHKv3RVdHK8aPhlXxeDF/9tbZSObzrWlBU8tJxN6siV4Jq
 5ZR13OBu/1dXd6vN5ce6gSqrHGL/Uv+w/gtxWpXlk6S+2JEggkbjHPLDDbYheQGeFZBZ
 n7EUImAHlPsETrjwLKBFNdYp58Q+El5vU15aIenAfm869XLNZLtVi1XHlQdiYZ8NKk/8
 K/mHceb0i7ZY7hgQO4cRjV91M6ufrTIcdTa4hb/ZrlCKtjQ6Ah0Jg0hMAVOnJaVnpk+W
 0zuBH4G9MrkLJMpgLLANNWj1ydibtzaojcqnvZ9ZDSDWtI/dxCRDecCXSbGaOSk0vcCe
 MZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hZ0dAu06YTeL4GnA5ycIpjXaPaGVq2wKErkJX2gIqmI=;
 b=t5Kx7FlSZss0ang+xPMOXqyidscc8GP3JC0IAAeD14J1/5xreto7zS1o/YsqxBDi9g
 D90QMWgEYzDhIwecK74K4J262vXDkf8DdCB5rKX6AMhEo3nzDOwLZNpPI5bzbB/aQhCP
 SGhDd4cJJnCzMBMEs9/IYU0IBuSrnLxSw6P/0naumGqUDZ9xNDzJxvepRy6Tn16vYL8j
 srd9lKfA11PhQiXl6GfM432GMfI9bXZtLoWGHsjVAsIo+6+zg4JmqjpQ0fWk6LC4Z79V
 ABnK5ewlZBkSp4M5rgTmEH9IzS/QjWThFxlKUn2CVlNAaBeXphQG6k+TTW9thpQBzXnM
 5FFw==
X-Gm-Message-State: APjAAAUp5ldhcwfj4sZTZSqOxNtYHjLZ00vHackOyrwo4XU5+AWiSwvy
 ZDKYYTz6cQp6K2ToWj1Ra1o=
X-Google-Smtp-Source: APXvYqyPIp/g5lhe0KJGIut7cCNrL9Y23lmH/GFBhTKzJ3kDJGUP4UO854K/cvp2L79Tj3G+5VgZWQ==
X-Received: by 2002:adf:82a7:: with SMTP id 36mr27153354wrc.203.1579019340783; 
 Tue, 14 Jan 2020 08:29:00 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v62sm20072355wmg.3.2020.01.14.08.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 08:28:59 -0800 (PST)
Date: Tue, 14 Jan 2020 16:28:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/3] block/io: serialising request clean up and
 locking fix
Message-ID: <20200114162858.GD132666@stefanha-x1.localdomain>
References: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Content-Disposition: inline
In-Reply-To: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 08, 2020 at 03:55:53PM +0100, Paolo Bonzini wrote:
> Peter Lieven noticed that reqs->overlap_offset and reqs->overlap_bytes
> are written outside bs->reqs_lock.  Patch 3 fixes it, while patches 1
> and 2 are preparatory cleanups.
>=20
> v1->v2: fix comment in patch 2, commit message in patch 3 [Kevin]
>=20
> Paolo Bonzini (3):
>   block: eliminate BDRV_REQ_NO_SERIALISING
>   block/io: wait for serialising requests when a request becomes
>     serialising
>   block/io: take bs->reqs_lock in bdrv_mark_request_serialising
>=20
>  block/file-posix.c        |   1 -
>  block/io.c                | 162 +++++++++++++++++++++++-----------------=
------
>  include/block/block.h     |  12 ----
>  include/block/block_int.h |   3 +-
>  4 files changed, 81 insertions(+), 97 deletions(-)

Is it possible to trigger the bug somehow?

Can you implement a test case?

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4d7EoACgkQnKSrs4Gr
c8igAwgAklnpKn98NM21A3i3LWV2wW6t3p5NptA1aPRzIIEK22L4tvD1XvQ71adV
2hWERCBM+SMHNR4Uz/Cz0OCxdFp9bCsxHasVVkDjtZVadyI3TfHkdLP5DsGo5Iu9
qpMDksaMEz8CsFzBAnlLXl8GVvChM2/vQcH3/wvgqIoIfmBNGJUMSLBYsMhjq10i
e9TiuCMt0Q/vd3MRSAhkrVtxgbKcBwQ6W3P5FQs79NUeCMYda7l+Fvg8EYNyA6bq
S/kRUwHxSBoOWIwevwUG6I6K+DLTWdTu6F2XzJQqpmXjVM0TVJOo1waTM41Asj63
RMHOB1CEXMeBV1aVsGVhO/Gr8/acsg==
=n1TU
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--

