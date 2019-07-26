Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0617EC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C989F22ADA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP/KIGyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C989F22ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzRb-0002t6-51
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46819)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hqzRQ-0002TJ-2p
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hqzRO-0007R3-6k
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:35:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hqzRM-0007AL-H5
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:35:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so54375098wru.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wdbUOyu6KgD3lG6WhbE++LKeyv2JLJBQT8esjyiuNfU=;
 b=nP/KIGyp2ubCe0NwWXK6qJiou0RKGCBLWwDse9VE3t5kp0JE4NmTGFZ7nw1QckusUC
 LjGEBBBz9okBE3EQfabJSRjeQgFkI1lUofamAozKuMvoPDJsypSp6WloGBa/fN4937Rc
 4nBLFr+892W2h3iGbkmbQ/iPSqKSL0pd4qCN0hUoma7aEth3ii7Jg/X32uZFFl/i9amz
 IqX6WFA2djZx38GW/UIr3XYvaI445O1ebLigFmVE7QjjQWsDw6emzbbYgHTSXFv+Hy1/
 S1wTqVidwUwC6TDGCXkeIPNvP14yTAJXmp60CrXhavgu7jBYB53Qh7i52OrmB8z1y1LA
 xtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wdbUOyu6KgD3lG6WhbE++LKeyv2JLJBQT8esjyiuNfU=;
 b=GPHs35PQorf9nRmKwVrTMCcIM4TVnABxKPdSc3Fgh2jDE0Fydlj9R/YXiMITrK9dAy
 eukFA6Y2cqmmEb2JLvxhP3rdFyNPRWNQgO14c9izRMxoWTnKKhE3vK35+CIB6M5OnVnQ
 UUxqXAJuz/DizQzNstt2hd1JyT0lBoilIswIEe1iFu220mZYd2Va8HpRZz+se543nzhJ
 ul3VDElq21jhQ1qW0oNMyn5D9sagT6dsHi4F9goV+G+YSgQglMG9av3nk5i8irpfyNX2
 rdj3ZN/2OAZcYPGSeNcD/zvtrRUA9a3g6IzQZ08qtTz1LijIZUstkXD6e2Zn6YkLS2El
 rFaA==
X-Gm-Message-State: APjAAAUG0B8AvF2eJ2YPC8Wzt3yu0ANUd518DyS2DwN3VB2irg1cFYh0
 H265xzEM2Gt6f/qs46htdw8=
X-Google-Smtp-Source: APXvYqyfiCHUfrGcUTkpt8ZTGymaPxZISf4PJk/SXfQPRTLWHFsuWXWhkPuIArCSg42kg88JMo0mTA==
X-Received: by 2002:adf:dd03:: with SMTP id a3mr56574590wrm.87.1564144515253; 
 Fri, 26 Jul 2019 05:35:15 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id k17sm60135450wrq.83.2019.07.26.05.35.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 05:35:14 -0700 (PDT)
Date: Fri, 26 Jul 2019 13:35:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190726123513.GB25977@stefanha-x1.localdomain>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-4-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
In-Reply-To: <20190725032321.12721-4-alxndr@bu.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RFC 03/19] fuzz: add fuzz accelerator
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 03:23:46AM +0000, Oleinik, Alexander wrote:
> Much like the qtest accelerator, the fuzz accelerator skips the CPU
> emulation
>=20
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  include/sysemu/qtest.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/sysemu/qtest.h b/include/sysemu/qtest.h
> index cd114b8d80..adfbd10d20 100644
> --- a/include/sysemu/qtest.h
> +++ b/include/sysemu/qtest.h
> @@ -23,7 +23,12 @@ static inline bool qtest_enabled(void)
>  }
> =20
>  bool qtest_driver(void);
> -
> +#ifdef CONFIG_FUZZ
> +/* Both the client and the server have qtest_init's, Rename on of them..=
=2E */

s/on/one/

> +void qtest_init_server(const char *qtest_chrdev, const char *qtest_log, =
Error **errp);
> +void qtest_server_recv(GString *inbuf); /* Client sends commands using t=
his */

qtest_server_init() is more consistent since the other function is
called qtest_server_recv().

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0684EACgkQnKSrs4Gr
c8gI6QgAoJqFLCJ41F6q6ehFqHP2seAitgu3LViEobJUCrk3y9ofIIpSvWPyW0fx
nlktdm1DBqzKTsO/GMoRgzVQnuioCHG2D62T/B54LN1Y4ljfKDzvGa8v4z1dF5HM
q7/hoQTfxTG6+g0KNzS1rnLpl/zx95RQiQqoJD30DhIggsxahoYUehHUbnHDSH2+
bqmn+t3W9I6cbX0u6mGZSWxVAUBJNS3gaCWxDnwefCZd60LH1dcOTSYOF3nFTkBW
1vWzk3cFsOI4R3JqwnZGx6yprzOOV9ibaRxCDxbdEEyy1b8LKadXqfDP8dsm/9sz
qbEnqbXz6+UTG324Q59BpJMOK5iOwg==
=0AEW
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

