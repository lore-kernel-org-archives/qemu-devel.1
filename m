Received: from eggs.gnu.org ([2001:4830:134:3::10]:47081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7P-0003vc-Rv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7N-0005Ih-IL
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:47 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:37175)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7N-0005IN-9d
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:45 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:53 +0100
Message-ID: <22d40c9833292f00f0d4ccaf3317aa57a4d905a6.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 8/14] target/mips: Check memory permissions
 with mem_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

When performing virtual to physical address translation, check the
required privilege level based on the mem_idx rather than the mode in
the hflags. This will allow EVA loads & stores to operate safely only on
user memory from kernel mode.

For the cases where the mmu_idx doesn't need to be overridden
(mips_cpu_get_phys_page_debug() and cpu_mips_translate_address()), we
calculate the required mmu_idx using cpu_mmu_index(). Note that this
only tests the MIPS_HFLAG_KSU bits rather than MIPS_HFLAG_MODE, so we
don't test the debug mode hflag MIPS_HFLAG_DM any longer. This should be
fine as get_physical_address() only compares against MIPS_HFLAG_UM and
MIPS_HFLAG_SM, neither of which should get set by compute_hflags() when
MIPS_HFLAG_DM is set.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 target/mips/helper.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index cd07995eedb2..f78d151d2583 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -109,11 +109,11 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
 
 static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
                                 int *prot, target_ulong real_address,
-                                int rw, int access_type)
+                                int rw, int access_type, int mmu_idx)
 {
     /* User mode can only access useg/xuseg */
-    int user_mode = (env->hflags & MIPS_HFLAG_MODE) == MIPS_HFLAG_UM;
-    int supervisor_mode = (env->hflags & MIPS_HFLAG_MODE) == MIPS_HFLAG_SM;
+    int user_mode = mmu_idx == MIPS_HFLAG_UM;
+    int supervisor_mode = mmu_idx == MIPS_HFLAG_SM;
     int kernel_mode = !user_mode && !supervisor_mode;
 #if defined(TARGET_MIPS64)
     int UX = (env->CP0_Status & (1 << CP0St_UX)) != 0;
@@ -413,11 +413,12 @@ static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
 hwaddr mips_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 {
     MIPSCPU *cpu = MIPS_CPU(cs);
+    CPUMIPSState *env = &cpu->env;
     hwaddr phys_addr;
     int prot;
 
-    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0,
-                             ACCESS_INT) != 0) {
+    if (get_physical_address(env, &phys_addr, &prot, addr, 0, ACCESS_INT,
+                             cpu_mmu_index(env, false)) != 0) {
         return -1;
     }
     return phys_addr;
@@ -449,7 +450,7 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
        correctly */
     access_type = ACCESS_INT;
     ret = get_physical_address(env, &physical, &prot,
-                               address, rw, access_type);
+                               address, rw, access_type, mmu_idx);
     switch (ret) {
     case TLBRET_MATCH:
         qemu_log_mask(CPU_LOG_MMU,
@@ -487,8 +488,8 @@ hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address, int r
 
     /* data access */
     access_type = ACCESS_INT;
-    ret = get_physical_address(env, &physical, &prot,
-                               address, rw, access_type);
+    ret = get_physical_address(env, &physical, &prot, address, rw, access_type,
+                               cpu_mmu_index(env, false));
     if (ret != TLBRET_MATCH) {
         raise_mmu_exception(env, address, rw, ret);
         return -1LL;
-- 
git-series 0.8.10
