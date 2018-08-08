Received: from eggs.gnu.org ([2001:4830:134:3::10]:45856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnKdI-0002ni-EY
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:19:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fnKdE-0002EU-DR
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:19:56 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:34417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fnKdD-0002Du-Sy
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:19:52 -0400
Received: by mail-wm0-x22b.google.com with SMTP id l2-v6so75150wme.1
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 02:19:51 -0700 (PDT)
References: <BN7PR08MB48688EB667F7EDFF86B90D2CC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <BN7PR08MB48688EB667F7EDFF86B90D2CC6200@BN7PR08MB4868.namprd08.prod.outlook.com>
Date: Wed, 08 Aug 2018 10:19:48 +0100
Message-ID: <87zhxxp64r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question: How to integrate simple tests for a new
 platform so that they fit in well within QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Petar Jovanovic <pjovanovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>


Aleksandar Markovic <amarkovic@wavecomp.com> writes:

> Hello, folks.
>
> We are introducing a new MIPS platform - called nanoMIPS - to the QEMU.
>
> Besides providing new functionality, we would like to integrate into QEMU=
 some basic testing capabilities for that new platform. Something like this:
>
>     Enable user to specify cross compiler and, using QEMU Linux user mode:
>         a. execute several tests that are just almost minimal tests of em=
ulation of selected instructions.
>         b. execute several tests that are just almost minimal tests of
>     translation of selected system calls.
>
> In other words, this would enable a user to run "smoke tests" for nanoMIP=
S platform, and perhaps to use these tests as a starting point for some oth=
er tests.
>
> My question is:
>
> 1. Is this a good idea at all?

Totally. The test/tcg section languished for awhile as most people don't
have cross compilers set up. Thanks to docker we can now have a fall-back to
known good cross-compilers while still supporting local setups with
--cross-cc-ARCH and --cross-cc-flags-ARCH.

> 2. If yes, what would be the best way to integrate these tests into
> current QEMU test organization?

So currently tests/tcg is setup for linux-user testing. It will run
everything in tests/tcg/multiarch and any additional user-mode tests in
tests/tcg/ARCH as governed by the Makefile.include.

For the existing MIPS it is basically multiarch however there are
sub-directories that are system tests that need to be re-integrated. We
have cross compilers for a bunch of the existing MIPS platforms in the
form of:

  debian-mips-cross.docker
  debian-mips64-cross.docker
  debian-mipsel-cross.docker
  debian-mipsn32-cross.docker
  debian-mips64el-cross.docker

If you would like to help resurrect the system emulation testing for the
existing MIPS tests I would welcome the help. I think all the
infrastructure for compilers is already there so it should just be a
case of tweaking the Makefile structure a little.

> I appreciate any opinion of yours.

So the first question that needs to be answered is where can you get
nanoMIPS compilers?

For some of the more esoteric architectures QEMU supports we ended up
using Debian's rolling Sid distribution as it still contains cross
compilers for unofficial architectures that are in ports. If there is
any push for getting a nanoMIPS Debian release that might be the
quickest way. Otherwise you would need to write a dockerfile to install
the toolchain on some reasonable base system - see for example
debian-tricore-cross.docker which basically builds Bastien's fork of
binutils.

You don't have to build the toolchain from scratch - however it would
nice to have a clear idea from of where the source for the toolchain
comes from. At least with Debian images we know any binary is only an
apt-get source away from it's code.

If you have any more questions please ask away and also CC me on any
patches (MAINTAINERS should take care of this).

--
Alex Benn=C3=A9e
