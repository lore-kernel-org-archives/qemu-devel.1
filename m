Received: from eggs.gnu.org ([2001:4830:134:3::10]:58574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02Z-0000ao-DA
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fE02W-0007nk-CN
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:15:59 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:37874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fE02W-0007nJ-6F
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:15:56 -0400
Received: by mail-pg0-x231.google.com with SMTP id a13-v6so11633294pgu.4
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 15:15:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  2 May 2018 15:15:38 -0700
Message-Id: <20180502221552.3873-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/14] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

When running the gcc testsuite with current aarch64-linux-user,
the testsuite detects the presence of the fp16 extension and
enables lots of extra tests for builtins.

Quite a few of these new tests fail because we missed implementing
some instructions.  We really should go back and verify that nothing
else is missing from this (rather large) extension.

In addition, it tests some edge conditions on data that show flaws
in the way we were performing integer<->fp conversion; particularly
with respect to scaled conversion.

Changes since v1:
  * Rebased vs master instead of tgt-arm-sve-9.
  * Alex did some additional digging through the ARM xhtml
    and came up with some additional missing instructions.
  * Everything cc'd to qemu-stable.


r~


Alex Bennée (4):
  target/arm: Implement FCMP for fp16
  target/arm: Implement FCSEL for fp16
  target/arm: Implement FMOV (immediate) for fp16
  target/arm: Fix sqrt_f16 exception raising

Richard Henderson (10):
  target/arm: Implement vector shifted SCVF/UCVF for fp16
  target/arm: Implement vector shifted FCVT for fp16
  target/arm: Fix float16 to/from int16
  target/arm: Clear SVE high bits for FMOV
  target/arm: Implement FMOV (general) for fp16
  target/arm: Implement FCVT (scalar,integer) for fp16
  target/arm: Implement FCVT (scalar,fixed-point) for fp16
  target/arm: Introduce and use read_fp_hreg
  target/arm: Implement FP data-processing (2 source) for fp16
  target/arm: Implement FP data-processing (3 source) for fp16

 target/arm/helper-a64.h    |   2 +
 target/arm/helper.h        |   6 +
 target/arm/helper-a64.c    |  10 +
 target/arm/helper.c        |  87 +++++++-
 target/arm/translate-a64.c | 535 ++++++++++++++++++++++++++++++++++++---------
 5 files changed, 532 insertions(+), 108 deletions(-)

-- 
2.14.3
