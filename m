Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F3C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B169D247C3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="OJgkrlgN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="OJgkrlgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B169D247C3
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnY0-00066Z-8N
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXnWX-0004TO-9E; Wed, 28 Oct 2020 11:38:05 -0400
Received: from home.keithp.com ([63.227.221.253]:46900 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXnWT-0000fm-GL; Wed, 28 Oct 2020 11:38:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id BF3BF3F2DD89;
 Wed, 28 Oct 2020 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603899476; bh=YzHdL/SVNn3Bt1bCDaUC9XvyJG5vFq4cXxNR1e8UkSI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OJgkrlgNH2HsYbNmegTXWjFvLgxiz7V1vKmFk+h6BSnXLXmrblBId8avUvsLghsKj
 LdiQcwm0ZdG6Kdtm+Q4xieTvGk/VLeEATpv/mopJpUCPCHVENODa8WRKkDGg8RIuhG
 g3MZ8Y70Ag3ZzK4PPgHrnTEoFwmmfrADeBt/7ho9xC8YiYPs+KDcyPs+HUKsS8Hky3
 ZfXdoSMKGoK1bxaplNBDFA5bKluhgFooD/cAgiD94It2cLjvjVPpYT+fwgDLShXiXl
 XD0ed4UNcBTlD0qhIiydnm8/j87gXrQ73lMfq/DXtMFuYfyOtg4O7UpdwcsTZx/u3a
 eogV4TlG3nRJQ==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id sDeMeo7hjEsz; Wed, 28 Oct 2020 08:37:56 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 544E23F2DD85;
 Wed, 28 Oct 2020 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603899476; bh=YzHdL/SVNn3Bt1bCDaUC9XvyJG5vFq4cXxNR1e8UkSI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OJgkrlgNH2HsYbNmegTXWjFvLgxiz7V1vKmFk+h6BSnXLXmrblBId8avUvsLghsKj
 LdiQcwm0ZdG6Kdtm+Q4xieTvGk/VLeEATpv/mopJpUCPCHVENODa8WRKkDGg8RIuhG
 g3MZ8Y70Ag3ZzK4PPgHrnTEoFwmmfrADeBt/7ho9xC8YiYPs+KDcyPs+HUKsS8Hky3
 ZfXdoSMKGoK1bxaplNBDFA5bKluhgFooD/cAgiD94It2cLjvjVPpYT+fwgDLShXiXl
 XD0ed4UNcBTlD0qhIiydnm8/j87gXrQ73lMfq/DXtMFuYfyOtg4O7UpdwcsTZx/u3a
 eogV4TlG3nRJQ==
Received: by keithp.com (Postfix, from userid 1000)
 id D505B1582210; Wed, 28 Oct 2020 08:37:55 -0700 (PDT)
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
Date: Wed, 28 Oct 2020 08:37:55 -0700
Message-ID: <87blgme4z0.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 11:37:57
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

> I don't think we want arm specific adds in the common code. I think what
> Peter was suggesting is a new config symbol that only ARM and RISC
> define, e.g something like:
>
>   specific_ss.add(when: 'CONFIG_ARM_STYLE_SEMIHOSTING',
>                   if_true: files ('common-semi.c'))
>
> or some other suitably descriptive symbol. Otherwise you have to keep
> adding an foo_ss.add line for each architecture that wants it.

Sure, that will also work, just a few lines of additional config file
stuff.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl+ZkFMACgkQ2yIaaQAA
ABGQyA/9Eknw0a9LPyqureDreTvCxw67YCgUYQMn2cxp2iMt/I03xf3SB0JOxg0h
Zj5WaJ5mtQOBKpZfRP4qLZqK1a3mLPxsCFQUzhtXxMwrMvnsPqJbSvykxh23gu88
ZbEpTAqgTF+8gZp+LgL7M2BSoAddCEO8C0jWmSBjobkatNthZEufTJrvsf3b8qP9
CVHbxSkhPEze4a1Y4d9HgvgefdBCHXgBnPZoTSTn4HvsdJzkyC5JK221kDhCWf7A
yvL8oeU2sTXls4hO5Y+ntt0CzjslKi2D8PmehJP0oEw/jgohQ9hXOxFTdkoiJsix
c5lueStzU3bzcPGK88DZUY8mejCaZyL5VQAC2z5yoafoEsh4AnhEydFxCyv+oZUi
nEWCcsk6DawT/bCfjcV/V6sHOHpjaLUT9soylE+UHtbuLtJiMmc3gqczSBcJc6JY
BpAoyCd5buq4gAb+VwxlPqai4XUGiuXpDK6hrWxJSwUYM0hNmRSPamxLVTCb2ksg
31eW3AWVkJsZh0XkfQPzWNGPud7oRR0sGwiWAg1k4Q9y19R06Zj/yK1dxtP1rfww
PU7RPDuYiz72UR/UY0vOJbfRQQ2PdOdQpmuiRBextHSykmEXLErur0cPSAR39JUP
So3572RP7lrHVy9CjcNl3cQxJqkrS4RFzSNQWvZLxwS/7MG8OWE=
=LZa5
-----END PGP SIGNATURE-----
--=-=-=--

