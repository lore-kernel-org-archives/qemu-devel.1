Received: from eggs.gnu.org ([2001:4830:134:3::10]:37502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fZ93r-0002Wm-9v
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1fZ93m-0007le-K6
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:08:43 -0400
Received: from mout.web.de ([212.227.17.12]:38731)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1fZ93m-0007jr-2E
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:08:38 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <567473a0-6005-5843-4c73-951f476085ca@web.de>
Date: Sat, 30 Jun 2018 08:08:23 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6n4oooVB4bl4XXmyF1YOG484M9VL1o7o1"
Subject: [Qemu-devel] [PATCH v2] target-i386: Add NPT support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6n4oooVB4bl4XXmyF1YOG484M9VL1o7o1
From: Jan Kiszka <jan.kiszka@web.de>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Message-ID: <567473a0-6005-5843-4c73-951f476085ca@web.de>
Subject: [PATCH v2] target-i386: Add NPT support
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From: Jan Kiszka <jan.kiszka@siemens.com>

This implements NPT suport for SVM by hooking into
x86_cpu_handle_mmu_fault where it reads the stage-1 page table. Whether
we need to perform this 2nd stage translation, and how, is decided
during vmrun and stored in hflags2, along with nested_cr3 and
nested_pg_mode.

As get_hphys performs a direct cpu_vmexit in case of NPT faults, we need
retaddr in that function. To avoid changing the signature of
cpu_handle_mmu_fault, this passes the value from tlb_fill to get_hphys
via the CPU state.

This was tested successfully via the Jailhouse hypervisor.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - use hflags2 instead of hflags
 - add conditional vmstate subsection

 target/i386/cpu.c         |   2 +-
 target/i386/cpu.h         |   6 ++
 target/i386/excp_helper.c | 216 ++++++++++++++++++++++++++++++++++++++++=
+++++-
 target/i386/machine.c     |  21 +++++
 target/i386/mem_helper.c  |   6 +-
 target/i386/svm.h         |  14 +++
 target/i386/svm_helper.c  |  22 +++++
 7 files changed, 281 insertions(+), 6 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1e6a7d0a75..6e1f180249 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -751,7 +751,7 @@ static void x86_cpu_vendor_words2str(char *dst, uint3=
2_t vendor1,
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
           CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A)
 #define TCG_EXT4_FEATURES 0
-#define TCG_SVM_FEATURES 0
+#define TCG_SVM_FEATURES CPUID_SVM_NPT
 #define TCG_KVM_FEATURES 0
 #define TCG_7_0_EBX_FEATURES (CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_SMAP | =
\
           CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | =
\
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 8eaefeee3e..7f33755bf5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -211,6 +211,7 @@ typedef enum X86Seg {
 #define HF2_VINTR_SHIFT          3 /* value of V_INTR_MASKING bit */
 #define HF2_SMM_INSIDE_NMI_SHIFT 4 /* CPU serving SMI nested inside NMI =
*/
 #define HF2_MPX_PR_SHIFT         5 /* BNDCFGx.BNDPRESERVE */
+#define HF2_NPT_SHIFT            6 /* Nested Paging enabled */
=20
 #define HF2_GIF_MASK            (1 << HF2_GIF_SHIFT)
 #define HF2_HIF_MASK            (1 << HF2_HIF_SHIFT)
@@ -218,6 +219,7 @@ typedef enum X86Seg {
 #define HF2_VINTR_MASK          (1 << HF2_VINTR_SHIFT)
 #define HF2_SMM_INSIDE_NMI_MASK (1 << HF2_SMM_INSIDE_NMI_SHIFT)
 #define HF2_MPX_PR_MASK         (1 << HF2_MPX_PR_SHIFT)
+#define HF2_NPT_MASK            (1 << HF2_NPT_SHIFT)
=20
 #define CR0_PE_SHIFT 0
 #define CR0_MP_SHIFT 1
@@ -1265,12 +1267,16 @@ typedef struct CPUX86State {
     uint16_t intercept_dr_read;
     uint16_t intercept_dr_write;
     uint32_t intercept_exceptions;
+    uint64_t nested_cr3;
+    uint32_t nested_pg_mode;
     uint8_t v_tpr;
=20
     /* KVM states, automatically cleared on reset */
     uint8_t nmi_injected;
     uint8_t nmi_pending;
=20
+    uintptr_t retaddr;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
=20
diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index cb4d1b7d33..37a33d5ae0 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -157,6 +157,209 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr ad=
dr, int size,
=20
 #else
=20
+static hwaddr get_hphys(CPUState *cs, hwaddr gphys, MMUAccessType access=
_type,
+                        int *prot)
+{
+    CPUX86State *env =3D &X86_CPU(cs)->env;
+    uint64_t rsvd_mask =3D PG_HI_RSVD_MASK;
+    uint64_t ptep, pte;
+    uint64_t exit_info_1 =3D 0;
+    target_ulong pde_addr, pte_addr;
+    uint32_t page_offset;
+    int page_size;
+
+    if (likely(!(env->hflags2 & HF2_NPT_MASK))) {
+        return gphys;
+    }
+
+    if (!(env->nested_pg_mode & SVM_NPT_NXE)) {
+        rsvd_mask |=3D PG_NX_MASK;
+    }
+
+    if (env->nested_pg_mode & SVM_NPT_PAE) {
+        uint64_t pde, pdpe;
+        target_ulong pdpe_addr;
+
+#ifdef TARGET_X86_64
+        if (env->nested_pg_mode & SVM_NPT_LMA) {
+            uint64_t pml5e;
+            uint64_t pml4e_addr, pml4e;
+
+            pml5e =3D env->nested_cr3;
+            ptep =3D PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
+
+            pml4e_addr =3D (pml5e & PG_ADDRESS_MASK) +
+                    (((gphys >> 39) & 0x1ff) << 3);
+            pml4e =3D x86_ldq_phys(cs, pml4e_addr);
+            if (!(pml4e & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            if (pml4e & (rsvd_mask | PG_PSE_MASK)) {
+                goto do_fault_rsvd;
+            }
+            if (!(pml4e & PG_ACCESSED_MASK)) {
+                pml4e |=3D PG_ACCESSED_MASK;
+                x86_stl_phys_notdirty(cs, pml4e_addr, pml4e);
+            }
+            ptep &=3D pml4e ^ PG_NX_MASK;
+            pdpe_addr =3D (pml4e & PG_ADDRESS_MASK) +
+                    (((gphys >> 30) & 0x1ff) << 3);
+            pdpe =3D x86_ldq_phys(cs, pdpe_addr);
+            if (!(pdpe & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            if (pdpe & rsvd_mask) {
+                goto do_fault_rsvd;
+            }
+            ptep &=3D pdpe ^ PG_NX_MASK;
+            if (!(pdpe & PG_ACCESSED_MASK)) {
+                pdpe |=3D PG_ACCESSED_MASK;
+                x86_stl_phys_notdirty(cs, pdpe_addr, pdpe);
+            }
+            if (pdpe & PG_PSE_MASK) {
+                /* 1 GB page */
+                page_size =3D 1024 * 1024 * 1024;
+                pte_addr =3D pdpe_addr;
+                pte =3D pdpe;
+                goto do_check_protect;
+            }
+        } else
+#endif
+        {
+            pdpe_addr =3D (env->nested_cr3 & ~0x1f) + ((gphys >> 27) & 0=
x18);
+            pdpe =3D x86_ldq_phys(cs, pdpe_addr);
+            if (!(pdpe & PG_PRESENT_MASK)) {
+                goto do_fault;
+            }
+            rsvd_mask |=3D PG_HI_USER_MASK;
+            if (pdpe & (rsvd_mask | PG_NX_MASK)) {
+                goto do_fault_rsvd;
+            }
+            ptep =3D PG_NX_MASK | PG_USER_MASK | PG_RW_MASK;
+        }
+
+        pde_addr =3D (pdpe & PG_ADDRESS_MASK) + (((gphys >> 21) & 0x1ff)=
 << 3);
+        pde =3D x86_ldq_phys(cs, pde_addr);
+        if (!(pde & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        if (pde & rsvd_mask) {
+            goto do_fault_rsvd;
+        }
+        ptep &=3D pde ^ PG_NX_MASK;
+        if (pde & PG_PSE_MASK) {
+            /* 2 MB page */
+            page_size =3D 2048 * 1024;
+            pte_addr =3D pde_addr;
+            pte =3D pde;
+            goto do_check_protect;
+        }
+        /* 4 KB page */
+        if (!(pde & PG_ACCESSED_MASK)) {
+            pde |=3D PG_ACCESSED_MASK;
+            x86_stl_phys_notdirty(cs, pde_addr, pde);
+        }
+        pte_addr =3D (pde & PG_ADDRESS_MASK) + (((gphys >> 12) & 0x1ff) =
<< 3);
+        pte =3D x86_ldq_phys(cs, pte_addr);
+        if (!(pte & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        if (pte & rsvd_mask) {
+            goto do_fault_rsvd;
+        }
+        /* combine pde and pte nx, user and rw protections */
+        ptep &=3D pte ^ PG_NX_MASK;
+        page_size =3D 4096;
+    } else {
+        uint32_t pde;
+
+        /* page directory entry */
+        pde_addr =3D (env->nested_cr3 & ~0xfff) + ((gphys >> 20) & 0xffc=
);
+        pde =3D x86_ldl_phys(cs, pde_addr);
+        if (!(pde & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        ptep =3D pde | PG_NX_MASK;
+
+        /* if PSE bit is set, then we use a 4MB page */
+        if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
+            page_size =3D 4096 * 1024;
+            pte_addr =3D pde_addr;
+
+            /* Bits 20-13 provide bits 39-32 of the address, bit 21 is r=
eserved.
+             * Leave bits 20-13 in place for setting accessed/dirty bits=
 below.
+             */
+            pte =3D pde | ((pde & 0x1fe000LL) << (32 - 13));
+            rsvd_mask =3D 0x200000;
+            goto do_check_protect_pse36;
+        }
+
+        if (!(pde & PG_ACCESSED_MASK)) {
+            pde |=3D PG_ACCESSED_MASK;
+            x86_stl_phys_notdirty(cs, pde_addr, pde);
+        }
+
+        /* page directory entry */
+        pte_addr =3D (pde & ~0xfff) + ((gphys >> 10) & 0xffc);
+        pte =3D x86_ldl_phys(cs, pte_addr);
+        if (!(pte & PG_PRESENT_MASK)) {
+            goto do_fault;
+        }
+        /* combine pde and pte user and rw protections */
+        ptep &=3D pte | PG_NX_MASK;
+        page_size =3D 4096;
+        rsvd_mask =3D 0;
+    }
+
+ do_check_protect:
+    rsvd_mask |=3D (page_size - 1) & PG_ADDRESS_MASK & ~PG_PSE_PAT_MASK;=

+ do_check_protect_pse36:
+    if (pte & rsvd_mask) {
+        goto do_fault_rsvd;
+    }
+    ptep ^=3D PG_NX_MASK;
+
+    if (!(ptep & PG_USER_MASK)) {
+        goto do_fault_protect;
+    }
+    if (ptep & PG_NX_MASK) {
+        if (access_type =3D=3D MMU_INST_FETCH) {
+            goto do_fault_protect;
+        }
+        *prot &=3D ~PAGE_EXEC;
+    }
+    if (!(ptep & PG_RW_MASK)) {
+        if (access_type =3D=3D MMU_DATA_STORE) {
+            goto do_fault_protect;
+        }
+        *prot &=3D ~PAGE_WRITE;
+    }
+
+    pte &=3D PG_ADDRESS_MASK & ~(page_size - 1);
+    page_offset =3D gphys & (page_size - 1);
+    return pte + page_offset;
+
+ do_fault_rsvd:
+    exit_info_1 |=3D SVM_NPTEXIT_RSVD;
+ do_fault_protect:
+    exit_info_1 |=3D SVM_NPTEXIT_P;
+ do_fault:
+    x86_stq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, control.exit_i=
nfo_2),
+                 gphys);
+    exit_info_1 |=3D SVM_NPTEXIT_US;
+    if (access_type =3D=3D MMU_DATA_STORE) {
+        exit_info_1 |=3D SVM_NPTEXIT_RW;
+    } else if (access_type =3D=3D MMU_INST_FETCH) {
+        exit_info_1 |=3D SVM_NPTEXIT_ID;
+    }
+    if (prot) {
+        exit_info_1 |=3D SVM_NPTEXIT_GPA;
+    } else { /* page table access */
+        exit_info_1 |=3D SVM_NPTEXIT_GPT;
+    }
+    cpu_vmexit(env, SVM_EXIT_NPF, exit_info_1, env->retaddr);
+}
+
 /* return value:
  * -1 =3D cannot handle fault
  * 0  =3D nothing more to do
@@ -224,6 +427,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
, int size,
             if (la57) {
                 pml5e_addr =3D ((env->cr[3] & ~0xfff) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
+                pml5e_addr =3D get_hphys(cs, pml5e_addr, MMU_DATA_STORE,=
 NULL);
                 pml5e =3D x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
                     goto do_fault;
@@ -243,6 +447,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
, int size,
=20
             pml4e_addr =3D ((pml5e & PG_ADDRESS_MASK) +
                     (((addr >> 39) & 0x1ff) << 3)) & a20_mask;
+            pml4e_addr =3D get_hphys(cs, pml4e_addr, MMU_DATA_STORE, fal=
se);
             pml4e =3D x86_ldq_phys(cs, pml4e_addr);
             if (!(pml4e & PG_PRESENT_MASK)) {
                 goto do_fault;
@@ -257,6 +462,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
, int size,
             ptep &=3D pml4e ^ PG_NX_MASK;
             pdpe_addr =3D ((pml4e & PG_ADDRESS_MASK) + (((addr >> 30) & =
0x1ff) << 3)) &
                 a20_mask;
+            pdpe_addr =3D get_hphys(cs, pdpe_addr, MMU_DATA_STORE, NULL)=
;
             pdpe =3D x86_ldq_phys(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 goto do_fault;
@@ -282,6 +488,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
, int size,
             /* XXX: load them when cr3 is loaded ? */
             pdpe_addr =3D ((env->cr[3] & ~0x1f) + ((addr >> 27) & 0x18))=
 &
                 a20_mask;
+            pdpe_addr =3D get_hphys(cs, pdpe_addr, MMU_DATA_STORE, false=
);
             pdpe =3D x86_ldq_phys(cs, pdpe_addr);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 goto do_fault;
@@ -295,6 +502,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
, int size,
=20
         pde_addr =3D ((pdpe & PG_ADDRESS_MASK) + (((addr >> 21) & 0x1ff)=
 << 3)) &
             a20_mask;
+        pde_addr =3D get_hphys(cs, pde_addr, MMU_DATA_STORE, NULL);
         pde =3D x86_ldq_phys(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK)) {
             goto do_fault;
@@ -317,6 +525,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
, int size,
         }
         pte_addr =3D ((pde & PG_ADDRESS_MASK) + (((addr >> 12) & 0x1ff) =
<< 3)) &
             a20_mask;
+        pte_addr =3D get_hphys(cs, pte_addr, MMU_DATA_STORE, NULL);
         pte =3D x86_ldq_phys(cs, pte_addr);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
@@ -333,6 +542,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
, int size,
         /* page directory entry */
         pde_addr =3D ((env->cr[3] & ~0xfff) + ((addr >> 20) & 0xffc)) &
             a20_mask;
+        pde_addr =3D get_hphys(cs, pde_addr, MMU_DATA_STORE, NULL);
         pde =3D x86_ldl_phys(cs, pde_addr);
         if (!(pde & PG_PRESENT_MASK)) {
             goto do_fault;
@@ -360,6 +570,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
, int size,
         /* page directory entry */
         pte_addr =3D ((pde & ~0xfff) + ((addr >> 10) & 0xffc)) &
             a20_mask;
+        pte_addr =3D get_hphys(cs, pte_addr, MMU_DATA_STORE, NULL);
         pte =3D x86_ldl_phys(cs, pte_addr);
         if (!(pte & PG_PRESENT_MASK)) {
             goto do_fault;
@@ -442,12 +653,13 @@ do_check_protect_pse36:
=20
     /* align to page_size */
     pte &=3D PG_ADDRESS_MASK & ~(page_size - 1);
+    page_offset =3D addr & (page_size - 1);
+    paddr =3D get_hphys(cs, pte + page_offset, is_write1, &prot);
=20
     /* Even if 4MB pages, we map only one 4KB page in the cache to
        avoid filling it too fast */
     vaddr =3D addr & TARGET_PAGE_MASK;
-    page_offset =3D vaddr & (page_size - 1);
-    paddr =3D pte + page_offset;
+    paddr &=3D TARGET_PAGE_MASK;
=20
     assert(prot & (1 << is_write1));
     tlb_set_page_with_attrs(cs, vaddr, paddr, cpu_get_mem_attrs(env),
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 4d98d367c1..8b64dff487 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -935,6 +935,26 @@ static const VMStateDescription vmstate_msr_virt_ssb=
d =3D {
     }
 };
=20
+static bool svm_npt_needed(void *opaque)
+{
+    X86CPU *cpu =3D opaque;
+    CPUX86State *env =3D &cpu->env;
+
+    return !!(env->hflags2 & HF2_NPT_MASK);
+}
+
+static const VMStateDescription vmstate_svm_npt =3D {
+    .name =3D "cpu/svn_npt",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D svm_npt_needed,
+    .fields =3D (VMStateField[]){
+        VMSTATE_UINT64(env.nested_cr3, X86CPU),
+        VMSTATE_UINT32(env.nested_pg_mode, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 VMStateDescription vmstate_x86_cpu =3D {
     .name =3D "cpu",
     .version_id =3D 12,
@@ -1059,6 +1079,7 @@ VMStateDescription vmstate_x86_cpu =3D {
         &vmstate_mcg_ext_ctl,
         &vmstate_msr_intel_pt,
         &vmstate_msr_virt_ssbd,
+        &vmstate_svm_npt,
         NULL
     }
 };
diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index a8ae694a9c..30c26b9d9c 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -202,13 +202,13 @@ void helper_boundl(CPUX86State *env, target_ulong a=
0, int v)
 void tlb_fill(CPUState *cs, target_ulong addr, int size,
               MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)=

 {
+    X86CPU *cpu =3D X86_CPU(cs);
+    CPUX86State *env =3D &cpu->env;
     int ret;
=20
+    env->retaddr =3D retaddr;
     ret =3D x86_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_id=
x);
     if (ret) {
-        X86CPU *cpu =3D X86_CPU(cs);
-        CPUX86State *env =3D &cpu->env;
-
         raise_exception_err_ra(env, cs->exception_index, env->error_code=
, retaddr);
     }
 }
diff --git a/target/i386/svm.h b/target/i386/svm.h
index 922c8fd39c..23a3a040b8 100644
--- a/target/i386/svm.h
+++ b/target/i386/svm.h
@@ -130,6 +130,20 @@
=20
 #define SVM_CR0_SELECTIVE_MASK (1 << 3 | 1) /* TS and MP */
=20
+#define SVM_NPT_ENABLED     (1 << 0)
+
+#define SVM_NPT_PAE         (1 << 0)
+#define SVM_NPT_LMA         (1 << 1)
+#define SVM_NPT_NXE         (1 << 2)
+
+#define SVM_NPTEXIT_P       (1ULL << 0)
+#define SVM_NPTEXIT_RW      (1ULL << 1)
+#define SVM_NPTEXIT_US      (1ULL << 2)
+#define SVM_NPTEXIT_RSVD    (1ULL << 3)
+#define SVM_NPTEXIT_ID      (1ULL << 4)
+#define SVM_NPTEXIT_GPA     (1ULL << 32)
+#define SVM_NPTEXIT_GPT     (1ULL << 33)
+
 struct QEMU_PACKED vmcb_control_area {
 	uint16_t intercept_cr_read;
 	uint16_t intercept_cr_write;
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index f245aec310..342ece082f 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -124,6 +124,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int ne=
xt_eip_addend)
 {
     CPUState *cs =3D CPU(x86_env_get_cpu(env));
     target_ulong addr;
+    uint64_t nested_ctl;
     uint32_t event_inj;
     uint32_t int_ctl;
=20
@@ -206,6 +207,26 @@ void helper_vmrun(CPUX86State *env, int aflag, int n=
ext_eip_addend)
                                                   control.intercept_exce=
ptions
                                                   ));
=20
+    nested_ctl =3D x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb,=

+                                                          control.nested=
_ctl));
+    if (nested_ctl & SVM_NPT_ENABLED) {
+        env->nested_cr3 =3D x86_ldq_phys(cs,
+                                env->vm_vmcb + offsetof(struct vmcb,
+                                                        control.nested_c=
r3));
+        env->hflags2 |=3D HF2_NPT_MASK;
+
+        env->nested_pg_mode =3D 0;
+        if (env->cr[4] & CR4_PAE_MASK) {
+            env->nested_pg_mode |=3D SVM_NPT_PAE;
+        }
+        if (env->hflags & HF_LMA_MASK) {
+            env->nested_pg_mode |=3D SVM_NPT_LMA;
+        }
+        if (env->efer & MSR_EFER_NXE) {
+            env->nested_pg_mode |=3D SVM_NPT_NXE;
+        }
+    }
+
     /* enable intercepts */
     env->hflags |=3D HF_SVMI_MASK;
=20
@@ -616,6 +637,7 @@ void do_vmexit(CPUX86State *env, uint32_t exit_code, =
uint64_t exit_info_1)
         x86_stl_phys(cs,
                  env->vm_vmcb + offsetof(struct vmcb, control.int_state)=
, 0);
     }
+    env->hflags2 &=3D ~HF2_NPT_MASK;
=20
     /* Save the VM state in the vmcb */
     svm_save_seg(env, env->vm_vmcb + offsetof(struct vmcb, save.es),
--=20
2.16.4


--6n4oooVB4bl4XXmyF1YOG484M9VL1o7o1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTKX4wA9fvIVGYBbICK1KxveuXnFAUCWzceVwAKCRCK1KxveuXn
FKETAJ4sjy8ysd4uDC8p0A+OUKFP62gTTACgj4xEnTn+/myaQzZ7izM5uiqZZ1c=
=M7xh
-----END PGP SIGNATURE-----

--6n4oooVB4bl4XXmyF1YOG484M9VL1o7o1--
