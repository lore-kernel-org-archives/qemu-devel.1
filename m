Received: from eggs.gnu.org ([2001:4830:134:3::10]:47444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPq-0000xs-M9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPo-00059a-Lh
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:14 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPo-00055o-E9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:12 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPi-0003Bl-Nz
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:06 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:42 +0000
Message-Id: <1484834995-26826-24-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 23/36] target-arm: Add ARMCPU fields for GIC CPU
 i/f config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add fields to the ARMCPU structure to allow CPU classes to
specify the configurable aspects of their GIC CPU interface.
In particular, the virtualization support allows different
values for number of list registers, priority bits and
preemption bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Message-id: 1483977924-14522-6-git-send-email-peter.maydell@linaro.org
---
 target/arm/cpu.h   | 5 +++++
 target/arm/cpu64.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index fa09498..16c7c10 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -662,6 +662,11 @@ struct ARMCPU {
     uint32_t dcz_blocksize;
     uint64_t rvbar;
 
+    /* Configurable aspects of GIC cpu interface (which is part of the CPU) */
+    int gic_num_lrs; /* number of list registers */
+    int gic_vpribits; /* number of virtual priority bits */
+    int gic_vprebits; /* number of virtual preemption bits */
+
     ARMELChangeHook *el_change_hook;
     void *el_change_hook_opaque;
 };
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 549cb1e..73c7f31 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -147,6 +147,9 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
     cpu->ccsidr[2] = 0x70ffe07a; /* 2048KB L2 cache */
     cpu->dcz_blocksize = 4; /* 64 bytes */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
     define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
 }
 
@@ -201,6 +204,9 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
     cpu->ccsidr[2] = 0x707fe07a; /* 1024KB L2 cache */
     cpu->dcz_blocksize = 4; /* 64 bytes */
+    cpu->gic_num_lrs = 4;
+    cpu->gic_vpribits = 5;
+    cpu->gic_vprebits = 5;
     define_arm_cp_regs(cpu, cortex_a57_a53_cp_reginfo);
 }
 
-- 
2.7.4
