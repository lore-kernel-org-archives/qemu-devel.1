Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E08C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C762225E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="N6eWqYJa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="N6eWqYJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C762225E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW7Dr-0008Kl-63
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kW7BO-00062W-L1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:13:18 -0400
Received: from home.keithp.com ([63.227.221.253]:42952 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kW7BK-0007Ra-B2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 20:13:18 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 6EB7A3F2DD13;
 Fri, 23 Oct 2020 17:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603498390; bh=6z3XBZyJXageL+uutf/KQ30suIRAyWPctZDuf1unqrI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=N6eWqYJaOaZ0DpAwqyadD2tu3g5fFNf7mD1yGAgj6cprQxM+x/Ap5O0l3LX5NPpk7
 LqQghoYCXyp43ldhXPWhlEooliWuETmkEEfLbHUeIUrmJdWgA9d/S9cGeTgW0cB8hY
 X5HyXe/q1EOeuAMnfZdTWqkwbeF0hJcRlvtXcBm7WAS1Pgf140pb0Vj4d9LA5OQSmP
 4r4IevkyrA5+j0Uq4UllXWtzHGeWR4xEJMaUREcjQSSe5XItjqEjmuTiUGJjhZ9hNY
 oBibWCZfNcVQ+wMyok0At+FbGZ39kY7ELyDDj8U9vuVlJAQSFh5g0qAYiAgRYL14Rn
 N2IObnRndNHXg==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id BYsshI_7z7II; Fri, 23 Oct 2020 17:13:10 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 2ACC03F2DD0B;
 Fri, 23 Oct 2020 17:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603498390; bh=6z3XBZyJXageL+uutf/KQ30suIRAyWPctZDuf1unqrI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=N6eWqYJaOaZ0DpAwqyadD2tu3g5fFNf7mD1yGAgj6cprQxM+x/Ap5O0l3LX5NPpk7
 LqQghoYCXyp43ldhXPWhlEooliWuETmkEEfLbHUeIUrmJdWgA9d/S9cGeTgW0cB8hY
 X5HyXe/q1EOeuAMnfZdTWqkwbeF0hJcRlvtXcBm7WAS1Pgf140pb0Vj4d9LA5OQSmP
 4r4IevkyrA5+j0Uq4UllXWtzHGeWR4xEJMaUREcjQSSe5XItjqEjmuTiUGJjhZ9hNY
 oBibWCZfNcVQ+wMyok0At+FbGZ39kY7ELyDDj8U9vuVlJAQSFh5g0qAYiAgRYL14Rn
 N2IObnRndNHXg==
Received: by keithp.com (Postfix, from userid 1000)
 id 06EF715821A3; Fri, 23 Oct 2020 17:13:10 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel\@nongnu.org Developers" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] riscv: Add sifive test device to sifive_e target
In-Reply-To: <CAKmqyKN20Fg_cKXmh2-vUaY4gPkE=PtPome5vwoTW9rM1gBTog@mail.gmail.com>
References: <20201023214506.917601-1-keithp@keithp.com>
 <20201023214506.917601-2-keithp@keithp.com>
 <CAKmqyKN20Fg_cKXmh2-vUaY4gPkE=PtPome5vwoTW9rM1gBTog@mail.gmail.com>
Date: Fri, 23 Oct 2020 17:13:09 -0700
Message-ID: <87eelo7a7e.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 20:13:10
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

> I don't see this mentioned in the FE310 data sheet. Is it included in
> the hardware?

This is strictly a virtual device used to support 'power off' when
running under QEMU. We need either this or semihosting support for doing
automated testing. Our tests currently use this device, but I'd be happy
to switch them over to using semihosting instead, if you'd be interested
in getting that merged...

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl+TcZUACgkQ2yIaaQAA
ABEw0BAAjV0NpUIl4SVvVGOpYrYgFGK7C2AuDVLhL/bnGEXm8zrAxNJuxfu8J9AW
MF6Vto5jGM+zDwbydwYq86/sBciK924EWUGOO1aABI5saMKy2kwwj77i2x4OJtlS
PsHCRjnGUCLjv67ieMRdWN6nPun/0RA1Ewmy5LZlC4LiCuLnwYbm5r4gDjfDZjlQ
X+rtIX1iSAnOyLSuovPKhC4EJOOxORqEQxIh8Vqiw1JMX9lM2FGzUUgfKCBpZ8Ot
UFI4Px9P4LuznVibDQQTaqzlz0bMseuGpM6o0/UX95qSgZbIoDy8J/KDICbHxdh/
V7drhH4nl2fRYWIWndLIQrKUDhCvTRObhQYK0J9G5bHhAy/Wuf43RqMTAof6yr6x
IJdf0uf7AqsVFUjOVwBmtvir/4zCaa6AN3XrSErAlQL9qmTmMubweBkuGEHZI3I5
n2dejj666TNXI9tFMo981IRZoecx+DzkkgEf3fyYl7Q4gdjIBwqdXxusyS+gcnZB
vs/I3gQCg4F65hmhNJYoDxTV8ZCbvufrxq3sWdfYaYS3lqEbPEqCBbfhAeuPFv4s
sp9+9G4tvmECT9Kd+ZLIx7Pe5dBcD/9Qtyr1BQJZS/HwEcMYg8Jby9VvA6amvqG8
0SK8g7Ahufldn6zGYJB6+0wlO33JpXIjD7EAF5Lcitos30ZEtvY=
=b4DV
-----END PGP SIGNATURE-----
--=-=-=--

