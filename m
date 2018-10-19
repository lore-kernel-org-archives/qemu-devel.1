Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJG4-00058Y-3W
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJFz-0003ad-1P
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:17 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:06:17 -0400
Message-Id: <20181019010625.25294-49-cota@braap.org>
In-Reply-To: <20181019010625.25294-1-cota@braap.org>
References: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 48/56] ppc: acquire the BQL in cpu_has_work
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

Soon we will call cpu_has_work without the BQL.

Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>
Cc: qemu-ppc@nongnu.org
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/ppc/translate_init.inc.c | 77 +++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 6827db14b6..a206715873 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "qemu/main-loop.h"
 #include "disas/bfd.h"
 #include "exec/gdbstub.h"
 #include "kvm_ppc.h"
@@ -8440,11 +8441,13 @@ static bool ppc_pvr_match_power7(PowerPCCPUClass *pcc, uint32_t pvr)
     return false;
 }
 
-static bool cpu_has_work_POWER7(CPUState *cs)
+static bool cpu_has_work_POWER7_locked(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
@@ -8474,6 +8477,21 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     }
 }
 
+static bool cpu_has_work_POWER7(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        bool ret;
+
+        cpu_mutex_unlock(cs);
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cs);
+        ret = cpu_has_work_POWER7_locked(cs);
+        qemu_mutex_unlock_iothread();
+        return ret;
+    }
+    return cpu_has_work_POWER7_locked(cs);
+}
+
 POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -8594,11 +8612,13 @@ static bool ppc_pvr_match_power8(PowerPCCPUClass *pcc, uint32_t pvr)
     return false;
 }
 
-static bool cpu_has_work_POWER8(CPUState *cs)
+static bool cpu_has_work_POWER8_locked(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
@@ -8636,6 +8656,21 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     }
 }
 
+static bool cpu_has_work_POWER8(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        bool ret;
+
+        cpu_mutex_unlock(cs);
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cs);
+        ret = cpu_has_work_POWER8_locked(cs);
+        qemu_mutex_unlock_iothread();
+        return ret;
+    }
+    return cpu_has_work_POWER8_locked(cs);
+}
+
 POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -8786,11 +8821,13 @@ static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
     return false;
 }
 
-static bool cpu_has_work_POWER9(CPUState *cs)
+static bool cpu_has_work_POWER9_locked(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     if (cpu_halted(cs)) {
         if (!(cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD)) {
             return false;
@@ -8829,6 +8866,21 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     }
 }
 
+static bool cpu_has_work_POWER9(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        bool ret;
+
+        cpu_mutex_unlock(cs);
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cs);
+        ret = cpu_has_work_POWER9_locked(cs);
+        qemu_mutex_unlock_iothread();
+        return ret;
+    }
+    return cpu_has_work_POWER9_locked(cs);
+}
+
 POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -10231,14 +10283,31 @@ static void ppc_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.nip = value;
 }
 
-static bool ppc_cpu_has_work(CPUState *cs)
+static bool ppc_cpu_has_work_locked(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     CPUPPCState *env = &cpu->env;
 
+    g_assert(qemu_mutex_iothread_locked());
+
     return msr_ee && (cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD);
 }
 
+static bool ppc_cpu_has_work(CPUState *cs)
+{
+    if (!qemu_mutex_iothread_locked()) {
+        bool ret;
+
+        cpu_mutex_unlock(cs);
+        qemu_mutex_lock_iothread();
+        cpu_mutex_lock(cs);
+        ret = ppc_cpu_has_work_locked(cs);
+        qemu_mutex_unlock_iothread();
+        return ret;
+    }
+    return ppc_cpu_has_work_locked(cs);
+}
+
 /* CPUClass::reset() */
 static void ppc_cpu_reset(CPUState *s)
 {
-- 
2.17.1
