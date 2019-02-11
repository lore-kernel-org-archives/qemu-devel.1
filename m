Received: from eggs.gnu.org ([209.51.188.92]:45709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtEWA-0002fz-0j
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtEW6-0003fF-1e
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:13 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49597 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gtEW1-0002or-QJ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:08 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Feb 2019 17:31:21 +0100
Message-Id: <1549902684-21740-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/6] hw/mips_int: hold BQL for all interrupt
 requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org, pburton@wavecomp.com, cota@braap.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Make sure BQL is held for all interrupt requests.

For MTTCG-enabled configurations, handling soft and hard interrupts
between vCPUs must be properly locked. By acquiring BQL, make sure
all paths triggering an IRQ are synchronized.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 hw/mips/mips_int.c      | 12 ++++++++++++
 target/mips/op_helper.c | 21 +++------------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
index 48192d2..5ddeb15 100644
--- a/hw/mips/mips_int.c
+++ b/hw/mips/mips_int.c
@@ -21,6 +21,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "hw/hw.h"
 #include "hw/mips/cpudevs.h"
 #include "cpu.h"
@@ -32,10 +33,17 @@ static void cpu_mips_irq_request(void *opaque, int ir=
q, int level)
     MIPSCPU *cpu =3D opaque;
     CPUMIPSState *env =3D &cpu->env;
     CPUState *cs =3D CPU(cpu);
+    bool locked =3D false;
=20
     if (irq < 0 || irq > 7)
         return;
=20
+    /* Make sure locking works even if BQL is already held by the caller=
 */
+    if (!qemu_mutex_iothread_locked()) {
+        locked =3D true;
+        qemu_mutex_lock_iothread();
+    }
+
     if (level) {
         env->CP0_Cause |=3D 1 << (irq + CP0Ca_IP);
=20
@@ -56,6 +64,10 @@ static void cpu_mips_irq_request(void *opaque, int irq=
, int level)
     } else {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
     }
+
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
 }
=20
 void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 943a7ea..8c53b3b 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -17,7 +17,6 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/host-utils.h"
@@ -905,11 +904,7 @@ target_ulong helper_mftc0_tcschefback(CPUMIPSState *=
env)
=20
 target_ulong helper_mfc0_count(CPUMIPSState *env)
 {
-    int32_t count;
-    qemu_mutex_lock_iothread();
-    count =3D (int32_t) cpu_mips_get_count(env);
-    qemu_mutex_unlock_iothread();
-    return count;
+    return (int32_t)cpu_mips_get_count(env);
 }
=20
 target_ulong helper_mfc0_saar(CPUMIPSState *env)
@@ -1594,9 +1589,7 @@ void helper_mtc0_hwrena(CPUMIPSState *env, target_u=
long arg1)
=20
 void helper_mtc0_count(CPUMIPSState *env, target_ulong arg1)
 {
-    qemu_mutex_lock_iothread();
     cpu_mips_store_count(env, arg1);
-    qemu_mutex_unlock_iothread();
 }
=20
 void helper_mtc0_saari(CPUMIPSState *env, target_ulong arg1)
@@ -1685,9 +1678,7 @@ void helper_mttc0_entryhi(CPUMIPSState *env, target=
_ulong arg1)
=20
 void helper_mtc0_compare(CPUMIPSState *env, target_ulong arg1)
 {
-    qemu_mutex_lock_iothread();
     cpu_mips_store_compare(env, arg1);
-    qemu_mutex_unlock_iothread();
 }
=20
 void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
@@ -1741,9 +1732,7 @@ void helper_mtc0_srsctl(CPUMIPSState *env, target_u=
long arg1)
=20
 void helper_mtc0_cause(CPUMIPSState *env, target_ulong arg1)
 {
-    qemu_mutex_lock_iothread();
     cpu_mips_store_cause(env, arg1);
-    qemu_mutex_unlock_iothread();
 }
=20
 void helper_mttc0_cause(CPUMIPSState *env, target_ulong arg1)
@@ -2587,16 +2576,12 @@ target_ulong helper_rdhwr_synci_step(CPUMIPSState=
 *env)
=20
 target_ulong helper_rdhwr_cc(CPUMIPSState *env)
 {
-    int32_t count;
     check_hwrena(env, 2, GETPC());
 #ifdef CONFIG_USER_ONLY
-    count =3D env->CP0_Count;
+    return env->CP0_Count;
 #else
-    qemu_mutex_lock_iothread();
-    count =3D (int32_t)cpu_mips_get_count(env);
-    qemu_mutex_unlock_iothread();
+    return (int32_t)cpu_mips_get_count(env);
 #endif
-    return count;
 }
=20
 target_ulong helper_rdhwr_ccres(CPUMIPSState *env)
--=20
2.7.4
