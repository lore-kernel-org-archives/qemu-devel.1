Received: from eggs.gnu.org ([2001:4830:134:3::10]:54350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3rZJ-00049J-T7
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3rZG-0003yu-Cr
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:11:53 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f3rZG-0003yc-60
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 19:11:50 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  4 Apr 2018 19:11:00 -0400
Message-Id: <1522883475-27858-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 00/15] fp-test + hardfloat
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06805.html

Changes since v2:

- Add R-b tags

- Add a patch to rename our canonicalize to sf_canonicalize,
  to avoid clashing with glibc's.

- Add a patch to define float{32,64}_is_zero_or_normal

- Simplify the float{32,64}_input_flushX macros -- now the
  macros are more verbose but the full function names are greppable.

- Move tests/fp-test to tests/fp, since now both fp-bench and fp-test
  are under tests/fp.
  + Use tests/fp/fp-test.h for helpers common to both fp-bench and fp-test.

- Complete rewrite of fp-bench:
  + We can now directly call the softfloat functions, thereby
    making the benchmark more sensitive to changes to those functions.
  + We can still use the native ops with "-t host".
  + The rewrite also has less macro trickery; we rely instead on
    constant propagation by the compiler.
  + Alex: dropped your R-b since this changed a lot. I think you'll
    like this version better though!

- Define a generic function to generate the hardfloat implementation
  for ops with 2 inputs; add, sub, mul and div depend on it.
  Instead of using macros, rely on the constant propagation done
  by the compiler. [Alex: I dropped your R-b for the addsub
  patch because it changed a lot]
  + I kept macros for other ops, because I think the subsequent
    code duplication savings are worth the pain.

- Add #define's to select whether to use fpclassify etc. or
  float32_is_zero etc.
  + Benchmark perf differences on x86_64, aarch64 and IBM Power8 hosts.
  + For 32-bit we don't use fpclassify etc. for any architectures,
    so I was tempted to get rid of this option to save some code.
    It's possible however that on some hosts I have not tested this option
    might pay off, so I decided to keep it there.

- Add a #define to select whether to use isinf() or floatX_is_infinity().
  Turns out this makes a big difference for power64.

- Remove float32_to_float64 support in hardfloat, since nbench or
  SPEC actually showed a small yet measurable slowdown with it,
  despite fp-bench showing a significant speedup for this operation.

- Do not flatten soft-fp functions; these are now slow paths.
  This shrinks the size of the softfloat object below its original
  size (see last patch's log).

- Add a #define to disable hardfloat for some targets. I noticed that
  some targets (at least I noticed PPC, there might be others) do
  clear the FP flags before calling softfloat. This precludes hardfloat
  since it relies on inexact not being set. In the long run we should
  fix these targets though.

Note: fp-bench can run _very_ slowly (~0.5 IPC) for -o fma on some x86_64
hosts. I have not pinned down what's going on, but from the few hosts
I have access to, it seems that machines that have been patched for
Spectre/Meltdown are susceptible to this slowdown.
Fortunately though:
1) when fma is run in QEMU (and not under a microbenchmark such as
   fp-bench), fma performance is still very good (much better than with
   soft-fp).
2) Compiling with -march=native gets rid of the problem.
I've reproduced this with both gcc 5.4.0 and gcc 7.1.0. The *very* same
fp-bench binary that performs very well for FMA on two machines (one
AMD, one Intel, neither patched against Meltdown/Spectre) performs
below soft-fp on another three machines (all Intel, all patched).

Note: there are some checkpatch errors, but they are false positives.

Perf numbers for fp-bench are in each commit log; numbers for several
benchmarks are in the last patch's commit log.

You can fetch this series from:
  https://github.com/cota/qemu/tree/hardfloat-v3

Thanks,

		Emilio

---
 configure                   |    2 +
 fpu/softfloat.c             |  945 ++++++++++++++++++++++++++++++--
 include/fpu/softfloat.h     |   30 +
 target/tricore/fpu_helper.c |    9 +-
 tests/Makefile.include      |    3 +
 tests/fp/.gitignore         |    4 +
 tests/fp/Makefile           |   36 ++
 tests/fp/fp-bench.c         |  528 ++++++++++++++++++
 tests/fp/fp-test.c          | 1183 ++++++++++++++++++++++++++++++++++++++++
 tests/fp/muladd.fptest      |   51 ++
 10 files changed, 2737 insertions(+), 54 deletions(-)
 create mode 100644 tests/fp/.gitignore
 create mode 100644 tests/fp/Makefile
 create mode 100644 tests/fp/fp-bench.c
 create mode 100644 tests/fp/fp-test.c
 create mode 100644 tests/fp/muladd.fptest
