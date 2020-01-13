Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC11C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085C9207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="iYoidXjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085C9207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3ot-0000tr-7u
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44383)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1ir3nx-0008S8-Di
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1ir3nw-0006dF-DI
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:47:09 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::11]:29498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1ir3nw-0006b9-6Q
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578937626;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=5osv5Z8x/E4h/Zk/q9Gps0qjPjy2cinqRfpLKcoRHqM=;
 b=iYoidXjw81zXPChC5wgiaiQymDlxSldvFYoU/I3fTCkXrm1fTgEkd97JPG8LQe+WUI
 lre7uyBhT48eHo6WPUYAgpQ9t1dItUsN8jihf7H63Zx6ihpdqmHii5vmMDTlgh/0JOTH
 6jdZlwOFEvYwqgvmu6Mx+++qJANqJKyeRjZbX9KVeUDnhBjDf1f5eTz+gKO9dNRBWEO+
 9cTpskAj0K5YTb1Jggm3nvT6kXNSwq9nPzRRtDA3CoJisG9hHxRK/JloYqGa2ihgDwIy
 v0IOUGqj7TWArcSKKhyeGLoztSwh2RxWlZPGgm6sps90HHLsj23jWplUN5NzWEr9L6Qe
 8Awg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuY8phYg=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
 with ESMTPSA id j08473w0DHl6HAq
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 13 Jan 2020 18:47:06 +0100 (CET)
Date: Mon, 13 Jan 2020 18:46:59 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: Re: [PATCH v1] hw/i386: disable smbus migration for xenfv
Message-ID: <20200113184659.38ee5ff1.olaf@aepfle.de>
In-Reply-To: <20200113174521.3336-1-olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k3Z4JWlanmuko1U0+YPR42y"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::11
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/k3Z4JWlanmuko1U0+YPR42y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 13 Jan 2020 18:45:21 +0100
schrieb Olaf Hering <olaf@aepfle.de>:

> commit 7fccf2a06890e3bc3b30e29827ad3fb93fe88fea forgot to handle xenpv

Actually it is xenFv, but you get the idea.

Olaf

--Sig_/k3Z4JWlanmuko1U0+YPR42y
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl4crRMACgkQ86SN7mm1
DoDfUg/8DEF2ZqL+AaCkfanVYurJDqTLbShJxlVRFLdXho+s2tJ1XyUG3BNqcVZS
BywQwP9LnxV36187RReWTpP6dKfwS+rzsIU5eFnGfNw0LGohZvv4AIipiKMf1Dit
0H+ciUqH9vlCzKhB/hl2ate+Bxg+NzZl7r2e4hXhgESsy9GM2v+7J3rYdBuFJuXN
fQ2i2Qp7tUF++Ni59CdnPxp5pRczNQGLhZ6Q/m+Ic0AENjx0VYJXux9L6MIaUawq
nh3EUV5lEOfNlpCy/56dZ33NrfhCgEUD8VoODpC4ZizM+78cF3fB5emYMmLj2Xuc
uhbNapLblt/NN/i+1jO7XklxgKbSye0GreF5Qa3FLWw5ZPOCohFA8VeesBKu/3p1
ZryGviNwjYrWTCgNY2egracifvHz++YfeGPxRdVMg+ZrC7V4Oo+RI6GgJsebn1GA
2Y1LoABOkmP+8bA4zaSEyBrXSs/hq1Y657MTXPlNvW/vCEwSQ1gVcUqd+xgNairl
BRYAFwYCTwMzMDV8kTxiKu2o09yeak3twyGXswDv2Pt+xKSmjJ+5a3xe2V9USkDO
h1A5d4vFKlimYIyClyNXIW/wjmVz/pFkx8kOOE0/c5UxJ3Rj7Ffr13vQBNVcT4f/
potvxbnL/CeuNzeJ6B6vPhbOYs68L9ImsXF7Tb+ulBSpOw7UST0=
=YjJp
-----END PGP SIGNATURE-----

--Sig_/k3Z4JWlanmuko1U0+YPR42y--

