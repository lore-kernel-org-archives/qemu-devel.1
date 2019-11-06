Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E19C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFAB021882
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="um/UiFpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFAB021882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSOcM-0007jg-TT
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSObb-0006tR-SQ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSOba-0006cg-QH
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:56:27 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34505)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSOba-0006cA-IB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:56:26 -0500
Received: by mail-wr1-x441.google.com with SMTP id e6so24896292wrw.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 08:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wPwSJ3A0S11gM80lsjpfWMNt34Fn9Ala6RfI0dE9g44=;
 b=um/UiFpfFy0DvbOtIXl80KcllbN6WYx8mGD7m/kA0LatfuCRq+Mg2YVG/pZ8xWqEmo
 PkmX+LyyslPcRXZicL5Ry+lKU7wCLaEC7QXbDi3CSGxuMhnhyK2h9QXvcFnkFvrvPqpS
 6nba6Z3semMUPEH4CHerFjtYPRtAInTZfhmG2+vISdxL+6QNgIyApGoCDIb2VdrISO75
 DBcrRzz39FgEg7gGrcniTWX4jtlao/EFEqrO/GFdeUd/JjQd18bdKt9ar+Yow8PkeixN
 xzYA6F1/MMt61tmwOt1COhPfdd2H2u4pwhIxZKa21dClwrExOKziDquidTfd2Hz/I3no
 RHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wPwSJ3A0S11gM80lsjpfWMNt34Fn9Ala6RfI0dE9g44=;
 b=OiNLZx3sjgz4KvqJEuFD3VTM6n5XliWDdnRleb92TEIs7MvSs8+XWPijOv+42wHmyr
 0ZyZ7ssvS9qwhtIDhYLzkDtXZp+7GIqdzGnAsJ9fRA5KCWMhgjwNbprAtp9kqzph6bf8
 VC7tg3nERqfpz9zDQbWjSaeyROTTm6AhahIDq9P34/vQik2ZfjGcBt7G26bfB1cE8PQ5
 EJeD1f0wmb0qtT5NjHNWVGlc68ZKS8cMFhk2G0M2QnLN021o22EBs1CzsinoQ78gG5XS
 RJdYhsLDZNE0jU8O7ogw399KoUa4/JPsFMcxyMnhaXEWikBI6OluZyibfCbhqeKuXCY0
 psZg==
X-Gm-Message-State: APjAAAXG2siQYMo0PFdBU4Pjrwsg4Iu5q6fwmS0jbAzbsEQ9BuyXP/wf
 J8PZM0WBDoeLW3187uMOlsk=
X-Google-Smtp-Source: APXvYqw5YoJGbp06tdeMcjADKd8sn3ReGXXyxJperjpmMYHvfqutITKobhN74wFbTeqWLdmL+akL6g==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr3524183wra.39.1573059385248;
 Wed, 06 Nov 2019 08:56:25 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id x16sm23080477wrp.91.2019.11.06.08.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 08:56:24 -0800 (PST)
Date: Wed, 6 Nov 2019 17:56:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 12/20] libqtest: add in-process qtest.c tx/rx handlers
Message-ID: <20191106165622.GK340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-13-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-13-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:58PM +0000, Oleinik, Alexander wrote:
> From: Alexander Oleinik <alxndr@bu.edu>
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
> There's a particularily ugly line here:
> qtest_client_set_tx_handler(qts,
>         (void (*)(QTestState *s, const char*, size_t)) send);

Please typedef the function pointer to avoid repetition:

  typedef void (*QTestSendFn)(QTestState *s, const char *buf, size_t len);

And then introduce a wrapper function for type-safety:

  /* A type-safe wrapper for s->send() */
  static void send_wrapper(QTestState *s, const char *buf, size_t len)
  {
      s->send(s, buf, len);
  }

  ...

  qts->send =3D send;
  qtest_client_set_tx_handler(qts, send_wrapper);

Does this solve the issue?

By the way, I also wonder whether the size_t len arguments are necessary
since const char *buf is a NUL-terminated C string.  The string should
be enough since the length can be calculated from it.

> diff --git a/qtest.c b/qtest.c
> index 9fbfa0f08f..f817a5d789 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -812,6 +812,6 @@ void qtest_server_inproc_recv(void *dummy, const char=
 *buf, size_t size)
>      g_string_append(gstr, buf);
>      if (gstr->str[gstr->len - 1] =3D=3D '\n') {
>          qtest_process_inbuf(NULL, gstr);
> -        g_string_free(gstr, true);
> +        g_string_truncate(gstr, 0);

Ah, a fix for the bug in an earlier commit.  Please squash it.

> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index ff3153daf2..6143af33da 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -71,6 +71,7 @@ static void qtest_client_set_tx_handler(QTestState *s,
>  static void qtest_client_set_rx_handler(QTestState *s,
>          GString * (*recv)(QTestState *));
> =20
> +static GString *recv_str;

Can this be a QTestState field?

--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C+zYACgkQnKSrs4Gr
c8jUYAf/dpewcKExYTcAO18p2owcn7lzMPMgBkkeZJfj/dk7AiwUa7xktR2hcqP1
rCsm9ADWrtLLaMBKISRScRD9YCrbRxlBsrvodWYgnTGeGNHACuTYuwxEKyXGo6bt
pz40NcJPEkwt5Lwc0TC0vrm08M62G1w6Zv26xoniY2UJf26DrtVK/Q48nmrZ1Xb2
zr0+LwqkYPkB15rV8Sb6Gz1Kb8j6hIb6iFlslGDW9TTyABpev+HszsUFUWd+gEgd
+S8j+RXpxXPlKc4wkOzpcmeek8fHBvcy7BqOS20npJX2omHQ0MHCuhzUWn4yMtb9
owo6gicXpsHZ33QMX4nPeUtIXvYGUg==
=cl2Z
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--

