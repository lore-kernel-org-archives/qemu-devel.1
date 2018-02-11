Received: from eggs.gnu.org ([2001:4830:134:3::10]:40251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekyi7-0006ib-0F
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekyi4-00042l-EB
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:58:55 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35397)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekyi4-00041e-8a
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 15:58:52 -0500
Received: by mail-pg0-x242.google.com with SMTP id l131so625610pga.2
	for <qemu-devel@nongnu.org>; Sun, 11 Feb 2018 12:58:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 11 Feb 2018 12:58:41 -0800
Message-Id: <20180211205848.4568-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/7] target/arm: More SVE prep work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Changes for v2:
Include signal frames and PR_SVE_SET/GET_VL.


Blurb for v1:
First, we had noted that ARM_CP_64BIT needed to be removed from
the ZCR_EL registers, but the patch set was applied without
actually fixing that.

Second, there's an existing bug by which the FPCR/FPSR registers
are not properly trapped when FP is disabled.  Fix that with a
translation-time check.

Third, my attempt at using .accessfn for ZCR_EL fails to take
into account the two different exception syndromes that must be
raised.  Although they probably aren't as important as FPCR/FPSR,
handle them at translation time too.

Fourth, when writing to an AdvSIMD register, zero the rest of
the SVE register.


r~


Richard Henderson (7):
  target/arm: Remove ARM_CP_64BIT from ZCR_EL registers
  target/arm: Enforce FP access to FPCR/FPSR
  target/arm: Suppress TB end for FPCR/FPSR
  target/arm: Enforce access to ZCR_EL at translation
  target/arm: Handle SVE registers when using clear_vec_high
  linux-user: Support SVE in aarch64 signal frames
  linux-user: Implement aarch64 PR_SVE_SET/GET_VL

 target/arm/cpu.h           |  38 ++---
 target/arm/internals.h     |   6 +
 linux-user/signal.c        | 348 ++++++++++++++++++++++++++++++++++++---------
 linux-user/syscall.c       |  20 +++
 target/arm/cpu64.c         |  61 ++++++++
 target/arm/helper.c        |  28 ++--
 target/arm/translate-a64.c | 181 +++++++++++------------
 7 files changed, 480 insertions(+), 202 deletions(-)

-- 
2.14.3
