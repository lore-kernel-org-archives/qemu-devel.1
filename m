Received: from eggs.gnu.org ([209.51.188.92]:42586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnw-0000m2-EN
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tnr-00018m-2F
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:30 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:13 +1100
Message-Id: <20190310082703.1245-11-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/60] target/ppc/spapr: Add SPAPR_CAP_CCF_ASSIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Introduce a new spapr_cap SPAPR_CAP_CCF_ASSIST to be used to indicate
the requirement for a hw-assisted version of the count cache flush
workaround.

The count cache flush workaround is a software workaround which can be
used to flush the count cache on context switch. Some revisions of
hardware may have a hardware accelerated flush, in which case the
software flush can be shortened. This cap is used to set the
availability of such hardware acceleration for the count cache flush
routine.

The availability of such hardware acceleration is indicated by the
H_CPU_CHAR_BCCTR_FLUSH_ASSIST flag being set in the characteristics
returned from the KVM_PPC_GET_CPU_CHAR ioctl.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-Id: <20190301031912.28809-2-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 25 +++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c   |  3 +++
 include/hw/ppc/spapr.h |  5 ++++-
 target/ppc/kvm.c       | 14 ++++++++++++++
 target/ppc/kvm_ppc.h   |  6 ++++++
 6 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8e24d7dc50..37fd7a1411 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2097,6 +2097,7 @@ static const VMStateDescription vmstate_spapr =3D {
         &vmstate_spapr_cap_nested_kvm_hv,
         &vmstate_spapr_dtb,
         &vmstate_spapr_cap_large_decr,
+        &vmstate_spapr_cap_ccf_assist,
         NULL
     }
 };
@@ -4312,6 +4313,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB *=
/
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON=
;
+    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq =3D &spapr_irq_xics;
     smc->dr_phb_enabled =3D true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 74a48a423a..f03f2f64e7 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -436,6 +436,21 @@ static void cap_large_decr_cpu_apply(sPAPRMachineSta=
te *spapr,
     ppc_store_lpcr(cpu, lpcr);
 }
=20
+static void cap_ccf_assist_apply(sPAPRMachineState *spapr, uint8_t val,
+                                 Error **errp)
+{
+    uint8_t kvm_val =3D kvmppc_get_cap_count_cache_flush_assist();
+
+    if (tcg_enabled() && val) {
+        /* TODO - for now only allow broken for TCG */
+        error_setg(errp,
+"Requested count cache flush assist capability level not supported by tc=
g, try cap-ccf-assist=3Doff");
+    } else if (kvm_enabled() && (val > kvm_val)) {
+        error_setg(errp,
+"Requested count cache flush assist capability level not supported by kv=
m, try cap-ccf-assist=3Doff");
+    }
+}
+
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
     [SPAPR_CAP_HTM] =3D {
         .name =3D "htm",
@@ -525,6 +540,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
         .apply =3D cap_large_decr_apply,
         .cpu_apply =3D cap_large_decr_cpu_apply,
     },
+    [SPAPR_CAP_CCF_ASSIST] =3D {
+        .name =3D "ccf-assist",
+        .description =3D "Count Cache Flush Assist via HW Instruction",
+        .index =3D SPAPR_CAP_CCF_ASSIST,
+        .get =3D spapr_cap_get_bool,
+        .set =3D spapr_cap_set_bool,
+        .type =3D "bool",
+        .apply =3D cap_ccf_assist_apply,
+    },
 };
=20
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -659,6 +683,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
+SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
=20
 void spapr_caps_init(sPAPRMachineState *spapr)
 {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 4aa8036fc0..8bfdddc964 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1693,6 +1693,7 @@ static target_ulong h_get_cpu_characteristics(Power=
PCCPU *cpu,
     uint8_t safe_cache =3D spapr_get_cap(spapr, SPAPR_CAP_CFPC);
     uint8_t safe_bounds_check =3D spapr_get_cap(spapr, SPAPR_CAP_SBBC);
     uint8_t safe_indirect_branch =3D spapr_get_cap(spapr, SPAPR_CAP_IBS)=
;
+    uint8_t count_cache_flush_assist =3D spapr_get_cap(spapr, SPAPR_CAP_=
CCF_ASSIST);
=20
     switch (safe_cache) {
     case SPAPR_CAP_WORKAROUND:
@@ -1733,6 +1734,8 @@ static target_ulong h_get_cpu_characteristics(Power=
PCCPU *cpu,
         break;
     case SPAPR_CAP_WORKAROUND:
         behaviour |=3D H_CPU_BEHAV_FLUSH_COUNT_CACHE;
+        if (count_cache_flush_assist)
+            characteristics |=3D H_CPU_CHAR_BCCTR_FLUSH_ASSIST;
         break;
     default: /* broken */
         assert(safe_indirect_branch =3D=3D SPAPR_CAP_BROKEN);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a7f3b1bfdd..ff1bd60615 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -76,8 +76,10 @@ typedef enum {
 #define SPAPR_CAP_NESTED_KVM_HV         0x07
 /* Large Decrementer */
 #define SPAPR_CAP_LARGE_DECREMENTER     0x08
+/* Count Cache Flush Assist HW Instruction */
+#define SPAPR_CAP_CCF_ASSIST            0x09
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_LARGE_DECREMENTER + 1=
)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
=20
 /*
  * Capability Values
@@ -838,6 +840,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbb=
c;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
+extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
=20
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 7a7a5adee3..e0f0de0ce0 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -90,6 +90,7 @@ static int cap_ppc_pvr_compat;
 static int cap_ppc_safe_cache;
 static int cap_ppc_safe_bounds_check;
 static int cap_ppc_safe_indirect_branch;
+static int cap_ppc_count_cache_flush_assist;
 static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
=20
@@ -2406,6 +2407,13 @@ static int parse_cap_ppc_safe_indirect_branch(stru=
ct kvm_ppc_cpu_char c)
     return 0;
 }
=20
+static int parse_cap_ppc_count_cache_flush_assist(struct kvm_ppc_cpu_cha=
r c)
+{
+    if (c.character & c.character_mask & H_CPU_CHAR_BCCTR_FLUSH_ASSIST)
+        return 1;
+    return 0;
+}
+
 static void kvmppc_get_cpu_characteristics(KVMState *s)
 {
     struct kvm_ppc_cpu_char c;
@@ -2428,6 +2436,7 @@ static void kvmppc_get_cpu_characteristics(KVMState=
 *s)
     cap_ppc_safe_cache =3D parse_cap_ppc_safe_cache(c);
     cap_ppc_safe_bounds_check =3D parse_cap_ppc_safe_bounds_check(c);
     cap_ppc_safe_indirect_branch =3D parse_cap_ppc_safe_indirect_branch(=
c);
+    cap_ppc_count_cache_flush_assist =3D parse_cap_ppc_count_cache_flush=
_assist(c);
 }
=20
 int kvmppc_get_cap_safe_cache(void)
@@ -2445,6 +2454,11 @@ int kvmppc_get_cap_safe_indirect_branch(void)
     return cap_ppc_safe_indirect_branch;
 }
=20
+int kvmppc_get_cap_count_cache_flush_assist(void)
+{
+    return cap_ppc_count_cache_flush_assist;
+}
+
 bool kvmppc_has_cap_nested_kvm_hv(void)
 {
     return !!cap_ppc_nested_kvm_hv;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index a79835bd14..2937b36cae 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -62,6 +62,7 @@ bool kvmppc_has_cap_mmu_hash_v3(void);
 int kvmppc_get_cap_safe_cache(void);
 int kvmppc_get_cap_safe_bounds_check(void);
 int kvmppc_get_cap_safe_indirect_branch(void);
+int kvmppc_get_cap_count_cache_flush_assist(void);
 bool kvmppc_has_cap_nested_kvm_hv(void);
 int kvmppc_set_cap_nested_kvm_hv(int enable);
 int kvmppc_get_cap_large_decr(void);
@@ -324,6 +325,11 @@ static inline int kvmppc_get_cap_safe_indirect_branc=
h(void)
     return 0;
 }
=20
+static inline int kvmppc_get_cap_count_cache_flush_assist(void)
+{
+    return 0;
+}
+
 static inline bool kvmppc_has_cap_nested_kvm_hv(void)
 {
     return false;
--=20
2.20.1
