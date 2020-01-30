Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D709C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2107F20707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 22:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="pyF0PfWE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="pyF0PfWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2107F20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixI5v-0005J1-0a
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 17:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1ixI3v-0003kr-6C
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1ixI3u-0003yH-9H
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:13:23 -0500
Received: from home.keithp.com ([63.227.221.253]:33170 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>)
 id 1ixI3t-0003oD-Rw; Thu, 30 Jan 2020 17:13:22 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 93B913F2AA6C;
 Thu, 30 Jan 2020 14:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1580422397; bh=yaVHPGyh874+mQ78S8X2p8uzfvXeaQLIIHBITFxyqsQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pyF0PfWEvm86RmPnDF43aYq9Pto7fpSYebXHHLpe06MaJesgZeqQaZMa5oA4jdQTw
 XpivhHPxyNoku/OBEfR4hoBmVVTVunq5Lu37hWyDbCiES+eU6wIRnPrU/6OPzi8ADg
 QeBmCr6R/XawVm4hCCNvTxV3FdCQ+8DI01x3QxThIH5PdhOtZ2Bhk3k0mj0YvYOzws
 t9I7PNxXPBg/eAuGVzQWuNDmS1JARKpRfywx/lIccwOqcxbyBS92HjxELhVUhk+Bir
 zPcWaO6aJHlG6ytu/+jb3MrChwinRqx7jwAwmMoOh2opOWxNkHaq4Q6Mnbt7CseFpq
 fQ4RLAISO4ztA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id lza7xOK8U_12; Thu, 30 Jan 2020 14:13:17 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 3350F3F2A963;
 Thu, 30 Jan 2020 14:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1580422397; bh=yaVHPGyh874+mQ78S8X2p8uzfvXeaQLIIHBITFxyqsQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pyF0PfWEvm86RmPnDF43aYq9Pto7fpSYebXHHLpe06MaJesgZeqQaZMa5oA4jdQTw
 XpivhHPxyNoku/OBEfR4hoBmVVTVunq5Lu37hWyDbCiES+eU6wIRnPrU/6OPzi8ADg
 QeBmCr6R/XawVm4hCCNvTxV3FdCQ+8DI01x3QxThIH5PdhOtZ2Bhk3k0mj0YvYOzws
 t9I7PNxXPBg/eAuGVzQWuNDmS1JARKpRfywx/lIccwOqcxbyBS92HjxELhVUhk+Bir
 zPcWaO6aJHlG6ytu/+jb3MrChwinRqx7jwAwmMoOh2opOWxNkHaq4Q6Mnbt7CseFpq
 fQ4RLAISO4ztA==
Received: by keithp.com (Postfix, from userid 1000)
 id AAF781582162; Thu, 30 Jan 2020 14:13:16 -0800 (PST)
To: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 sagark@eecs.berkeley.edu, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH] riscv: Separate FPU register size from core register size
 in gdbstub [v2]
In-Reply-To: <mhng-2ed22ad1-9efc-4ffb-856b-0d63ad8a9173@palmerdabbelt-glaptop1>
References: <20200128233216.515171-1-keithp@keithp.com>
 <mhng-2ed22ad1-9efc-4ffb-856b-0d63ad8a9173@palmerdabbelt-glaptop1>
Date: Thu, 30 Jan 2020 14:13:16 -0800
Message-ID: <87sgjwr3sz.fsf@keithp.org>
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

> This isn't working for me.  When I apply it on top of my for-master (whic=
h is
> very close to master), I get=20

>     warning: while parsing target description (at line 1): Could not load=
 XML document "riscv-64bit-fpu.xml"

If you're building from an existing directory, I think you'll have to
force re-creation of riscv32-softmmu/gdbstub-xml.c

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl4zVPwACgkQ2yIaaQAA
ABHtExAAh+e3lWokXF31WEoms5bPrxYYzR9r8wyRH2+JPNYfK1uM5aZLuGSkZhrV
y3woNgwg1zv5A+xFIDGc+i6gt+H504rrpC+cx9KOWQr5m4PHxhXGKb9CmVSffIMh
uojLzicVZB1nS308LE+UEub6YoFJjET+qSjUX/C6ehjaEsSuTxRLYdcfzTXSbkRv
wDujGskwx/5z/xpbaeL4aLQNlYNCrLDiqDZeJiav+6sfgwJzEYg3sB55AwD0r1Qo
241vRlTV+12OICluHiy9nx2EvGQTFF3R0Psw5S7b41oZEgpAnVlQwFl9MUg4v0R1
dcsqMEmLVR/orsvlanDzPHaCJNY8ydi7mEsTZHking2npjxLXWovTRDhAA7tLGR6
0QV0iKfKkP2u0Cxsc4LJMoa8/6KXkkzPFTeMr6BXntKaKaGNDB5Bd78VX+32jNkL
Dfue+tNdKgsxR0waSDqDmxuYEI1eUWlucYG3QMNwTPeGRylUPUgxAjJ2Smok1hnZ
Qcrq/A82ucjRNePkP14IkSgh98McGxSNVOEp7JWLS4fx1F+Rjy3ZW/sPC1qOHaEB
PhQPkawwGxH2wJBjD+7ZufYF41JV5Wll5N8upFAOCeCVtOs/8fS/8eMRCufjx1Ii
ohUgh/zo6eF2IkxOIB1AWTFNqaW1qxgRUAuq77dbB9G4QL8nF3c=
=PEBC
-----END PGP SIGNATURE-----
--=-=-=--

