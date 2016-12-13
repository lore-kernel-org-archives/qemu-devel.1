Received: from eggs.gnu.org ([2001:4830:134:3::10]:56751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cGkTT-0006D1-5Q
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cGkTS-0000NN-8j
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 05:38:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 10:36:13 +0000
Message-Id: <1481625384-15077-13-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 12/23] target-arm: Add ARMCPU fields for GIC
 CPU i/f config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Christoffer Dall <christoffer.dall@linaro.org>, Andrew Jones <drjones@redhat.com>

Add fields to the ARMCPU structure to allow CPU classes to
specify the configurable aspects of their GIC CPU interface.
In particular, the virtualization support allows different
values for number of list registers, priority bits and
preemption bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target-arm/cpu.h   | 5 +++++
 target-arm/cpu64.c | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/target-arm/cpu.h b/target-arm/cpu.h
index c38488a..be42ffb 100644
--- a/target-arm/cpu.h
+++ b/target-arm/cpu.h
@@ -659,6 +659,11 @@ struct ARMCPU {
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
diff --git a/target-arm/cpu64.c b/target-arm/cpu64.c
index 549cb1e..73c7f31 100644
--- a/target-arm/cpu64.c
+++ b/target-arm/cpu64.c
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
