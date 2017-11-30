Received: from eggs.gnu.org ([2001:4830:134:3::10]:49426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKpLI-0007bX-4u
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:43:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eKpLG-0000Uo-Iv
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:43:16 -0500
Received: from indium.canonical.com ([91.189.90.7]:51950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eKpLG-0000UJ-Bc
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:43:14 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eKYI9-00049H-ES
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 23:30:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 52F0E2E80D2
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 23:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Nov 2017 23:25:20 -0000
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Reply-To: Bug 1735384 <1735384@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
	<151204437224.3145.2784740143531482152.malone@gac.canonical.com>
	<74ce90f9-f123-8fba-1038-7dd181d9148c@physik.fu-berlin.de>
Message-Id: <177a2c67-932a-8842-fc71-229373bc28aa@physik.fu-berlin.de>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1735384] Re: OpenJDK JVM segfaults on
 qemu-sh4 (regression)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The offending commit is:

d25f2a72272b9ffe0d06710d6217d1169bc2cc7d is the first bad commit
commit d25f2a72272b9ffe0d06710d6217d1169bc2cc7d
Author: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Date:   Mon Nov 13 13:55:27 2017 +0000

    accel/tcg/translate-all: expand cpu_restore_state addr check

    We are still seeing signals during translation time when we walk over
    a page protection boundary. This expands the check to ensure the host
    PC is inside the code generation buffer. The original suggestion was
    to check versus tcg_ctx.code_gen_ptr but as we now segment the
    translation buffer we have to settle for just a general check for
    being inside.

    I've also fixed up the declaration to make it clear it can deal with
    invalid addresses. A later patch will fix up the call sites.

    Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
    Reported-by: Peter Maydell <peter.maydell@linaro.org>
    Reviewed-by: Laurent Vivier <laurent@vivier.eu>
    Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
    Message-id: 20171108153245.20740-2-alex.bennee@linaro.org
    Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
    Cc: Richard Henderson <rth@twiddle.net>
    Tested-by: Peter Maydell <peter.maydell@linaro.org>
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

:040000 040000 da50c4c43089d3ee7d1e9ad50d3c9036114e5f11 cd6a0dcaa1d284fe543=
9f6f3b61547d4b0662768 M      accel
:040000 040000 c294a7c102d27295f8d81cc06b5d4d17357440ad 5a1268b7634f69f0806=
f22161ec7d6a1a26c8812 M      include

Reverting the commit resolves the issue.

-- =

 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1735384

Title:
  OpenJDK JVM segfaults on qemu-sh4 (regression)

Status in QEMU:
  New

Bug description:
  Some of the recent changes introduced a regression which makes the
  OpenJDK JVM crash on qemu-sh4:

  (sid-sh4-sbuild)root@nofan:/# java -version
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault
  (sid-sh4-sbuild)root@nofan:/#

  An older version works fine:

  (sid-sh4-sbuild)root@nofan:/# java -version
  openjdk version "9.0.1"
  OpenJDK Runtime Environment (build 9.0.1+11-Debian-1)
  OpenJDK Zero VM (build 9.0.1+11-Debian-1, interpreted mode)
  (sid-sh4-sbuild)root@nofan:/#

  Haven't had time for bisecting this yet.

  Adrian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1735384/+subscriptions
