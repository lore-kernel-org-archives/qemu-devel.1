Received: from eggs.gnu.org ([2001:4830:134:3::10]:40566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMar7-0002di-2R
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gMar6-0002Xm-5l
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:43:56 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gMar5-0002C5-TC
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:43:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id w7-v6so12402582wmc.1
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 07:43:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 13 Nov 2018 16:42:22 +0100
Message-Id: <20181113154226.14396-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 0/4] target/arm: KVM vs ARMISARegisters
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


Changes, v3->v4:
  * Drop THUMB2EE patch; will revisit next development cycle.
  * Fix aa32 id_isar6 read on old kernels (pmm).

Changes, v2->v3:
  * Work around sysreg read failures from old host kernels.

Changes, v1->v2:
  * Remove assert that AArch32 sysreg <= UINT32_MAX.
  * Remove unused local variable.
  * Add commentary for AArch32 sysregs vs missing AArch32 support.


r~


Richard Henderson (4):
  target/arm: Install ARMISARegisters from kvm host
  target/arm: Fill in ARMISARegisters for kvm64
  target/arm: Introduce read_sys_reg32 for kvm32
  target/arm: Fill in ARMISARegisters for kvm32

 target/arm/kvm_arm.h |  1 +
 target/arm/kvm.c     |  1 +
 target/arm/kvm32.c   | 77 ++++++++++++++++++++++++++++----------------
 target/arm/kvm64.c   | 62 +++++++++++++++++++++++++++++++++--
 4 files changed, 111 insertions(+), 30 deletions(-)

-- 
2.17.2
