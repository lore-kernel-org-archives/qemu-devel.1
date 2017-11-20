Received: from eggs.gnu.org ([2001:4830:134:3::10]:45854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eGiw7-0000kM-Uc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eGiw1-0001hW-6p
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:19 -0500
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:49115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eGiw0-0001Zf-V7
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:04:13 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id C706C88A27
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 11:04:04 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 20 Nov 2017 11:03:45 +0100
Message-Id: <20171120100347.8601-2-clg@kaod.org>
In-Reply-To: <20171120100347.8601-1-clg@kaod.org>
References: <20171120100347.8601-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.12 v3 1/3] spapr/rtas: disable the
 decrementer interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

When a CPU is stopped with the 'stop-self' RTAS call, its state
'halted' is switched to 1 and, in this case, the MSR is not taken into
account anymore in the cpu_has_work() routine. Only the pending
hardware interrupts are checked with their LPCR:PECE* enablement bit.

If the DECR timer fires after 'stop-self' is called and before the CPU
'stop' state is reached, the nearly-dead CPU will have some work to do
and the guest will crash. This case happens very frequently with the
not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
occasionally fired but after 'stop' state, so no work is to be done
and the guest survives.

I suspect there is a race between the QEMU mainloop triggering the
timers and the TCG CPU thread but I could not quite identify the root
cause. To be safe, let's disable in the LPCR all the exceptions which
can cause an exit while the CPU is in power-saving mode and reenable
them when the CPU is started.

For this purpose, we introduce a little helper routine to calculate
the PECE bits for a processor variant. We could also use the mask
value LPCR_PECE_L_MASK for the P8 and P9 processors. bit 47 and 48 are
reserved on P7 but it is still compatible.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

Changes in v3:

 - introduced a cpu_ppc_papr_pece_bits() helper to gather the PECE
   bits depending on the CPU family.  =20
 - enabled Power-saving mode Exit Cause exceptions only on the boot CPU.
=20
Changes in v2:

 - used a new routine ppc_cpu_pvr_match() to discriminate CPU versions
 - removed the LPCR:PECE* enablement bit when the CPU is initialized
   if it is a secondary

 hw/ppc/spapr_rtas.c         |  9 +++++++++
 target/ppc/cpu.h            |  1 +
 target/ppc/translate_init.c | 33 +++++++++++++++++++++++++--------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index cdf0b607a0a0..b5cff3ab29d3 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -174,6 +174,10 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMa=
chineState *spapr,
         kvm_cpu_synchronize_state(cs);
=20
         env->msr =3D (1ULL << MSR_SF) | (1ULL << MSR_ME);
+
+        /* Enable Power-saving mode Exit Cause exceptions for the new CP=
U */
+        env->spr[SPR_LPCR] |=3D cpu_ppc_papr_pece_bits(env);
+
         env->nip =3D start;
         env->gpr[3] =3D r3;
         cs->halted =3D 0;
@@ -210,6 +214,11 @@ static void rtas_stop_self(PowerPCCPU *cpu, sPAPRMac=
hineState *spapr,
      * no need to bother with specific bits, we just clear it.
      */
     env->msr =3D 0;
+
+    /* Disable Power-saving mode Exit Cause exceptions for the CPU.
+     * This could deliver an interrupt on a dying CPU and crash the
+     * guest */
+    env->spr[SPR_LPCR] &=3D ~cpu_ppc_papr_pece_bits(env);
 }
=20
 static inline int sysparm_st(target_ulong addr, target_ulong len,
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 989761b79569..7c84344421f3 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1327,6 +1327,7 @@ void store_booke_tsr (CPUPPCState *env, target_ulon=
g val);
 void ppc_tlb_invalidate_all (CPUPPCState *env);
 void ppc_tlb_invalidate_one (CPUPPCState *env, target_ulong addr);
 void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp);
+target_ulong cpu_ppc_papr_pece_bits(CPUPPCState *env);
 #endif
 #endif
=20
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index b9c49c22f29f..a0bf5e01dc52 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8901,11 +8901,28 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *dat=
a)
 }
=20
 #if !defined(CONFIG_USER_ONLY)
+
+target_ulong cpu_ppc_papr_pece_bits(CPUPPCState *env)
+{
+    switch (env->mmu_model) {
+    case POWERPC_MMU_3_00:
+        return LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
+    default:
+        /* P7 and P8 has slightly different PECE bits, mostly because P8=
 adds
+         * bit 47 and 48 which are reserved on P7. Here we set them all,=
 which
+         * will work as expected for both implementations
+         */
+        return LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 | LPCR_P8_P=
ECE3 |
+            LPCR_P8_PECE4;
+    }
+}
+
 void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
 {
     CPUPPCState *env =3D &cpu->env;
     ppc_spr_t *lpcr =3D &env->spr_cb[SPR_LPCR];
     ppc_spr_t *amor =3D &env->spr_cb[SPR_AMOR];
+    CPUState *cs =3D CPU(cpu);
=20
     cpu->vhyp =3D vhyp;
=20
@@ -8947,16 +8964,16 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtual=
Hypervisor *vhyp)
         } else {
             lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
         }
-        lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
-                               LPCR_OEE;
         break;
     default:
-        /* P7 and P8 has slightly different PECE bits, mostly because P8=
 adds
-         * bit 47 and 48 which are reserved on P7. Here we set them all,=
 which
-         * will work as expected for both implementations
-         */
-        lpcr->default_value |=3D LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8=
_PECE2 |
-                               LPCR_P8_PECE3 | LPCR_P8_PECE4;
+        ;
+    }
+
+    /* Only enable Power-saving mode Exit Cause exceptions on the boot
+     * CPU. The RTAS command start-cpu will enable them on secondaries.
+     */
+    if (cs =3D=3D first_cpu) {
+        lpcr->default_value |=3D cpu_ppc_papr_pece_bits(env);
     }
=20
     /* We should be followed by a CPU reset but update the active value
--=20
2.13.6
