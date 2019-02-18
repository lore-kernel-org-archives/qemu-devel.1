Received: from eggs.gnu.org ([209.51.188.92]:39627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjyF-0006qy-Ro
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxx-0003Gx-Gg
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:27 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:45 +1100
Message-Id: <20190218143049.17142-40-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 39/43] target/ppc: Use mtvscr/mfvscr for vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Richard Henderson <richard.henderson@linaro.org>

This is required before changing the representation of the register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215100058.20015-14-mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/machine.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index eff30053b0..756b6d2971 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -10,6 +10,7 @@
 #include "migration/cpu.h"
 #include "qapi/error.h"
 #include "kvm_ppc.h"
+#include "exec/helper-proto.h"
=20
 static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
 {
@@ -17,7 +18,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int =
version_id)
     CPUPPCState *env =3D &cpu->env;
     unsigned int i, j;
     target_ulong sdr1;
-    uint32_t fpscr;
+    uint32_t fpscr, vscr;
 #if defined(TARGET_PPC64)
     int32_t slb_nr;
 #endif
@@ -84,7 +85,8 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int =
version_id)
     if (!cpu->vhyp) {
         ppc_store_sdr1(env, sdr1);
     }
-    qemu_get_be32s(f, &env->vscr);
+    qemu_get_be32s(f, &vscr);
+    helper_mtvscr(env, vscr);
     qemu_get_be64s(f, &env->spe_acc);
     qemu_get_be32s(f, &env->spe_fscr);
     qemu_get_betls(f, &env->msr_mask);
@@ -429,6 +431,28 @@ static bool altivec_needed(void *opaque)
     return (cpu->env.insns_flags & PPC_ALTIVEC);
 }
=20
+static int get_vscr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field)
+{
+    PowerPCCPU *cpu =3D opaque;
+    helper_mtvscr(&cpu->env, qemu_get_be32(f));
+    return 0;
+}
+
+static int put_vscr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, QJSON *vmdesc)
+{
+    PowerPCCPU *cpu =3D opaque;
+    qemu_put_be32(f, helper_mfvscr(&cpu->env));
+    return 0;
+}
+
+static const VMStateInfo vmstate_vscr =3D {
+    .name =3D "cpu/altivec/vscr",
+    .get =3D get_vscr,
+    .put =3D put_vscr,
+};
+
 static const VMStateDescription vmstate_altivec =3D {
     .name =3D "cpu/altivec",
     .version_id =3D 1,
@@ -436,7 +460,21 @@ static const VMStateDescription vmstate_altivec =3D =
{
     .needed =3D altivec_needed,
     .fields =3D (VMStateField[]) {
         VMSTATE_AVR_ARRAY(env.vsr, PowerPCCPU, 32),
-        VMSTATE_UINT32(env.vscr, PowerPCCPU),
+        /*
+         * Save the architecture value of the vscr, not the internally
+         * expanded version.  Since this architecture value does not
+         * exist in memory to be stored, this requires a but of hoop
+         * jumping.  We want OFFSET=3D0 so that we effectively pass CPU
+         * to the helper functions.
+         */
+        {
+            .name =3D "vscr",
+            .version_id =3D 0,
+            .size =3D sizeof(uint32_t),
+            .info =3D &vmstate_vscr,
+            .flags =3D VMS_SINGLE,
+            .offset =3D 0
+        },
         VMSTATE_END_OF_LIST()
     },
 };
--=20
2.20.1
