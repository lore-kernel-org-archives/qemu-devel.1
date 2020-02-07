Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7FDC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 290E1214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQB3qhOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 290E1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06d2-0003x4-C4
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j06Zm-0007r9-F0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:33:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j06Zk-0005WA-Vz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:33:54 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1j06Zk-0005Uz-OQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:33:52 -0500
Received: by mail-wr1-x442.google.com with SMTP id w12so3447694wrt.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=C95CCnY5kxNxiQILo/Fbv5m4J5y4oKKlJzE0ehA2D+c=;
 b=AQB3qhOQVl92rVNQmPjZJluEXG/YN1oSGmZ0q8v1eUC/KLyU/iYgRtQyFJEXz6zXvg
 HFk9spV9Z1vRjG0/P43Nv4SPKIU56EcKdfRxpRHxM9Mxlicw28CK9agimDAEHRPsMfSX
 ZnBxzYWazJOwcqGdyAB2ZLYYKHw53iW/SvtOrcNWrXAJP4O7WKFQ4QYGa+858bXDIeQn
 f5Lc8eC6/4WYHP2eQu4VNEGKej48sBHEoIE9dJWML12mov8+XMc02IwfzPNcVr1d9+wV
 TWRTQIrEQ6RzWtirhLTrquKhtQNfFG2017X1Wbs73EQ3UMGmnNNENDBIDuzi8PpwL8VP
 OG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C95CCnY5kxNxiQILo/Fbv5m4J5y4oKKlJzE0ehA2D+c=;
 b=Jy7Cwxm9yv108hZsA57H9KC/kjBg3HnNzlkFQju1j61Ltwh3DtUh15USC7EDvIYVpd
 qHhWAd9/m8YU2+UxwSvgXWy60mDxqdC5s8qEX+f7aTrGDMXRbuLbZC3foC1mC1+bIqO4
 WqycZj+EJ1tTcYMuArVnCtLyR1nCje6KlWbbZlBMf8Den24Had3ZDrBYsdE00UZgwg9q
 cza4KBobmWvSd+6O7Znioy1Tr+NgR1zJ1DerF9IeOXbPKGNMgOloHSFnGarcfs1k9lUA
 CZeH5hjhktBV7o4nv8d2+ng8BDfhWN0lRqVS2mfhEQNzgaC58hPkl2NAUvJTB7GXQgJ0
 nvFg==
X-Gm-Message-State: APjAAAVf9FiFwCufvpwSLVFIrtn/QHzSNw5/bFJDRafH19LUqUzm1SQH
 UH2P1Qnmv95d3cAgxDgaHLw=
X-Google-Smtp-Source: APXvYqyHUzY4PrUr0euxARC+r1xUtQgwl1ZcZc9e1GhR2Rh1f45JK0BLwHtiGpu0HiV4kf8GfI7yNw==
X-Received: by 2002:adf:ec06:: with SMTP id x6mr5331884wrn.335.1581093231636; 
 Fri, 07 Feb 2020 08:33:51 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id i11sm3950964wrs.10.2020.02.07.08.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 08:33:50 -0800 (PST)
Date: Fri, 7 Feb 2020 16:33:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC 0/9] Add an interVM memory sharing device
Message-ID: <20200207163349.GI168381@stefanha-x1.localdomain>
References: <CGME20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a@eucas1p1.samsung.com>
 <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <20200205143911.GG58062@stefanha-x1.localdomain>
 <1e872eb3-a21b-0f9b-e6a4-54843a028bed@siemens.com>
 <91d3f574-3a4f-8291-040e-520c5c58e77e@partner.samsung.com>
 <20200207110403.08a8a7cc@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Content-Disposition: inline
In-Reply-To: <20200207110403.08a8a7cc@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Igor =?utf-8?Q?Kotrasi=C5=84ski?= <i.kotrasinsk@partner.samsung.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 11:04:03AM +0100, Igor Mammedov wrote:
> On Fri, 7 Feb 2020 10:00:50 +0100
> Igor Kotrasi=C5=84ski <i.kotrasinsk@partner.samsung.com> wrote:
>=20
> > On 2/5/20 3:49 PM, Jan Kiszka wrote:
> > > On 05.02.20 15:39, Stefan Hajnoczi wrote: =20
> > >> On Tue, Feb 04, 2020 at 12:30:42PM +0100,=20
> > >> i.kotrasinsk@partner.samsung.com wrote: =20
> > >>> From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
> > >>>
> > >>> This patchset adds a "memory exposing" device that allows two QEMU
> > >>> instances to share arbitrary memory regions. Unlike ivshmem, it doe=
s not
> > >>> create a new region of memory that's shared between VMs, but instead
> > >>> allows one VM to access any memory region of the other VM we choose=
 to
> > >>> share.
> > >>>
> > >>> The motivation for this device is a sort of ARM Trustzone "emulatio=
n",
> > >>> where a rich system running on one machine (e.g. x86_64 linux) is a=
ble
> > >>> to perform SMCs to a trusted system running on another (e.g. OpTEE =
on
> > >>> ARM). With a device that allows sharing arbitrary memory between VM=
s,
> > >>> this can be achieved with minimal changes to the trusted system and=
 its
> > >>> linux driver while allowing the rich system to run on a speedier x86
> > >>> emulator. I prepared additional patches for linux, OpTEE OS and OpT=
EE
> > >>> build system as a PoC that such emulation works and passes OpTEE te=
sts;
> > >>> I'm not sure what would be the best way to share them.
> > >>>
> > >>> This patchset is my first foray into QEMU source code and I'm certa=
in
> > >>> it's not yet ready to be merged in. I'm not sure whether memory sha=
ring
> > >>> code has any race conditions or breaks rules of working with memory
> > >>> regions, or if having VMs communicate synchronously via chardevs is=
 the
> > >>> right way to do it. I do believe the basic idea for sharing memory
> > >>> regions is sound and that it could be useful for inter-VM communica=
tion. =20
> > >>
> > >> Hi,
> > >> Without having looked into the patches yet, I'm already wondering if=
 you
> > >> can use the existing -object
> > >> memory-backend-file,size=3D512M,mem-path=3D/my/shared/mem feature fo=
r your
> > >> use case?
> > >>
> > >> That's the existing mechanism for fully sharing guest RAM and if you
> > >> want to share all of memory then maybe a device is not necessary - j=
ust
> > >> share the memory. =20
> >=20
> > That option adds memory in addition to the memory allocated with the=20
> > '-m' flag, doesn't it? I looked into that option, and it seemed to me=
=20
> > you can't back all memory this way.
> with current QEMU you play with memory sharing using numa workaround
>=20
> -m 512 \
> -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/shared/me=
m feature,share=3Don \
> -numa node,memdev=3Dmem
>=20
> also on the list there is series that allows to share main ram
> without numa workaround, see
>   "[PATCH v4 00/80] refactor main RAM allocation to use hostmem backend"
>=20
> with it applied you can share main RAM with following CLI:
>=20
> -object memory-backend-file,id=3Dmem,size=3D512M,mem-path=3D/my/shared/me=
m feature,share=3Don \
> -m 512 \
> -M virt,memory-backend=3Dmem

Nice!  That takes care of memory.

If signalling (e.g. a notification interrupt) is necessary then a
mechanism is still needed for that.  I don't know enough about TrustZone
to suggest an appropriate way of doing it with existing QEMU features.
Maybe Peter understands?

Stefan

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl49kW0ACgkQnKSrs4Gr
c8jc3Qf9H0FNjvHr4kqjE9aAyp+6zGpCQpqJBDUDI3dZRIIlAfPq4v4sJkY1GFSV
yzH021QeV2tGRpZizsEEMJS0PjJZhjsYztJeOho0CLnJnd81YVWRnIkUD6tWacu/
wFdXkJBPi99buictdApIFM8w9S3eNAUDQmbcneIq8BXmwzwj6rp071nX7MRKfJhG
+LDSrynJE0JpWEa+KtpHciXOIBygZJgPYT8nrHcXOLxd8q798mwk5ohohMwIJgd6
ZVUTV8YDbau2Vuz8iDwo8iRbgdDY3IEKKlPJC162twHfRgCce1BbDuFHRl7hK63b
DAafGnyOubLROYWXQi3l07IN5cMnIw==
=hnnz
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--

