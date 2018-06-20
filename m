Received: from eggs.gnu.org ([2001:4830:134:3::10]:36052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVbyA-0006vF-Gp
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@mips.com>) id 1fVby7-0006Mx-8L
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:14 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:49350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Yongbok.Kim@mips.com>)
	id 1fVby6-0006H9-UL
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:12:11 -0400
From: Yongbok Kim <yongbok.kim@mips.com>
Date: Wed, 20 Jun 2018 13:06:05 +0100
Message-ID: <20180620120620.12806-21-yongbok.kim@mips.com>
In-Reply-To: <20180620120620.12806-1-yongbok.kim@mips.com>
References: <20180620120620.12806-1-yongbok.kim@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 20/35] target/mips: Fix not to update BadVAddr
 in Debug Mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, Aleksandar.Markovic@mips.com, James.Hogan@mips.com, Paul.Burton@mips.com, Matthew.Fortune@mips.com, Stefan.Markovic@mips.com

From: Yongbok Kim <yongbok.kim@imgtec.com>

BadVaddr shouldn't be updated in Debug Mode

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/helper.c    |  4 +++-
 target/mips/op_helper.c | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 8cf91ce..e215af9 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -502,7 +502,9 @@ static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
         break;
     }
     /* Raise exception */
-    env->CP0_BadVAddr = address;
+    if (!(env->hflags & MIPS_HFLAG_DM)) {
+        env->CP0_BadVAddr = address;
+    }
     env->CP0_Context = (env->CP0_Context & ~0x007fffff) |
                        ((address >> 9) & 0x007ffff0);
     env->CP0_EntryHi = (env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask) |
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 71a9d66..c9a111c 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -271,7 +271,9 @@ static inline hwaddr do_translate_address(CPUMIPSState *env,
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
 {                                                                             \
     if (arg & almask) {                                                       \
-        env->CP0_BadVAddr = arg;                                              \
+        if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
+            env->CP0_BadVAddr = arg;                                          \
+        }                                                                     \
         do_raise_exception(env, EXCP_AdEL, GETPC());                          \
     }                                                                         \
     env->lladdr = do_translate_address(env, arg, 0, GETPC());                 \
@@ -288,7 +290,9 @@ void helper_llwp(CPUMIPSState *env, target_ulong addr, uint32_t reg1,
                  uint32_t reg2, uint32_t mem_idx)
 {
     if (addr & 0x7) {
-        env->CP0_BadVAddr = addr;
+        if (!(env->hflags & MIPS_HFLAG_DM)) {
+            env->CP0_BadVAddr = addr;
+        }
         do_raise_exception(env, EXCP_AdEL, GETPC());
     }
     env->lladdr = do_translate_address(env, addr, 0, GETPC());
@@ -304,7 +308,9 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg1,              \
     target_long tmp;                                                          \
                                                                               \
     if (arg2 & almask) {                                                      \
-        env->CP0_BadVAddr = arg2;                                             \
+        if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
+            env->CP0_BadVAddr = arg2;                                         \
+        }                                                                     \
         do_raise_exception(env, EXCP_AdES, GETPC());                          \
     }                                                                         \
     if (do_translate_address(env, arg2, 1, GETPC()) == env->lladdr) {         \
@@ -329,7 +335,9 @@ target_ulong helper_scwp(CPUMIPSState *env, target_ulong addr,
     uint32_t tmp2;
 
     if (addr & 0x7) {
-        env->CP0_BadVAddr = addr;
+        if (!(env->hflags & MIPS_HFLAG_DM)) {
+            env->CP0_BadVAddr = addr;
+        }
         do_raise_exception(env, EXCP_AdES, GETPC());
     }
     if (do_translate_address(env, addr, 1, GETPC()) == env->lladdr) {
@@ -2472,7 +2480,9 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     int error_code = 0;
     int excp;
 
-    env->CP0_BadVAddr = addr;
+    if (!(env->hflags & MIPS_HFLAG_DM)) {
+        env->CP0_BadVAddr = addr;
+    }
 
     if (access_type == MMU_DATA_STORE) {
         excp = EXCP_AdES;
-- 
1.9.1
