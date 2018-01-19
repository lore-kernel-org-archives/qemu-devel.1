Received: from eggs.gnu.org ([2001:4830:134:3::10]:34617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1ecZ2f-0002yU-Ft
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1ecZ2b-000691-F9
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:57:21 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49796 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1ecZ2b-0005gp-3l
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 10:57:17 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 19 Jan 2018 16:56:27 +0100
Message-Id: <1516377391-25945-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1516377391-25945-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1516377391-25945-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/7] Revert "target/mips: hold BQL for timer
 interrupts"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

This reverts commit d394698d73836d1c50545bdb32dc58d09708fcfb.

Ther revert is needed in order not to cause overlap with subsequent
patches related to handling synchronization of interrupt code paths.

Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 target/mips/op_helper.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index a429987..3830ee8 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/host-utils.h"
@@ -809,11 +808,7 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
 
 target_ulong helper_mfc0_count(CPUMIPSState *env)
 {
-    int32_t count;
-    qemu_mutex_lock_iothread();
-    count = (int32_t) cpu_mips_get_count(env);
-    qemu_mutex_unlock_iothread();
-    return count;
+    return (int32_t)cpu_mips_get_count(env);
 }
 
 target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
@@ -1388,9 +1383,7 @@ void helper_mtc0_hwrena(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
 {
-    qemu_mutex_lock_iothread();
     cpu_mips_store_count(env, arg1);
-    qemu_mutex_unlock_iothread();
 }
 
 void helper_mtc0_entryhi(CPUMIPSState *env, target_ulong arg1)
@@ -1439,9 +1432,7 @@ void helper_mttc0_entryhi(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
 {
-    qemu_mutex_lock_iothread();
     cpu_mips_store_compare(env, arg1);
-    qemu_mutex_unlock_iothread();
 }
 
 void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
@@ -1495,9 +1486,7 @@ void helper_mtc0_srsctl(CPUMIPSState *env, target_ulong arg1)
 
 void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
 {
-    qemu_mutex_lock_iothread();
     cpu_mips_store_cause(env, arg1);
-    qemu_mutex_unlock_iothread();
 }
 
 void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
@@ -2339,16 +2328,12 @@ target_ulong helper_rdhwr_synci_step(CPUMIPSState *env)
 
 target_ulong helper_rdhwr_cc(CPUMIPSState *env)
 {
-    int32_t count;
     check_hwrena(env, 2, GETPC());
 #ifdef CONFIG_USER_ONLY
-    count = env->CP0_Count;
+    return env->CP0_Count;
 #else
-    qemu_mutex_lock_iothread();
-    count = (int32_t)cpu_mips_get_count(env);
-    qemu_mutex_unlock_iothread();
+    return (int32_t)cpu_mips_get_count(env);
 #endif
-    return count;
 }
 
 target_ulong helper_rdhwr_ccres(CPUMIPSState *env)
-- 
2.7.4
