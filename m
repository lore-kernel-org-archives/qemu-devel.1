Received: from eggs.gnu.org ([2001:4830:134:3::10]:47162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHTm-0003Ha-FG
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gFHTl-0005Hd-8C
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gFHTk-0005B5-UG
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:37:37 -0400
Received: by mail-wr1-x443.google.com with SMTP id q7-v6so5200350wrr.8
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 04:37:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Oct 2018 12:37:04 +0100
Message-Id: <20181024113709.16599-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/5] target/arm: KVM vs ARMISARegisters
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

My previous patch set for replacing feature bits with id registers
failed to consider that these id registers are beginning to control
migration, and thus we must fill them in for KVM as well.

Thus, we want to initialize these values within CPU from the host.

Finally, re-send the T32EE conversion patch, fixing the build
failure on an arm32 host in kvm32.c.

Tested on arm64; cross-build tested for arm32.


r~


Richard Henderson (5):
  target/arm: Install ARMISARegisters from kvm host
  target/arm: Fill in ARMISARegisters for kvm64
  target/arm: Introduce read_sys_reg32 for kvm32
  target/arm: Fill in ARMISARegisters for kvm32
  target/arm: Convert t32ee from feature bit to isar3 test

 target/arm/cpu.h     |  6 +++-
 target/arm/kvm_arm.h |  1 +
 linux-user/elfload.c |  2 +-
 target/arm/cpu.c     |  4 ---
 target/arm/helper.c  |  2 +-
 target/arm/kvm.c     |  1 +
 target/arm/kvm32.c   | 75 +++++++++++++++++++++++++-------------------
 target/arm/kvm64.c   | 63 +++++++++++++++++++++++++++++++++++--
 target/arm/machine.c |  3 +-
 9 files changed, 114 insertions(+), 43 deletions(-)

-- 
2.17.2
