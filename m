Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA4C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 01:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB4B22249
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 01:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="qOAs9+X5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="qOAs9+X5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB4B22249
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXaMU-0003cv-Oo
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 21:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXaLR-000309-99; Tue, 27 Oct 2020 21:33:45 -0400
Received: from home.keithp.com ([63.227.221.253]:44678 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1kXaLO-0004Wc-Nu; Tue, 27 Oct 2020 21:33:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id C4DA53F2DD87;
 Tue, 27 Oct 2020 18:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603848818; bh=DlddCx9B00ZgsLS0DimPBQMwugUwvBncKW7lGIGUX/o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qOAs9+X5HFMhscSvDGKoTy7h/uQAmsLYPTcevfO+2bWEIUbRtESfKNVZPQzJLoCC3
 BGZF+XieeTc5dp5blocazje74is56zvhfmit6L4gX8UcqAWa+CTesUUqDnRj8Qbga5
 X2m63RDnuncbUE5iHX3PObuUnfBKfAtHseepTKmTQbYhTBYMIdwzUVM4R89oib1oR/
 wXBp8pQP7EXCEHLwadZ6O+U29FfvINJ9/B8Nj5ECNmGbwa5byxrU7mgP6ZR9I3xYnd
 NGT/lOOuFDn4R9UcIutaICLSEsSu1AXgBH6gpDS0F0Er0eflmJAiwPTCLd1bYX+IB1
 aaZ9u+nNbeRgQ==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id nrbUSEkdNccG; Tue, 27 Oct 2020 18:33:38 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 367BD3F2D926;
 Tue, 27 Oct 2020 18:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603848818; bh=DlddCx9B00ZgsLS0DimPBQMwugUwvBncKW7lGIGUX/o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qOAs9+X5HFMhscSvDGKoTy7h/uQAmsLYPTcevfO+2bWEIUbRtESfKNVZPQzJLoCC3
 BGZF+XieeTc5dp5blocazje74is56zvhfmit6L4gX8UcqAWa+CTesUUqDnRj8Qbga5
 X2m63RDnuncbUE5iHX3PObuUnfBKfAtHseepTKmTQbYhTBYMIdwzUVM4R89oib1oR/
 wXBp8pQP7EXCEHLwadZ6O+U29FfvINJ9/B8Nj5ECNmGbwa5byxrU7mgP6ZR9I3xYnd
 NGT/lOOuFDn4R9UcIutaICLSEsSu1AXgBH6gpDS0F0Er0eflmJAiwPTCLd1bYX+IB1
 aaZ9u+nNbeRgQ==
Received: by keithp.com (Postfix, from userid 1000)
 id A16831582210; Tue, 27 Oct 2020 18:33:37 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, qemu-arm
 <qemu-arm@nongnu.org>, Palmer Dabbelt <palmer@dabbelt.com>, Alistair
 Francis <Alistair.Francis@wdc.com>, Sagar Karandikar
 <sagark@eecs.berkeley.edu>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, "open list:RISC-V"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH 1/4] semihosting: Move ARM semihosting code to shared
 directories
In-Reply-To: <CAFEAcA8Sha5QYbO25dtzBZHoXUeiGVv8aojPFTMrst8nbVDAdg@mail.gmail.com>
References: <20201026212853.92880-1-keithp@keithp.com>
 <20201026212853.92880-2-keithp@keithp.com>
 <CAFEAcA-0_WLMP1Y1sgcu7Ng+0w8Ovt9DVWzYU8ZA_FA2+bwcUw@mail.gmail.com>
 <87pn53e3ke.fsf@keithp.com>
 <CAFEAcA8Sha5QYbO25dtzBZHoXUeiGVv8aojPFTMrst8nbVDAdg@mail.gmail.com>
Date: Tue, 27 Oct 2020 18:33:37 -0700
Message-ID: <87k0vbdthq.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 21:33:39
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

Peter Maydell <peter.maydell@linaro.org> writes:

>>         arm_ss.add(when: 'CONFIG_TCG', if_true: files ('common-semi.c'))
>>         riscv_ss.add(files('common-semi.c'))
>>
>> This appears to work in my testing (building arm, risc-v and x86_64
>> configs).
>
> I'm not a kconfig expert but it might be preferable to have
> a new CONFIG_ for arm-semihosting-ABI which the relevant
> targets enable. Somebody else may be able to advise.

The change above makes this do exactly what the old code did -- add this
file to the arm_ss sourceset whenever CONFIG_TCG is true. arm_ss is
only used to build ARM targets, so this file gets added only for those
targets. Here's what the patch to target/arm/meson.build and
hw/semihosting/meson.build looks like now.

diff --git a/target/arm/meson.build b/target/arm/meson.build
index f5de2a77b8..15b936c101 100644
=2D-- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -32,8 +32,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
=20
=2Darm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))
=2D
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c', 'kvm64.c'), if_fals=
e: files('kvm-stub.c'))
=20
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(

diff --git a/hw/semihosting/meson.build b/hw/semihosting/meson.build
index f40ac574c4..26538e81e7 100644
=2D-- a/hw/semihosting/meson.build
+++ b/hw/semihosting/meson.build
@@ -2,3 +2,5 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
 ))
+
+arm_ss.add(when: 'CONFIG_TCG', if_true: files ('common-semi.c'))

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl+YynEACgkQ2yIaaQAA
ABHpGQ//aNlybBfsN7SE8dZjtOa8qjztPHMCozcjrBgGlqK2LLa6sesSXbcFgtIn
ulbK63AZV14rtJvZi0puhWvGatchidYh/32amSLk8isZ1pHTOkvlv+ua5XXhYebS
EuXwg+6mqEBXI4ZXLfP8+iVP1l05qCXbW/hc7K3mZNRXKpguyh9p7jtEI16WwEcb
NKUX+ubJPiEXjWRILWuNQx/4lO67I1tER4KrGm8Bmr/6i/Wp1MzHla7+ODBIz+hm
jVpR1PpChnGsDIiACq6XiWs7OfYk7XbpR/pHf1d8rGRRmLBMaYMvQbDm+IdqfCli
OASvL8+UPvdoDdanNMd6/OjTaUiR0v094c9Gp4mHQm6X8i7ffIfT3PB9lCXsqs8i
RQpML1OFLWhqEUiPuQe2uaSWl4Bl71C5dDjtOHuSnYc0kYjkXThEdi80VkPZdRR6
FbDxhx122oXe21xBz5SzMqhrhkOHxVFVQGGYinmoyTlQYQEzc3GBHcl5UjIjRfS+
C6re9XQ4H+D271KPpQN5bIUN04XPmf8VvwuJgtY2tDoFlhEUQMiq/3QjOQULcNdT
NUAwQA36B7KQeC0gRMi3TvF0xlcPVXuCvJz3JhvdpPtb4xWKFVo8xZ7llFwSAUIm
HHrhbzE/DKi6cDGoRC2Xnr1e4dvst7GaR2rRml8O2xfJ1u03vg4=
=Zp/R
-----END PGP SIGNATURE-----
--=-=-=--

