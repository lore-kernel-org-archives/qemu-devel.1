Received: from eggs.gnu.org ([209.51.188.92]:57254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guOVD-00035P-K7
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guOSO-0002hv-78
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:22:09 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1guOSN-0002HS-H8
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 16:22:08 -0500
Received: by mail-pg1-x541.google.com with SMTP id r11so3690084pgp.6
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 13:21:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Feb 2019 13:21:41 -0800
Message-Id: <20190214212144.12784-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/3] target/arm: Implement ARMv8.3-JSConv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Based-on: something akin to target-arm.next, with the gvec changes,
but without the v2 2/3 "Restructure disas_fp_int_conv".

The full tree is at

  https://github.com/rth7680/qemu.git tgt-arm-jscvt

Patch 1 splits out vfp_helper.c, which I wrote for something else.
But while rebasing it occured to me that helper_vjcvt is better placed
in vfp_helper.c than op_helper.c, so why not include it here and now.

Patch 2 corresponds to the v2 patch 2, but totally rewritten.  What
I missed the first time around is that register Sn is encoded differenly
than Dn, so merely setting dp = 0 doesn't help because we've already
decoded the register number incorrectly.  Therefore, replace some really
ugly if conditions and set some variables as appropriate.

Patch 3 is adjusted to match the change in decode from patch 2, and
putting the aa32 flags in the right place.

And now, finally, tested aa32 vs risu.


r~


Richard Henderson (3):
  target/arm: Split out vfp_helper.c
  target/arm: Rearrange decode of Floating-point data-processing (2
    regs)
  target/arm: Implement ARMv8.3-JSConv

 target/arm/cpu.h           |   10 +
 target/arm/helper.h        |    3 +
 target/arm/cpu.c           |    1 +
 target/arm/cpu64.c         |    2 +
 target/arm/helper.c        | 1062 --------------------------------
 target/arm/translate-a64.c |   26 +
 target/arm/translate.c     |  237 ++++----
 target/arm/vfp_helper.c    | 1176 ++++++++++++++++++++++++++++++++++++
 target/arm/Makefile.objs   |    2 +-
 9 files changed, 1340 insertions(+), 1179 deletions(-)
 create mode 100644 target/arm/vfp_helper.c

-- 
2.17.2
