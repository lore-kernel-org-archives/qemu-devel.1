Received: from eggs.gnu.org ([2001:4830:134:3::10]:59335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g0ZLq-0008GB-6m
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g0ZLb-0008Rr-56
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:40:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43133)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g0ZLR-0007yN-W9
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:40:17 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 13 Sep 2018 17:39:07 -0400
Message-Id: <20180913213910.28189-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 0/3] softfloat tests based on berkeley's
 testfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>

v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg00927.html

Changes:

- Add a patch to remove an unused FP primitive (patch 1). This patch can be
  applied before patches 2 and 3. The gcov numbers quoted in patch 3
  assume that patch 1 has been applied.

- Rewrite fp-test.c from scratch, instead of trying to preserve most of
  the original testsoftfloat.c.

- Test all operations by default. A subset of ops can be chosen as well.

- Test rounding=even (-r even) by default. All rounding modes
  can be tested with `-r all'.

- Fix endianess issues. Turns out I was not including config-host.h
  when compiling softfloat/testfloat. The tests now give the same results
  on both little and big-endian hosts.

- Update git submodules to point to my github tree. This is a temporary
  fix; we're working on having the trees hosted on qemu.org.

- Support setting the initial FP flags for each test. This will allow
  us to test hardfloat, since it only kicks in when "inexact" is set.

Checkpatch reports some errors, but they're false positives.

You can fetch this series from:
  https://github.com/cota/qemu/tree/fp-test-v3

The tests show that we probably have bugs in at least:

- f16_mulAdd, f32_mulAdd, f64_mulAdd

- extF80_lt_quiet, extF80_rem, extF80_roundToInt, extF80_to_f128,
  extF80_to_f32, extF80_to_f64

- f128_to_extF80, f128_to_f32, f128_to_f64, f32_to_extF80, f32_to_f128,
  f64_to_extF80, f64_to_f128, i32_to_extF80, i64_to_extF80

- f64_div

A sample of these errors are appended.
I do not have time to look into these, but I hope someone else does.

Once the muladd and div bugs are fixed, I'll resubmit the hardfloat
patches (they do not affect conversions).

Thanks,

		Emilio
---
$ ./fp-test -e 1 2>&1 | grep -A2 'Errors found'
Errors found in i32_to_extF80:
E801FFFF
        => -401B.BFF0000800000000 .....  expected -401B.BFF0000000000000 ....x
--
Errors found in i64_to_extF80:
03FFFFFFFC001000
        => +4038.FFFFFFFF00040000 .....  expected +4039.8000000000000000 ....x
--
Errors found in f16_mulAdd, rounding near_even, tininess before rounding:
+00.000  +1F.000  +1F.203  => +1F.203 .....  expected -1F.3FF v....
31754 tests performed; 1 error found.
--
Errors found in f16_mulAdd, rounding near_even, tininess after rounding:
+00.000  +1F.000  +1F.3FF  => +1F.3FF .....  expected -1F.3FF v....
32067 tests performed; 1 error found.
--
Errors found in f32_to_extF80:
+FF.000001
        => +7FFF.8000010000000000 v....  expected -7FFF.FFFFFFFFFFFFFFFF v....
--
Errors found in f32_to_f128:
+FF.000001  => +7FFF.0000020000000000000000000000 v....
        expected -7FFF.FFFFFFFFFFFFFFFFFFFFFFFFFFFF v....
--
Errors found in f32_mulAdd, rounding near_even, tininess before rounding:
+00.000000  +FF.000000  +FF.5F7FFF
        => +FF.5F7FFF .....  expected -FF.7FFFFF v....
--
Errors found in f32_mulAdd, rounding near_even, tininess after rounding:
+00.000000  +FF.000000  -FF.6C4D58
        => -FF.6C4D58 .....  expected -FF.7FFFFF v....
--
Errors found in f64_to_extF80:
-3FE.00FF7FFFFFFFF
        => -3FFE.807FBFFFFFFFF800 .....  expected -3FFE.807FC00000000000 ....x
--
Errors found in f64_to_f128:
-7FF.0100000000000  => -7FFF.0100000000000000000000000000 v....
        expected -7FFF.FFFFFFFFFFFFFFFFFFFFFFFFFFFF v....
--
Errors found in f64_mulAdd, rounding near_even, tininess before rounding:
+000.0000000000000  +7FF.0000000000000  +7FF.BF24ED0677699
        => +7FF.BF24ED0677699 .....  expected -7FF.FFFFFFFFFFFFF v....
--
Errors found in f64_mulAdd, rounding near_even, tininess after rounding:
+000.0000000000000  +7FF.0000000000000  +7FF.FFC0007FFFFFF
        => +7FF.FFC0007FFFFFF .....  expected -7FF.FFFFFFFFFFFFF v....
--
Errors found in f64_div, rounding near_even:
-001.FFFFFFEFF7FFF  -3FD.0000007FFDFFF
        => +003.FFFFFEEFFC00A ....x  expected +003.FFFFFEEFFC009 ....x
--
Errors found in extF80_to_f32, rounding near_even, tininess before rounding:
-7FFF.80401FFFFFFFFFFF  => -FF.00401F v....  expected -FF.7FFFFF v....
139 tests performed; 1 error found.
--
Errors found in extF80_to_f32, rounding near_even, tininess after rounding:
+7FFF.8000800000FFFFFF  => +FF.000080 v....  expected -FF.7FFFFF v....
71 tests performed; 1 error found.
--
Errors found in extF80_to_f64, rounding near_even, tininess before rounding:
+7FFF.930086F7F7267DA4
        => +7FF.26010DEFEE4CF v....  expected -7FF.FFFFFFFFFFFFF v....
--
Errors found in extF80_to_f64, rounding near_even, tininess after rounding:
+7FFF.800000FFFFFFF7FE
        => +7FF.000001FFFFFFE v....  expected -7FF.FFFFFFFFFFFFF v....
--
Errors found in extF80_to_f128:
+7FFF.8000000000000001  => +7FFF.0000000000000002000000000000 v....
        expected -7FFF.FFFFFFFFFFFFFFFFFFFFFFFFFFFF v....
--
Errors found in extF80_roundToInt, rounding near_even, exact:
+41CE.FFFFFFF000080000
        => +41CE.FFFFFFF000080000 .....  expected +41CF.8000000000000000 ....x
--
Errors found in extF80_rem:
+400B.8699A4DE2E7CE377  -403F.80000000001F0000
        => +400B.8699A4DE2E7CE377 .....  expected +400B.8699A50000000000 ....x
--
Errors found in extF80_lt_quiet:
+0000.0000000000000000  +0000.0000000000000000  => 1 .....  expected 0 .....
6 tests performed; 1 error found.
--
Errors found in f128_to_f32, rounding near_even, tininess before rounding:
+7FFF.130D47134E0139488DB1C13ECDAA
        => +FF.0986A3 v....  expected -FF.7FFFFF v....
--
Errors found in f128_to_f32, rounding near_even, tininess after rounding:
-7FFF.03FFFFFFFFFFFFFFFFFFFFFC0000
        => -FF.01FFFF v....  expected -FF.7FFFFF v....
--
Errors found in f128_to_f64, rounding near_even, tininess before rounding:
-7FFF.6312E1534A40638DAB5A8EDC5B64
        => -7FF.6312E1534A406 v....  expected -7FF.FFFFFFFFFFFFF v....
--
Errors found in f128_to_f64, rounding near_even, tininess after rounding:
-7FFF.000000000FFFFFFFFFFF80000000
        => -7FF.000000000FFFF v....  expected -7FF.FFFFFFFFFFFFF v....
--
Errors found in f128_to_extF80, rounding near_even, tininess before rounding:
-4000.00000000000000FFFEFFFFFFFFFF
        => -4000.8000000000000080 ....x  expected -4000.8000000000000000 ....x
--
Errors found in f128_to_extF80, rounding near_even, tininess after rounding:
+4003.38A57DBF7023D11088F01AE93540
        => +4003.9C52BEDFB811E888 ....x  expected +4003.9C52BF0000000000 ....x
