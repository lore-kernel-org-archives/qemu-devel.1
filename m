Received: from eggs.gnu.org ([2001:4830:134:3::10]:35778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFH-0007Oz-DG
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0hFD-0005L6-1R
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:07 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0hFC-0005Jz-S9
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 01:34:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 27 Mar 2018 01:33:46 -0400
Message-Id: <1522128840-498-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 00/14] fp-test + hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

v1: https://lists.nongnu.org/archive/html/qemu-devel/2018-03/msg05908.html

Changes from v1:

- Rename series from "hostfloat" to "hardfloat". The series already uses
  "host" as an option for fp-test, so this change should make things clearer

- Rebase on top of master (4c2c101590).

- Move code from fpu/hostfloat.c to fpu/softfloat.c. I am not mentioning
  anything about the license; I read the softfloat-2a license and I'm OK
  with it. [ Laurent: thanks for the clarification on this. ]

- Fix target-m68k build breakage

- Merge is_normal and is_denormal additions into a single commit

- Add tricore patch to use float32_is_denormal

- Keep the flatten attribute for the soft-fp implementations that
  have now become a slow path

- Add the noinline attribute to the soft-fp primitives. Not doing
  this reduces performance significantly

- Add a comment about why dealing with denormals in hardfloat is
  a bad idea

- Keep separate float32 and float64 implementations for most ops. This
  improves performance as shown in the commit logs.
  + I'm keeping the macro-based definitions to make testing easier.
  + In v1 I wrongly reported similar float/double results for fp-bench;
  I noticed that in my testing I forgot to set -p single/double, so I was
  benchmarking only with the default precision (single). Ouch!

- Update commit logs with fresh (correct) numbers from fp-bench.

- Move some zero-input detection (addsub/div) *after* checking for
  <= min_normal. This makes the common case (i.e. not all inputs are zero)
  faster, still allowing us to handle the 0-input cases in hardfloat

- Update the commit log of the comparison patch to mention that
  int64_to_float32/64 are still in soft-fp and take quite a bit of
  execution time for fp-bench -o cmp.

- fp-test:
  + add *.txt to fp-test/.gitignore instead of just whitelist.txt

- fp-bench
  + generate only positive numbers for testing sqrt
  + add -o cmp
  + use g_strjoinv to print the list of available ops in the
    help message
  + remove libc headers except math.h
  + use qemu/timer.h's get_clock_realtime instead of open-coding it
  + add entry to tests/Makefile.include to call fp-test/Makefile
    when building anything in tests/fp-test/

Perf numbers are in the last patch. They are a little different than
last week; I cannot replicate last week's performance (even with
the very same binaries; might have to reboot the machine I'm using
soon), but as of today v2 is certainly faster than v1 (e.g. 5% faster
for nbench-fp).

I have checked all checkpatch warnings; they're all false positives.

You can fetch the series from:
  https://github.com/cota/qemu/tree/hardfloat-v2

Thanks,

		Emilio

diffstat:
 configure                   |    2 +
 fpu/softfloat.c             |  619 ++++++++++++++++++--
 include/fpu/softfloat.h     |   20 +
 target/tricore/fpu_helper.c |    9 +-
 tests/.gitignore            |    2 +
 tests/Makefile.include      |    6 +-
 tests/fp-bench.c            |  334 +++++++++++
 tests/fp-test/.gitignore    |    3 +
 tests/fp-test/Makefile      |   34 ++
 tests/fp-test/fp-test.c     | 1183 ++++++++++++++++++++++++++++++++++++++
 tests/fp-test/muladd.fptest |   51 ++
 11 files changed, 2212 insertions(+), 51 deletions(-)
 create mode 100644 tests/fp-bench.c
 create mode 100644 tests/fp-test/.gitignore
 create mode 100644 tests/fp-test/Makefile
 create mode 100644 tests/fp-test/fp-test.c
 create mode 100644 tests/fp-test/muladd.fptest
