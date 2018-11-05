Received: from eggs.gnu.org ([2001:4830:134:3::10]:46548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gJjyo-0004c1-Vh
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gJjyn-0000Xf-49
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:52:06 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Mon, 5 Nov 2018 18:51:53 +0000
Message-ID: <20181105185046.2802-4-aaron@os.amperecomputing.com>
References: <20181105185046.2802-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181105185046.2802-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v7 03/12] target/arm: Swap PMU values
 before/after migrations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>, Aaron Lindsay <aclindsa@gmail.com>

Because of the PMU's design, many register accesses have side effects
which are inter-related, meaning that the normal method of saving CP
registers can result in inconsistent state. These side-effects are
largely handled in pmu_op_start/finish functions which can be called
before and after the state is saved/restored. By doing this and adding
raw read/write functions for the affected registers, we avoid
migration-related inconsistencies.

Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
---
 target/arm/helper.c  |  6 ++++--
 target/arm/machine.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 281bcff1da..5deff3d11f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1450,11 +1450,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] =3D {
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 13, .opc2 =3D 0,
       .access =3D PL0_RW, .accessfn =3D pmreg_access_ccntr,
       .type =3D ARM_CP_IO,
-      .readfn =3D pmccntr_read, .writefn =3D pmccntr_write, },
+      .fieldoffset =3D offsetof(CPUARMState, cp15.c15_ccnt),
+      .readfn =3D pmccntr_read, .writefn =3D pmccntr_write,
+      .raw_readfn =3D raw_read, .raw_writefn =3D raw_write, },
 #endif
     { .name =3D "PMCCFILTR_EL0", .state =3D ARM_CP_STATE_AA64,
       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 15, .opc2 =3D 7,
-      .writefn =3D pmccfiltr_write,
+      .writefn =3D pmccfiltr_write, .raw_writefn =3D raw_write,
       .access =3D PL0_RW, .accessfn =3D pmreg_access,
       .type =3D ARM_CP_IO,
       .fieldoffset =3D offsetof(CPUARMState, cp15.pmccfiltr_el0),
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 239fe4e84d..6d14b08e0c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -604,6 +604,8 @@ static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu =3D opaque;
=20
+    pmu_op_start(&cpu->env);
+
     if (kvm_enabled()) {
         if (!write_kvmstate_to_list(cpu)) {
             /* This should never fail */
@@ -625,6 +627,20 @@ static int cpu_pre_save(void *opaque)
     return 0;
 }
=20
+static int cpu_post_save(void *opaque)
+{
+    ARMCPU *cpu =3D opaque;
+    pmu_op_finish(&cpu->env);
+    return 0;
+}
+
+static int cpu_pre_load(void *opaque)
+{
+    ARMCPU *cpu =3D opaque;
+    pmu_op_start(&cpu->env);
+    return 0;
+}
+
 static int cpu_post_load(void *opaque, int version_id)
 {
     ARMCPU *cpu =3D opaque;
@@ -672,6 +688,8 @@ static int cpu_post_load(void *opaque, int version_id)
     hw_breakpoint_update_all(cpu);
     hw_watchpoint_update_all(cpu);
=20
+    pmu_op_finish(&cpu->env);
+
     return 0;
 }
=20
@@ -680,6 +698,8 @@ const VMStateDescription vmstate_arm_cpu =3D {
     .version_id =3D 22,
     .minimum_version_id =3D 22,
     .pre_save =3D cpu_pre_save,
+    .post_save =3D cpu_post_save,
+    .pre_load =3D cpu_pre_load,
     .post_load =3D cpu_post_load,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(env.regs, ARMCPU, 16),
--=20
2.19.1
