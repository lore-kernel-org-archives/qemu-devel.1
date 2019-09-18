Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758E4C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41406218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 09:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaxV6RG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41406218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAWZy-0006A5-6e
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 05:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAWYR-0005Ge-OW
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAWYQ-0002wJ-O9
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:47:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36316)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iAWYQ-0002vT-Fg
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 05:47:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id y19so6190548wrd.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 02:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=T0PDRveDOgDAHs4/hokzWJMVeqgNYaJY4r0GLJsq2ds=;
 b=eaxV6RG+X7utFk1t1JZxgKwijZEPDX6ShhRqZCxdYiliZOM9WBLbkDu0gyXEuQMWsN
 T3QK0w4qZk+GpXNBT0ZgyUyHplzJIBepW/STE8TZ6EKhPQdw5pWhZM7J71yE6f397tA5
 e1NqbIkCe1DXhKis7R58CVNfXFWV4W6rhkuDMrB7YcQjPdcSC3ftxsQna2Z9Yj9/Zsag
 ZxMUbAxvs+bRF8mw4FYrEa7Ca9B0Jq2mh204tOSwW376hj3hAZymfKxjzUQXLe4uf/89
 nkCOStf9lffNNlZ5bJk9MrVhTskhcX7bn7dzEBSDFV+8aWyi1Fplo/kOJYd67uxM27o2
 Yj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=T0PDRveDOgDAHs4/hokzWJMVeqgNYaJY4r0GLJsq2ds=;
 b=M8QQPapGpN+8JKZ76YwQ5OCHU2MJAl2OOIxsiChTKZ0i+MZMqRt1PeUyVNq8oVLpaC
 4xW03r4kLWlnKJgGocOYDVzVCRx/l2y6eefjGWxgi9Rl6Ybw5SXhiLN6lIZ/32mw3593
 5a986bVZvL8vtqMmcYeKJ/cjMH0OXeHUSKpTYrNGx8FJMepFY0bJDOhZ5SQZshNUWlLC
 8aUIn0TLufg1udvcfyns1efNM4vHv3nPtR5naMTALy5pJAA1Uqs8i06baJ8lYK5BnEW0
 whV/1JUmr/W0Lsong2qjmMh4z1e3SbY327lIk9BB/7OwSX6pCeqf11hfcOs6g7j133ZA
 f/8Q==
X-Gm-Message-State: APjAAAXbGXrQmHAcmrJiSf52wrEY/bMndg/T/dCc0Vey38gERGpWEqg6
 rYBuTTlD1T6QxuOzrmi6/F8=
X-Google-Smtp-Source: APXvYqxwBQkiqklRObvB1329NrIHJj7s1ppzzSRPFO4uTNm1JFrxZtYcVq7ZHdMungJ3UMODQBXmzw==
X-Received: by 2002:adf:f58c:: with SMTP id f12mr2265300wro.38.1568800037040; 
 Wed, 18 Sep 2019 02:47:17 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k9sm7989088wrd.7.2019.09.18.02.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 02:47:16 -0700 (PDT)
Date: Wed, 18 Sep 2019 10:47:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Message-ID: <20190918094715.GD26027@stefanha-x1.localdomain>
References: <20190911145818.18962-1-stefanha@redhat.com>
 <20190911145818.18962-2-stefanha@redhat.com>
 <2de26e7e-1ea9-3fb6-d9b8-fcb397794d82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <2de26e7e-1ea9-3fb6-d9b8-fcb397794d82@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 1/2] audio: fix buffer-length typo in
 documentation
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2019 at 09:29:34PM +0200, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3=
 wrote:
> On 2019-09-11 16:58, Stefan Hajnoczi wrote:
> > Fixes: f0b3d811529 ("audio: -audiodev command line option: documentatio=
n")
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   qemu-options.hx | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index bbfd936d29..a4f9f74f52 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -439,7 +439,7 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
> >       "                in|out.format=3D sample format to use with fixed=
 settings\n"
> >       "                valid values: s8, s16, s32, u8, u16, u32\n"
> >       "                in|out.voices=3D number of voices to use\n"
> > -    "                in|out.buffer-len=3D length of buffer in microsec=
onds\n"
> > +    "                in|out.buffer-length=3D length of buffer in micro=
seconds\n"
> >       "-audiodev none,id=3Did,[,prop[=3Dvalue][,...]]\n"
> >       "                dummy driver that discards all output\n"
> >   #ifdef CONFIG_AUDIO_ALSA
> > @@ -524,7 +524,7 @@ Valid values are: @code{s8}, @code{s16}, @code{s32}=
, @code{u8},
> >   @item in|out.voices=3D@var{voices}
> >   Specify the number of @var{voices} to use.  Default is 1.
> > -@item in|out.buffer=3D@var{usecs}
> > +@item in|out.buffer-length=3D@var{usecs}
> >   Sets the size of the buffer in microseconds.
> >   @end table
> >=20
>=20
> Double checking it's indeed "buffer-length" in qapi.  Also I spot a
> different bug: the alsa documentation qemu-options.hx has "period-len" but
> according to qapi it should be "period-length".  Care to fix it or should=
 I
> submit a different patch?

Thanks.  I will send another revision.

Stefan

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2B/SIACgkQnKSrs4Gr
c8hOOgf/Q97PTTa5NKbCicjcaQbgzoEosu5Zk0tgnmU3FLLZv3ZjgXqxJtvhmhVV
nMkFyV+qegVgNU0+cdb6xv/QqIOqgltMc3MbEp/tJklLdMJCkRQCSGNdouQ6wi/7
/eAucM0f/tJEKPa/yz/asiI1W9XGTtYp7ZrbTMOMo8867vGNShDNJKMU11XORgZG
raXOjdCI10LwcHuzWZYXOM7z8ZMd7bjj4YX4YO9Y7zGH9vSxYBHfpoxfGjvKGgkD
dGF+akSM+BGDoHynjBwDfhtQM3pXnCmu/0n0bAmsAefzk5XiEirAv7DAvNasRDDf
M/05SolKqsl0gmvPvrtdXxBLq0u8Jw==
=FRLP
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--

