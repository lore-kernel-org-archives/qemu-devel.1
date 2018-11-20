Received: from eggs.gnu.org ([2001:4830:134:3::10]:58050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gPDXz-0000Mf-74
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:27:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaron@os.amperecomputing.com>) id 1gPDXr-00061Q-4V
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 16:26:59 -0500
From: Aaron Lindsay <aaron@os.amperecomputing.com>
Date: Tue, 20 Nov 2018 21:26:40 +0000
Message-ID: <20181120212553.8480-8-aaron@os.amperecomputing.com>
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
In-Reply-To: <20181120212553.8480-1-aaron@os.amperecomputing.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v8 07/13] target-arm: Make PMCEID[01]_EL0 64
 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aaron@os.amperecomputing.com>

Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
---
 target/arm/cpu.h    |  4 ++--
 target/arm/helper.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 627e5c1995..50de58e4a2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -837,8 +837,8 @@ struct ARMCPU {
     uint32_t id_pfr0;
     uint32_t id_pfr1;
     uint32_t id_dfr0;
-    uint32_t pmceid0;
-    uint32_t pmceid1;
+    uint64_t pmceid0;
+    uint64_t pmceid1;
     uint32_t id_afr0;
     uint32_t id_mmfr0;
     uint32_t id_mmfr1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 71be6fb578..75f054fe79 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5432,7 +5432,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name =3D "PMCEID0", .state =3D ARM_CP_STATE_AA32,
               .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 12, .opc2 =3D =
6,
               .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D ARM=
_CP_CONST,
-              .resetvalue =3D cpu->pmceid0 },
+              .resetvalue =3D extract64(cpu->pmceid0, 0, 32) },
+            { .name =3D "PMCEID2", .state =3D ARM_CP_STATE_AA32,
+              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =3D =
4,
+              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D ARM=
_CP_CONST,
+              .resetvalue =3D extract64(cpu->pmceid0, 32, 32) },
             { .name =3D "PMCEID0_EL0", .state =3D ARM_CP_STATE_AA64,
               .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2 =3D=
 6,
               .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D ARM=
_CP_CONST,
@@ -5440,7 +5444,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             { .name =3D "PMCEID1", .state =3D ARM_CP_STATE_AA32,
               .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 12, .opc2 =3D =
7,
               .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D ARM=
_CP_CONST,
-              .resetvalue =3D cpu->pmceid1 },
+              .resetvalue =3D extract64(cpu->pmceid1, 0, 32) },
+            { .name =3D "PMCEID3", .state =3D ARM_CP_STATE_AA32,
+              .cp =3D 15, .opc1 =3D 0, .crn =3D 9, .crm =3D 14, .opc2 =3D =
5,
+              .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D ARM=
_CP_CONST,
+              .resetvalue =3D extract64(cpu->pmceid1, 32, 32) },
             { .name =3D "PMCEID1_EL0", .state =3D ARM_CP_STATE_AA64,
               .opc0 =3D 3, .opc1 =3D 3, .crn =3D 9, .crm =3D 12, .opc2 =3D=
 7,
               .access =3D PL0_R, .accessfn =3D pmreg_access, .type =3D ARM=
_CP_CONST,
--=20
2.19.1
