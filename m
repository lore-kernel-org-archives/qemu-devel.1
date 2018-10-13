Received: from eggs.gnu.org ([2001:4830:134:3::10]:57876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCf-0002TG-LF
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCc-0007wu-PK
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54739)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gBTCc-0007vg-HX
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 13 Oct 2018 19:19:20 -0400
Message-Id: <20181013231933.28789-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 00/13] hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

v4: https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02960.html

Changes since v4:

- Rebase on current master (a73549f99).

- Add a patch for fp-test to pick a specialization; this gets rid of
  the muladd errors, since our default "no specialization" does not
  raise invalid when one of the muladd inputs is a nan.

- fp-bench: add -r flag to set rounding mode. Do not support "odd"
  as an option though, because few ops support it.

- fp-bench: use -o mulAdd instead of -o fma for muladd, to
  be consistent with fp-test.

- fp-bench: Use get_clock() instead of get_clock_realtime,
  which on unix will use the monotonic clock, if available.
  Thus, link fp-bench against libqemuutil (get_clock reads
  the use_rt_clock variable, which is provided by
  qemu-timer-common.o).

- Do not remove the "flatten" attribute from the softfloat
  primitives. Removing it reduces code size, but hurts execution time
  (slowdown 2 to 3x) when the rounding mode != even.
  Instead, keep the attribute so that !even ops run at a reasonable
  speed.

  Note that this speed is still a little slower (up to 12% slower
  with fp-bench) than before hardfloat, due to the checks
  at the beginning of hardfloat functions:
    flush_to_zero_if_needed();
    if (rounding != even) {
        return softfloat();
    }
  but I suspect we can live with that.
  If this were to be an issue in the future, we could use an "ops"
  struct with function pointers to just call the right function
  (in)directly. I am not doing that here because that would
  require that all modifications of .float_rounding_mode go through
  set_rounding_mode(), so that the function pointers can be updated.
  Let me know if you feel strongly about this -- I did a quick
  test with an ops struct for f32_add and it does indeed bringt
  the slowdown for !even ops to 0%.

This series introduces no regressions to fp-test. You can test
hardfloat by passing "-f x" to fp-test (so that the inexact flag
is set before each operation) and using even rounding (fp-test's
default). Note that hardfloat does not affect any other rounding
mode.

Perf numbers for fp-bench running on several host machines are in
each commit log; numbers for several benchmarks (NBench, SPEC06fp)
are in the last patch's commit log.

You can fetch this series from:
  https://github.com/cota/qemu/tree/hardfloat-v5

Thanks,

		Emilio
