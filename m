Received: from eggs.gnu.org ([209.51.188.92]:38729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3Vt-0005aE-7q
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1go3Vm-0003Wf-Dy
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33754
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1go3Vk-00030G-RA
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:47:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0S9jEQo033928
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:58 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q9v2c06wy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:46:58 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Mon, 28 Jan 2019 09:46:56 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 28 Jan 2019 10:46:20 +0100
In-Reply-To: <20190128094625.4428-1-clg@kaod.org>
References: <20190128094625.4428-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190128094625.4428-15-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/19] target/ppc: Add POWER9 exception model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

And use it to get the correct HILE bit in HID0

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu-qom.h            |  2 ++
 target/ppc/excp_helper.c        | 17 +++++++++++++----
 target/ppc/translate.c          |  3 ++-
 target/ppc/translate_init.inc.c |  2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 7c54093a7122..7ff8b2d68632 100644
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
index 7536620a4133..37546bb0f0fe 100644
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
index 07bedbb8f1ce..62a9a57e4a65 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7483,7 +7483,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpri=
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
index f235162a1f6b..c1719c46a383 100644
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
