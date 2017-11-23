Received: from eggs.gnu.org ([2001:4830:134:3::10]:50977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHuwV-0006Yp-K0
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHuwR-00085l-71
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:05:39 -0500
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:42064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHuwR-00084e-19
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:05:35 -0500
Received: from player797.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 8EDBB175AB9
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 18:05:33 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 23 Nov 2017 18:05:24 +0100
Message-Id: <20171123170524.3865-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] pcc: define the Power-saving mode Exit Cause
 Enable bits in PowerPCCPUClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

and use the value to define precisely the default value of the LPCR in
the helper routine cpu_ppc_set_papr()

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/cpu-qom.h        |  1 +
 target/ppc/translate_init.c | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index 429b47f959dc..deaa46a14b2e 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -191,6 +191,7 @@ typedef struct PowerPCCPUClass {
     uint64_t insns_flags;
     uint64_t insns_flags2;
     uint64_t msr_mask;
+    uint64_t lpcr_pm;           /* Power-saving mode Exit Cause Enable b=
its */
     powerpc_mmu_t   mmu_model;
     powerpc_excp_t  excp_model;
     powerpc_input_t bus_model;
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index b9c49c22f29f..828d7e778c3b 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8535,6 +8535,7 @@ POWERPC_FAMILY(POWER7)(ObjectClass *oc, void *data)
     pcc->l1_dcache_size =3D 0x8000;
     pcc->l1_icache_size =3D 0x8000;
     pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
+    pcc->lpcr_pm =3D LPCR_P7_PECE0 | LPCR_P7_PECE1 | LPCR_P7_PECE2;
 }
=20
 static void init_proc_POWER8(CPUPPCState *env)
@@ -8704,6 +8705,8 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->l1_dcache_size =3D 0x8000;
     pcc->l1_icache_size =3D 0x8000;
     pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
+    pcc->lpcr_pm =3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 |
+                   LPCR_P8_PECE3 | LPCR_P8_PECE4;
 }
=20
 #ifdef CONFIG_SOFTMMU
@@ -8898,11 +8901,13 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *dat=
a)
     pcc->l1_dcache_size =3D 0x8000;
     pcc->l1_icache_size =3D 0x8000;
     pcc->interrupts_big_endian =3D ppc_cpu_interrupts_big_endian_lpcr;
+    pcc->lpcr_pm =3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_=
OEE;
 }
=20
 #if !defined(CONFIG_USER_ONLY)
 void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env =3D &cpu->env;
     ppc_spr_t *lpcr =3D &env->spr_cb[SPR_LPCR];
     ppc_spr_t *amor =3D &env->spr_cb[SPR_AMOR];
@@ -8932,8 +8937,7 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHy=
pervisor *vhyp)
     lpcr->default_value &=3D ~LPCR_RMLS;
     lpcr->default_value |=3D 1ull << LPCR_RMLS_SHIFT;
=20
-    switch (env->mmu_model) {
-    case POWERPC_MMU_3_00:
+    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
         /* By default we choose legacy mode and switch to new hash or ra=
dix
          * when a register process table hcall is made. So disable proce=
ss
          * tables and guest translation shootdown by default
@@ -8947,18 +8951,13 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtual=
Hypervisor *vhyp)
         } else {
             lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
         }
-        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
-                               LPCR_OEE;
-        break;
-    default:
-        /* P7 and P8 has slightly different PECE bits, mostly because P8=
 adds
-         * bit 47 and 48 which are reserved on P7. Here we set them all,=
 which
-         * will work as expected for both implementations
-         */
-        lpcr->default_value |=3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8=
_PECE2 |
-                               LPCR_P8_PECE3 | LPCR_P8_PECE4;
     }
=20
+    /* Also set the power-saving mode bits which depend on the CPU
+     * family
+     */
+    lpcr->default_value |=3D pcc->lpcr_pm;
+
     /* We should be followed by a CPU reset but update the active value
      * just in case...
      */
--=20
2.13.6
