Received: from eggs.gnu.org ([209.51.188.92]:43317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqWwc-00017m-WB
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqWn0-0002ff-3Q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:27:28 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:36917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqWmy-0002Wo-1U
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 00:27:26 -0500
Received: by mail-wr1-x42a.google.com with SMTP id s12so13015992wrt.4
	for <qemu-devel@nongnu.org>; Sun, 03 Feb 2019 21:27:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 05:27:09 +0000
Message-Id: <20190204052712.30833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Two cleanups to surrounding code preceed the actual implementation.

I did not find the ARM FPToFixedJS pseudo-function particularly helpful,
so I mostly cribed off of the Alpha cvttq implementation.  But I think
it all makes sense -- convert, produce the mod 2^32 result with NaN
getting INT32_MAX, set ZF iff the conversion is exact.

I've tested the aa64 version vs FVP with RISU.  I need to adjust my
FVP configuration in order to test aa32.


r~


Richard Henderson (3):
  target/arm: Force result size into dp after operation
  target/arm: Restructure disas_fp_int_conv
  target/arm: Implement ARMv8.3-JSConv

 target/arm/cpu.h           |  10 ++++
 target/arm/helper.h        |   2 +
 target/arm/cpu.c           |   1 +
 target/arm/cpu64.c         |   2 +
 target/arm/op_helper.c     |  91 ++++++++++++++++++++++++++++
 target/arm/translate-a64.c | 120 +++++++++++++++++++++++--------------
 target/arm/translate.c     |  47 ++++++++++-----
 7 files changed, 212 insertions(+), 61 deletions(-)

-- 
2.17.2
