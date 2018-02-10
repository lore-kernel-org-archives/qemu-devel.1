Received: from eggs.gnu.org ([2001:4830:134:3::10]:58482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekeDC-0006Tc-Ef
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekeD9-00080X-E2
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:38 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekeD9-0007yn-2p
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 18:05:35 -0500
Received: by mail-pf0-x244.google.com with SMTP id p8so572050pff.3
	for <qemu-devel@nongnu.org>; Sat, 10 Feb 2018 15:05:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 10 Feb 2018 15:05:25 -0800
Message-Id: <20180210230530.8421-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] target/arm: More SVE prep work
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


Richard Henderson (5):
  target/arm: Remove ARM_CP_64BIT from ZCR_EL registers
  target/arm: Enforce FP access to FPCR/FPSR
  target/arm: Suppress TB end for FPCR/FPSR
  target/arm: Enforce access to ZCR_EL at translation
  target/arm: Handle SVE registers when using clear_vec_high

 target/arm/cpu.h           |  36 ++++-----
 target/arm/internals.h     |   6 ++
 target/arm/helper.c        |  28 ++-----
 target/arm/translate-a64.c | 181 ++++++++++++++++++++-------------------------
 4 files changed, 114 insertions(+), 137 deletions(-)

-- 
2.14.3
