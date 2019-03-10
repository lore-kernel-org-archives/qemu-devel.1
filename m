Received: from eggs.gnu.org ([209.51.188.92]:42524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tns-0000hX-Nn
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnr-00018d-25
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:10 +1100
Message-Id: <20190310082703.1245-8-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/60] target/ppc: Implement large decrementer
 support for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Implement support to allow KVM guests to take advantage of the large
decrementer introduced on POWER9 cpus.

To determine if the host can support the requested large decrementer
size, we check it matches that specified in the ibm,dec-bits device-tree
property. We also need to enable it in KVM by setting the LPCR_LD bit in
the LPCR. Note that to do this we need to try and set the bit, then read
it back to check the host allowed us to set it, if so we can use it but
if we were unable to set it the host cannot support it and we must not
use the large decrementer.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190301024317.22137-3-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_caps.c  | 18 ++++++++++++++++--
 target/ppc/kvm.c     | 39 +++++++++++++++++++++++++++++++++++++++
 target/ppc/kvm_ppc.h | 12 ++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 9a34d1f4ed..1e76685199 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -394,6 +394,7 @@ static void cap_large_decr_apply(sPAPRMachineState *s=
papr,
                                  uint8_t val, Error **errp)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
+    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
=20
     if (!val)
         return; /* Disabled by default */
@@ -405,8 +406,16 @@ static void cap_large_decr_apply(sPAPRMachineState *=
spapr,
                 "Large decrementer only supported on POWER9, try -cpu PO=
WER9");
             return;
         }
-    } else {
-        error_setg(errp, "No large decrementer support, try cap-large-de=
cr=3Doff");
+    } else if (kvm_enabled()) {
+        int kvm_nr_bits =3D kvmppc_get_cap_large_decr();
+
+        if (!kvm_nr_bits) {
+            error_setg(errp, "No large decrementer support, try cap-larg=
e-decr=3Doff");
+        } else if (pcc->lrg_decr_bits !=3D kvm_nr_bits) {
+            error_setg(errp,
+"KVM large decrementer size (%d) differs to model (%d), try -cap-large-d=
ecr=3Doff",
+                kvm_nr_bits, pcc->lrg_decr_bits);
+        }
     }
 }
=20
@@ -417,6 +426,11 @@ static void cap_large_decr_cpu_apply(sPAPRMachineSta=
te *spapr,
     CPUPPCState *env =3D &cpu->env;
     target_ulong lpcr =3D env->spr[SPR_LPCR];
=20
+    if (kvm_enabled()) {
+        if (kvmppc_enable_cap_large_decr(cpu, val))
+            error_setg(errp, "No large decrementer support, try cap-larg=
e-decr=3Doff");
+    }
+
     if (val)
         lpcr |=3D LPCR_LD;
     else
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d01852fe31..3f650c8fc4 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -91,6 +91,7 @@ static int cap_ppc_safe_cache;
 static int cap_ppc_safe_bounds_check;
 static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_nested_kvm_hv;
+static int cap_large_decr;
=20
 static uint32_t debug_inst_opcode;
=20
@@ -124,6 +125,7 @@ static bool kvmppc_is_pr(KVMState *ks)
=20
 static int kvm_ppc_register_host_cpu_type(MachineState *ms);
 static void kvmppc_get_cpu_characteristics(KVMState *s);
+static int kvmppc_get_dec_bits(void);
=20
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
@@ -151,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     cap_resize_hpt =3D kvm_vm_check_extension(s, KVM_CAP_SPAPR_RESIZE_HP=
T);
     kvmppc_get_cpu_characteristics(s);
     cap_ppc_nested_kvm_hv =3D kvm_vm_check_extension(s, KVM_CAP_PPC_NEST=
ED_HV);
+    cap_large_decr =3D kvmppc_get_dec_bits();
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -1927,6 +1930,15 @@ uint64_t kvmppc_get_clockfreq(void)
     return kvmppc_read_int_cpu_dt("clock-frequency");
 }
=20
+static int kvmppc_get_dec_bits(void)
+{
+    int nr_bits =3D kvmppc_read_int_cpu_dt("ibm,dec-bits");
+
+    if (nr_bits > 0)
+        return nr_bits;
+    return 0;
+}
+
 static int kvmppc_get_pvinfo(CPUPPCState *env, struct kvm_ppc_pvinfo *pv=
info)
  {
      PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
@@ -2442,6 +2454,33 @@ bool kvmppc_has_cap_spapr_vfio(void)
     return cap_spapr_vfio;
 }
=20
+int kvmppc_get_cap_large_decr(void)
+{
+    return cap_large_decr;
+}
+
+int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable)
+{
+    CPUState *cs =3D CPU(cpu);
+    uint64_t lpcr;
+
+    kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+    /* Do we need to modify the LPCR? */
+    if (!!(lpcr & LPCR_LD) !=3D !!enable) {
+        if (enable)
+            lpcr |=3D LPCR_LD;
+        else
+            lpcr &=3D ~LPCR_LD;
+        kvm_set_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+        kvm_get_one_reg(cs, KVM_REG_PPC_LPCR_64, &lpcr);
+
+        if (!!(lpcr & LPCR_LD) !=3D !!enable)
+            return -1;
+    }
+
+    return 0;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr =3D mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index bdfaa4e70a..a79835bd14 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -64,6 +64,8 @@ int kvmppc_get_cap_safe_bounds_check(void);
 int kvmppc_get_cap_safe_indirect_branch(void);
 bool kvmppc_has_cap_nested_kvm_hv(void);
 int kvmppc_set_cap_nested_kvm_hv(int enable);
+int kvmppc_get_cap_large_decr(void);
+int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -332,6 +334,16 @@ static inline int kvmppc_set_cap_nested_kvm_hv(int e=
nable)
     return -1;
 }
=20
+static inline int kvmppc_get_cap_large_decr(void)
+{
+    return 0;
+}
+
+static inline int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enab=
le)
+{
+    return -1;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
--=20
2.20.1
