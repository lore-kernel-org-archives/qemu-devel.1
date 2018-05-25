Received: from eggs.gnu.org ([2001:4830:134:3::10]:39252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fMDJP-0007ET-NR
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <petrutlucian94@gmail.com>) id 1fMDJK-0000Wp-Ss
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:19 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:43699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <petrutlucian94@gmail.com>)
	id 1fMDJK-0000WS-JX
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:03:14 -0400
Received: by mail-wr0-x242.google.com with SMTP id r13-v6so9438651wrj.10
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:03:14 -0700 (PDT)
From: petrutlucian94@gmail.com
Date: Fri, 25 May 2018 17:02:23 +0300
Message-Id: <1527256943-7667-3-git-send-email-lpetrut@cloudbasesolutions.com>
In-Reply-To: <1527256943-7667-1-git-send-email-lpetrut@cloudbasesolutions.com>
References: <1527256943-7667-1-git-send-email-lpetrut@cloudbasesolutions.com>
Subject: [Qemu-devel] [PATCH v3 3/3] WHPX: fix some compiler warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lucian Petrut <lpetrut@cloudbasesolutions.com>, Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>

From: Lucian Petrut <lpetrut@cloudbasesolutions.com>

This patch fixes a few compiler warnings, especially in case of
x86 targets, where the number of registers was not properly handled
and could cause an overflow.

Signed-off-by: Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
Signed-off-by: Lucian Petrut <lpetrut@cloudbasesolutions.com>
---
 target/i386/whpx-all.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 280e2bc..e9542e7 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -229,6 +229,7 @@ static void whpx_set_registers(CPUState *cpu)
     struct whpx_register_set vcxt = {0};
     HRESULT hr;
     int idx = 0;
+    int idx_next;
     int i;
     int v86, r86;
 
@@ -241,9 +242,11 @@ static void whpx_set_registers(CPUState *cpu)
     vcpu->apic_base = cpu_get_apic_base(x86_cpu->apic_state);
 
     /* Indexes for first 16 registers match between HV and QEMU definitions */
-    for (idx = 0; idx < CPU_NB_REGS64; idx += 1) {
-        vcxt.values[idx].Reg64 = env->regs[idx];
+    idx_next = 16;
+    for (idx = 0; idx < CPU_NB_REGS; idx += 1) {
+        vcxt.values[idx].Reg64 = (uint64_t)env->regs[idx];
     }
+    idx = idx_next;
 
     /* Same goes for RIP and RFLAGS */
     assert(whpx_register_names[idx] == WHvX64RegisterRip);
@@ -290,10 +293,12 @@ static void whpx_set_registers(CPUState *cpu)
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-    for (i = 0; i < 16; i += 1, idx += 1) {
+    idx_next = idx + 16;
+    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
         vcxt.values[idx].Reg128.Low64 = env->xmm_regs[i].ZMM_Q(0);
         vcxt.values[idx].Reg128.High64 = env->xmm_regs[i].ZMM_Q(1);
     }
+    idx = idx_next;
 
     /* 8 FP registers */
     assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
@@ -385,6 +390,7 @@ static void whpx_get_registers(CPUState *cpu)
     uint64_t tpr, apic_base;
     HRESULT hr;
     int idx = 0;
+    int idx_next;
     int i;
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
@@ -400,9 +406,11 @@ static void whpx_get_registers(CPUState *cpu)
     }
 
     /* Indexes for first 16 registers match between HV and QEMU definitions */
-    for (idx = 0; idx < CPU_NB_REGS64; idx += 1) {
+    idx_next = 16;
+    for (idx = 0; idx < CPU_NB_REGS; idx += 1) {
         env->regs[idx] = vcxt.values[idx].Reg64;
     }
+    idx = idx_next;
 
     /* Same goes for RIP and RFLAGS */
     assert(whpx_register_names[idx] == WHvX64RegisterRip);
@@ -449,10 +457,12 @@ static void whpx_get_registers(CPUState *cpu)
 
     /* 16 XMM registers */
     assert(whpx_register_names[idx] == WHvX64RegisterXmm0);
-    for (i = 0; i < 16; i += 1, idx += 1) {
+    idx_next = idx + 16;
+    for (i = 0; i < sizeof(env->xmm_regs) / sizeof(ZMMReg); i += 1, idx += 1) {
         env->xmm_regs[i].ZMM_Q(0) = vcxt.values[idx].Reg128.Low64;
         env->xmm_regs[i].ZMM_Q(1) = vcxt.values[idx].Reg128.High64;
     }
+    idx = idx_next;
 
     /* 8 FP registers */
     assert(whpx_register_names[idx] == WHvX64RegisterFpMmx0);
@@ -1203,7 +1213,7 @@ static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
         error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
                      " Host:%p, hr=%08lx",
                      (add ? "MAP" : "UNMAP"), name,
-                     (void *)start_pa, (void *)size, host_va, hr);
+                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
     }
 }
 
@@ -1234,8 +1244,8 @@ static void whpx_process_section(MemoryRegionSection *section, int add)
     host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
             + section->offset_within_region + delta;
 
-    whpx_update_mapping(start_pa, size, (void *)host_va, add,
-                       memory_region_is_rom(mr), mr->name);
+    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
+                        memory_region_is_rom(mr), mr->name);
 }
 
 static void whpx_region_add(MemoryListener *listener,
-- 
2.7.4
