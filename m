Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096DEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB17E206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 20:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="Z5FcMgF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB17E206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joukh-000112-4Q
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 16:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1jouk7-0000TL-5F; Fri, 26 Jun 2020 16:14:35 -0400
Received: from home.keithp.com ([63.227.221.253]:46130 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>)
 id 1jouk5-0005TO-Me; Fri, 26 Jun 2020 16:14:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id AD1023F2CB96;
 Fri, 26 Jun 2020 13:14:31 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id BkigoMvGP13E; Fri, 26 Jun 2020 13:14:31 -0700 (PDT)
Received: from keithp.com (168-103-152-72.tukw.qwest.net [168.103.152.72])
 by elaine.keithp.com (Postfix) with ESMTPSA id 569373F2CA82;
 Fri, 26 Jun 2020 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1593202471; bh=msWDRdQRNxC30MFl3LwnTsr1ZyE7PDGQXo/A0w72/14=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Z5FcMgF6n+uG4v4yqhQogyuyKXfN63xj99pp4NCbpDHTrMDrDndbT4XPCiOlHHLtY
 X3LExSWhUw5hfpytQTek30eKJGT1UmHAb1E/WWP5DrkTc30hDzhxo5Ey16PhAQ65y9
 autN/xNXgX5PcCqhd0qN4zJnG7gm+O+mbG0QVnBqlvX25dgpRcfkyexgfh0TQQErjZ
 vDaaBrP9eNtXjIYfCPbrv+X+zkvNj0hFZ3agzt7IFif580ltBWvpqSzJf/VU+CG1Y3
 u7wWjhdU98M4cOYTLVGh3n9lPlhDJ76CRk/M+yqxqbVq/das4fK3WpARFm9vS+Ym/t
 1rd5ZbSpHlC+w==
Received: by keithp.com (Postfix, from userid 1000)
 id CEAB61582167; Fri, 26 Jun 2020 13:14:30 -0700 (PDT)
To: Max Filippov <jcmvbkbc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/arm: Add 'virtm' hardware
In-Reply-To: <CAMo8Bf+57b=u12nMp4EWaza3WdOQpx_L_O=HvdouM99wW-Xe=A@mail.gmail.com>
References: <20200625230740.549114-1-keithp@keithp.com>
 <CAFEAcA9ut5CVAgRTP-_BK3WpiDSmitFowZMe549TvgSAjj+Kfg@mail.gmail.com>
 <87imfdixv9.fsf@keithp.com>
 <CAFEAcA_ZRMpqAhR7BL05a+O_C54fhXZn8-+kC_KUU5n3BpzoCw@mail.gmail.com>
 <CAMo8Bf+57b=u12nMp4EWaza3WdOQpx_L_O=HvdouM99wW-Xe=A@mail.gmail.com>
Date: Fri, 26 Jun 2020 13:14:30 -0700
Message-ID: <877dvtinyx.fsf@keithp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 16:12:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Max Filippov <jcmvbkbc@gmail.com> writes:

> Most of them are due to unsupported/differently implemented
> syscalls.

Yeah, I think that was the basis of my confusion -- qemu-arm is not a
bare metal environment, and my work is focused on enabling application
development in that environment.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl72VyYACgkQ2yIaaQAA
ABEXpw/+ME0hsqDba1gmQY54wODhKE5wQn6I1AkSPsNmDN0rJ6sxM3EdesLlQOEh
qLWQzBD9cSbcbkZrk8s9/jxjkrSnjbq+lPObGOrLTLbSgr9+AAerrozOrjDq4sKm
W3DzWgFPxhj55IdSLrJhfLh2kgYPGLh+3cbhcfMaCDTULm2PD/KzfcL+6k8YAP+3
DV7KFFKKbAzGAplZFVpifIpES6I0aCUkdcYypHlN2gPy7Ifh26du3DiEE4FdwGHe
cunoK4rvlPHCiAyJusnetMb+OWzOx7utSSiUvB6naVHj4fBqaX46sZih6i8cGt5Y
ONx7Pq2vwdVzd3I9yCRhIZmkG9wUvDapSl48kx7ZkNQPX5oQ903U9GUzeO5dR3QB
8cZ6gurgIW59JMBhehpRDeljW+PMeBW/YFv2vWNvKNzcf0RQwzslPjXLG3Tm/Prd
4xxPy8hYk4CZew5ssyKM87eNnxkA1eoVomR/IIiBWmZVvOuLDj2oF+ZqKYmx9Zjc
/dtT7WttVUYkeF50V5Cy+GeeYbh66CA3LLUQVepmaDIGjw1DASQcOV2ZE0msXpiS
kFI3OwCZf6JTachLNl0xAiLb10S00Rxf7WywdGkh7yc0TosxZc2GsTBdfqYeErAV
YsFO1bOjiywNl7vJ8xrw8th8JACk5+xbXnCBRAcxaU6Jtv0F9XE=
=3Bbs
-----END PGP SIGNATURE-----
--=-=-=--

