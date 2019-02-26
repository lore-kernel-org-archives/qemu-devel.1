Received: from eggs.gnu.org ([209.51.188.92]:57621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkj-0004tp-H1
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkh-0002BV-Nv
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:20 +1100
Message-Id: <20190226045304.25618-7-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/50] target/ppc: Add POWER9 exception model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

And use it to get the correct HILE bit in HID0

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190215161648.9600-7-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-qom.h            |  2 ++
 target/ppc/excp_helper.c        | 17 +++++++++++++----
 target/ppc/translate.c          |  3 ++-
 target/ppc/translate_init.inc.c |  2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index e9cb158423..904ee694ac 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -113,6 +113,8 @@ enum powerpc_excp_t {
     POWERPC_EXCP_POWER7,
     /* POWER8 exception model           */
     POWERPC_EXCP_POWER8,
+    /* POWER9 exception model           */
+    POWERPC_EXCP_POWER9,
 };
=20
 /***********************************************************************=
******/
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 7536620a41..37546bb0f0 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -147,7 +147,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
=20
     /* Exception targetting modifiers
      *
-     * LPES0 is supported on POWER7/8
+     * LPES0 is supported on POWER7/8/9
      * LPES1 is not supported (old iSeries mode)
      *
      * On anything else, we behave as if LPES0 is 1
@@ -158,9 +158,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
      */
 #if defined(TARGET_PPC64)
     if (excp_model =3D=3D POWERPC_EXCP_POWER7 ||
-        excp_model =3D=3D POWERPC_EXCP_POWER8) {
+        excp_model =3D=3D POWERPC_EXCP_POWER8 ||
+        excp_model =3D=3D POWERPC_EXCP_POWER9) {
         lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
-        if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
+        if (excp_model !=3D POWERPC_EXCP_POWER7) {
             ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
         } else {
             ail =3D 0;
@@ -662,7 +663,15 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
         }
     } else if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
         if (new_msr & MSR_HVB) {
-            if (env->spr[SPR_HID0] & (HID0_HILE | HID0_POWER9_HILE)) {
+            if (env->spr[SPR_HID0] & HID0_HILE) {
+                new_msr |=3D (target_ulong)1 << MSR_LE;
+            }
+        } else if (env->spr[SPR_LPCR] & LPCR_ILE) {
+            new_msr |=3D (target_ulong)1 << MSR_LE;
+        }
+    } else if (excp_model =3D=3D POWERPC_EXCP_POWER9) {
+        if (new_msr & MSR_HVB) {
+            if (env->spr[SPR_HID0] & HID0_POWER9_HILE) {
                 new_msr |=3D (target_ulong)1 << MSR_LE;
             }
         } else if (env->spr[SPR_LPCR] & LPCR_ILE) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fde7ead7b7..819221f246 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7481,7 +7481,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
=20
 #if defined(TARGET_PPC64)
     if (env->excp_model =3D=3D POWERPC_EXCP_POWER7 ||
-        env->excp_model =3D=3D POWERPC_EXCP_POWER8) {
+        env->excp_model =3D=3D POWERPC_EXCP_POWER8 ||
+        env->excp_model =3D=3D POWERPC_EXCP_POWER9)  {
         cpu_fprintf(f, "HSRR0 " TARGET_FMT_lx " HSRR1 " TARGET_FMT_lx "\=
n",
                     env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
     }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
index 8b1d324b3b..9909e58761 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -8905,7 +8905,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
     pcc->radix_page_info =3D &POWER9_radix_page_info;
 #endif
-    pcc->excp_model =3D POWERPC_EXCP_POWER8;
+    pcc->excp_model =3D POWERPC_EXCP_POWER9;
     pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
     pcc->bfd_mach =3D bfd_mach_ppc64;
     pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
--=20
2.20.1
