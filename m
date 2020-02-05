Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE2FC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF922072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqMmDVVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF922072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izICH-000690-9D
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1izIBH-00057j-24
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:45:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1izIBG-0008CO-0a
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:45:14 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:34093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1izIBF-00083C-OH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:45:13 -0500
Received: by mail-wm1-x330.google.com with SMTP id s144so4188853wme.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 02:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=FOIPs7DjAN+3/SLbr/SiGVw80J1E7qzdbuWaHoxyNv0=;
 b=MqMmDVVPWf7uDz/XRD+RYr0pr/W3zmsEFQStmphJ1m1uNLGEUMvxNBt7UjOVk/pKs+
 W95gs6QvKXvx81w8mOiP+x5Ofc77vExsSaND44ipAyTVfvmFG1FJodjoSjnFG5oJKwpl
 oRSXDCx2d7SE6Ef9e7X04SBKbLEmVFajbHCZB5WvcT4NHLCalmo9cBXqx6fdsJFJGlwo
 tdkDIa8EYLHQ48mwET3nt/gPG3HaVLaD6pYa4zcRpVgr9Cg5sgacMYl8O+MOP9KFmkec
 ABwfjZx2hYNcAuC1Eoj3HcDNm+PpQKq7pwUBpuTF5ufqRGv90dpGdV4iDN853j/OA1W7
 gbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FOIPs7DjAN+3/SLbr/SiGVw80J1E7qzdbuWaHoxyNv0=;
 b=rUbwpTByk8TMIn3Jj64uCBanMy7E26OeFMI/bF+nRbWaGrft2C3ji+ed1ZGbFvzPpA
 D9lUiO6alW0AUKbjJlI9hLAQHky3PLAafEioj1+IQO8d+g/ASwJ8kS9x+ApU98iUoNDj
 OCYQEQWs2AkK3WrDftngSjDlvVZiQX9RKd3CL1qrhfsz0ghhSF0xsb8k2DKoYXQ+i/Gi
 xT+dDriv20lwfPNW/Sb95WgZ34ZnNy0+p0Ks19QfNUyv+7GWzcF/K+mUgyMeCvc9Ymw+
 9DvQXc+gTBzT3n0No7ctId9OVAUWRF9RGF4eR7t4Ah8hRSIQg9q3EsMVZSBElJ5yjjeO
 t6xQ==
X-Gm-Message-State: APjAAAVhTCAW3Xeee1lE67NtTa9MhAghpLt1kzsfL4BekPVDmQ6RHaBm
 sqHDa/d4BTmo/1KzRDqH3HI=
X-Google-Smtp-Source: APXvYqzTvkUlUeBudTrBp6m6R+sW2y96dfjQx7r2wCzWLWBc2aNouuqQ4i5sSigG16elJs5JlmLy4A==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr4870654wml.173.1580899512789; 
 Wed, 05 Feb 2020 02:45:12 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c74sm7795620wmd.26.2020.02.05.02.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 02:45:11 -0800 (PST)
Date: Wed, 5 Feb 2020 10:45:10 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
Message-ID: <20200205104510.GC58062@stefanha-x1.localdomain>
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <CAL1e-=ghxDLcU3iqkZ8q_sbk_DyR70t2a-jFtoNDVa7iTkMXsQ@mail.gmail.com>
 <3d768689-b69f-02d9-b3b1-0c5a9a68df89@vivier.eu>
 <CAFEAcA8ph4Bt1S7k6NfySYM9O1YARxE54r-izDpDWoWX41z98w@mail.gmail.com>
 <94e34d48-aa6f-4c8f-88c8-740cdf406250@vivier.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <94e34d48-aa6f-4c8f-88c8-740cdf406250@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2020 at 09:37:04AM +0100, Laurent Vivier wrote:
> Le 30/01/2020 =E0 12:52, Peter Maydell a =E9crit=A0:
> > On Thu, 30 Jan 2020 at 11:20, Laurent Vivier <laurent@vivier.eu> wrote:
> >>
> >> Le 30/01/2020 =E0 12:09, Aleksandar Markovic a =E9crit :
> >>> Laurent, all this seems to be dependant on whether you are ready to
> >>> mentor the project. Are you?
> >>
> >> Yes, of course.
> >>
> >>> The deadline for submitting GSoC/Outreachy projects (within QEMU) is
> >>> just around the corner (Feb 1). I leave to Laurent or Peter (should t=
hey
> >>> give "go" to this proposal) to officially submit the project on our w=
iki
> >>> page created for that purpose, in the form they deem the best.
> >>
> >> Peter, is it ok for you?
> >=20
> > I don't really have the time to do GSoC mentoring projects;
> > if you are willing to do the mentoring then that's great.
>=20
> No problem. I will. I asked only to be sure you don't see any problem.
>=20
> Stefan,  I think it's your role to add the project to the wiki page.
> Could you?

Great, I'll add it now.

You are welcome to add project ideas to the wiki in the future.

Stefan

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl46nLYACgkQnKSrs4Gr
c8hPEggAxxmEPk/CY+qIkSIirru1wbI7tNVgY5JFZCgYEAUeGgtSZpSVohF2OKrW
MDbUB/Xyf/vZ8pqUH1S2whRzQLnXsUAr88xlhyyg6Z3pTm9oH8pkhDR2dOGQddQm
YopbedrEyU1GUtYKX0/zCV4Ce5ov+QBh338JfpyZR9j+XciNgALLw8VoOUfZvj39
U6tgCrqDTtIM3m4FuoHhMdgZTYO1UMncg7dafq+WZ9i697IWbJ/GY2bY8wiGPK8Z
U3eGcegZQz8x65WF/iHcBpDJkr/5SUMBjMsXC9IYYCJUqE30Kux13Yr87wShNUiG
7VanjNZeOmzCHXAJCHWv/a+x0B1ROA==
=MOwL
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--

