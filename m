Received: from eggs.gnu.org ([2001:4830:134:3::10]:33513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1gg-0007iu-UM
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1ga-0006qr-D9
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:42 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:58722)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dv1ga-0006pU-18
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:38:36 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 21 Sep 2017 14:38:05 +0100
Message-ID: <1506001091-8296-2-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
References: <1506001091-8296-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/7] mips: move hw/mips/cputimer.c to
 target/mips/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This timer is a required part of the MIPS32/MIPS64 System Control coproce=
ssor
(CP0). Moving it with the other architecture related files will allow an =
opaque
use of CPUMIPSState* in the next commit (introduce "internal.h").

also remove it from 'user' targets, remove an unnecessary include.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/mips/Makefile.objs     |   2 +-
 hw/mips/cputimer.c        | 165 ----------------------------------------=
------
 target/mips/Makefile.objs |   2 +-
 target/mips/cp0_timer.c   | 164 ++++++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 166 insertions(+), 167 deletions(-)
 delete mode 100644 hw/mips/cputimer.c
 create mode 100644 target/mips/cp0_timer.c

diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
index 48cd2ef..17a311a 100644
--- a/hw/mips/Makefile.objs
+++ b/hw/mips/Makefile.objs
@@ -1,5 +1,5 @@
 obj-y +=3D mips_r4k.o mips_malta.o mips_mipssim.o
-obj-y +=3D addr.o cputimer.o mips_int.o
+obj-y +=3D addr.o mips_int.o
 obj-$(CONFIG_JAZZ) +=3D mips_jazz.o
 obj-$(CONFIG_FULONG) +=3D mips_fulong2e.o
 obj-y +=3D gt64xxx_pci.o
diff --git a/hw/mips/cputimer.c b/hw/mips/cputimer.c
deleted file mode 100644
index 8a166b3..0000000
--- a/hw/mips/cputimer.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * QEMU MIPS timer support
- *
- * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
- * of this software and associated documentation files (the "Software"),=
 to deal
- * in the Software without restriction, including without limitation the=
 rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be includ=
ed in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "hw/hw.h"
-#include "hw/mips/cpudevs.h"
-#include "qemu/timer.h"
-#include "sysemu/kvm.h"
-
-#define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
-
-/* XXX: do not use a global */
-uint32_t cpu_mips_get_random (CPUMIPSState *env)
-{
-    static uint32_t seed =3D 1;
-    static uint32_t prev_idx =3D 0;
-    uint32_t idx;
-    uint32_t nb_rand_tlb =3D env->tlb->nb_tlb - env->CP0_Wired;
-
-    if (nb_rand_tlb =3D=3D 1) {
-        return env->tlb->nb_tlb - 1;
-    }
-
-    /* Don't return same value twice, so get another value */
-    do {
-        /* Use a simple algorithm of Linear Congruential Generator
-         * from ISO/IEC 9899 standard. */
-        seed =3D 1103515245 * seed + 12345;
-        idx =3D (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
-    } while (idx =3D=3D prev_idx);
-    prev_idx =3D idx;
-    return idx;
-}
-
-/* MIPS R4K timer */
-static void cpu_mips_timer_update(CPUMIPSState *env)
-{
-    uint64_t now, next;
-    uint32_t wait;
-
-    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    wait =3D env->CP0_Compare - env->CP0_Count - (uint32_t)(now / TIMER_=
PERIOD);
-    next =3D now + (uint64_t)wait * TIMER_PERIOD;
-    timer_mod(env->timer, next);
-}
-
-/* Expire the timer.  */
-static void cpu_mips_timer_expire(CPUMIPSState *env)
-{
-    cpu_mips_timer_update(env);
-    if (env->insn_flags & ISA_MIPS32R2) {
-        env->CP0_Cause |=3D 1 << CP0Ca_TI;
-    }
-    qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
-}
-
-uint32_t cpu_mips_get_count (CPUMIPSState *env)
-{
-    if (env->CP0_Cause & (1 << CP0Ca_DC)) {
-        return env->CP0_Count;
-    } else {
-        uint64_t now;
-
-        now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        if (timer_pending(env->timer)
-            && timer_expired(env->timer, now)) {
-            /* The timer has already expired.  */
-            cpu_mips_timer_expire(env);
-        }
-
-        return env->CP0_Count + (uint32_t)(now / TIMER_PERIOD);
-    }
-}
-
-void cpu_mips_store_count (CPUMIPSState *env, uint32_t count)
-{
-    /*
-     * This gets called from cpu_state_reset(), potentially before timer=
 init.
-     * So env->timer may be NULL, which is also the case with KVM enable=
d so
-     * treat timer as disabled in that case.
-     */
-    if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer)
-        env->CP0_Count =3D count;
-    else {
-        /* Store new count register */
-        env->CP0_Count =3D count -
-               (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_=
PERIOD);
-        /* Update timer timer */
-        cpu_mips_timer_update(env);
-    }
-}
-
-void cpu_mips_store_compare (CPUMIPSState *env, uint32_t value)
-{
-    env->CP0_Compare =3D value;
-    if (!(env->CP0_Cause & (1 << CP0Ca_DC)))
-        cpu_mips_timer_update(env);
-    if (env->insn_flags & ISA_MIPS32R2)
-        env->CP0_Cause &=3D ~(1 << CP0Ca_TI);
-    qemu_irq_lower(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
-}
-
-void cpu_mips_start_count(CPUMIPSState *env)
-{
-    cpu_mips_store_count(env, env->CP0_Count);
-}
-
-void cpu_mips_stop_count(CPUMIPSState *env)
-{
-    /* Store the current value */
-    env->CP0_Count +=3D (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 /
-                                 TIMER_PERIOD);
-}
-
-static void mips_timer_cb (void *opaque)
-{
-    CPUMIPSState *env;
-
-    env =3D opaque;
-#if 0
-    qemu_log("%s\n", __func__);
-#endif
-
-    if (env->CP0_Cause & (1 << CP0Ca_DC))
-        return;
-
-    /* ??? This callback should occur when the counter is exactly equal =
to
-       the comparator value.  Offset the count by one to avoid immediate=
ly
-       retriggering the callback before any virtual time has passed.  */
-    env->CP0_Count++;
-    cpu_mips_timer_expire(env);
-    env->CP0_Count--;
-}
-
-void cpu_mips_clock_init (MIPSCPU *cpu)
-{
-    CPUMIPSState *env =3D &cpu->env;
-
-    /*
-     * If we're in KVM mode, don't create the periodic timer, that is ha=
ndled in
-     * kernel.
-     */
-    if (!kvm_enabled()) {
-        env->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &mips_timer_cb, =
env);
-    }
-}
diff --git a/target/mips/Makefile.objs b/target/mips/Makefile.objs
index bc5ed85..651f36f 100644
--- a/target/mips/Makefile.objs
+++ b/target/mips/Makefile.objs
@@ -1,4 +1,4 @@
 obj-y +=3D translate.o dsp_helper.o op_helper.o lmi_helper.o helper.o cp=
u.o
 obj-y +=3D gdbstub.o msa_helper.o mips-semi.o
-obj-$(CONFIG_SOFTMMU) +=3D machine.o
+obj-$(CONFIG_SOFTMMU) +=3D machine.o cp0_timer.o
 obj-$(CONFIG_KVM) +=3D kvm.o
diff --git a/target/mips/cp0_timer.c b/target/mips/cp0_timer.c
new file mode 100644
index 0000000..a9a58c5
--- /dev/null
+++ b/target/mips/cp0_timer.c
@@ -0,0 +1,164 @@
+/*
+ * QEMU MIPS timer support
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/mips/cpudevs.h"
+#include "qemu/timer.h"
+#include "sysemu/kvm.h"
+
+#define TIMER_PERIOD 10 /* 10 ns period for 100 Mhz frequency */
+
+/* XXX: do not use a global */
+uint32_t cpu_mips_get_random (CPUMIPSState *env)
+{
+    static uint32_t seed =3D 1;
+    static uint32_t prev_idx =3D 0;
+    uint32_t idx;
+    uint32_t nb_rand_tlb =3D env->tlb->nb_tlb - env->CP0_Wired;
+
+    if (nb_rand_tlb =3D=3D 1) {
+        return env->tlb->nb_tlb - 1;
+    }
+
+    /* Don't return same value twice, so get another value */
+    do {
+        /* Use a simple algorithm of Linear Congruential Generator
+         * from ISO/IEC 9899 standard. */
+        seed =3D 1103515245 * seed + 12345;
+        idx =3D (seed >> 16) % nb_rand_tlb + env->CP0_Wired;
+    } while (idx =3D=3D prev_idx);
+    prev_idx =3D idx;
+    return idx;
+}
+
+/* MIPS R4K timer */
+static void cpu_mips_timer_update(CPUMIPSState *env)
+{
+    uint64_t now, next;
+    uint32_t wait;
+
+    now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    wait =3D env->CP0_Compare - env->CP0_Count - (uint32_t)(now / TIMER_=
PERIOD);
+    next =3D now + (uint64_t)wait * TIMER_PERIOD;
+    timer_mod(env->timer, next);
+}
+
+/* Expire the timer.  */
+static void cpu_mips_timer_expire(CPUMIPSState *env)
+{
+    cpu_mips_timer_update(env);
+    if (env->insn_flags & ISA_MIPS32R2) {
+        env->CP0_Cause |=3D 1 << CP0Ca_TI;
+    }
+    qemu_irq_raise(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
+}
+
+uint32_t cpu_mips_get_count (CPUMIPSState *env)
+{
+    if (env->CP0_Cause & (1 << CP0Ca_DC)) {
+        return env->CP0_Count;
+    } else {
+        uint64_t now;
+
+        now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        if (timer_pending(env->timer)
+            && timer_expired(env->timer, now)) {
+            /* The timer has already expired.  */
+            cpu_mips_timer_expire(env);
+        }
+
+        return env->CP0_Count + (uint32_t)(now / TIMER_PERIOD);
+    }
+}
+
+void cpu_mips_store_count (CPUMIPSState *env, uint32_t count)
+{
+    /*
+     * This gets called from cpu_state_reset(), potentially before timer=
 init.
+     * So env->timer may be NULL, which is also the case with KVM enable=
d so
+     * treat timer as disabled in that case.
+     */
+    if (env->CP0_Cause & (1 << CP0Ca_DC) || !env->timer)
+        env->CP0_Count =3D count;
+    else {
+        /* Store new count register */
+        env->CP0_Count =3D count -
+               (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_=
PERIOD);
+        /* Update timer timer */
+        cpu_mips_timer_update(env);
+    }
+}
+
+void cpu_mips_store_compare (CPUMIPSState *env, uint32_t value)
+{
+    env->CP0_Compare =3D value;
+    if (!(env->CP0_Cause & (1 << CP0Ca_DC)))
+        cpu_mips_timer_update(env);
+    if (env->insn_flags & ISA_MIPS32R2)
+        env->CP0_Cause &=3D ~(1 << CP0Ca_TI);
+    qemu_irq_lower(env->irq[(env->CP0_IntCtl >> CP0IntCtl_IPTI) & 0x7]);
+}
+
+void cpu_mips_start_count(CPUMIPSState *env)
+{
+    cpu_mips_store_count(env, env->CP0_Count);
+}
+
+void cpu_mips_stop_count(CPUMIPSState *env)
+{
+    /* Store the current value */
+    env->CP0_Count +=3D (uint32_t)(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 /
+                                 TIMER_PERIOD);
+}
+
+static void mips_timer_cb (void *opaque)
+{
+    CPUMIPSState *env;
+
+    env =3D opaque;
+#if 0
+    qemu_log("%s\n", __func__);
+#endif
+
+    if (env->CP0_Cause & (1 << CP0Ca_DC))
+        return;
+
+    /* ??? This callback should occur when the counter is exactly equal =
to
+       the comparator value.  Offset the count by one to avoid immediate=
ly
+       retriggering the callback before any virtual time has passed.  */
+    env->CP0_Count++;
+    cpu_mips_timer_expire(env);
+    env->CP0_Count--;
+}
+
+void cpu_mips_clock_init (MIPSCPU *cpu)
+{
+    CPUMIPSState *env =3D &cpu->env;
+
+    /*
+     * If we're in KVM mode, don't create the periodic timer, that is ha=
ndled in
+     * kernel.
+     */
+    if (!kvm_enabled()) {
+        env->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &mips_timer_cb, =
env);
+    }
+}
--=20
2.7.4
