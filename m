Received: from eggs.gnu.org ([209.51.188.92]:33968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjTU7-00041F-19
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:30:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjTU5-000880-Lm
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:30:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjTU5-000843-5x
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:30:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjTU1-0006na-N5
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 18:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id AD7232E80C8
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 18:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2019 18:22:41 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1777252 <1777252@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152916202234.7686.15264921741576357687.malonedeb@wampee.canonical.com>
Message-Id: <154757656145.19406.7478548066089933902.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1777252] Re: tests/Makefile.include trying to add
 linking library '-lutil' that break the build on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The condition we use in configure to decide whether to add -lutil to
libs_softmmu is "not Darwin and not MinGW and not Solaris and not
Haiku"...

I think the thing we're trying to get from libutil is openpty(), which
is in that library for Linux and the BSDs. It's not in libutil for OSX
(though since OSX has a libutil anyway it's harmless that it gets linked
in). For Windows we avoid code paths that use openpty(), and Solaris
doesn't have openpty() at all so we have to hand-roll our own
implementation in util/qemu-openpty.c.

I think the cleanest fix to this problem is to have a configure test
that checks "does openpty() require -lutil?", and then use the answer to
that both to decide whether to add -lutil to libs_softmmu and to decide
whether to add -lutil to the link line for this test binary.

PS: Thanks for the offer of Solaris hardware access. We may be able to
take you up on that but it would also require some time from somebody on
our end to set things up to use it. The other possible option is to have
one of the free-solaris-equivalents set up as a VM to run tests in in
the same way we do for the BSDs in tests/vm.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1777252

Title:
  tests/Makefile.include trying to add linking library '-lutil' that
  break the build on Solaris

Status in QEMU:
  New

Bug description:
  Building script 'tests/Makefile.include' contains following code
  ```
  ifeq ($(CONFIG_POSIX),y)
  LIBS +=3D -lutil
  endif
  ```

  library -lutil is not available on Solaris, so the building will failed, =
like
  ```
  ld: fatal: library -lutil: not found
  make: *** [SOMEWHERE/src/qemu-2.12.0/rules.mak:121: qemu-nbd] Error 1
  ```

  Commenting those code out fixed the error.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1777252/+subscriptions
