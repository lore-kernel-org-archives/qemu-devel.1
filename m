Received: from eggs.gnu.org ([209.51.188.92]:33291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guj4m-0005Iu-01
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1guj4l-00035D-5E
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:07 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1guj4k-000338-PQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 14:23:06 -0500
Received: by mail-pf1-x444.google.com with SMTP id q1so5281734pfi.5
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 11:23:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Feb 2019 11:22:54 -0800
Message-Id: <20190215192302.27855-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 0/8] target/arm: Implement ARMv8.3-JSConv &
 ARMv8.2-FHM
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


Changes since v3:

Rebased on master, and combined the JSConv and FHM patch sets.
There were a number of patch conflicts which needed fixing up.

Changes since v2:

Patch 2 splits out vfp_helper.c, which I wrote for something else.
But while rebasing it occured to me that helper_vjcvt is better placed
in vfp_helper.c than op_helper.c, so why not include it here and now.

Patch 3 corresponds to the v2 patch 1, but totally rewritten.  What
I missed the first time around is that register Sn is encoded differenly
than Dn, so merely setting dp = 0 doesn't help because we've already
decoded the register number incorrectly.  Therefore, replace some really
ugly if conditions and set some variables as appropriate.

Patch 4 is adjusted to match the change in decode from patch 2, and
putting the aa32 flags in the right place.


r~


Richard Henderson (8):
  target/arm: Restructure disas_fp_int_conv
  target/arm: Split out vfp_helper.c
  target/arm: Rearrange Floating-point data-processing (2 regs)
  target/arm: Implement ARMv8.3-JSConv
  target/arm: Add helpers for FMLAL
  target/arm: Implement FMLAL and FMLSL for aarch64
  target/arm: Implement VFMAL and VFMSL for aarch32
  target/arm: Enable ARMv8.2-FHM for -cpu max

 target/arm/cpu.h           |   20 +
 target/arm/helper.h        |    8 +
 target/arm/cpu.c           |    2 +
 target/arm/cpu64.c         |    4 +
 target/arm/helper.c        | 1062 --------------------------------
 target/arm/translate-a64.c |  170 ++++--
 target/arm/translate.c     |  340 ++++++-----
 target/arm/vec_helper.c    |  114 ++++
 target/arm/vfp_helper.c    | 1176 ++++++++++++++++++++++++++++++++++++
 target/arm/Makefile.objs   |    2 +-
 10 files changed, 1644 insertions(+), 1254 deletions(-)
 create mode 100644 target/arm/vfp_helper.c

-- 
2.17.2
