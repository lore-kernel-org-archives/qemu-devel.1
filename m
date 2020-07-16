Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9CCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1284C207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="fgmQucFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1284C207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5Gv-0005Mf-Az
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jw5GD-0004xU-VT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:53:22 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:42417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jw5GA-0001kk-Hd
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=lGXDf7qZUAZ4lidEUas/RtfXGUifWrdA6pnBIDM/vVY=; b=fgmQucFdwwly+5i9Z0Gu3pYSCw
 JXW6abWPJnkQVyMk/6rcKPLENAGm3azi6I2vvQmkJLbgi6inAXaele1N9Ht1P/GgKJLIV/4L3pbhD
 xut2h0pXkoENPwwoCy8Bs/r6xTulSWlq6nU6KWf5vY9Zqz+Oqn+7KX+MGLoxkAeTPy+cFzVNrxvhz
 cB3DRiDxE7sdlNW2bpp76fwkdBCvv+b/re4xCKXytIRNKG9Sya1DqTVPy8TyjXsJ+9kGaPP5QpyX/
 PKQ+bo/yd0owpHN6ZS3DL6nb20RnMe/0aBKsICuQN0adoX+0GW+vF1IhASogpOTj9htfC0fD/ZkYB
 FXZVskag==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org,
 Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] configure: Fix atomic64 test for --enable-werror on
 macOS
Date: Thu, 16 Jul 2020 16:53:15 +0200
Message-ID: <2414218.yr2C7u7i7c@silver>
In-Reply-To: <20200716142518.GU227735@redhat.com>
References: <20200716131101.18462-1-thuth@redhat.com>
 <20200716142518.GU227735@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 08:22:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

On Donnerstag, 16. Juli 2020 16:25:18 CEST Daniel P. Berrang=E9 wrote:
> On Thu, Jul 16, 2020 at 03:11:01PM +0200, Thomas Huth wrote:
> > When using --enable-werror for the macOS builders in the Cirrus-CI,
> > the atomic64 test is currently failing, and config.log shows a bunch
> >=20
> > of error messages like this:
> >  config-temp/qemu-conf.c:6:7: error: implicit declaration of function
> >  '__atomic_load_8' is invalid in C99
> >  [-Werror,-Wimplicit-function-declaration]> =20
> >   y =3D __atomic_load_8(&x, 0);
> >  =20
> >       ^
> > =20
> >  config-temp/qemu-conf.c:6:7: error: this function declaration is not a
> >  prototype [-Werror,-Wstrict-prototypes]
> >=20
> > Suppress the warnings to make it pass.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >=20
> >  Not sure whether this is the best way to fix this issue ... thus marked
> >  as RFC.
> >  Even though the compiler warns here, the program links apparently just
> >  fine afterwards and CONFIG_ATOMIC64=3Dy gets set in the config-host.mak
> >  file on macOS, so the 64-bit atomic operations seem to be available...
> >  Any macOS users here who could shed some light on this?
>=20
> The error message refers to c99, but QEMU code standard is gnu99.
>=20
> It doesn't look like we set std=3Dgnu99 when running configure
> tests though, and I wonder if that is relevant in this case,
> given that the atomic_load* stuff is all compiler built-in.
> eg does  -std=3Dgnu99  have any impact on the warnings ?

I already tried that. It makes no difference for me with clang on macOS=20
10.15.5. I also tried higher C standards with & without gnu extensions, sam=
e=20
thing.

I also tried raising the minimum deployment target, as I saw some macOS sys=
tem=20
libs are hiding these __atomic_*_8() calls depending on the macOS version, =
did=20
not help either though.

Like I mentioned in my other email, I don't see __atomic_*_8() being declar=
ed=20
in any public header on Mac, and keep in mind if you don't have a proper=20
function prototype declaration somewhere (i.e. if you just use the '-Wno-
implicit-function-declaration -Wno-strict-prototypes' hammer), then those=20
functions' arguments and return values would *all* simply, silently default=
 to=20
type 'int' with C -> potential data truncation and/or ending up in wrong=20
registers on ABI level, etc.

So __atomic_*_8() -> __atomic_*() (and including <stdatomic.h>) is probably=
=20
the best choice. Even though __atomic_*() uses a different data type, but i=
ts=20
just a couple lines changes in this case fortunately, as the actual qemu co=
de=20
base is not affected.

Best regards,
Christian Schoenebeck



