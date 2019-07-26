Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62DFC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D1F2238C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1dZ7Lt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D1F2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzfH-0003vB-VX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51819)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqzf7-0003Wm-43
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:49:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqzf5-0006sI-6z
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:49:29 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqzf3-0006pD-Cb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:49:26 -0400
Received: by mail-wr1-x42f.google.com with SMTP id z1so54303777wru.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 05:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IEeOfOFGrONoGnVNN+lFisDOxnHXTAXt94OzdsfJQy0=;
 b=p1dZ7Lt9hdw1dYf4SjD+/9Fuwak3iCmJSzZvLQaK53al9Fr2t0k0DaA7AW9jkDYUep
 LyOYr+nk4MiOKYd4zs2REOC5qPsCKe9nqa3K4YRli8MJ7eVSJLEOOmkqtEh2hNmKrrbl
 LDd6vVJpOLB3Ldd6znlkyiRbyfIKOr4VhecutzEwtmRuB3MEIFOn7qyB6V8qMH4z4dKD
 wNP4PAVC+EpAFeYCYGy+cojBJoNoQ5g4Wjo+hbe3ac58p9GD4LlGODPZhPpF9yYAFpba
 Sx3MXv4FY04Zt18xBHzumyu64HgBL8FIxIwMZ99CT7If6MX/qxDjWh8Q+T38Y19ngiRI
 gK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IEeOfOFGrONoGnVNN+lFisDOxnHXTAXt94OzdsfJQy0=;
 b=JT2rf439a06oVtKIxmTKoE1Cw0BJaV1xobtqK8/kuB8lORaemsorX5EZ1twlINpWjn
 mVw2MeipRXfTK4wOkaNgb9DLsCQK2zDvRu/9i0uqMmOTJjGIzdG2sbCKMNyRgFx4l5SX
 Tco83shEl3hckbYofIhaYhlMpJQbKWqmjoJQWNq04tVeLpIefsUNFyepxUOMbTa8j2vv
 1sox7QRYrVDzufmC1j5LANOw6MWfTe4bjvAjUvnUqERnCU7BtNIpinSIsyHav18ZDhsU
 /ODNERbl60YD1V2mw3OV7es26Fvwg32BQQJEwlQVq09C5nuLHS+XAfDIXrrVDNaygHzA
 Scaw==
X-Gm-Message-State: APjAAAXXwRbsKOagmsyLEIDknlrmJcDrx8tKRhKftsWvXVlCS3YgnmNA
 DJpqCDxskwIq4dfheO5v2Wk=
X-Google-Smtp-Source: APXvYqyVlHSrN3aeNzLa/6jEk5+ANyrwIRVTQ7wrjKbQSTvyY+lrRH0IlBAoLiXzqECiwtcEVMXSAA==
X-Received: by 2002:adf:f646:: with SMTP id x6mr107852783wrp.18.1564145364159; 
 Fri, 26 Jul 2019 05:49:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id a81sm54163530wmh.3.2019.07.26.05.49.22
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 05:49:23 -0700 (PDT)
Date: Fri, 26 Jul 2019 13:49:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190726124921.GD25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-8-alxndr@bu.edu>
 <cbe08ddf-4552-3603-4d2c-49ea4282a47e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <cbe08ddf-4552-3603-4d2c-49ea4282a47e@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
Subject: Re: [Qemu-devel] [RFC 07/19] fuzz: Modify libqtest to directly
 invoke qtest.c
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 11:04:11AM +0200, Thomas Huth wrote:
> On 25/07/2019 05.23, Oleinik, Alexander wrote:
> > @@ -379,9 +399,18 @@ static void socket_sendf(int fd, const char *fmt, =
va_list ap)
> >  {
> >      gchar *str =3D g_strdup_vprintf(fmt, ap);
> >      size_t size =3D strlen(str);
> > +#ifdef CONFIG_FUZZ
> > +    // Directly call qtest_process_inbuf in the qtest server
> > +    GString *gstr =3D g_string_new_len(str, size);
> > +	/* printf(">>> %s",gstr->str); */
>=20
> Please check your patches with scripts/checkpatch.pl - e.g. don't use
> TABs for indentation like in the above line, don't use //-comments, etc.

You can set up a git-hook with checkpatch.pl to scan code automatically
before each commit:
http://blog.vmsplice.net/2011/03/how-to-automatically-run-checkpatchpl.html

Stefan

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl069tEACgkQnKSrs4Gr
c8i1twgAwLzhcpLgqSIjFdApttB8/XRMO10CBhL4z57obvbEIoOYylPV1CewrNgF
8aRmJZNWNarxE8QwSbYtbWh0pcrinduQktbgqZ1l8jzJyqJLdTPOwq/9lN+T/Gu7
XFSf2kDD3vP9GrvCHAI9FbM7UM95LbqmGvEPJ7AtCcmHufEDzjhKIIGXFVzJhk8G
k9WidJQwpEZpl4vmJNU4xD5/SpbfnQlA7mBxmEiJO52rDb4ZZir/qiJYDJ/HmbY+
q8NTxKsepHh9Fq6DJFdfc+6oX7d3IVks0ykGwVNqgqs31YReLzANLG62FWabnIMZ
M8p1CvKwLh9age/PnwPMEEYvdIz0YA==
=aJQ/
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--

