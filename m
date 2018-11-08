Received: from eggs.gnu.org ([2001:4830:134:3::10]:39530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKoW8-0001c6-DX
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gKoW3-00089O-8H
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gKoW2-000880-Tm
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 12:54:51 -0500
Received: by mail-wr1-x441.google.com with SMTP id y3-v6so21910283wrh.10
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 09:54:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  8 Nov 2018 18:52:41 +0100
Message-Id: <20181108175246.13416-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/5] target/arm: KVM vs ARMISARegisters
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

My previous patch set for replacing feature bits with id registers
failed to consider that these id registers are beginning to control
migration, and thus we must fill them in for KVM as well.

Thus, we want to initialize these values within CPU from the host.

Finally, re-send the T32EE conversion patch, fixing the build
failure on an arm32 host in kvm32.c.

Changes, v2->v3:
  * Work around sysreg read failures from old host kernels.

Changes, v1->v2:
  * Remove assert that AArch32 sysreg <= UINT32_MAX.
  * Remove unused local variable.
  * Add commentary for AArch32 sysregs vs missing AArch32 support.


r~


Richard Henderson (5):
  target/arm: Install ARMISARegisters from kvm host
  target/arm: Fill in ARMISARegisters for kvm64
  target/arm: Introduce read_sys_reg32 for kvm32
  target/arm: Fill in ARMISARegisters for kvm32
  target/arm: Convert t32ee from feature bit to isar3 test

 target/arm/cpu.h     |  6 ++-
 target/arm/kvm_arm.h |  1 +
 linux-user/elfload.c |  2 +-
 target/arm/cpu.c     |  4 --
 target/arm/helper.c  |  2 +-
 target/arm/kvm.c     |  1 +
 target/arm/kvm32.c   | 75 ++++++++++++++++++++----------------
 target/arm/kvm64.c   | 90 +++++++++++++++++++++++++++++++++++++++++++-
 target/arm/machine.c |  3 +-
 9 files changed, 141 insertions(+), 43 deletions(-)

-- 
2.17.2
