Received: from eggs.gnu.org ([2001:4830:134:3::10]:53610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjlGb-0004X3-9P
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjlGW-0007uv-Sv
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:20:57 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:40887)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cjlGW-0007uc-G4
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 06:20:52 -0500
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 3 Mar 2017 11:20:21 +0000
Message-ID: <1488540021-35506-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] target/mips: hold BQL for timer interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hold BQL when accessing timer which can cause interrupts

Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/op_helper.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index b683fcb..e5f3ea4 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
@@ -827,7 +828,11 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
 
 target_ulong helper_mfc0_count(CPUMIPSState *env)
 {
-    return (int32_t)cpu_mips_get_count(env);
+    int32_t count;
+    qemu_mutex_lock_iothread();
+    count = (int32_t) cpu_mips_get_count(env);
+    qemu_mutex_unlock_iothread();
+    return count;
 }
 
 target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
@@ -1375,7 +1380,9 @@ void helper_mtc0_hwrena(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
 {
+    qemu_mutex_lock_iothread();
     cpu_mips_store_count(env, arg1);
+    qemu_mutex_unlock_iothread();
 }
 
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
@@ -1424,7 +1431,9 @@ void helper_mttc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
 {
+    qemu_mutex_lock_iothread();
     cpu_mips_store_compare(env, arg1);
+    qemu_mutex_unlock_iothread();
 }
 
 void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
@@ -1475,7 +1484,9 @@ void helper_mtc0_srsctl(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
 {
+    qemu_mutex_lock_iothread();
     cpu_mips_store_cause(env, arg1);
+    qemu_mutex_unlock_iothread();
 }
 
 void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
@@ -2296,12 +2307,16 @@ target_ulong helper_rdhwr_synci_step(CPUMIPSState *env)
 
 target_ulong helper_rdhwr_cc(CPUMIPSState *env)
 {
+    int32_t count;
     check_hwrena(env, 2, GETPC());
 #ifdef CONFIG_USER_ONLY
-    return env->CP0_Count;
+    count = env->CP0_Count;
 #else
-    return (int32_t)cpu_mips_get_count(env);
+    qemu_mutex_lock_iothread();
+    count = (int32_t)cpu_mips_get_count(env);
+    qemu_mutex_unlock_iothread();
 #endif
+    return count;
 }
 
 target_ulong helper_rdhwr_ccres(CPUMIPSState *env)
-- 
2.7.4
