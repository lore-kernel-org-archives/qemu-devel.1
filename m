Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582BC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDDC20731
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfFYoKfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDDC20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlw5-0007nj-FG
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXlvO-0007Ft-GZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXlvN-0005F4-9f
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:51:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:37875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXlvN-0005Dt-3I
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:51:05 -0500
Received: by mail-wm1-x333.google.com with SMTP id f129so2220257wmf.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AH9agyRdLK9JNefXdNE/drf9Vb7hmvfGGHcSV9Kr+0o=;
 b=kfFYoKfj4IodSA4HxrUKHhvIMSjEFhsE7z2rTG42/KcdQ4PmIUWm+MMiflrUrWXWLu
 fafSIJeBHun+MHemTMM8V/Ir3XmZlj79NkhY1X3pgUo4AnZ8WgwISz/n2Lk1JTCnx5Q+
 yf+bwPhjGLoIuJguuJVRNaCpWsWQA8fmE66ARieraaV97VzlOpYqucDAOkl//3CcT3Sh
 f4qK/SJoXQwbiWlM5UbLVIC3Re3QzUv3+k/0woOroj7WNIjrGPLogk2Fn6VsfUIQfiyk
 odDinLPrni+IkxaLtdG7s4xCo7qigI4/RA6qI7Eu1ME13rJhA7RjmCVcBbLOttlS8GZY
 d3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AH9agyRdLK9JNefXdNE/drf9Vb7hmvfGGHcSV9Kr+0o=;
 b=mqf7qLC415GclL/X7D8gKTIbil3IqpdLe7DjpVBY/dbmYpIi6F3jk2yaJbWZeqOqRK
 6lGDeDmNmt8WnjumRuZ0eGwDCDJL+rmRy1b5frJmaUlhbAScoDx3GKQgUR62DWFqjfPv
 E9kP0o0oSFuh/6g0lEAcuifQM6+Fh2Ne28IVOJ/GweiVkp5mhqK4KdcoC5dwC6gT+7IY
 gltHtkZ5U4W479Pph6jB6CVgmyfCgq/qHayHlvOlqiJISdbneVQ22sMZdb1/k1NyjWnh
 3RLVD3z9mi9o9DOahoR5QnAN8Br2jprJyxYu2ipzqrbBRk0QWyZ4i2Ut8QXdsqYU7NcG
 LZfw==
X-Gm-Message-State: APjAAAXbKS08ZxTcWnA5NcOnHdeHWAB6URoKoraTxb7rh4OqI/DhiK9v
 lFkRQO6Sss0pDkzm7u+K+qY=
X-Google-Smtp-Source: APXvYqzI1dNBgw7rsUWYC6OWDY3y9Q95zcLl49ayGnFEFKr2A5ZZSQG9Lj5izj9DM7RrUUuN9JcxlQ==
X-Received: by 2002:a1c:39c1:: with SMTP id g184mr9772573wma.75.1574340663886; 
 Thu, 21 Nov 2019 04:51:03 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id w4sm2695492wmk.29.2019.11.21.04.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 04:51:02 -0800 (PST)
Date: Thu, 21 Nov 2019 12:51:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: G 3 <programmingkidx@gmail.com>
Subject: Re: QEMU HTML documentation now on qemu.org
Message-ID: <20191121125101.GS439743@stefanha-x1.localdomain>
References: <mailman.2098.1573202511.13329.qemu-devel@nongnu.org>
 <CAKyx-3OHvfqYbzqhVxGYJr46massr6h9H81FO2OtxWL7T9exZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ixDgnS8AC6zwmyK0"
Content-Disposition: inline
In-Reply-To: <CAKyx-3OHvfqYbzqhVxGYJr46massr6h9H81FO2OtxWL7T9exZA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ixDgnS8AC6zwmyK0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2019 at 09:05:32AM -0500, G 3 wrote:
> > You can now access the latest QEMU HTML documentation built from
>=20
> https://wiki.qemu.org/docs/qemu-doc.html
> <snip>
>=20
> This is a welcome start. Could we add version support to the URL?
>=20
> What I mean is add the version number to the path of the URL.
> Like this:
> https://wiki.qemu.org/docs/4.2/qemu-doc.html
>=20
> This way users of older versions of QEMU can still access documentation
> relevant to his or her version.

The current setup only builds qemu.git/master.  The final URL is now:

  https://www.qemu.org/docs/master/qemu-doc.html

Mike Roth could add something to the release process that publishes
versioned HTML documentation.

There probably won't be much activity around this until after QEMU 4.2
has been released.  My patches haven't been reviewed/merged because of
the code freeze.

Stefan

--ixDgnS8AC6zwmyK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WiDUACgkQnKSrs4Gr
c8jK3gf+OpKBTCERlNb8hamy6PNaCUMcq6+FK7E3KfNKYzBxSRYL7uLPv82424Jd
Z7QCt/Cz6XtfU3tBRWpSLPiGySukABjdFa2z0J6qPQhNf+F1BqB4YIyTdvupxu/F
5DXm0BHhd+SQZ7d9kFKu10YtnkVm4gda5KLX2/Dy3GCK5421X4oOwBziBGzpnfvl
tR7fJiXPFeDCQjNzgMA45a8qavJI1vHWPTJpU0hW8gDpS7czqTdWlyHTugD+vz+R
DnkYQsg/rm2b5ixJ6gVp3e/vhf3PST5YmrLVJwf5y3lKPTzXIMQsO0Fly1PupO8y
jRtGJwZuVFHsRH0B0KlAkHMJkUAfrA==
=yI2N
-----END PGP SIGNATURE-----

--ixDgnS8AC6zwmyK0--

