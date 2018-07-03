Received: from eggs.gnu.org ([2001:4830:134:3::10]:57654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3k-0006IT-4X
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1faN3g-0000LD-6k
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:40 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1faN3g-0000Ki-0d
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:17:36 -0400
Received: by mail-pf0-x244.google.com with SMTP id q7-v6so75250pff.2
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:17:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue,  3 Jul 2018 08:17:25 -0700
Message-Id: <20180703151732.29843-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.1 0/7] target/ppc fp cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: programmingkidx@gmail.com, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

Beginning with John Arbuckle's fdiv test case, clean up some
of the fp helpers.  As with fdiv, fre and fresqrt are missing
divide-by-zero exceptions.

I've also noticed that load/store were using arithmetic conversions
to/from float32.  These should be using the non-arithmetic algorithms
listed in the manual.

Aside from cleaning up all of the rest of the helpers, I believe that
the implementation of the single-precision operations are incorrect.
They are currently implemented with the double-precision operation
followed by a round-to-single.  This causes incorrect results via
double rounding.  I believe better results could be had by using
these non-arithmetic converters to produce float32 operands, use the
proper float32 softfloat operations, and then convert back.

Anyway, all of this has been broken long enough that it'll need to
wait til next devel cycle before anything further gets done.


r~


Richard Henderson (7):
  target/ppc: Enable fp exceptions for user-only
  target/ppc: Honor fpscr_ze semantics and tidy fdiv
  target/ppc: Tidy helper_fmul
  target/ppc: Tidy helper_fadd, helper_fsub
  target/ppc: Tidy helper_fsqrt
  target/ppc: Honor fpscr_ze semantics and tidy fre, fresqrt
  target/ppc: Use non-arithmetic conversions for fp load/store

 target/ppc/helper.h                |  14 +-
 target/ppc/fpu_helper.c            | 294 +++++++++++++++++------------
 target/ppc/translate/fp-impl.inc.c |  26 +--
 target/ppc/translate_init.inc.c    |   2 +
 4 files changed, 189 insertions(+), 147 deletions(-)

-- 
2.17.1
