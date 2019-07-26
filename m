Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7010C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FED621871
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbG+6+2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FED621871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzmC-00014r-KV
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54128)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqzm1-0000gE-NC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqzm0-0001K2-QH
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:56:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:41203)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqzm0-0001CQ-Ge
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:56:36 -0400
Received: by mail-wr1-x42b.google.com with SMTP id c2so51134767wrm.8
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lLabzua+XYeVBZFgJb2YSg5pfApap2pWHbOVBvrkLn0=;
 b=TbG+6+2Hfhj/0ud8GFO3tSNtnrDacaaf/EiFrp7JF0pat7QoVuNYsmrk3A3hjAzfwp
 8TXTf63ErkxMazKKbBSYslCAv4RfKm7COQwO3yVtVSNk15ersyFbv5mlW6QrxBUMpUzB
 TdzpJBdUDGs1w1KGEGAY24+nwI7e89SMuaO7u+cG3uPhuLqlqsYCJ3XwhE1CUwv/OgOZ
 Y55PYiBM+pGsmd9IouROPGBPk+eGQn75Rnu52SP0xaHaFib4huau17rVD6WZj+4z02w1
 QW9cVE6I2mxTqlojho/mNWMFGqB4Mxt9KwlFpsDHBKthLsaFSm6b1kWH9VGi/VMoJDzN
 6cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lLabzua+XYeVBZFgJb2YSg5pfApap2pWHbOVBvrkLn0=;
 b=BA4JCJ/0O/r16gaoo+ea4v91U7eCgWSvvJzN+ZoeuEPqFHVZxCBNTJqMdWQblc/YGL
 m1ZXZkJjCr+mxiFz6NhxFsSE7oZ+CEuw2X6OWgrMdVajeKaIMrP0mEmJw0hKwM+bpBd8
 l2rQdOmxakfX+ZpId20wxGaLDd9wixNGzNDkwk4uVyD8yLKXt399ZPAYFbCVTWy5zR53
 7D3KbbcmB9NdsP0WNKD50ajvwUEIuAb4sbwC/C9xgKtjQ2MkcViYpBye+bIpbSN/V+s4
 ZVuyTer5y5k6zg0l5576NjVUIgjjCjJba+TKVnX8dSFARKwdRW35mxDeXlOaP+gSGfrA
 AuMw==
X-Gm-Message-State: APjAAAV7f1lj6NNX16KmPeExCyY/yI7pDf6aZ3UgL4U3Ir6kVdRA67wz
 IxeBFE2o0woGi5ECd8KWmwI=
X-Google-Smtp-Source: APXvYqytyYotfEQzuArTdPdWPFmG+Tc47/csBCi5dFPr/J1GM3OtLaM0XBF4/SpfB5zuehrREaREBw==
X-Received: by 2002:adf:ea82:: with SMTP id s2mr95062543wrm.91.1564145795261; 
 Fri, 26 Jul 2019 05:56:35 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x20sm116448536wrg.10.2019.07.26.05.56.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 05:56:34 -0700 (PDT)
Date: Fri, 26 Jul 2019 13:56:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190726125633.GE25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-8-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <20190725032321.12721-8-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 03:23:49AM +0000, Oleinik, Alexander wrote:
> @@ -379,9 +399,18 @@ static void socket_sendf(int fd, const char *fmt, va=
_list ap)
>  {
>      gchar *str =3D g_strdup_vprintf(fmt, ap);
>      size_t size =3D strlen(str);
> +#ifdef CONFIG_FUZZ
> +    // Directly call qtest_process_inbuf in the qtest server
> +    GString *gstr =3D g_string_new_len(str, size);
> +	/* printf(">>> %s",gstr->str); */
> +    qtest_server_recv(gstr);
> +    g_string_free(gstr, true);
> +    g_free(str);
> +#else
> =20
>      socket_send(fd, str, size);
>      g_free(str);
> +#endif
>  }

This should use indirection: a function pointer to dispatch to either
the socket or the internal qtest_process_inbuf() call.

With a bit of refactoring you can eliminate the #ifdefs and treat the
socket fd as one backend and direct invocation as another backend.

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl06+IEACgkQnKSrs4Gr
c8hKgwf+Pg1vccPuCdynlQ7gfpApZGggbiGh72RrLVrv3eWj4olyXCcJjKRprk8T
bDy9dRhy8TTwOST7X5oNNUZUcjfHSDfSxkhwWDYwiTLOmc34S/YmtDO3O0oEeiQk
Q3do1jVZPhF3g8Mezvl6JvfqyBLLhOBxfBvuZ3eY+TE4CvXiBDleyY/katcq4tF6
OSV49MzJwuVqIJ1rKMqRtAdSgAunpKUa/wybAx4WuByZnbniMu/amG4tlDIASqT4
2f7QH9ujOGG40OdVWQbtY6qni//KlD7Jqj2hQ3xZcq2VxSY1W08gzYp8ZvC5rf0h
OZGcWagRGSmjeL1sGHsSYSJUWh3U6A==
=dp2X
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--

