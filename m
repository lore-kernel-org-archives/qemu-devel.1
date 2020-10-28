Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7354DC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8EE724817
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 19:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="dLey65VJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="dLey65VJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EE724817
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqvm-0004AF-Oa
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 15:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXquY-0003NL-6e; Wed, 28 Oct 2020 15:15:06 -0400
Received: from home.keithp.com ([63.227.221.253]:47664 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXquU-0007BB-MW; Wed, 28 Oct 2020 15:15:05 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 9DCB43F2DDAC;
 Wed, 28 Oct 2020 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603912497; bh=15AVrp7vyPKovp+JUmmgOjjbkG5b36Rdgg5pRySikf4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=dLey65VJwjuSS+DXkhpBWfbyHvLyQiOAeGulUDSP+Mang9Lldm3/qbzWrUha60GBY
 cAVHpxeU6fQSkLwWJpx2CiahvXOE1w3C/VBIiSjQv0ba0lnLe/u4SZiVEksGrw51FG
 UqgD6Bwy9gE3O2x9vo3OIE6ZEQI/1FpGWoA4y6pOmd8RmgO8l1lJSfN9YWeeNbXgZD
 T8NwO9c5N43A8DrmNZUtJXVcRvo6p5J1QXgFnPhBqONqaCBIVvm9yB4yY8+fTo2P5J
 /YRh77kr4eQ4SKCfWJtOfI3rRCHZBEmk1dlOJ34cCpGNu9Tb5fZfQm5cRbUjwB+iC/
 gLevWNNJeVIrQ==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id UGHBryi3ZMdv; Wed, 28 Oct 2020 12:14:57 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 37F213F2DDAA;
 Wed, 28 Oct 2020 12:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603912497; bh=15AVrp7vyPKovp+JUmmgOjjbkG5b36Rdgg5pRySikf4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=dLey65VJwjuSS+DXkhpBWfbyHvLyQiOAeGulUDSP+Mang9Lldm3/qbzWrUha60GBY
 cAVHpxeU6fQSkLwWJpx2CiahvXOE1w3C/VBIiSjQv0ba0lnLe/u4SZiVEksGrw51FG
 UqgD6Bwy9gE3O2x9vo3OIE6ZEQI/1FpGWoA4y6pOmd8RmgO8l1lJSfN9YWeeNbXgZD
 T8NwO9c5N43A8DrmNZUtJXVcRvo6p5J1QXgFnPhBqONqaCBIVvm9yB4yY8+fTo2P5J
 /YRh77kr4eQ4SKCfWJtOfI3rRCHZBEmk1dlOJ34cCpGNu9Tb5fZfQm5cRbUjwB+iC/
 gLevWNNJeVIrQ==
Received: by keithp.com (Postfix, from userid 1000)
 id 074E41582210; Wed, 28 Oct 2020 12:14:57 -0700 (PDT)
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair
 Francis <Alistair.Francis@wdc.com>, Sagar Karandikar
 <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, "open list:RISC-V"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH 1/4] semihosting: Move ARM semihosting code to shared
 directories
In-Reply-To: <87lffqmwi6.fsf@linaro.org>
References: <20201026212853.92880-1-keithp@keithp.com>
 <20201026212853.92880-2-keithp@keithp.com>
 <CAFEAcA-0_WLMP1Y1sgcu7Ng+0w8Ovt9DVWzYU8ZA_FA2+bwcUw@mail.gmail.com>
 <87pn53e3ke.fsf@keithp.com>
 <CAFEAcA8Sha5QYbO25dtzBZHoXUeiGVv8aojPFTMrst8nbVDAdg@mail.gmail.com>
 <87k0vbdthq.fsf@keithp.com> <87lffqmwi6.fsf@linaro.org>
Date: Wed, 28 Oct 2020 12:14:56 -0700
Message-ID: <87pn52cgcv.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 14:57:36
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

>   specific_ss.add(when: 'CONFIG_ARM_STYLE_SEMIHOSTING',
>                   if_true: files ('common-semi.c'))

I've sent another version of the series using this plan. It does look a
bit nicer as the only changes required when adding support to another
target is to place this option in the config file.

Thanks for the suggestion, and thanks for helping review this patch!

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl+ZwzAACgkQ2yIaaQAA
ABFKfRAAoNNSBmk9FrsTXQWVoNV5Lee3o2z3Azr2etFFYs/2piRt9f0ewsZPJNn4
sZKOI/G1ShBYsPKulb/JBWPsdh6uN7+8cr9GE8MGr7VIRsDZOxKJNh1cDSACVhva
yxu8A4r4tjNDfTG4L/J8HPpOlTpqM459F3fAwEQoPkOtwOp7J9mMHKKcPgCCVoUe
QzZHZZoDrrK3VQSvzgZPjVuBeFqrWrIyy9LETeMD6PYl7gwz+EJmjm+1/VbKU8dO
pJ70JO7tECiF4ZMw/AjZKtPkl4HDaXvbn8ajyyJuUnKTpP0uywtw9vHyQl5za7ep
b/2QzJF+HxircBU5t5VtPj6xT2C40KetqJBOB1ADroAQ2Xp5DJsQhKf+jxVulBv+
qGIR/pK6ToGYnvUFxTP345dywInUp8WOcZ022ElnhFEdDLMz7iZUeCxTdg+QxXr4
2GJewp5ij+bU8E4Py51+4r5MzuVVJwVnfQtt/RW0u2c78fj3Zzuk26yj4T1KkFQc
3K+W9pqmxsJWlPbAto6OYz+ek/+VeG3wSu28KPclCmJE66Qmp3IEG6cPBamvcb2R
cC6K3QEPpTjT2/nYSLRVisy+zsuWcjLD5OnLIhg/HS90Ge050r7pSWY3qmLUfPVA
hbPUAb9QadLefOnbkjRhXbproOGEd90NJX+8gI+bqlYTltWhZxs=
=pnGw
-----END PGP SIGNATURE-----
--=-=-=--

