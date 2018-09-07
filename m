Received: from eggs.gnu.org ([2001:4830:134:3::10]:39135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyOun-0003sq-3V
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fyOui-0005Qq-EG
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:07:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fyOui-0005P5-2W
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 18:07:40 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  7 Sep 2018 18:07:29 -0400
Message-Id: <20180907220731.19368-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/2] softfloat tests based on berkeley's
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

Alex was not too pleased with my previous fp-test incarnation;
it only tested some 32 and 64 primitives, and it relied on test
files by IBM that had no particular license (so we could not
redistribute them, and IBM might pull them off the web any time).

This attempt leverages berkeley's softfloat and testfloat, which
are BSD-licensed and therefore we can pull in as submodules.

Not everything that berkeley's softfloat does is implemented in
QEMU (and vice versa), but the coverage of our implementation with
this test is quite high.

Regarding regressions, it shows at least one regression since
the recent FP refactor, e.g. with -all2 -errors 1:

Testing f64_div, rounding near_even.
46464 tests total.
Errors found in f64_div, rounding near_even:
+7FE.FFFFFFEFFBFFE  +480.0000007FFEFFE
        => +77D.FFFFFEEFFE00B ....x  expected +77D.FFFFFEEFFE00A ....x
15469 tests performed; 1 error found.

If I bring back the code before cf07323d49 ("fpu/softfloat:
re-factor div", 2018-02-21), that error goes away.

Many errors are reported for both 80-bit and 128-bit implementations.
I don't know whether those have always been there or not,
or perhaps I'm doing something wrong when converting
80-bit and 128-bit floats between our implementation and
softfloat.

I'm appending to this message the output of two runs (-all1 and -all2);
-errors 1 means "stop testing this particular op when 1 error is found".

You can pull this tree from:
  https://github.com/cota/qemu/tree/fp-test
Bear in mind that you'll need to initialize the submodules.

BTW checkpatch points to some errors, but they're false positives.

Thanks,

		Emilio

---

$ ./fp-test -all1 -errors 1
Testing ui32_to_f16, rounding near_even.

372 tests total.

372 tests performed.
In 372 tests, no errors found in ui32_to_f16, rounding near_even.
Testing ui32_to_f32, rounding near_even.

372 tests total.

372 tests performed.
In 372 tests, no errors found in ui32_to_f32, rounding near_even.
Testing ui32_to_f64.

372 tests total.

372 tests performed.
In 372 tests, no errors found in ui32_to_f64.
Testing ui32_to_extF80.
Testing ui32_to_f128.
Testing ui64_to_f16, rounding near_even.

756 tests total.

756 tests performed.
In 756 tests, no errors found in ui64_to_f16, rounding near_even.
Testing ui64_to_f32, rounding near_even.

756 tests total.

756 tests performed.
In 756 tests, no errors found in ui64_to_f32, rounding near_even.
Testing ui64_to_f64, rounding near_even.

756 tests total.

756 tests performed.
In 756 tests, no errors found in ui64_to_f64, rounding near_even.
Testing ui64_to_extF80.
Testing ui64_to_f128.

756 tests total.

Errors found in ui64_to_f128:
F8003FFFFFFFDFFE  => -3FFC.000000000000403EF0007FFFFFFF .....
	expected +403E.F0007FFFFFFFBFFC000000000000 .....

1 tests performed; 1 error found.
Testing i32_to_f16, rounding near_even.

372 tests total.

372 tests performed.
In 372 tests, no errors found in i32_to_f16, rounding near_even.
Testing i32_to_f32, rounding near_even.

372 tests total.

372 tests performed.
In 372 tests, no errors found in i32_to_f32, rounding near_even.
Testing i32_to_f64.

372 tests total.

372 tests performed.
In 372 tests, no errors found in i32_to_f64.
Testing i32_to_extF80.

372 tests total.

Errors found in i32_to_extF80:
0100001E
	=> +0000.0000000000004017 .....  expected +4017.80000F0000000000 .....

1 tests performed; 1 error found.
Testing i32_to_f128.

372 tests total.

Errors found in i32_to_f128:
3EFFDFFE  => +0000.000000000000401CF7FEFFF00000 .....
	expected +401C.F7FEFFF000000000000000000000 .....

1 tests performed; 1 error found.
Testing i64_to_f16, rounding near_even.

756 tests total.

756 tests performed.
In 756 tests, no errors found in i64_to_f16, rounding near_even.
Testing i64_to_f32, rounding near_even.

756 tests total.

756 tests performed.
In 756 tests, no errors found in i64_to_f32, rounding near_even.
Testing i64_to_f64, rounding near_even.

756 tests total.

756 tests performed.
In 756 tests, no errors found in i64_to_f64, rounding near_even.
Testing i64_to_extF80.

756 tests total.

Errors found in i64_to_extF80:
0000000800001FFE
	=> +0000.0000000000004022 .....  expected +4022.800001FFE0000000 .....

1 tests performed; 1 error found.
Testing i64_to_f128.

756 tests total.

Errors found in i64_to_f128:
FF7FFFFFFF0001FE  => +0400.000000000000C03600000001FFFC .....
	expected -4036.00000001FFFC0400000000000000 .....

1 tests performed; 1 error found.
Testing f16_to_ui32, rounding near_even, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui32, rounding near_even, exact.
Testing f16_to_ui32, rounding minMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui32, rounding minMag, exact.
Testing f16_to_ui32, rounding min, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui32, rounding min, exact.
Testing f16_to_ui32, rounding max, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui32, rounding max, exact.
Testing f16_to_ui32, rounding near_maxMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui32, rounding near_maxMag, exact.
Testing f16_to_ui64, rounding near_even, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui64, rounding near_even, exact.
Testing f16_to_ui64, rounding minMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui64, rounding minMag, exact.
Testing f16_to_ui64, rounding min, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui64, rounding min, exact.
Testing f16_to_ui64, rounding max, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui64, rounding max, exact.
Testing f16_to_ui64, rounding near_maxMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_ui64, rounding near_maxMag, exact.
Testing f16_to_i32, rounding near_even, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i32, rounding near_even, exact.
Testing f16_to_i32, rounding minMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i32, rounding minMag, exact.
Testing f16_to_i32, rounding min, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i32, rounding min, exact.
Testing f16_to_i32, rounding max, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i32, rounding max, exact.
Testing f16_to_i32, rounding near_maxMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i32, rounding near_maxMag, exact.
Testing f16_to_i64, rounding near_even, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i64, rounding near_even, exact.
Testing f16_to_i64, rounding minMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i64, rounding minMag, exact.
Testing f16_to_i64, rounding min, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i64, rounding min, exact.
Testing f16_to_i64, rounding max, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i64, rounding max, exact.
Testing f16_to_i64, rounding near_maxMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_i64, rounding near_maxMag, exact.
Testing f16_to_ui32_r_minMag, exact.
Testing f16_to_ui64_r_minMag, exact.
Testing f16_to_i32_r_minMag, exact.
Testing f16_to_i64_r_minMag, exact.
Testing f16_to_f32.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_f32.
Testing f16_to_f64.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_to_f64.
Testing f16_to_extF80.
Testing f16_to_f128.
Testing f16_roundToInt, rounding near_even, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_roundToInt, rounding near_even, exact.
Testing f16_roundToInt, rounding minMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_roundToInt, rounding minMag, exact.
Testing f16_roundToInt, rounding min, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_roundToInt, rounding min, exact.
Testing f16_roundToInt, rounding max, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_roundToInt, rounding max, exact.
Testing f16_roundToInt, rounding near_maxMag, exact.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_roundToInt, rounding near_maxMag, exact.
Testing f16_sqrt, rounding near_even.

408 tests total.

408 tests performed.
In 408 tests, no errors found in f16_sqrt, rounding near_even.
Testing f32_to_ui32, rounding near_even, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui32, rounding near_even, exact.
Testing f32_to_ui32, rounding minMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui32, rounding minMag, exact.
Testing f32_to_ui32, rounding min, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui32, rounding min, exact.
Testing f32_to_ui32, rounding max, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui32, rounding max, exact.
Testing f32_to_ui32, rounding near_maxMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui32, rounding near_maxMag, exact.
Testing f32_to_ui64, rounding near_even, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui64, rounding near_even, exact.
Testing f32_to_ui64, rounding minMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui64, rounding minMag, exact.
Testing f32_to_ui64, rounding min, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui64, rounding min, exact.
Testing f32_to_ui64, rounding max, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui64, rounding max, exact.
Testing f32_to_ui64, rounding near_maxMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_ui64, rounding near_maxMag, exact.
Testing f32_to_i32, rounding near_even, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i32, rounding near_even, exact.
Testing f32_to_i32, rounding minMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i32, rounding minMag, exact.
Testing f32_to_i32, rounding min, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i32, rounding min, exact.
Testing f32_to_i32, rounding max, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i32, rounding max, exact.
Testing f32_to_i32, rounding near_maxMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i32, rounding near_maxMag, exact.
Testing f32_to_i64, rounding near_even, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i64, rounding near_even, exact.
Testing f32_to_i64, rounding minMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i64, rounding minMag, exact.
Testing f32_to_i64, rounding min, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i64, rounding min, exact.
Testing f32_to_i64, rounding max, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i64, rounding max, exact.
Testing f32_to_i64, rounding near_maxMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_i64, rounding near_maxMag, exact.
Testing f32_to_ui32_r_minMag, exact.
Testing f32_to_ui64_r_minMag, exact.
Testing f32_to_i32_r_minMag, exact.
Testing f32_to_i64_r_minMag, exact.
Testing f32_to_f16, rounding near_even, tininess before rounding.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_f16, rounding near_even, tininess before rounding.
Testing f32_to_f16, rounding near_even, tininess after rounding.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_f16, rounding near_even, tininess after rounding.
Testing f32_to_f64.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_to_f64.
Testing f32_to_extF80.

600 tests total.

Errors found in f32_to_extF80:
-9F.7FFEEF
	=> +0000.000000000000C01F .....  expected -401F.FFFEEF0000000000 .....

1 tests performed; 1 error found.
Testing f32_to_f128.

600 tests total.

Errors found in f32_to_f128:
+7D.041FFF  => +0000.0000000000003FFD083FFE000000 .....
	expected +3FFD.083FFE0000000000000000000000 .....

1 tests performed; 1 error found.
Testing f32_roundToInt, rounding near_even, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_roundToInt, rounding near_even, exact.
Testing f32_roundToInt, rounding minMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_roundToInt, rounding minMag, exact.
Testing f32_roundToInt, rounding min, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_roundToInt, rounding min, exact.
Testing f32_roundToInt, rounding max, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_roundToInt, rounding max, exact.
Testing f32_roundToInt, rounding near_maxMag, exact.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_roundToInt, rounding near_maxMag, exact.
Testing f32_sqrt, rounding near_even.

600 tests total.

600 tests performed.
In 600 tests, no errors found in f32_sqrt, rounding near_even.
Testing f64_to_ui32, rounding near_even, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui32, rounding near_even, exact.
Testing f64_to_ui32, rounding minMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui32, rounding minMag, exact.
Testing f64_to_ui32, rounding min, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui32, rounding min, exact.
Testing f64_to_ui32, rounding max, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui32, rounding max, exact.
Testing f64_to_ui32, rounding near_maxMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui32, rounding near_maxMag, exact.
Testing f64_to_ui64, rounding near_even, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui64, rounding near_even, exact.
Testing f64_to_ui64, rounding minMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui64, rounding minMag, exact.
Testing f64_to_ui64, rounding min, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui64, rounding min, exact.
Testing f64_to_ui64, rounding max, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui64, rounding max, exact.
Testing f64_to_ui64, rounding near_maxMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_ui64, rounding near_maxMag, exact.
Testing f64_to_i32, rounding near_even, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i32, rounding near_even, exact.
Testing f64_to_i32, rounding minMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i32, rounding minMag, exact.
Testing f64_to_i32, rounding min, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i32, rounding min, exact.
Testing f64_to_i32, rounding max, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i32, rounding max, exact.
Testing f64_to_i32, rounding near_maxMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i32, rounding near_maxMag, exact.
Testing f64_to_i64, rounding near_even, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i64, rounding near_even, exact.
Testing f64_to_i64, rounding minMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i64, rounding minMag, exact.
Testing f64_to_i64, rounding min, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i64, rounding min, exact.
Testing f64_to_i64, rounding max, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i64, rounding max, exact.
Testing f64_to_i64, rounding near_maxMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_i64, rounding near_maxMag, exact.
Testing f64_to_ui32_r_minMag, exact.
Testing f64_to_ui64_r_minMag, exact.
Testing f64_to_i32_r_minMag, exact.
Testing f64_to_i64_r_minMag, exact.
Testing f64_to_f16, rounding near_even, tininess before rounding.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_f16, rounding near_even, tininess before rounding.
Testing f64_to_f16, rounding near_even, tininess after rounding.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_f16, rounding near_even, tininess after rounding.
Testing f64_to_f32, rounding near_even, tininess before rounding.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_f32, rounding near_even, tininess before rounding.
Testing f64_to_f32, rounding near_even, tininess after rounding.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_to_f32, rounding near_even, tininess after rounding.
Testing f64_to_extF80.

768 tests total.

Errors found in f64_to_extF80:
-388.FFFFFFFFFEFBF
	=> -7800.000000000000BF88 .....  expected -3F88.FFFFFFFFFF7DF800 .....

1 tests performed; 1 error found.
Testing f64_to_f128.

768 tests total.

Errors found in f64_to_f128:
+3E2.00001FBFFFFFF  => -7000.0000000000003FE200001FBFFFFF .....
	expected +3FE2.00001FBFFFFFF000000000000000 .....

1 tests performed; 1 error found.
Testing f64_roundToInt, rounding near_even, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_roundToInt, rounding near_even, exact.
Testing f64_roundToInt, rounding minMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_roundToInt, rounding minMag, exact.
Testing f64_roundToInt, rounding min, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_roundToInt, rounding min, exact.
Testing f64_roundToInt, rounding max, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_roundToInt, rounding max, exact.
Testing f64_roundToInt, rounding near_maxMag, exact.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_roundToInt, rounding near_maxMag, exact.
Testing f64_sqrt, rounding near_even.

768 tests total.

768 tests performed.
In 768 tests, no errors found in f64_sqrt, rounding near_even.
Testing extF80_to_ui32, rounding near_even, exact.
Testing extF80_to_ui32, rounding minMag, exact.
Testing extF80_to_ui32, rounding min, exact.
Testing extF80_to_ui32, rounding max, exact.
Testing extF80_to_ui32, rounding near_maxMag, exact.
Testing extF80_to_ui64, rounding near_even, exact.
Testing extF80_to_ui64, rounding minMag, exact.
Testing extF80_to_ui64, rounding min, exact.
Testing extF80_to_ui64, rounding max, exact.
Testing extF80_to_ui64, rounding near_maxMag, exact.
Testing extF80_to_i32, rounding near_even, exact.

912 tests total.

Errors found in extF80_to_i32, rounding near_even, exact:
-0001.FFDDFFFFFFFFFFFF  => 80000000 v....  expected 00000000 ....x

1 tests performed; 1 error found.
Testing extF80_to_i32, rounding minMag, exact.

912 tests total.

Errors found in extF80_to_i32, rounding minMag, exact:
+4010.FFFFC00100000000  => 00000000 ....x  expected 0003FFFF ....x

4 tests performed; 1 error found.
Testing extF80_to_i32, rounding min, exact.

912 tests total.

Errors found in extF80_to_i32, rounding min, exact:
-4001.FEFFFFFFFFFFFBFF  => 80000000 v....  expected FFFFFFF8 ....x

2 tests performed; 1 error found.
Testing extF80_to_i32, rounding max, exact.

912 tests total.

Errors found in extF80_to_i32, rounding max, exact:
-3FFF.FFFFFF0000080000  => 00000001 ....x  expected FFFFFFFF ....x

1 tests performed; 1 error found.
Testing extF80_to_i32, rounding near_maxMag, exact.

912 tests total.

Errors found in extF80_to_i32, rounding near_maxMag, exact:
-38C2.8000020000000080  => 80000000 v....  expected 00000000 ....x

2 tests performed; 1 error found.
Testing extF80_to_i64, rounding near_even, exact.

912 tests total.

Errors found in extF80_to_i64, rounding near_even, exact:
-2969.FFFFFEFFFBFFFFFE
	=> 8000000000000000 v....  expected 0000000000000000 ....x

1 tests performed; 1 error found.
Testing extF80_to_i64, rounding minMag, exact.

912 tests total.

Errors found in extF80_to_i64, rounding minMag, exact:
+4005.803FFFFFFF7FFFFF
	=> 8000000000000000 v....  expected 0000000000000040 ....x

1 tests performed; 1 error found.
Testing extF80_to_i64, rounding min, exact.

912 tests total.

Errors found in extF80_to_i64, rounding min, exact:
-0603.FFFFFFFF9FFFFFFF
	=> 8000000000000000 v....  expected FFFFFFFFFFFFFFFF ....x

1 tests performed; 1 error found.
Testing extF80_to_i64, rounding max, exact.

912 tests total.

Errors found in extF80_to_i64, rounding max, exact:
-4080.8007800000000000
	=> 0000000000000001 ....x  expected 8000000000000000 v....

2 tests performed; 1 error found.
Testing extF80_to_i64, rounding near_maxMag, exact.

912 tests total.

Errors found in extF80_to_i64, rounding near_maxMag, exact:
-4016.8DC95F52FED40FC8
	=> 8000000000000000 v....  expected FFFFFFFFFF7236A1 ....x

4 tests performed; 1 error found.
Testing extF80_to_ui32_r_minMag, exact.
Testing extF80_to_ui64_r_minMag, exact.
Testing extF80_to_i32_r_minMag, exact.
Testing extF80_to_i64_r_minMag, exact.
Testing extF80_to_f16, rounding near_even, tininess before rounding.
Testing extF80_to_f16, rounding near_even, tininess after rounding.
Testing extF80_to_f32, rounding near_even, tininess before rounding.

912 tests total.

Errors found in extF80_to_f32, rounding near_even, tininess before rounding:
+4002.80200007FFFFFFFE  => +FF.400000 v....  expected +82.002000 ....x

1 tests performed; 1 error found.
Testing extF80_to_f32, rounding near_even, tininess after rounding.

912 tests total.

Errors found in extF80_to_f32, rounding near_even, tininess after rounding:
+4005.FFFFFFE0001FFFFF  => +FF.400000 v....  expected +86.000000 ....x

1 tests performed; 1 error found.
Testing extF80_to_f64, rounding near_even, tininess before rounding.

912 tests total.

Errors found in extF80_to_f64, rounding near_even, tininess before rounding:
+3C01.FFFDFFFF80000000
	=> +000.0000000000000 ...ux  expected +001.FFFBFFFF00000 .....

1 tests performed; 1 error found.
Testing extF80_to_f64, rounding near_even, tininess after rounding.

912 tests total.

Errors found in extF80_to_f64, rounding near_even, tininess after rounding:
+4002.FFFFFFFFFFFF0008
	=> +7FF.8000000000000 v....  expected +402.FFFFFFFFFFFE0 ....x

1 tests performed; 1 error found.
Testing extF80_to_f128.

912 tests total.

Errors found in extF80_to_f128:
+7ABE.80000FFFFFFFFFF7  => +0000.0000000000007FFF800000000000 v....
	expected +7ABE.00001FFFFFFFFFEE000000000000 .....

1 tests performed; 1 error found.
Testing extF80_roundToInt, rounding near_even, exact.

912 tests total.

Errors found in extF80_roundToInt, rounding near_even, exact:
-3D85.FFDFFFFFFFFFBFFE
	=> +0000.000000000000FFFF v....  expected -0000.0000000000000000 ....x

1 tests performed; 1 error found.
Testing extF80_roundToInt, rounding minMag, exact.

912 tests total.

Errors found in extF80_roundToInt, rounding minMag, exact:
-401C.FFFFF9FFFFFFFFFE
	=> +0000.000000000000FFFF v....  expected -401C.FFFFF9FC00000000 ....x

1 tests performed; 1 error found.
Testing extF80_roundToInt, rounding min, exact.

912 tests total.

Errors found in extF80_roundToInt, rounding min, exact:
+3F81.FFFFFFFFFDDFFFFE
	=> +0000.000000000000FFFF v....  expected +0000.0000000000000000 ....x

1 tests performed; 1 error found.
Testing extF80_roundToInt, rounding max, exact.

912 tests total.

Errors found in extF80_roundToInt, rounding max, exact:
-349C.FFFFFFFDFFFFFFFC
	=> +0000.000000000000FFFF v....  expected -0000.0000000000000000 ....x

1 tests performed; 1 error found.
Testing extF80_roundToInt, rounding near_maxMag, exact.

912 tests total.

Errors found in extF80_roundToInt, rounding near_maxMag, exact:
+403A.FFFFFFFEFFFFFDFE
	=> +0000.000000000000FFFF v....  expected +403A.FFFFFFFEFFFFFE00 ....x

1 tests performed; 1 error found.
Testing extF80_sqrt, precision 32, rounding near_even.

912 tests total.

Errors found in extF80_sqrt, precision 32, rounding near_even:
+3FFB.800FFE0000000000
	=> +0000.0000000000001FE7 ....x  expected +3FFD.8007FF0000000000 ....x

1 tests performed; 1 error found.
Testing extF80_sqrt, precision 64, rounding near_even.

912 tests total.

Errors found in extF80_sqrt, precision 64, rounding near_even:
-4AF3.E48BE55C338B96E5
	=> +0000.000000000000FFFF v....  expected -7FFF.FFFFFFFFFFFFFFFF v....

1 tests performed; 1 error found.
Testing extF80_sqrt, precision 80, rounding near_even.

912 tests total.

Errors found in extF80_sqrt, precision 80, rounding near_even:
+4003.8000000003FFFFFD
	=> +0000.000000000000FFFF v....  expected +4001.8000000001FFFFFE ....x

1 tests performed; 1 error found.
Testing f128_to_ui32, rounding near_even, exact.
Testing f128_to_ui32, rounding minMag, exact.
Testing f128_to_ui32, rounding min, exact.
Testing f128_to_ui32, rounding max, exact.
Testing f128_to_ui32, rounding near_maxMag, exact.
Testing f128_to_ui64, rounding near_even, exact.

936 tests total.

Errors found in f128_to_ui64, rounding near_even, exact:
+4080.00000000000080000000000007FF
	=> 0000000000000000 ....x  expected FFFFFFFFFFFFFFFF v....

1 tests performed; 1 error found.
Testing f128_to_ui64, rounding minMag, exact.

936 tests total.

Errors found in f128_to_ui64, rounding minMag, exact:
-3FEC.FFFFFFFFFFFFFFFFFF80000001FF
	=> FFFFFFFFFFFFFFFF v....  expected 0000000000000000 ....x

2 tests performed; 1 error found.
Testing f128_to_ui64, rounding min, exact.

936 tests total.

Errors found in f128_to_ui64, rounding min, exact:
-7FFE.0400000000000040000000000000
	=> 0000000000000000 ....x  expected 0000000000000000 v....

5 tests performed; 1 error found.
Testing f128_to_ui64, rounding max, exact.

936 tests total.

Errors found in f128_to_ui64, rounding max, exact:
-4070.0000000004000000080000000000
	=> 0000000000000001 ....x  expected 0000000000000000 v....

4 tests performed; 1 error found.
Testing f128_to_ui64, rounding near_maxMag, exact.

936 tests total.

Errors found in f128_to_ui64, rounding near_maxMag, exact:
-27B3.1C5ACEDF8F927769DC95EF2810A5
	=> FFFFFFFFFFFFFFFF v....  expected 0000000000000000 ....x

1 tests performed; 1 error found.
Testing f128_to_i32, rounding near_even, exact.

936 tests total.

Errors found in f128_to_i32, rounding near_even, exact:
+408A.00000000020001FFFFFFFFFFFFFF  => 00000000 ....x  expected 7FFFFFFF v....

1 tests performed; 1 error found.
Testing f128_to_i32, rounding minMag, exact.

936 tests total.

Errors found in f128_to_i32, rounding minMag, exact:
+3FFF.0000000000001FFFFFFFF7FFFFFF  => 00000000 ....x  expected 00000001 ....x

1 tests performed; 1 error found.
Testing f128_to_i32, rounding min, exact.

936 tests total.

Errors found in f128_to_i32, rounding min, exact:
+3EFF.1FFFFFFFFFFFFFFFFFFFFFFFFFFE  => 7FFFFFFF v....  expected 00000000 ....x

1 tests performed; 1 error found.
Testing f128_to_i32, rounding max, exact.

936 tests total.

Errors found in f128_to_i32, rounding max, exact:
+3F38.003FFFFFFFFFFFFFFEFFFFFFFFFE  => 7FFFFFFF v....  expected 00000001 ....x

2 tests performed; 1 error found.
Testing f128_to_i32, rounding near_maxMag, exact.

936 tests total.

Errors found in f128_to_i32, rounding near_maxMag, exact:
+3FFE.DBDDEB45B111767526204FC55847  => 7FFFFFFF v....  expected 00000001 ....x

1 tests performed; 1 error found.
Testing f128_to_i64, rounding near_even, exact.

936 tests total.

Errors found in f128_to_i64, rounding near_even, exact:
+3F81.7FFFFFFFFDFFFFFFFFFFFFFFFFFE
	=> 7FFFFFFFFFFFFFFF v....  expected 0000000000000000 ....x

2 tests performed; 1 error found.
Testing f128_to_i64, rounding minMag, exact.

936 tests total.

Errors found in f128_to_i64, rounding minMag, exact:
+3FFC.FFFFFFFFFFFFBFFFBFFFFFFFFFFF
	=> FFFFFFFFFFFFFFFF ....x  expected 0000000000000000 ....x

1 tests performed; 1 error found.
Testing f128_to_i64, rounding min, exact.

936 tests total.

Errors found in f128_to_i64, rounding min, exact:
-4CBA.000000000000008007FFFFFFFFFE
	=> 0000000000000000 ....x  expected 8000000000000000 v....

2 tests performed; 1 error found.
Testing f128_to_i64, rounding max, exact.

936 tests total.

Errors found in f128_to_i64, rounding max, exact:
-3B9B.DD44B67959B70B5E2279FE1E3B8D
	=> 0000000000000001 ....x  expected 0000000000000000 ....x

2 tests performed; 1 error found.
Testing f128_to_i64, rounding near_maxMag, exact.

936 tests total.

Errors found in f128_to_i64, rounding near_maxMag, exact:
-3FFB.0000080001FFFFFFFFFFFFFFFFFF
	=> 7FFFFFFFFFFFFFFF v....  expected 0000000000000000 ....x

2 tests performed; 1 error found.
Testing f128_to_ui32_r_minMag, exact.
Testing f128_to_ui64_r_minMag, exact.
Testing f128_to_i32_r_minMag, exact.
Testing f128_to_i64_r_minMag, exact.
Testing f128_to_f16, rounding near_even, tininess before rounding.
Testing f128_to_f16, rounding near_even, tininess after rounding.
Testing f128_to_f32, rounding near_even, tininess before rounding.

936 tests total.

Errors found in f128_to_f32, rounding near_even, tininess before rounding:
-3FF2.FFFFFFFFFFFFFEFFFFF7FFFFFFFE
	=> -FF.000000 ..o.x  expected -73.000000 ....x

1 tests performed; 1 error found.
Testing f128_to_f32, rounding near_even, tininess after rounding.

936 tests total.

Errors found in f128_to_f32, rounding near_even, tininess after rounding:
+4005.000407FFFFFFFFFFFFFFFFFFFFFE
	=> -FF.7FFFFF .....  expected +85.000204 ....x

1 tests performed; 1 error found.
Testing f128_to_f64, rounding near_even, tininess before rounding.

936 tests total.

Errors found in f128_to_f64, rounding near_even, tininess before rounding:
-403D.FEFC000000000000000000000000
	=> +000.0000000000000 ...ux  expected -43D.FEFC000000000 .....

1 tests performed; 1 error found.
Testing f128_to_f64, rounding near_even, tininess after rounding.

936 tests total.

Errors found in f128_to_f64, rounding near_even, tininess after rounding:
+609B.FFFFFFFF000000000000003FFFFE
	=> +000.0000000000000 ...ux  expected +7FF.0000000000000 ..o.x

1 tests performed; 1 error found.
Testing f128_to_extF80, rounding near_even, tininess before rounding.

936 tests total.

Errors found in f128_to_extF80, rounding near_even, tininess before rounding:
-3905.E695B832466AE04C1E31C2EF6F9E
	=> +5C83.000000000000E04C ....x  expected -3905.F34ADC1923357026 ....x

1 tests performed; 1 error found.
Testing f128_to_extF80, rounding near_even, tininess after rounding.

936 tests total.

Errors found in f128_to_extF80, rounding near_even, tininess after rounding:
+3F80.FFF9FFFFFFFFFFFFFFFFFFFFFFFF
	=> -1FC0.000000000000FFFF .....  expected +3F80.FFFD000000000000 ....x

1 tests performed; 1 error found.
Testing f128_roundToInt, rounding near_even, exact.

936 tests total.

Errors found in f128_roundToInt, rounding near_even, exact:
-3F7E.000000004000000000000000007F  => +0000.0000000000000000000000000000 ....x
	expected -0000.0000000000000000000000000000 ....x

1 tests performed; 1 error found.
Testing f128_roundToInt, rounding minMag, exact.

936 tests total.

Errors found in f128_roundToInt, rounding minMag, exact:
+0002.EACBC11D122BFE5E4A2F21399EBF  => +0002.EACBC11D122BFE5E4A2F21399EBF .....
	expected +0000.0000000000000000000000000000 ....x

1 tests performed; 1 error found.
Testing f128_roundToInt, rounding min, exact.

936 tests total.

Errors found in f128_roundToInt, rounding min, exact:
+407E.4F04776B088F226593269B9C1166  => +0000.0000000000000000000000000000 ....x
	expected +407E.4F04776B088F226593269B9C1166 .....

1 tests performed; 1 error found.
Testing f128_roundToInt, rounding max, exact.

936 tests total.

Errors found in f128_roundToInt, rounding max, exact:
-3FFF.000007FFFFFFFFDFFFFFFFFFFFFF  => -3FFF.000007FFFFFFFFDFFFFFFFFFFFFF .....
	expected -3FFF.0000000000000000000000000000 ....x

1 tests performed; 1 error found.
Testing f128_roundToInt, rounding near_maxMag, exact.

936 tests total.

Errors found in f128_roundToInt, rounding near_maxMag, exact:
-403D.000000001000000000000FFFFFFF  => +0000.0000000000000000000000000000 ....x
	expected -403D.0000000010000000000000000000 ....x

1 tests performed; 1 error found.
Testing f128_sqrt, rounding near_even.

936 tests total.

Errors found in f128_sqrt, rounding near_even:
-43FE.FFFFFFC000000000000100000000  => +7FFF.ED1E30FFE73A1FF80000000061FF ....x
	expected -7FFF.FFFFFFFFFFFFFFFFFFFFFFFFFFFF v....

1 tests performed; 1 error found.


./fp-test -all2 -errors 1
Testing f16_add, rounding near_even.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_add, rounding near_even.
Testing f16_sub, rounding near_even.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_sub, rounding near_even.
Testing f16_mul, rounding near_even, tininess before rounding.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_mul, rounding near_even, tininess before rounding.
Testing f16_mul, rounding near_even, tininess after rounding.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_mul, rounding near_even, tininess after rounding.
Testing f16_div, rounding near_even.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_div, rounding near_even.
Testing f16_rem.
Testing f16_eq.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_eq.
Testing f16_le.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_le.
Testing f16_lt.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_lt.
Testing f16_eq_signaling.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_eq_signaling.
Testing f16_le_quiet.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_le_quiet.
Testing f16_lt_quiet.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f16_lt_quiet.
Testing f32_add, rounding near_even.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_add, rounding near_even.
Testing f32_sub, rounding near_even.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_sub, rounding near_even.
Testing f32_mul, rounding near_even, tininess before rounding.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_mul, rounding near_even, tininess before rounding.
Testing f32_mul, rounding near_even, tininess after rounding.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_mul, rounding near_even, tininess after rounding.
Testing f32_div, rounding near_even.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_div, rounding near_even.
Testing f32_rem.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_rem.
Testing f32_eq.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_eq.
Testing f32_le.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_le.
Testing f32_lt.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_lt.
Testing f32_eq_signaling.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_eq_signaling.
Testing f32_le_quiet.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_le_quiet.
Testing f32_lt_quiet.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f32_lt_quiet.
Testing f64_add, rounding near_even.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_add, rounding near_even.
Testing f64_sub, rounding near_even.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_sub, rounding near_even.
Testing f64_mul, rounding near_even, tininess before rounding.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_mul, rounding near_even, tininess before rounding.
Testing f64_mul, rounding near_even, tininess after rounding.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_mul, rounding near_even, tininess after rounding.
Testing f64_div, rounding near_even.

46464 tests total.

  10000
Errors found in f64_div, rounding near_even:
+7FE.FFFFFFEFFBFFE  +480.0000007FFEFFE
	=> +77D.FFFFFEEFFE00B ....x  expected +77D.FFFFFEEFFE00A ....x

15469 tests performed; 1 error found.
Testing f64_rem.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_rem.
Testing f64_eq.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_eq.
Testing f64_le.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_le.
Testing f64_lt.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_lt.
Testing f64_eq_signaling.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_eq_signaling.
Testing f64_le_quiet.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_le_quiet.
Testing f64_lt_quiet.

46464 tests total.

  10000
  20000
  30000
  40000
46464 tests performed.
In 46464 tests, no errors found in f64_lt_quiet.
Testing extF80_add, precision 32, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_add, precision 32, rounding near_even, tininess before rounding:
-4015.81000000003FFFFF  -4004.BE9D91BC33D9E829
	=> +0000.000000000000FFFF v....  expected -4015.81005F0000000000 ....x

1 tests performed; 1 error found.
Testing extF80_add, precision 32, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_add, precision 32, rounding near_even, tininess after rounding:
-4002.FFF0000000010000  +4006.FFFFF8000000007F
	=> +0000.000000000000FFFF v....  expected +4006.F000F80000000000 ....x

1 tests performed; 1 error found.
Testing extF80_add, precision 64, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_add, precision 64, rounding near_even, tininess before rounding:
-3B08.80001FFFFFFFFFFC  -4004.FFFFBFFFFFF00000
	=> +0000.000000000000FFFF v....  expected -4004.FFFFBFFFFFF00000 ....x

1 tests performed; 1 error found.
Testing extF80_add, precision 64, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_add, precision 64, rounding near_even, tininess after rounding:
+3C00.FFFFFF3FFFFFFFFE  +4001.F7FFFFFFFFFE0000
	=> +0000.000000000000FFFF v....  expected +4001.F7FFFFFFFFFE0000 ....x

1 tests performed; 1 error found.
Testing extF80_add, precision 80, rounding near_even.

46464 tests total.

Errors found in extF80_add, precision 80, rounding near_even:
-3BFF.C8F98DA74B7F0494  +3C01.92E0F8D071CC39C0
	=> +0000.000000000000FFFF v....  expected +3C00.C1452ACD3DD8F136 .....

1 tests performed; 1 error found.
Testing extF80_sub, precision 32, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_sub, precision 32, rounding near_even, tininess before rounding:
-3CE4.820000000000007F  -4003.AAF5E1DD492AD6D7
	=> +0000.000000000000FFFF v....  expected +4003.AAF5E20000000000 ....x

1 tests performed; 1 error found.
Testing extF80_sub, precision 32, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_sub, precision 32, rounding near_even, tininess after rounding:
+4000.FFFFFFC7FFFFFFFF  -41C9.CADB9ABCA8D47DE7
	=> +0000.000000000000FFFF v....  expected +41C9.CADB9B0000000000 ....x

1 tests performed; 1 error found.
Testing extF80_sub, precision 64, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_sub, precision 64, rounding near_even, tininess before rounding:
+7FFE.800040000000FFFF  -403C.FEFFFFFFFFFFFDFE
	=> +0000.000000000000FFFF v....  expected +7FFE.8000400000010000 ....x

1 tests performed; 1 error found.
Testing extF80_sub, precision 64, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_sub, precision 64, rounding near_even, tininess after rounding:
-3FFD.92BD936994658CEC  +3E1F.FFFFFFF000000FFF
	=> +0000.000000000000FFFF v....  expected -3FFD.92BD936994659000 ....x

1 tests performed; 1 error found.
Testing extF80_sub, precision 80, rounding near_even.

46464 tests total.

Errors found in extF80_sub, precision 80, rounding near_even:
-3F7F.A37BDA8A84245595  +4000.C784770517E09A7D
	=> +0000.000000000000FFFF v....  expected -4000.C784770517E09A7D ....x

1 tests performed; 1 error found.
Testing extF80_mul, precision 32, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_mul, precision 32, rounding near_even, tininess before rounding:
-4030.800000010FFFFFFE  -3F64.800000001FFFFFDF
	=> +0000.000000000000FFFF v....  expected +3F95.8000000000000000 ....x

1 tests performed; 1 error found.
Testing extF80_mul, precision 32, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_mul, precision 32, rounding near_even, tininess after rounding:
+0001.800000003DFFFFFF  +3C00.8000080000100000
	=> +0000.000000000000FFFF v....  expected +0000.0000000000000000 ...ux

1 tests performed; 1 error found.
Testing extF80_mul, precision 64, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_mul, precision 64, rounding near_even, tininess before rounding:
-3F66.F9B146142FB39AE9  -401C.C220F69785D21065
	=> +0000.000000000000FFFF v....  expected +3F84.BD587DC83219C800 ....x

1 tests performed; 1 error found.
Testing extF80_mul, precision 64, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_mul, precision 64, rounding near_even, tininess after rounding:
+3F80.8000FFFFFEFFFFFF  -4001.98D85F0D72C68624
	=> +0000.000000000000FFFF v....  expected -3F82.98D990BE2FAFB800 ....x

1 tests performed; 1 error found.
Testing extF80_mul, precision 80, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_mul, precision 80, rounding near_even, tininess before rounding:
+4000.8810000000000000  +4400.A497C976A72E00BA
	=> +0000.000000000000FFFF v....  expected +4401.AEF5D9074075C686 ....x

1 tests performed; 1 error found.
Testing extF80_mul, precision 80, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_mul, precision 80, rounding near_even, tininess after rounding:
+40BA.D7BF9337CC05FD53  +3C00.80000000000007FE
	=> +0000.000000000000FFFF v....  expected +3CBB.D7BF9337CC060ACC ....x

1 tests performed; 1 error found.
Testing extF80_div, precision 32, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_div, precision 32, rounding near_even, tininess before rounding:
+4001.E000000000000FFE  +403C.FFFFEFFFFFFFFF80
	=> +0000.000000000000FFFF v....  expected +3FC3.E0000E0000000000 ....x

1 tests performed; 1 error found.
Testing extF80_div, precision 32, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_div, precision 32, rounding near_even, tininess after rounding:
+401C.EDB32254DADC2C99  +3F75.E0B99F6AA81C34CC
	=> +0000.000000000000FFFF v....  expected +40A6.8763E20000000000 ....x

1 tests performed; 1 error found.
Testing extF80_div, precision 64, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in extF80_div, precision 64, rounding near_even, tininess before rounding:
-3E8F.FFFFFF0000080000  -0002.8000000100000001
	=> +0000.000000000000FFFF v....  expected +7E8C.FFFFFEFE00080000 ....x

1 tests performed; 1 error found.
Testing extF80_div, precision 64, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in extF80_div, precision 64, rounding near_even, tininess after rounding:
-43FE.9D44667A7000EAD3  +401F.8003FFFBFFFFFFFE
	=> +0000.000000000000FFFF v....  expected -43DE.9D3F7C8375E12000 ....x

1 tests performed; 1 error found.
Testing extF80_div, precision 80, rounding near_even.

46464 tests total.

Errors found in extF80_div, precision 80, rounding near_even:
-7FFE.8000000000000106  -403D.FFBC000000000000
	=> +0000.000000000000FFFF v....  expected +7FBF.8022090A66C34CE6 ....x

1 tests performed; 1 error found.
Testing extF80_rem.

46464 tests total.

Errors found in extF80_rem:
+7FFE.8400000000400000  -403C.8000600000000000
	=> +403E.0000000000008000 .....  expected -403A.F39D000000000000 .....

1 tests performed; 1 error found.
Testing extF80_eq.

46464 tests total.

Errors found in extF80_eq:
+39C2.FFFFFFFFFEFFFFDF  +4006.FC926A1083604304  => 0 v....  expected 0 .....

1 tests performed; 1 error found.
Testing extF80_le.

46464 tests total.

Errors found in extF80_le:
+3FC8.FFFFFFFFFFFFFFFE  +6A14.8D99437CC95C3F5E  => 0 v....  expected 1 .....

1 tests performed; 1 error found.
Testing extF80_lt.

46464 tests total.

Errors found in extF80_lt:
+444C.80001FFFFFEFFFFE  -3161.FFFFFFFFFC0FFFFE  => 0 v....  expected 0 .....

1 tests performed; 1 error found.
Testing extF80_eq_signaling.

46464 tests total.

Errors found in extF80_eq_signaling:
+38CB.FEFFFFFFFFFFBFFF  -43FF.80000000007FEFFF  => 0 v....  expected 0 .....

1 tests performed; 1 error found.
Testing extF80_le_quiet.

46464 tests total.

Errors found in extF80_le_quiet:
-3F80.81FFFFFBFFFFFFFF  +4013.80FEFFFFFFFFFFFE  => 0 v....  expected 1 .....

1 tests performed; 1 error found.
Testing extF80_lt_quiet.

46464 tests total.

Errors found in extF80_lt_quiet:
+4080.80000003FFFFFFFE  +0000.000FFFFFFFFF7FFF  => 0 v....  expected 0 .....

1 tests performed; 1 error found.
Testing f128_add, rounding near_even.

46464 tests total.

Errors found in f128_add, rounding near_even:
+4003.3D7CA128D17828B3E96B11240AAF  -49E0.FFFFFFFFFFFFFFFFFFFEFFFFF7FF
	=> -49E0.FFFFFFFFFFFFFFFFFFFEFFFFF7FF .....
	expected -49E0.FFFFFFFFFFFFFFFFFFFEFFFFF7FF ....x

1 tests performed; 1 error found.
Testing f128_sub, rounding near_even.

46464 tests total.

Errors found in f128_sub, rounding near_even:
+7FFD.FFFFFFFFFFFFFFEFFFFFFFFF7FFF  +3FFE.FFFFFFFFFFFFFFF7DFFFFFFFFFFF
	=> +407F.01FFFFFFFFFF7FF7DE000000007F ....x
	expected +7FFD.FFFFFFFFFFFFFFEFFFFFFFFF7FFF ....x

1 tests performed; 1 error found.
Testing f128_mul, rounding near_even, tininess before rounding.

46464 tests total.

Errors found in f128_mul, rounding near_even, tininess before rounding:
-4003.87801299A41C48629BCBCCDCEE75  -3F65.FFFFBFFFFFFEFFFFFFFFFFFFFFFF
	=> -3F65.FFFFBFFFFFFEFFFFFFFFFFFFFFFF .....
	expected +3F6A.877FE1A9A1C8501F0972A75550A7 ....x

1 tests performed; 1 error found.
Testing f128_mul, rounding near_even, tininess after rounding.

46464 tests total.

Errors found in f128_mul, rounding near_even, tininess after rounding:
+3FFB.FFFF0000000000000000000007FF  -4AF9.CD3F1616A1B2E16E8ECFE44AB7E3
	=> -0E46.4A975ECC90CEA14B8EAA8005E8BE ....x
	expected -4AF6.CD3E2F7716A790951E189CE2CCF2 ....x

1 tests performed; 1 error found.
Testing f128_div, rounding near_even.

46464 tests total.

Errors found in f128_div, rounding near_even:
+3BFF.0000000000000000000004001FFF  -3FD8.0004000003FFFFFFFFFFFFFFFFFF
	=> -3FD8.0004000003FFFFFFFFFFFFFFFFFF .....
	expected -3C25.FFF8001FF78041FE78282657ACC1 ....x

1 tests performed; 1 error found.
Testing f128_rem.

46464 tests total.

Errors found in f128_rem:
-3FFB.FFFFFFFFFFFFBFFFFFFFFFFFFFF7  +4001.FFFFFFFFFFF7FFFFBFFFFFFFFFFF
	=> +4001.FFFFFFFFFFF7FFFFBFFFFFFFFFFF .....
	expected -3FFB.FFFFFFFFFFFFBFFFFFFFFFFFFFF7 .....

1 tests performed; 1 error found.
Testing f128_eq.

46464 tests total.

Errors found in f128_eq:
+407F.000000003FFFFFFF000000000000  +4080.FFFFFFFFFFFFF7FFFFFFFFFFFFC0
	=> 0 v....  expected 0 .....

69 tests performed; 1 error found.
Testing f128_le.

46464 tests total.

Errors found in f128_le:
+3562.F92FC606839A91DE4E432E5B76BD  +3F80.FFBFFFFFFFFFFFFFFFFFFFFFFFFE
	=> 0 v....  expected 1 .....

3 tests performed; 1 error found.
Testing f128_lt.

46464 tests total.

Errors found in f128_lt:
-4070.008000000000000000000000FFFE  +407E.FFFFFFFFFFFFFFF000000007FFFE
	=> 0 .....  expected 1 .....

1 tests performed; 1 error found.
Testing f128_eq_signaling.

46464 tests total.

Errors found in f128_eq_signaling:
-3E25.FFFFFDFFFFFFFFFFFFFFFFFFFDFF  +21BE.A2F25F3E05B214685C99F23722DE
	=> 0 v....  expected 0 .....

1 tests performed; 1 error found.
Testing f128_le_quiet.

46464 tests total.

Errors found in f128_le_quiet:
-43FE.DF51357B00807226877347461639  -3FE2.FFFFFFFFFFFFFF7F800000000000
	=> 0 .....  expected 1 .....

1 tests performed; 1 error found.
Testing f128_lt_quiet.

46464 tests total.

Errors found in f128_lt_quiet:
+0000.0000000000000000000000000000  +43FF.FFFFBFFFEFFFFFFFFFFFFFFFFFFF
	=> 0 .....  expected 1 .....

2 tests performed; 1 error found.
