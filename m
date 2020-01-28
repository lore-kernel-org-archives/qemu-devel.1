Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBDDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C412073A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 23:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="AEbN6Yq5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="UUxlameO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C412073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwaP0-0005Cv-Kw
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 18:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iwaNf-0003vj-66
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:34:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iwaNd-0003ne-9B
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 18:34:50 -0500
Received: from home.keithp.com ([63.227.221.253]:44670 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>)
 id 1iwaNd-0003ko-32; Tue, 28 Jan 2020 18:34:49 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 2DFD83F2A89E;
 Tue, 28 Jan 2020 15:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1580254488; bh=+p0k5tb8ZttMZ50WWyUz1i4/f41iRVLYEz/z8eBqkgM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=AEbN6Yq5lKRHgvsG8JWBYqh9utmoz71CszaoOpNznRK9KM+Kd/JX93mzbV4JUTUz7
 eosTdN8sMGWr1nquQtXPSzIWoA0BnarM1inDOwurO7IyxVkJQBTArRMDXymm71aZVK
 Kb7XG6tWCRvO9psUbAmyQdiVXSsvHDc9C/ezsdTSQ7BmQTzxNXCo567dvDCYZljFFT
 Cz9TH8w2C5RHkcvt8GW8uZ887m8wr0/yQkzE15Q1dISGw4PVcbQusN06rj+GQ4r36U
 VcgmfDnRif7kuvHf8cTEyevhSeD6cKU7HGv9zVUcVoxwH1ZehfkEiMwy/VSYTGulat
 RfIjJSnGBVfMQ==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id ZEzBFwehzoUJ; Tue, 28 Jan 2020 15:34:47 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 9C7F23F2A895;
 Tue, 28 Jan 2020 15:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1580254487; bh=+p0k5tb8ZttMZ50WWyUz1i4/f41iRVLYEz/z8eBqkgM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UUxlameO2nWHeXy/510P28tBe/S/lwhjgYrcTBCQFW295vNlWfgCs4jYc7VjxV7QD
 IEDU15UEhyCz0Iu9Oq1yULtgXqP9+1t5lSmbVutx7WR69wQBKnVMtx4flnEsgflt94
 xpqk2JHciY0CZqZo3C2R8gpRoQQE9pbpbuNx0hdvXDvdtTS3zV3JJEjUDXkqMcSlFc
 mrArL7/9sT5DIYPmb6y/qLUtix/IR4MXRpkWnOvKnQH2wO9wtmvii5V8xAnGc8eDV8
 h0yz/O7xO+akHoAcFsypX710nkzIQOZLHxenzd1qh+wDlLMfUhrlvxryk0gYbDDjmP
 rkPBfx06g4YxA==
Received: by keithp.com (Postfix, from userid 1000)
 id 8832B1582162; Tue, 28 Jan 2020 15:34:47 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-riscv@nongnu.org
Subject: Re: [PATCH] riscv: Add semihosting support [v3]
In-Reply-To: <20200128231840.508986-1-keithp@keithp.com>
References: <20200128231840.508986-1-keithp@keithp.com>
Date: Tue, 28 Jan 2020 15:34:47 -0800
Message-ID: <87lfprrw88.fsf@keithp.org>
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

Keith Packard <keithp@keithp.com> writes:

> Adapt the arm semihosting support code for RISCV. This implementation
> is based on the standard for RISC-V semihosting as documented in

Sorry for the noise on the list; I failed to run checkpatch.pl before
submitting. I've re-submittd [v4] with the formatting errors corrected.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl4wxRcACgkQ2yIaaQAA
ABH7qg/9FVPgw6oQtuHRtcbrT+QXuzq4zJ9v2przHuXeLcGnuoKyvoaXG8Tr3XuK
hthU80KlfwVx1OJ9aBGD2/cRxFxzggBmEeQthpxM2KIMFrMIv+r4/X8IcEXsD5tg
pfzRGDs6JhxAd268TwPCQqlN7XUITMJEbZaERDkkiSKcEj5UZlhFflCKceccUWP3
klgV/xIoMahHbgALzoeikUPSGenjQMyYH2Y/OfznH0ypJRl2E0vvKIrUYfrwrI3P
P87HWXIYukTKxIJLAZKwEzp6AYpNiG2iAXac6c/zJBto/BSmiux83RzpROE41NrW
zuYep4XISLS4IQ6OsyaaRdjJIyB22wOUhQs0HCa6OIWSowkzW+Xb/S/YpSF/0ISN
+chPFNobHSFuOAF9IJq3DtpzXQpQ0ByA+MmUaNgfPtzt8zmuLjSBS4QT+U+H+mvL
rL/KM96pGNGjnHiCdzLSAShKfhIDSkofBg3Gv9ixVoXXEOm43f4HGdXU8STwheqS
jYSD/RSGbdpCR4yqxWsO+soFI39z1/jgsrKn0XK9QGox/WcH7M1g9X9rDupP/WJn
5DlgJKBcDnHPVcGVVky9/GS+3AkIpdd8hvgLWUOUrQ3IDath0MemQaR82hCimlNr
zhyoPOdxcOUxS7czAjFWJHGur117oFdWOScBACjbkm8IlhTYz2A=
=hemM
-----END PGP SIGNATURE-----
--=-=-=--

