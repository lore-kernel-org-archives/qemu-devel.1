Received: from eggs.gnu.org ([2001:4830:134:3::10]:59561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaG-0001pN-Ka
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaF-0002A4-El
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:15 +1000
Message-Id: <20180427092126.24812-39-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/49] target/ppc: Make hash64_opts field
 mandatory for 64-bit hash MMUs
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

Currently some cpus set the hash64_opts field in the class structure, wit=
h
specific details of their variant of the 64-bit hash mmu.  For the
remaining cpus with that mmu, ppc_hash64_realize() fills in defaults.

But there are only a couple of cpus that use those fallbacks, so just hav=
e
them to set the has64_opts field instead, simplifying the logic.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-hash64.c     | 36 ++++++++++++++++++------------------
 target/ppc/mmu-hash64.h     |  1 +
 target/ppc/translate_init.c |  2 ++
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 6758afd9de..2809c31170 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1100,25 +1100,12 @@ void ppc_hash64_init(PowerPCCPU *cpu)
     CPUPPCState *env =3D &cpu->env;
     PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
=20
-    if (pcc->hash64_opts) {
-        cpu->hash64_opts =3D g_memdup(pcc->hash64_opts,
-                                    sizeof(*cpu->hash64_opts));
-    } else if (env->mmu_model & POWERPC_MMU_64) {
-        /* Use default sets of page sizes. We don't support MPSS */
-        static const PPCHash64Options defopts =3D {
-            .sps =3D {
-                { .page_shift =3D 12, /* 4K */
-                  .slb_enc =3D 0,
-                  .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 } }
-                },
-                { .page_shift =3D 24, /* 16M */
-                  .slb_enc =3D 0x100,
-                  .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 } }
-                },
-            },
-        };
-        cpu->hash64_opts =3D g_memdup(&defopts, sizeof(*cpu->hash64_opts=
));
+    if (!pcc->hash64_opts) {
+        assert(!(env->mmu_model & POWERPC_MMU_64));
+        return;
     }
+
+    cpu->hash64_opts =3D g_memdup(pcc->hash64_opts, sizeof(*cpu->hash64_=
opts));
 }
=20
 void ppc_hash64_finalize(PowerPCCPU *cpu)
@@ -1126,6 +1113,19 @@ void ppc_hash64_finalize(PowerPCCPU *cpu)
     g_free(cpu->hash64_opts);
 }
=20
+const PPCHash64Options ppc_hash64_opts_basic =3D {
+    .sps =3D {
+        { .page_shift =3D 12, /* 4K */
+          .slb_enc =3D 0,
+          .enc =3D { { .page_shift =3D 12, .pte_enc =3D 0 } }
+        },
+        { .page_shift =3D 24, /* 16M */
+          .slb_enc =3D 0x100,
+          .enc =3D { { .page_shift =3D 24, .pte_enc =3D 0 } }
+        },
+    },
+};
+
 const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
     .sps =3D {
         {
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 957bd68e33..341c1524c2 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -156,6 +156,7 @@ struct PPCHash64Options {
     PPCHash64SegmentPageSizes sps[PPC_PAGE_SIZES_MAX_SZ];
 };
=20
+extern const PPCHash64Options ppc_hash64_opts_basic;
 extern const PPCHash64Options ppc_hash64_opts_POWER7;
=20
 #endif /* CONFIG_USER_ONLY */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 040d6fbac3..ae005b2a54 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8242,6 +8242,7 @@ POWERPC_FAMILY(970)(ObjectClass *oc, void *data)
     pcc->mmu_model =3D POWERPC_MMU_64B;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
+    pcc->hash64_opts =3D &ppc_hash64_opts_basic;
 #endif
     pcc->excp_model =3D POWERPC_EXCP_970;
     pcc->bus_model =3D PPC_FLAGS_INPUT_970;
@@ -8319,6 +8320,7 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *data=
)
     pcc->mmu_model =3D POWERPC_MMU_2_03;
 #if defined(CONFIG_SOFTMMU)
     pcc->handle_mmu_fault =3D ppc_hash64_handle_mmu_fault;
+    pcc->hash64_opts =3D &ppc_hash64_opts_basic;
 #endif
     pcc->excp_model =3D POWERPC_EXCP_970;
     pcc->bus_model =3D PPC_FLAGS_INPUT_970;
--=20
2.14.3
