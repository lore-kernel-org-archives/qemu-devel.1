Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6C8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEBAE2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 18:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="ClxRbHxF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="ClxRbHxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEBAE2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv3ys-0007rz-15
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 13:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45069)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <keithp@keithp.com>) id 1iv3xe-0006m0-LI
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <keithp@keithp.com>) id 1iv3xd-0004ys-NN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 13:45:42 -0500
Received: from home.keithp.com ([63.227.221.253]:42314 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <keithp@keithp.com>)
 id 1iv3xZ-0004uc-BX; Fri, 24 Jan 2020 13:45:37 -0500
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 7D0F33F2A7A5;
 Fri, 24 Jan 2020 10:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1579891533; bh=RshqEZGatXEqsXZKYTF1ApW75pjoemfPpkTV4FQT3yQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ClxRbHxFgxIAQEg+hZLw/L7fGTCRME5qNQLi6ulM1QGdWJMl31SSlZlPyNv41wLYC
 rmAGHoJJTYADxGoXO1yAwBYqR9hBwBe7VV/WwQGrClf+ZjXOZCbhuLrTCRL2ahcw+k
 VR4I3KbHK5f3l4lNv6C4W0e557/QrqhyV2MxM1rJ3ghrSodXhEjQ72+/pgHK8cJ010
 Y9wSo0HczEINJybEKQmuHhGpn8KWunNpSLOw0kpEcIk2jfL4sGPM1r1AJPe8SFAbVJ
 OLPymYgK5Zjiswzyf/O09RCepM+np/a/Zk7kUAfI1AZLh+tEOpdidxgX/WHlZRn5tw
 XQsc7l11HzDVQ==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id L2qj3kusRI9n; Fri, 24 Jan 2020 10:45:33 -0800 (PST)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 153B63F2A683;
 Fri, 24 Jan 2020 10:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1579891533; bh=RshqEZGatXEqsXZKYTF1ApW75pjoemfPpkTV4FQT3yQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ClxRbHxFgxIAQEg+hZLw/L7fGTCRME5qNQLi6ulM1QGdWJMl31SSlZlPyNv41wLYC
 rmAGHoJJTYADxGoXO1yAwBYqR9hBwBe7VV/WwQGrClf+ZjXOZCbhuLrTCRL2ahcw+k
 VR4I3KbHK5f3l4lNv6C4W0e557/QrqhyV2MxM1rJ3ghrSodXhEjQ72+/pgHK8cJ010
 Y9wSo0HczEINJybEKQmuHhGpn8KWunNpSLOw0kpEcIk2jfL4sGPM1r1AJPe8SFAbVJ
 OLPymYgK5Zjiswzyf/O09RCepM+np/a/Zk7kUAfI1AZLh+tEOpdidxgX/WHlZRn5tw
 XQsc7l11HzDVQ==
Received: by keithp.com (Postfix, from userid 1000)
 id EC5181582165; Fri, 24 Jan 2020 10:45:32 -0800 (PST)
To: Peter Maydell <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 "open list\:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PULL v2 11/14] semihosting: add qemu_semihosting_console_inc for
 SYS_READC
In-Reply-To: <CAFEAcA-os-6iWZ-ucM-VUECyf8sn-xoANHCqJqtSyuttgZY23A@mail.gmail.com>
References: <20200109141858.14376-1-alex.bennee@linaro.org>
 <20200109141858.14376-12-alex.bennee@linaro.org>
 <CAFEAcA-os-6iWZ-ucM-VUECyf8sn-xoANHCqJqtSyuttgZY23A@mail.gmail.com>
Date: Fri, 24 Jan 2020 10:45:32 -0800
Message-ID: <87wo9gy9pv.fsf@keithp.org>
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

Peter Maydell <peter.maydell@linaro.org> writes:

> I'm not sure what we should do with EOF, but presumably
> we should handle it in some way.

There's no correct answer here, which is why the current implementation
just ignores it. Here are a couple of options:

 1. Just return whatever getchar() provides; if it returns EOF, we'll
    pass that on to the application. Semihost-aware applications may
    learn about this 'special' value.

 2. Return some ASCII control code (0x04?) in an attempt to tell the
    application what has happened.

 3. Block forever. This would at least keep the application from
    spinning.

=2D-=20
=2Dkeith

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw4O3eCVWE9/bQJ2R2yIaaQAAABEFAl4rO0wACgkQ2yIaaQAA
ABEocRAAl5ata2RuyXtE96rNi+RSDz3OVEoWNGGDvOscNx+F+pAmVBaoYueQtCt5
rcwaccib5RPFPhktjQVxVRUtFj1jcQ/M7EEF0U7Rtho9RcV2O203aYBq3aQ8qPer
tU7DvfSDZ6OiGAwTXk0QhClPOEZYlcLYWzrGyyjqbI2yvuI3Fcsy+7ZrDHpY7lvQ
sonX66rYqdg6xVZ1LjgMDZzqv32Q95B+3BWMrkhMF2Yp3ksTTrb8L/21Oq+hwr1N
Zw7vso6anQ3JtxKbHaezuwNLpa+jdWQ2eiX+rC3vDbCi/3ehRY1w5BDrsYXv/EGc
AtFT9QydrnoXsjDxrVORO1pWZVFCGwOKR5dFk++59bzP/T2VxKW1wokb881QCJf2
k0Q+SbtA+w5jfrDWZKH4TP5lGpQgk4VtGH98tRaOrEYmy5tjTP7xE3GEu5ILxo7U
UTjzpFmSLRDnDegCXaLsuJ5/jdBZNo7sXwIn0uwgN+655VclHZLAtuEnAc6ZkNd6
SyB+D+MV7IxuXD6AwRk20HVgBPxzguMOfnt0xvCUOT57IgBD4P7sUUBBYTZ7XAwt
R6oTnjpi3vOIfas/CBcAXHkySTJtQSZO1G9gdPqAgtrmpEycvMDtLKxldTnPk565
w+SY4tdaEDGWVZHK6nN6LvFsKs2U8UkjRMZ6ox8uoxJkPUV4RTo=
=N2Tb
-----END PGP SIGNATURE-----
--=-=-=--

