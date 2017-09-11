Received: from eggs.gnu.org ([2001:4830:134:3::10]:50859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drPaR-0007cS-DG
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1drPaL-0001ot-Mk
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:21:19 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 11 Sep 2017 16:20:55 +0200
Message-Id: <20170911142056.15643-3-lvivier@redhat.com>
In-Reply-To: <20170911142056.15643-1-lvivier@redhat.com>
References: <20170911142056.15643-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] hmp: fix "dump-quest-memory" segfault
 (arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
fixes the problem for i386, do the same for arm.

Running QEMU with
    qemu-system-aarch64 -M none -nographic -m 256
and executing
    dump-guest-memory /dev/null 0 8192
results in segfault

Fix by checking if we have CPU.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 target/arm/arch_dump.c | 52 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1a9861f69b..1f58cff256 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -273,8 +273,6 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
 int cpu_get_dump_info(ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
-    ARMCPU *cpu = ARM_CPU(first_cpu);
-    CPUARMState *env = &cpu->env;
     GuestPhysBlock *block;
     hwaddr lowest_addr = ULLONG_MAX;
 
@@ -290,13 +288,32 @@ int cpu_get_dump_info(ArchDumpInfo *info,
         }
     }
 
-    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-        info->d_machine = EM_AARCH64;
-        info->d_class = ELFCLASS64;
-        info->page_size = (1 << 16); /* aarch64 max pagesize */
-        if (lowest_addr != ULLONG_MAX) {
-            info->phys_base = lowest_addr;
+    if (first_cpu) {
+        ARMCPU *cpu = ARM_CPU(first_cpu);
+        CPUARMState *env = &cpu->env;
+        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+            info->d_machine = EM_AARCH64;
+            info->d_class = ELFCLASS64;
+            info->page_size = (1 << 16); /* aarch64 max pagesize */
+            if (lowest_addr != ULLONG_MAX) {
+                info->phys_base = lowest_addr;
+            }
+        } else {
+            info->d_machine = EM_ARM;
+            info->d_class = ELFCLASS32;
+            info->page_size = (1 << 12);
+            if (lowest_addr < UINT_MAX) {
+                info->phys_base = lowest_addr;
+            }
         }
+
+        /* We assume the relevant endianness is that of EL1; this is right
+         * for kernels, but might give the wrong answer if you're trying to
+         * dump a hypervisor that happens to be running an opposite-endian
+         * kernel.
+         */
+        info->d_endian = (env->cp15.sctlr_el[1] & SCTLR_EE) != 0
+                         ? ELFDATA2MSB : ELFDATA2LSB;
     } else {
         info->d_machine = EM_ARM;
         info->d_class = ELFCLASS32;
@@ -304,25 +321,24 @@ int cpu_get_dump_info(ArchDumpInfo *info,
         if (lowest_addr < UINT_MAX) {
             info->phys_base = lowest_addr;
         }
+        info->d_endian = ELFDATA2LSB;
     }
 
-    /* We assume the relevant endianness is that of EL1; this is right
-     * for kernels, but might give the wrong answer if you're trying to
-     * dump a hypervisor that happens to be running an opposite-endian
-     * kernel.
-     */
-    info->d_endian = (env->cp15.sctlr_el[1] & SCTLR_EE) != 0
-                     ? ELFDATA2MSB : ELFDATA2LSB;
-
     return 0;
 }
 
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
-    ARMCPU *cpu = ARM_CPU(first_cpu);
-    CPUARMState *env = &cpu->env;
+    ARMCPU *cpu;
+    CPUARMState *env;
     size_t note_size;
 
+    if (first_cpu == NULL) {
+        return 0;
+    }
+
+    cpu = ARM_CPU(first_cpu);
+    env = &cpu->env;
     if (class == ELFCLASS64) {
         note_size = AARCH64_PRSTATUS_NOTE_SIZE;
         note_size += AARCH64_PRFPREG_NOTE_SIZE;
-- 
2.13.5
