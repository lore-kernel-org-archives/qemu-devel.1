Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89961C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F5720776
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhxeuw6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F5720776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHtb-0004G7-EC
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50828)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHoE-0006vE-Q7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHoD-0000Ov-FZ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:01:10 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:53956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRHoC-0000K1-UF
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:01:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id t63so2968564wmt.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=JXtxeNhSPsuNv0Lq5sMm9wLumsAwhFG99DQ1uYmkY6o=;
 b=qhxeuw6jEsOBHUywt+Ai3YO+Qd61jaXaYoVW9Ydng/sqSKSyxesuwOCKb1adp2PPdr
 NYR4pG88b+UhAruNOvhT8xpCMrIg04XL1yKeZNIIeMBIx3wFXAjJGP+/CaLFMNLfcaaU
 yzxfyYEn46pItPnkRoAnfN2AnectgY2lSQmTQB016N5osQivH/ltX5FvHjAfW+Zf1WVo
 /1Rt5N61hpbAzDU77KIlUW/u/XlYTMlHa2Ww1A3zzdgrxphBliYygEohri8t1VIDgUdz
 zRWMX9IslI5IESzaGPRlcufFLQNFKriEwiVYkK7NCoqo2skPG8gbSuJs5Vj8viZVDbBD
 CqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JXtxeNhSPsuNv0Lq5sMm9wLumsAwhFG99DQ1uYmkY6o=;
 b=Xga90NjYHN/wI58Ik4Nki6nb9l2eb/iZFbBdEfyodb9SP6PIiVQlZ4E6NCVd6QnbST
 tADyZghoe7hXOEk6mIK6xG8Q6PX1rVqK9Hf8qrEgz95g64CFEbzag78EFplG3ynwL4au
 P9+rM9QAW03yYa+pu4PoV09b5JZcVpsr9mRLAxr9JuTve2otzvwPCrafNIdLJ0W3/zbg
 1sgIkvm983cQJkQAHuR+KWKxH2kDF4jx9UzmjCE4rdWViBO8S6s1NOla9aWajul3w/Vz
 u5M6PufuqYHxA3jzVETBsU7GlyXjChwE0hxB4P9Fo7WIwSlA8Lud3Fv0czDdDHXf9iL8
 FFpg==
X-Gm-Message-State: AGi0PubwttxOP7Qynj/hbra0LpJCxBw4342mAuVftP5Jj6jSfUvTzoSz
 HnSyywTsB416rltIO46B0UA=
X-Google-Smtp-Source: APiQypLgp4H5ZJubPW4QmAz7niYvmFgZbuSy2Fd5OuRiUy9uwUECvmjiXozOwhxhOFLxVS6Epi4x1Q==
X-Received: by 2002:a05:600c:295a:: with SMTP id
 n26mr12423080wmd.16.1587571267164; 
 Wed, 22 Apr 2020 09:01:07 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v131sm8649979wmb.19.2020.04.22.09.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 09:01:05 -0700 (PDT)
Date: Wed, 22 Apr 2020 17:01:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: FYI GitHub pull request / issue tracker lockdown bot
Message-ID: <20200422160103.GG47385@stefanha-x1.localdomain>
References: <20200403142213.GO559148@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Cgrdyab2wu3Akvjd"
Content-Disposition: inline
In-Reply-To: <20200403142213.GO559148@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Cgrdyab2wu3Akvjd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 03, 2020 at 03:22:13PM +0100, Daniel P. Berrang=E9 wrote:
> QEMU, like libvirt, has a github.com project which contains automated
> read-only mirrors of QEMU repositories.
>=20
>   https://github.com/qemu/
>=20
> An unfortunate side effect of this is that some users will try to open
> pull requests against these mirrors. These get ignored until eventually
> someone notices and closes the request. QEMU has had about 90 prs opened
> over the years.
>=20
>   https://github.com/qemu/qemu/pulls
>=20
> The same applies to the issue tracker, but fortunately github lets
> projects disable this feature, which QEMU has done.
>=20
> I have recently discovered that there is a nice 3rd party bot for github
> which can autorespond to pull requests with a friendly comment, close the
> request, and then lock it to prevent further comments.
>=20
>   https://github.com/apps/repo-lockdown
>=20
> I'm setting this up for libvirt and it was suggested QEMU can probably
> benefit from it too as an example see:
>=20
>   https://github.com/libvirt/test/issues/2
>   https://github.com/libvirt/test/pull/3
>=20
>=20
> Configuration just requires creation of a ".github/lockdown.yml" file
> which provides the friendly message to add to the merge requests. This
> can be either done per-repository, or a special repo can be created
> called ".github" and this will apply to all repos within the project.
>=20
> Ideally each repo would have a CONTRIBUTING.md file created too, since
> both GitHub and GitLab will direct users to this file for guidelines
> on how to contribute.
>=20
> I don't have time right now to do this for QEMU, so consider this email
> a friendly suggestion for some other interested person to do for QEMU...

Ping Alex and Paolo, who have access to github.com/qemu.

Stefan

--Cgrdyab2wu3Akvjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6gaj8ACgkQnKSrs4Gr
c8hscAf/U34LF1LV59hrMbQCRZ8La84yqAPiuMmib1QorOKN/kowaCxjkyArEXjp
InQxbL1Y36tiHm5INqoOfVlggowDwYm0376+kjeVoVmSgiVv+iKqymNa2pNxfsLG
+RC5xXPrBRHcS+KQKNOaMY4pC4yl2NaltjNN4qYrzhFhkAngLja16MS5DOwe7XGv
FNEGCQveTRcx8xkdMd4eN5Sb3TOe98rpcpya7PkOfHtjm5uEgjSrhitkxqOfAHJS
v+36/SKh7i7Yl42CpwCAa9oQWhpBo42Ti4GWDIzs6p659h95rfiRnfbAlVQfSZdb
wjqTpS29+39YrSzYmtXv72SzsU4QEA==
=nwkP
-----END PGP SIGNATURE-----

--Cgrdyab2wu3Akvjd--

