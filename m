Received: from eggs.gnu.org ([2001:4830:134:3::10]:42155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-00029p-Nu
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000yb-0E
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5Q-0000xC-ST
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:35 -0400
Message-Id: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 00/14] fp-test + hostfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This series is a first stab at (1) having a test suite for our floating
point (FP) implementation, and (2) leveraging the host FPU to speed up
guest FP operations whenever possible.

- Patch 1 is a set of simple microbenchmarks to isolate the performance
  of particular FP operations.

- Patch 2 adds fp-test, a floating point test suite. Note that I'm
  hacking around target poisoning to be able to include softfloat
  headers. I am not defining any TARGET_* cpu, so softfloat-specialize
  will take the defaults. The commit message has more info on how
  fp-test can be used to test the full FP implementation of a guest CPU.

- Patch 3 fixes a bug in FP that was identified with fp-test.
  The bug is very minor, but we might want to get this fixed in 2.12.

- Patches 5-6 add some helpers to be used later. Note that
  the functions there return bools, not integers like the
  functions around them. [wasn't sure which way to go for.]

- Patch 8 introduces hostfloat, as a separate, GPL'ed file.
  The commit message and a comment in the file document the
  assumptions and possible pitfalls of this approach.

- Patches 9-14 implement some common FP operations in hostfloat.

For performance numbers see the last patch.

BTW checkpatch reports some warnings, but they're false positives
so please ignore them.

This series applies on top of f6d81cde ("Merge remote-tracking
branch 'remotes/stsquad/tags/pull-shippable-disable-ppc-080318-1'
into staging", 2018-03-08).

You can fetch the series from:
  https://github.com/cota/qemu/tree/hostfloat-v1

Feedback appreciated!
Thanks,

		Emilio

diffstat:
 Makefile.target             |    2 +-
 configure                   |    2 +
 fpu/hostfloat.c             |  342 +++++++++++++
 fpu/softfloat.c             |   97 ++--
 include/fpu/hostfloat.h     |   34 ++
 include/fpu/softfloat.h     |   53 +-
 target/m68k/Makefile.objs   |    2 +-
 tests/.gitignore            |    2 +
 tests/Makefile.include      |    3 +-
 tests/fp-bench.c            |  290 +++++++++++
 tests/fp-test/.gitignore    |    3 +
 tests/fp-test/Makefile      |   34 ++
 tests/fp-test/fp-test.c     | 1183 ++++++++++++++++++++++++++++++++++++++++++++
 tests/fp-test/muladd.fptest |   51 ++
 14 files changed, 2035 insertions(+), 63 deletions(-)
