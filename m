Received: from eggs.gnu.org ([2001:4830:134:3::10]:59763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnO-00088f-My
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnM-0002X8-1o
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:50 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnL-0002Wm-Rt
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:47 -0500
Received: by mail-wr0-x22a.google.com with SMTP id u108so60200391wrb.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:47 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:35 +0000
Message-Id: <20170302195337.31558-10-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/11] target/mips/op_helper: hold BQL
 before calling cpu_mips_get_count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

We should hold the BQL before we transition to HW emulation. This is
because all HW emulation needs to be serialised under MTTCG
conditions. This is picked up by asserts that fire when
cpu_mips_get_count triggers and IRQ.

Reported-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/op_helper.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index b683fcb025..38bca03f52 100644
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
@@ -827,7 +828,13 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *env)
 
 target_ulong helper_mfc0_count(CPUMIPSState *env)
 {
-    return (int32_t)cpu_mips_get_count(env);
+    int32_t count;
+
+    qemu_mutex_lock_iothread();
+    count = (int32_t)cpu_mips_get_count(env);
+    qemu_mutex_unlock_iothread();
+
+    return count;
 }
 
 target_ulong helper_mftc0_entryhi(CPUMIPSState *env)
@@ -2296,12 +2303,16 @@ target_ulong helper_rdhwr_synci_step(CPUMIPSState *env)
 
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
2.11.0
