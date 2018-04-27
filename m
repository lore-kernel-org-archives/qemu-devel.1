Received: from eggs.gnu.org ([2001:4830:134:3::10]:59795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaW-00027n-EE
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaV-0002HK-37
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:19 +1000
Message-Id: <20180427092126.24812-43-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 42/49] target/ppc: Get rid of POWERPC_MMU_VER()
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

These macros were introduced to deal with the fact that the mmu_model
field has bit flags mixed in with what's otherwise an enum of various mmu
types.

We've now eliminated all those flags except for one, and that one -
POWERPC_MMU_64 - is already included/compared in the MMU_VER macros.  So,
we can get rid of those macros and just directly compare mmu_model values
in the places it was used.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/cpu-qom.h    |  6 ------
 target/ppc/kvm.c        |  8 ++++----
 target/ppc/mmu-hash64.c | 12 ++++++------
 target/ppc/mmu_helper.c | 24 ++++++++++++------------
 target/ppc/translate.c  | 12 ++++++------
 5 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index ef96d42cf2..433a71e484 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -79,12 +79,6 @@ enum powerpc_mmu_t {
     /* Architecture 3.00 variant                               */
     POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | 0x00000005,
 };
-#define POWERPC_MMU_VER(x) ((x) & (POWERPC_MMU_64 | 0xFFFF))
-#define POWERPC_MMU_VER_64B POWERPC_MMU_VER(POWERPC_MMU_64B)
-#define POWERPC_MMU_VER_2_03 POWERPC_MMU_VER(POWERPC_MMU_2_03)
-#define POWERPC_MMU_VER_2_06 POWERPC_MMU_VER(POWERPC_MMU_2_06)
-#define POWERPC_MMU_VER_2_07 POWERPC_MMU_VER(POWERPC_MMU_2_07)
-#define POWERPC_MMU_VER_3_00 POWERPC_MMU_VER(POWERPC_MMU_3_00)
=20
 /***********************************************************************=
******/
 /* Exception model                                                      =
     */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25f93dc708..246b9eab2a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -306,8 +306,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
u,
             info->flags |=3D KVM_PPC_1T_SEGMENTS;
         }
=20
-        if (POWERPC_MMU_VER(env->mmu_model) =3D=3D POWERPC_MMU_VER_2_06 =
||
-           POWERPC_MMU_VER(env->mmu_model) =3D=3D POWERPC_MMU_VER_2_07) =
{
+        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
+            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
             info->slb_size =3D 32;
         } else {
             info->slb_size =3D 64;
@@ -321,8 +321,8 @@ static void kvm_get_fallback_smmu_info(PowerPCCPU *cp=
u,
         i++;
=20
         /* 64K on MMU 2.06 and later */
-        if (POWERPC_MMU_VER(env->mmu_model) =3D=3D POWERPC_MMU_VER_2_06 =
||
-            POWERPC_MMU_VER(env->mmu_model) =3D=3D POWERPC_MMU_VER_2_07)=
 {
+        if (env->mmu_model =3D=3D POWERPC_MMU_2_06 ||
+            env->mmu_model =3D=3D POWERPC_MMU_2_07) {
             info->sps[i].page_shift =3D 16;
             info->sps[i].slb_enc =3D 0x110;
             info->sps[i].enc[0].page_shift =3D 16;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index df26a03c15..a5570c8774 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1033,8 +1033,8 @@ void helper_store_lpcr(CPUPPCState *env, target_ulo=
ng val)
     uint64_t lpcr =3D 0;
=20
     /* Filter out bits */
-    switch (POWERPC_MMU_VER(env->mmu_model)) {
-    case POWERPC_MMU_VER_64B: /* 970 */
+    switch (env->mmu_model) {
+    case POWERPC_MMU_64B: /* 970 */
         if (val & 0x40) {
             lpcr |=3D LPCR_LPES0;
         }
@@ -1060,26 +1060,26 @@ void helper_store_lpcr(CPUPPCState *env, target_u=
long val)
          * to dig HRMOR out of HID5
          */
         break;
-    case POWERPC_MMU_VER_2_03: /* P5p */
+    case POWERPC_MMU_2_03: /* P5p */
         lpcr =3D val & (LPCR_RMLS | LPCR_ILE |
                       LPCR_LPES0 | LPCR_LPES1 |
                       LPCR_RMI | LPCR_HDICE);
         break;
-    case POWERPC_MMU_VER_2_06: /* P7 */
+    case POWERPC_MMU_2_06: /* P7 */
         lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_DPFD |
                       LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
                       LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2 |
                       LPCR_MER | LPCR_TC |
                       LPCR_LPES0 | LPCR_LPES1 | LPCR_HDICE);
         break;
-    case POWERPC_MMU_VER_2_07: /* P8 */
+    case POWERPC_MMU_2_07: /* P8 */
         lpcr =3D val & (LPCR_VPM0 | LPCR_VPM1 | LPCR_ISL | LPCR_KBV |
                       LPCR_DPFD | LPCR_VRMASD | LPCR_RMLS | LPCR_ILE |
                       LPCR_AIL | LPCR_ONL | LPCR_P8_PECE0 | LPCR_P8_PECE=
1 |
                       LPCR_P8_PECE2 | LPCR_P8_PECE3 | LPCR_P8_PECE4 |
                       LPCR_MER | LPCR_TC | LPCR_LPES0 | LPCR_HDICE);
         break;
-    case POWERPC_MMU_VER_3_00: /* P9 */
+    case POWERPC_MMU_3_00: /* P9 */
         lpcr =3D val & (LPCR_VPM1 | LPCR_ISL | LPCR_KBV | LPCR_DPFD |
                       (LPCR_PECE_U_MASK & LPCR_HVEE) | LPCR_ILE | LPCR_A=
IL |
                       LPCR_UPRT | LPCR_EVIRT | LPCR_ONL |
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 5568d1642b..8075b7149a 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -1266,7 +1266,7 @@ static void mmu6xx_dump_mmu(FILE *f, fprintf_functi=
on cpu_fprintf,
=20
 void dump_mmu(FILE *f, fprintf_function cpu_fprintf, CPUPPCState *env)
 {
-    switch (POWERPC_MMU_VER(env->mmu_model)) {
+    switch (env->mmu_model) {
     case POWERPC_MMU_BOOKE:
         mmubooke_dump_mmu(f, cpu_fprintf, env);
         break;
@@ -1278,13 +1278,13 @@ void dump_mmu(FILE *f, fprintf_function cpu_fprin=
tf, CPUPPCState *env)
         mmu6xx_dump_mmu(f, cpu_fprintf, env);
         break;
 #if defined(TARGET_PPC64)
-    case POWERPC_MMU_VER_64B:
-    case POWERPC_MMU_VER_2_03:
-    case POWERPC_MMU_VER_2_06:
-    case POWERPC_MMU_VER_2_07:
+    case POWERPC_MMU_64B:
+    case POWERPC_MMU_2_03:
+    case POWERPC_MMU_2_06:
+    case POWERPC_MMU_2_07:
         dump_slb(f, cpu_fprintf, ppc_env_get_cpu(env));
         break;
-    case POWERPC_MMU_VER_3_00:
+    case POWERPC_MMU_3_00:
         if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
             /* TODO - Unsupported */
         } else {
@@ -1423,14 +1423,14 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, =
vaddr addr)
     CPUPPCState *env =3D &cpu->env;
     mmu_ctx_t ctx;
=20
-    switch (POWERPC_MMU_VER(env->mmu_model)) {
+    switch (env->mmu_model) {
 #if defined(TARGET_PPC64)
-    case POWERPC_MMU_VER_64B:
-    case POWERPC_MMU_VER_2_03:
-    case POWERPC_MMU_VER_2_06:
-    case POWERPC_MMU_VER_2_07:
+    case POWERPC_MMU_64B:
+    case POWERPC_MMU_2_03:
+    case POWERPC_MMU_2_06:
+    case POWERPC_MMU_2_07:
         return ppc_hash64_get_phys_page_debug(cpu, addr);
-    case POWERPC_MMU_VER_3_00:
+    case POWERPC_MMU_3_00:
         if (ppc64_radix_guest(ppc_env_get_cpu(env))) {
             return ppc_radix64_get_phys_page_debug(cpu, addr);
         } else {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b0d79a3fb9..3beaa1e2f0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7121,17 +7121,17 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fp=
rintf_function cpu_fprintf,
     if (env->spr_cb[SPR_LPCR].name)
         cpu_fprintf(f, " LPCR " TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
=20
-    switch (POWERPC_MMU_VER(env->mmu_model)) {
+    switch (env->mmu_model) {
     case POWERPC_MMU_32B:
     case POWERPC_MMU_601:
     case POWERPC_MMU_SOFT_6xx:
     case POWERPC_MMU_SOFT_74xx:
 #if defined(TARGET_PPC64)
-    case POWERPC_MMU_VER_64B:
-    case POWERPC_MMU_VER_2_03:
-    case POWERPC_MMU_VER_2_06:
-    case POWERPC_MMU_VER_2_07:
-    case POWERPC_MMU_VER_3_00:
+    case POWERPC_MMU_64B:
+    case POWERPC_MMU_2_03:
+    case POWERPC_MMU_2_06:
+    case POWERPC_MMU_2_07:
+    case POWERPC_MMU_3_00:
 #endif
         if (env->spr_cb[SPR_SDR1].name) { /* SDR1 Exists */
             cpu_fprintf(f, " SDR1 " TARGET_FMT_lx " ", env->spr[SPR_SDR1=
]);
--=20
2.14.3
