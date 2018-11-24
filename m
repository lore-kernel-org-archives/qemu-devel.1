Received: from eggs.gnu.org ([2001:4830:134:3::10]:57456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQhmV-0003G1-Sp
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQhmQ-0005Dz-Oq
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:11 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQhmO-0004eC-8P
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:05 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 24 Nov 2018 18:55:40 -0500
Message-Id: <20181124235553.17371-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 00/13] hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

v5: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02793.html

Changes since v5:

- Rebase on rth/tcg-next-for-4.0

- Use QEMU_FLATTEN instead of __attribute__((flatten))

- Merge rth's cleanups (thanks!). With this, we now use a union to
  hold {float|float32} or {double|float64} types, which gets
  rid of most macros. I added a few optimizations (i.e. likely
  hints in some branches, and not using temp variables to hold
  the result of fpclassify) to roughly match (and sometimes
  surpass) v5's performance.

- float64_sqrt: use fpclassify, which gives a 1.5x speedup.

This series introduces no regressions to fp-test. You can test
hardfloat by passing "-f x" to fp-test (so that the inexact flag
is set before each operation) and using even rounding (fp-test's
default). Note that hardfloat does not affect operations with
other rounding modes.

Perf numbers for fp-bench running on several host machines are in
each commit log; numbers for several benchmarks (NBench, SPEC06fp)
are in the last patch's commit log. These numbers are a bit
outdated (they're from v2 or so), but I've decided to keep them
because they give a good idea of the speedups to expect, and I don't
have time to re-run them =)

I did re-run the numbers for sqrt and cmp, though, since the
implementation has changed quite a bit since v5. I didn't
re-run these on Aarch64 and PPC hosts due to lack of time,
but I doubt they'd change significantly.

You can fetch this series from:
  https://github.com/cota/qemu/tree/hardfloat-v6

Thanks,

		Emilio
