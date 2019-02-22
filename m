Received: from eggs.gnu.org ([209.51.188.92]:36563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxEKv-0006Hj-Fm
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxEKu-0001ev-9A
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:10:09 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:45884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxEKt-0000oP-RG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:10:08 -0500
Received: by mail-wr1-x429.google.com with SMTP id w17so3128137wrn.12
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 09:09:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 17:09:34 +0000
Message-Id: <20190222170936.13268-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] target/arm: Use MVFR feature bits to gate
 some insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This patchset switches some of the A32/T32 VFP decode to
look at the relevant MVFR feature bits rather than using
ARM_FEATURE_* feature flags:
 * use MVFR1.FPHP and .SIMDHP to gate the FP16 conversion insns
 * use MVFR2.FPMISC to gate the various insns in disas_vfp_v8_insn()

This is a bit of preparatory work for v7M/v8M floating point
support: the v7M FPU has the "misc" insns that only arrived
in A-profile in v8, and also the FP16 to/from double precision
conversion insns which are v8-only. So feature checks that look
at ARM_FEATURE_V8 won't work there, and we need to look at the
MVFR* fields instead.

This should have no behavioural changes for current CPUs.

thanks
-- PMM

Peter Maydell (2):
  target/arm: Use MVFR1 feature bits to gate A32/T32 FP16 instructions
  target/arm: Gate "miscellaneous FP" insns by ID register field

 target/arm/cpu.h       | 57 +++++++++++++++++++++++++++++++++++++++++-
 target/arm/cpu.c       |  2 --
 target/arm/kvm32.c     |  3 ---
 target/arm/translate.c | 47 ++++++++++++++++++++++------------
 4 files changed, 87 insertions(+), 22 deletions(-)

-- 
2.20.1
