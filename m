Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00485C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 06:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AB292225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 06:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="L7ff8sbB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="ejNHlwhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AB292225F
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWCdk-0001zV-B2
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 02:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kWCce-0001XN-A9
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 02:01:48 -0400
Received: from home.keithp.com ([63.227.221.253]:43616 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kWCcc-0001em-N9
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 02:01:48 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 2558B3F2DD1A;
 Fri, 23 Oct 2020 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603519305; bh=xN9ErKQ91NIPf0/wboPK7U7ETBLM/yLD2Hrgx6caq1g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=L7ff8sbBgkPz1tEJcsGUiY+I7Ug47M8q1YAle4+ilTvT27iuvVtX+RRyGTN/HmfAb
 44849SCkNlA6gZsdITr24BGDp1L1ECxoIV0kfYpzGQL1GXrNyf0Izll6ZT7bo/ot4j
 Ujc+i6s42BuqPw2ogOop6OYPJcvM+wd4HeFR8YfsxkN5lFnTTzPKx3P2XJgwB84xDF
 GY3GUgZvDmkaWc2doynv9InurYd4WjfDO5DJ77l9vPwH5xC9r5t2Ce7hbSNGOObK+r
 SuFiJV2obrRGv2lHPMpdn2bxr8v2zZH7tqCeEEvbH8CyY9sua0cFzAzJY+jJKMLf8H
 9wWxmuMc/NE4w==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 7XRxWMWbweJG; Fri, 23 Oct 2020 23:01:44 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id B34C33F2DD12;
 Fri, 23 Oct 2020 23:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603519304; bh=xN9ErKQ91NIPf0/wboPK7U7ETBLM/yLD2Hrgx6caq1g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ejNHlwhSJsL7bVGCP/+Do8+hZGJWGIrLFOlZ3xTzC+J8m9VQt/U2a845CPaKJ4N4b
 3Glao7UkENDaWYlIQEOw6YTru6PcVIPHsOpMFrRPn3CeUjBUSvoMMKYB2DArHw0gIZ
 8AptBq40uZhD+wvZ9b9xSOjqygw+MdF1U3LUkTNvdBTyu8choZw+k4cGUP4nZzmrd/
 WqPyWAsV2XER9Uff03yZA3B85L4MnI1mLVoO5UhCHnDWCeHrpLzFnFJKafx6YMYp59
 HSjCPyIyxART9PqAsEjDIJt80ARJTR0fOf5Q9bIwCy6pfhCmzKoqVUgAxBBIvvvWDf
 Uzi1yW15mwrWg==
Received: by keithp.com (Postfix, from userid 1000)
 id 942B515821A3; Fri, 23 Oct 2020 23:01:44 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel\@nongnu.org Developers" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] riscv: Add sifive test device to sifive_e target
In-Reply-To: <CAKmqyKNKAwtE6M6zSiP1mneo3GhMzz--GOjW6Yh+kaBLB=zp=g@mail.gmail.com>
References: <20201023214506.917601-1-keithp@keithp.com>
 <20201023214506.917601-2-keithp@keithp.com>
 <CAKmqyKN20Fg_cKXmh2-vUaY4gPkE=PtPome5vwoTW9rM1gBTog@mail.gmail.com>
 <87eelo7a7e.fsf@keithp.com>
 <CAKmqyKNKAwtE6M6zSiP1mneo3GhMzz--GOjW6Yh+kaBLB=zp=g@mail.gmail.com>
Date: Fri, 23 Oct 2020 23:01:44 -0700
Message-ID: <87y2jw5fhz.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:56:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-to: "Keith Packard" <keithp@keithp.com>
From: "Keith Packard" via <qemu-devel@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alistair Francis <alistair23@gmail.com> writes:

> The sifive_u and sifive_e model real hardware (the names are confusing
> I agree) so I would rather not add a virtual device.

That seems reasonable; semihosting will be a much better solution for
the long term anyways. I posted this because we've been maintaining it
out-of-tree for several years now and I wondered if it could be merged
to reduce our ongoing qemu support costs.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl+Tw0gACgkQ2yIaaQAA
ABHLuw//apXpVBbc+Kivt7FsYHFlIEwGRlCKad6fMCYk7s35F/BiPhBcTBFEgVt8
RrtA87gb9MqoVBUVfr7BZ8iS/PPAY42oIwm7NVArW/qP/B0rDiF1n90ZFF4FQADd
x8KaL6LpG2tu5EkB+RVBRAQnrd/4l/+Hk5NIu0nVb0EsWFDAwtXRKKEkhRg79fcy
rI0fBTi28gpebwnCmucX/dUHi+i0WdUTvBbZeVdr0WFf9LPD14pBhbHCT5WvYWtB
Ve9Ml/Wgi7TSBo7Bwohmie694gBIqtC+HX/qiab+mYRDDJtMpVJVEezCfac7ZSCq
we5HsZ8M3mDIVY/zZVGA90GFtU+T+Pe/qKRCDHYEarx5JosDYIThU5Yq+bGPi7Fy
o7/WL8MczBw8rB/QkdgmIVpzz8eB4dDPljL/L6SrPBmQAJr8VResZHM61sJDvwaN
tZ4kMisIywlDBxh8LsN18mawwFdI4NcdeFUCtngg1597clfKVwTyH+Ll88gWvoDN
ydbFeoBnRN6SFrXQNFfiC6Vd7Cz5/NRISeo96kh2Tj/TRd5FbpcdJ/WkUrEYNvtI
EJ9WbSdbVGsZmfBLu5evnhPDSiCngZINhTkcZ2ZOdmizAq2pyUosXj2YsOxCM1wL
OAwGIW5YIsJCdOosAsqCVhMKroDMt74GNexWi8GQKzGCnU4/lBs=
=oTQe
-----END PGP SIGNATURE-----
--=-=-=--

