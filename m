Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodo-00088k-Dy
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dzodn-0002Xq-HC
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:32 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:48926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dzodn-0002XV-AY
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 14:43:31 -0400
Received: by mail-qt0-x231.google.com with SMTP id d13so20371295qta.5
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 11:43:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  4 Oct 2017 14:43:13 -0400
Message-Id: <20171004184325.24157-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v1 00/12] ARM v8.1 simd + v8.3 complex insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

This patch set depends on v3 of native-vector-registers;
for ease of review the whole tree is at

  git://github.com/rth7680/qemu.git tgt-arm-cplx

I have successfully tested all insns for AArch64 via RISU.
I have successfully tested everything but VCMLA for AArch32.

The insn that doesn't match up is

  fef3c848  vcmla.f32  q14, <illegal reg q1.5>, d8[0], #270

for which FoundationModel is *not* signalling illegal insn.
I'm not really sure what it is doing -- perhaps treating the
insn as a coprocessor 8 nop?  I'll have to investigate further.

In the meantime, it's surely time for a round 1 review.


r~


Richard Henderson (12):
  HACK: use objdump disas
  target/arm: Add ARM_FEATURE_V8_1_SIMD
  target/arm: Decode aa64 armv8.1 scalar three same extra
  target/arm: Decode aa64 armv8.1 three same extra
  target/arm: Decode aa64 armv8.1 scalar/vector x indexed element
  target/arm: Decode aa32 armv8.1 three same
  target/arm: Decode aa32 armv8.1 two reg and a scalar
  target/arm: Add ARM_FEATURE_V8_FCMA
  target/arm: Decode aa64 armv8.3 fcadd
  target/arm: Decode aa64 armv8.3 fcmla
  target/arm: Decode aa32 armv8.3 3-same
  target/arm: Decode aa32 armv8.3 2-reg-index

 target/arm/cpu.h            |   2 +
 target/arm/helper.h         |  26 ++++
 disas.c                     |   2 +-
 linux-user/elfload.c        |  10 ++
 target/arm/advsimd_helper.c | 331 +++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.c            |   2 +
 target/arm/cpu64.c          |   2 +
 target/arm/translate-a64.c  | 350 +++++++++++++++++++++++++++++++++++++++-----
 target/arm/translate.c      | 241 +++++++++++++++++++++++++++---
 target/arm/Makefile.objs    |   2 +-
 10 files changed, 912 insertions(+), 56 deletions(-)
 create mode 100644 target/arm/advsimd_helper.c

-- 
2.13.6
