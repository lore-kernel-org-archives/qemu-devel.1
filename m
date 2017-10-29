Received: from eggs.gnu.org ([2001:4830:134:3::10]:43124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1e8vdo-0001TA-4P
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 18:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1e8vdl-0001le-3P
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 18:01:12 -0400
Received: from [77.247.229.177] (port=51420 helo=neth.polepetko.eu)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pixo@polepetko.eu>) id 1e8vdk-0001j8-TQ
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 18:01:09 -0400
From: Stanislav Lanci <pixo@polepetko.eu>
Date: Sun, 29 Oct 2017 22:22:24 +0100
Message-Id: <20171029212224.2777-1-pixo@polepetko.eu>
Subject: [Qemu-devel] [PATCH] AMD Processor Topology Information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stanislav Lanci <pixo@polepetko.eu>

Add CPUID 0x8000001E for describing AMD Processor Topology Information
Disables warning about smt for 17h family of AMD CPUs

Signed-off-by: Stanislav Lanci <pixo@polepetko.eu>
---
 target/i386/cpu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ddc45abd70..5885b2dd9e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3072,6 +3072,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = 0;
         }
         break;
+    case 0x8000001E:
+        /* AMD CPU Topology */
+        if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
+            env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
+            env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
+            *eax = cpu->apic_id;
+            *ebx = (cs->nr_threads - 1 ) << 8 | cpu->core_id;
+            *ecx = cpu->socket_id;
+            *edx = 0;
+        } else {
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
+            *edx = 0;
+        }
+        break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
@@ -3742,7 +3758,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      * NOTE: the following code has to follow qemu_init_vcpu(). Otherwise
      * cs->nr_threads hasn't be populated yet and the checking is incorrect.
      */
-    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned) {
+    if (!IS_INTEL_CPU(env) && cs->nr_threads > 1 && !ht_warned && (env->cpuid_version & 0xFF00F00) != 0x800F00) {
         error_report("AMD CPU doesn't support hyperthreading. Please configure"
                      " -smp options properly.");
         ht_warned = true;
-- 
2.14.2
