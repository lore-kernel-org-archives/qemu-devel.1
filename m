Received: from eggs.gnu.org ([2001:4830:134:3::10]:38912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9V-0007hN-7V
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cUG9U-0007v7-8o
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:33 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cUG9U-0007up-36
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 12:05:32 -0500
Received: by mail-wm0-x22f.google.com with SMTP id c85so2327456wmi.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:05:31 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Jan 2017 17:05:00 +0000
Message-Id: <20170119170507.16185-21-alex.bennee@linaro.org>
In-Reply-To: <20170119170507.16185-1-alex.bennee@linaro.org>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 20/27] target-arm: ensure BQL taken for
 ARM_CP_IO register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, rth@twiddle.net, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "open list:ARM cores" <qemu-arm@nongnu.org>

Most ARMCPRegInfo structures just allow updating of the CPU field.
However some have more complex operations that *may* be have cross vCPU
effects therefor need to be serialised. The most obvious examples at the
moment are things that affect the GICv3 IRQ controller. To avoid
applying this requirement to all registers with custom access functions
we check for if the type is marked ARM_CP_IO.

By default all MMIO access to devices already takes the BQL to serialise
hardware emulation.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 hw/intc/arm_gicv3_cpuif.c |  3 +++
 target/arm/op_helper.c    | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 35e8eb30fc..897ae31607 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "trace.h"
 #include "gicv3_internal.h"
 #include "cpu.h"
@@ -128,6 +129,8 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
                              cs->hppi.grp, cs->hppi.prio);
 
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index ba796d898e..1348789760 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "internals.h"
@@ -735,28 +736,58 @@ void HELPER(set_cp_reg)(CPUARMState *env, void *rip, uint32_t value)
 {
     const ARMCPRegInfo *ri = rip;
 
-    ri->writefn(env, ri, value);
+    if (ri->type & ARM_CP_IO) {
+        qemu_mutex_lock_iothread();
+        ri->writefn(env, ri, value);
+        qemu_mutex_unlock_iothread();
+    } else {
+        ri->writefn(env, ri, value);
+    }
 }
 
 uint32_t HELPER(get_cp_reg)(CPUARMState *env, void *rip)
 {
     const ARMCPRegInfo *ri = rip;
+    uint32_t res;
 
-    return ri->readfn(env, ri);
+    if (ri->type & ARM_CP_IO) {
+        qemu_mutex_lock_iothread();
+        res = ri->readfn(env, ri);
+        qemu_mutex_unlock_iothread();
+    } else {
+        res = ri->readfn(env, ri);
+    }
+
+    return res;
 }
 
 void HELPER(set_cp_reg64)(CPUARMState *env, void *rip, uint64_t value)
 {
     const ARMCPRegInfo *ri = rip;
 
-    ri->writefn(env, ri, value);
+    if (ri->type & ARM_CP_IO) {
+        qemu_mutex_lock_iothread();
+        ri->writefn(env, ri, value);
+        qemu_mutex_unlock_iothread();
+    } else {
+        ri->writefn(env, ri, value);
+    }
 }
 
 uint64_t HELPER(get_cp_reg64)(CPUARMState *env, void *rip)
 {
     const ARMCPRegInfo *ri = rip;
+    uint64_t res;
+
+    if (ri->type & ARM_CP_IO) {
+        qemu_mutex_lock_iothread();
+        res = ri->readfn(env, ri);
+        qemu_mutex_unlock_iothread();
+    } else {
+        res = ri->readfn(env, ri);
+    }
 
-    return ri->readfn(env, ri);
+    return res;
 }
 
 void HELPER(msr_i_pstate)(CPUARMState *env, uint32_t op, uint32_t imm)
-- 
2.11.0
