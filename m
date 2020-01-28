Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B9EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21E9207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="agfYABxL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="agfYABxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21E9207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwaNn-0003pW-3o
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 18:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iwaMP-0002Zg-4S
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iwaMO-0000LJ-4L
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:33:32 -0500
Received: from home.keithp.com ([63.227.221.253]:44634 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>)
 id 1iwaMN-0000Gk-Te; Tue, 28 Jan 2020 18:33:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 835CD3F2A89D;
 Tue, 28 Jan 2020 15:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1580254409; bh=0/icW2R0xElBKWqbPW/bPBhWmuMOtQtHIR20kKLD03g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=agfYABxL+8XeLXPJyNtFERVlOtLD6NAZHw0DgnVZsF33zeO7au0TzBFDGLpuaHr//
 vzGmcRXmjcUqQS04PcaHUjXvo6YpUZ4K7BJS9Fe+EBuG+779zDiZFbjfTOgLTo9FK2
 uHuVy3EzKxFDT7h6KuCrlMPaLv8B6acU/VTswUT2o++jx6DCIQaPILk0UriO2105xa
 1KMK46qicbQggG/+DosTX4XCEBnrepg14hGBEfbeTUpQDYRAWCPJLNobOjfzE1J+pv
 gLSEus9qRR0xIVDLlvJRxa49XqkcfYVmTSOkzIbSTQ1sz4gEER2KDNxnHMcRhDhNWd
 xn/x0mwO/kMAg==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id OOD6eP0GWAAl; Tue, 28 Jan 2020 15:33:29 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 28D8A3F2A895;
 Tue, 28 Jan 2020 15:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1580254409; bh=0/icW2R0xElBKWqbPW/bPBhWmuMOtQtHIR20kKLD03g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=agfYABxL+8XeLXPJyNtFERVlOtLD6NAZHw0DgnVZsF33zeO7au0TzBFDGLpuaHr//
 vzGmcRXmjcUqQS04PcaHUjXvo6YpUZ4K7BJS9Fe+EBuG+779zDiZFbjfTOgLTo9FK2
 uHuVy3EzKxFDT7h6KuCrlMPaLv8B6acU/VTswUT2o++jx6DCIQaPILk0UriO2105xa
 1KMK46qicbQggG/+DosTX4XCEBnrepg14hGBEfbeTUpQDYRAWCPJLNobOjfzE1J+pv
 gLSEus9qRR0xIVDLlvJRxa49XqkcfYVmTSOkzIbSTQ1sz4gEER2KDNxnHMcRhDhNWd
 xn/x0mwO/kMAg==
Received: by keithp.com (Postfix, from userid 1000)
 id 1625A1582162; Tue, 28 Jan 2020 15:33:29 -0800 (PST)
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel\@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list\:RISC-V" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH] riscv: Separate FPU register size from core register size
 in gdbstub
In-Reply-To: <CAKmqyKOpG1QYD_w1EHEUEs-8J1RAx=k8xMqxRZ5H0nD2N7q_+w@mail.gmail.com>
References: <20200128223955.464556-1-keithp@keithp.com>
 <CAKmqyKOpG1QYD_w1EHEUEs-8J1RAx=k8xMqxRZ5H0nD2N7q_+w@mail.gmail.com>
Date: Tue, 28 Jan 2020 15:33:28 -0800
Message-ID: <87o8unrwaf.fsf@keithp.org>
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

Alistair Francis <alistair23@gmail.com> writes:

> You need brackets around all if statements, besides that:

Sorry for the noise; I caught that and sent another version of this
patch.

> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for your review!

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl4wxMgACgkQ2yIaaQAA
ABGLmw//UdfL49nt27THQVkMeALI28cXeP31xY2GWXvrCjRBWhfAZYjITZeAAAMV
BVvLoGaykJvjjWrwJdHo7anuKl0Oy3DTV8Bm/BZDImC2TNQU3jTaQRCxmkQkH5DA
ad8bfhtgcfAtc+r2Z02e8ivjDkPrlFPetj10LaWXGqwO5c6Q/FQxcKNSyPYK02NX
q63XH15evtUVnMszI6vGEnOorWkQKFIL45VeO5/s9jdPlyAPZtn/YJF1dtv4ZFJv
tjo9Tnlzzj/+/ruZK0HpsEczn7oIFYxiZTagAR5FaAanuw20YcZpRLp0r+xlJxAk
uXyaZiBoDENotH8RRUN8keTLRtCVfeuwLaGYgdZK7HzgUDSXZleaE88udR06e/xL
t3ucvpDNeOdZehxJrjuy+9MnzEGiwUHzao7o4XvmM78bYHTrBFMFbH58FnOoQMnU
XYA92c9Ebmk5tHLe8BdU0YnIKJqPbDnU4SFWiRN6z1UD3aOyE0z5Z+isCSMTkRZ6
d84r1p1ULv9LijJsQzYMwFaax6YUw36sc9WA+e/G+dKza7816kH+eNehDcsXyynU
wnsbLxkoNT6AnVhpU5bed5GILDkgoMqEFaAdVwstVptFK5qHG554SHNAf8vof/NX
ULRLGw4nYZj8szMAZUplT4QT7NstfFHe56ZMlbhHN+wmJ+HR4Zs=
=Tfcs
-----END PGP SIGNATURE-----
--=-=-=--

