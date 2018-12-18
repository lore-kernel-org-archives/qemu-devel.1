Received: from eggs.gnu.org ([2001:4830:134:3::10]:53105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92z-0001kN-Rc
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZ92t-0002ug-J8
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:40:05 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZ92s-0002nX-SC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 01:39:59 -0500
Received: by mail-pg1-x544.google.com with SMTP id s198so7352692pgs.2
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 22:39:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 17 Dec 2018 22:39:07 -0800
Message-Id: <20181218063911.2112-31-richard.henderson@linaro.org>
In-Reply-To: <20181218063911.2112-1-richard.henderson@linaro.org>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 30/34] target/ppc: Use mtvscr/mfvscr for vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

This is required before changing the representation of the register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/machine.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 451cf376b4..3c27a89166 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -10,6 +10,7 @@
 #include "migration/cpu.h"
 #include "qapi/error.h"
 #include "kvm_ppc.h"
+#include "exec/helper-proto.h"
 
 static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
 {
@@ -17,7 +18,7 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
     CPUPPCState *env = &cpu->env;
     unsigned int i, j;
     target_ulong sdr1;
-    uint32_t fpscr;
+    uint32_t fpscr, vscr;
 #if defined(TARGET_PPC64)
     int32_t slb_nr;
 #endif
@@ -84,7 +85,8 @@ static int cpu_load_old(QEMUFile *f, void *opaque, int version_id)
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
 
+static int get_vscr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field)
+{
+    PowerPCCPU *cpu = opaque;
+    helper_mtvscr(&cpu->env, qemu_get_be32(f));
+    return 0;
+}
+
+static int put_vscr(QEMUFile *f, void *opaque, size_t size,
+                    const VMStateField *field, QJSON *vmdesc)
+{
+    PowerPCCPU *cpu = opaque;
+    qemu_put_be32(f, helper_mfvscr(&cpu->env));
+    return 0;
+}
+
+static const VMStateInfo vmstate_vscr = {
+    .name = "cpu/altivec/vscr",
+    .get = get_vscr,
+    .put = put_vscr,
+};
+
 static const VMStateDescription vmstate_altivec = {
     .name = "cpu/altivec",
     .version_id = 1,
@@ -436,7 +460,21 @@ static const VMStateDescription vmstate_altivec = {
     .needed = altivec_needed,
     .fields = (VMStateField[]) {
         VMSTATE_AVR_ARRAY(env.vsr, PowerPCCPU, 32),
-        VMSTATE_UINT32(env.vscr, PowerPCCPU),
+        /*
+         * Save the architecture value of the vscr, not the internally
+         * expanded version.  Since this architecture value does not
+         * exist in memory to be stored, this requires a but of hoop
+         * jumping.  We want OFFSET=0 so that we effectively pass CPU
+         * to the helper functions.
+         */
+        {
+            .name = "vscr",
+            .version_id = 0,
+            .size = sizeof(uint32_t),
+            .info = &vmstate_vscr,
+            .flags = VMS_SINGLE,
+            .offset = 0
+        },
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.17.2
