Received: from eggs.gnu.org ([2001:4830:134:3::10]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uQL-0001Xl-Re
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uQJ-0000uI-Uy
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:14:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  5 Apr 2018 12:14:29 +1000
Message-Id: <20180405021437.16761-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180405021437.16761-1-david@gibson.dropbear.id.au>
References: <20180405021437.16761-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-2.13 05/13] target/ppc: Remove fallback 64k
 pagesize information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, groug@kaod.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

CPU definitions for cpus with the 64-bit hash MMU can include a table of
available pagesizes.  If this isn't supplied ppc_cpu_instance_init() will
fill it in a fallback table based on the POWERPC_MMU_64K bit in mmu_model=
.

However, it turns out all the cpus which support 64K pages already includ=
e
an explicit table of page sizes, so there's no point to the fallback tabl=
e
including 64k pages.

That removes the only place which tests POWERPC_MMU_64K, so we can remove
it.  Which in turn allows some logic to be removed from
kvm_fixup_page_sizes().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/cpu-qom.h        |  4 ----
 target/ppc/kvm.c            |  7 -------
 target/ppc/translate_init.c | 20 ++------------------
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index deaa46a14b..9bbb05cf62 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -70,7 +70,6 @@ enum powerpc_mmu_t {
 #define POWERPC_MMU_64       0x00010000
 #define POWERPC_MMU_1TSEG    0x00020000
 #define POWERPC_MMU_AMR      0x00040000
-#define POWERPC_MMU_64K      0x00080000
 #define POWERPC_MMU_V3       0x00100000 /* ISA V3.00 MMU Support */
     /* 64 bits PowerPC MMU                                     */
     POWERPC_MMU_64B        =3D POWERPC_MMU_64 | 0x00000001,
@@ -78,15 +77,12 @@ enum powerpc_mmu_t {
     POWERPC_MMU_2_03       =3D POWERPC_MMU_64 | 0x00000002,
     /* Architecture 2.06 variant                               */
     POWERPC_MMU_2_06       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
-                             | POWERPC_MMU_64K
                              | POWERPC_MMU_AMR | 0x00000003,
     /* Architecture 2.07 variant                               */
     POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
-                             | POWERPC_MMU_64K
                              | POWERPC_MMU_AMR | 0x00000004,
     /* Architecture 3.00 variant                               */
     POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
-                             | POWERPC_MMU_64K
                              | POWERPC_MMU_AMR | POWERPC_MMU_V3
                              | 0x00000005,
 };
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 79a436a384..6160356a4a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -425,7 +425,6 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     static bool has_smmu_info;
     CPUPPCState *env =3D &cpu->env;
     int iq, ik, jq, jk;
-    bool has_64k_pages =3D false;
=20
     /* We only handle page sizes for 64-bit server guests for now */
     if (!(env->mmu_model & POWERPC_MMU_64)) {
@@ -471,9 +470,6 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
                                      ksps->enc[jk].page_shift)) {
                 continue;
             }
-            if (ksps->enc[jk].page_shift =3D=3D 16) {
-                has_64k_pages =3D true;
-            }
             qsps->enc[jq].page_shift =3D ksps->enc[jk].page_shift;
             qsps->enc[jq].pte_enc =3D ksps->enc[jk].pte_enc;
             if (++jq >=3D PPC_PAGE_SIZES_MAX_SZ) {
@@ -488,9 +484,6 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
         env->mmu_model &=3D ~POWERPC_MMU_1TSEG;
     }
-    if (!has_64k_pages) {
-        env->mmu_model &=3D ~POWERPC_MMU_64K;
-    }
 }
=20
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 29bd6f3654..99be6fcd68 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10469,7 +10469,7 @@ static void ppc_cpu_instance_init(Object *obj)
         env->sps =3D *pcc->sps;
     } else if (env->mmu_model & POWERPC_MMU_64) {
         /* Use default sets of page sizes. We don't support MPSS */
-        static const struct ppc_segment_page_sizes defsps_4k =3D {
+        static const struct ppc_segment_page_sizes defsps =3D {
             .sps =3D {
                 { .page_shift =3D 12, /* 4K */
                   .slb_enc =3D 0,
@@ -10481,23 +10481,7 @@ static void ppc_cpu_instance_init(Object *obj)
                 },
             },
         };
-        static const struct ppc_segment_page_sizes defsps_64k =3D {
-            .sps =3D {
-                { .page_shift =3D 12, /* 4K */
-                  .slb_enc =3D 0,
-                  .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 } }
-                },
-                { .page_shift =3D 16, /* 64K */
-                  .slb_enc =3D 0x110,
-                  .enc =3D { { .page_shift =3D 16, .pte_enc =3D 1 } }
-                },
-                { .page_shift =3D 24, /* 16M */
-                  .slb_enc =3D 0x100,
-                  .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 } }
-                },
-            },
-        };
-        env->sps =3D (env->mmu_model & POWERPC_MMU_64K) ? defsps_64k : d=
efsps_4k;
+        env->sps =3D defsps;
     }
 #endif /* defined(TARGET_PPC64) */
 }
--=20
2.14.3
