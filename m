Return-Path: <SRS0=oVW3=4Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CD0C10F00
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 19:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A8420656
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2020 19:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="YFlkoNPi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="EIBONHvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A8420656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAfOa-00034X-MU
	for qemu-devel@archiver.kernel.org; Sat, 07 Mar 2020 14:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1jAfNT-0002UG-5I
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 14:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1jAfNR-0003l8-5j
 for qemu-devel@nongnu.org; Sat, 07 Mar 2020 14:44:50 -0500
Received: from home.keithp.com ([63.227.221.253]:50090 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>)
 id 1jAfNQ-0003ey-NZ; Sat, 07 Mar 2020 14:44:49 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 18BB83F2B3A3;
 Sat,  7 Mar 2020 11:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1583610283; bh=TvqGKmJtgEGXBkFdsxHoqzayU0NpBrhdcHKXAHXOrrw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=YFlkoNPio/YPB7XVTWp2HnheJMGVes3MqB1pBfdrBdZC3CwPXQIaFgpNI0BrxbVTL
 hpYmBxkPxT2BmGnWmKQySmvTBIMKE2EcL6M0kYS3/Aufhvnn/ATYdd4yoXJtbRHCte
 VuPg46W+055H8KIfw+NdMjx6JCx2NwUZbUmoDtIRln2d1Xrn6kLn00NAyPNPU6X+EJ
 Y2oVec5wgzLE0CQX4oMuxTi3tgd3LgOKWZOfGNvJWUxfwHBUNzPBEeTypBjdnFe+5U
 660E7Wr9+DlyphnhwksiBESnF83lDgFp6z3hdn0RimFCmJf0bon/wmfEHyypcSEpQQ
 gQhJhmZlzI63g==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id V3D8Gp6VUgXl; Sat,  7 Mar 2020 11:44:42 -0800 (PST)
Received: from keithp.com (c-98-247-178-150.hsd1.wa.comcast.net
 [98.247.178.150])
 by elaine.keithp.com (Postfix) with ESMTPSA id 087163F2B3A2;
 Sat,  7 Mar 2020 11:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1583610282; bh=TvqGKmJtgEGXBkFdsxHoqzayU0NpBrhdcHKXAHXOrrw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EIBONHvcfyDzzJ5zyi5ZlRkLbePHZck/hoTu4Jj/McWWwm3j/r6IDnQYsDvNkD4AF
 xxAx5lKEYO+8E1a8owqAxYhp+j5XGuIQJOAqc++S6YcvR6W7+eNNlezfsUJCOvf5UT
 cql5HlGAe+XSdKH6vzd2E15CvnjMr7U4JhTQzDL+UZj5nOjyMymz5CcXvXu6QrNat9
 mpDWmkXbn0J8YlVZOTm+iXl2+LmQMC5Ri2M7Kqe/AKeUh2jWnkjMsvONb/od95fHTL
 rQM63bW+7TbdM4KKM96PteabxpmY8iRQmAg+X5EdI2StPeLxjJ7Nsys11cCCRi0Dph
 XtmmwVett/qzw==
Received: by keithp.com (Postfix, from userid 1000)
 id 443BB158211C; Sat,  7 Mar 2020 11:44:35 -0800 (PST)
To: Palmer Dabbelt <palmerdabbelt@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi, laurent@vivier.eu,
 Alistair Francis <Alistair.Francis@wdc.com>, sagark@eecs.berkeley.edu,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org
Subject: Re: [PATCH] riscv: Add semihosting support [v4]
In-Reply-To: <mhng-e399eb36-5106-485c-972c-db2610e42dff@palmerdabbelt-glaptop1>
References: <CAFEAcA8Vs5Bp7tPgxLOG_T0350-Y_w7SitNzNuvHZN6AB=b0gg@mail.gmail.com>
 <20200128233224.515233-1-keithp@keithp.com>
 <CAFEAcA_dD3eAfKvOGOoXe3NWKg1PiW8=s2Xk41w19Tk67R-R4A@mail.gmail.com>
 <877e1arz2w.fsf@keithp.org>
 <mhng-e399eb36-5106-485c-972c-db2610e42dff@palmerdabbelt-glaptop1>
Date: Sat, 07 Mar 2020 11:44:34 -0800
Message-ID: <87zhcsymot.fsf@keithp.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.227.221.253
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

Palmer Dabbelt <palmerdabbelt@google.com> writes:

> I think, more concretely, the issues here are:
>
> * The only mention of "semihosting" in the RISC-V specification is in the
>   commentary, which is not considered a normative part of the
> specification.

Ok, we're starting the process of creating a 'real' RISC-V semihosting
spec. This references the existing 2.0 version of the ARM semihosting
specification, defining only the RISC-V specific details necessary.
I've created a public github repository containing this work; that is
likely to eventually move over to the RISC-V github repository.

        https://github.com/keith-packard/riscv-semihosting-spec/

The goal is to enable RISC-V semihosting implementations that share most
of the underlying details with existing ARM semihosting implemenations.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl5j+aMACgkQ2yIaaQAA
ABGz6g//bkJdOLJukNLNva6U76v+IslbHiMYScTrjlyDgWEHawI0xT74MzngwRmF
3Nmuh8dS7xEdrA8++6DF1t+G9DsccY0v1NymaVQo+5scMHYYswQ9DmICYHhaxN8K
fhpV/MX+LCKj9LlWD6+J6etdm6sh8q6gPWJORpXvJmkDV/m1Oc9hYJbPHyJ+aDSY
d0e0y+1F0cfYsAAYmCoUIK/8r/ZFxr4r+1xQzlE2mF3piGK3qSz4vTWY72QalbzQ
cADaU8o1JGwtyXMbvkVqbWK2dr9JfZKce5/C4DwrviMO/NpR9RdcIbkiA/krZ1OT
avhrTVxkgRGdvDRt2d/5mMSRKqYJXf6ORIieI/azg99QTzA0k35+fviLVSlvu3fT
l+Ips8S1gIe45rkfh0D7eHSTJszW7X4dYoEjudhWkZ4hnIBjRZ6lGTfj+2apOzao
m6eCiD9vrUrdeDRzSEJ7bUqzIb+ofX1bNZWixAF3gTkPFIpsU5Dw9KwZDCzjQssT
iK/sB9jms35dlvEtLWE/iOwqZ6tAQ/1vVHPAlBmFssO/9qOW4Tb0X2B9ZWct0bh2
bDhm9X4ASmD3eHZ8K/6HpnQpeGunpCuiIP5J5K6svTmCSIOyN4GcWmg44H1uxic2
6sWHGNmv4cyJ2RMgrJe7Fayqa2GIH7kMBJx15wPE8O7iu6dsMwg=
=Rvdp
-----END PGP SIGNATURE-----
--=-=-=--

