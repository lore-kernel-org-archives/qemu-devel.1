Received: from eggs.gnu.org ([2001:4830:134:3::10]:59624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaK-0001ub-VQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBzaJ-0002Bm-D6
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 05:22:32 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 27 Apr 2018 19:21:17 +1000
Message-Id: <20180427092126.24812-41-david@gibson.dropbear.id.au>
In-Reply-To: <20180427092126.24812-1-david@gibson.dropbear.id.au>
References: <20180427092126.24812-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 40/49] target/ppc: Fold ci_large_pages flag into
 PPCHash64Options
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

The ci_large_pages boolean in CPUPPCState is only relevant to 64-bit hash
MMU machines, indicating whether it's possible to map large (> 4kiB) page=
s
as cache-inhibitied (i.e. for IO, rather than memory).  Fold it as anothe=
r
flag into the PPCHash64Options structure.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c              | 3 +--
 target/ppc/cpu.h            | 1 -
 target/ppc/kvm.c            | 6 +++++-
 target/ppc/mmu-hash64.c     | 2 +-
 target/ppc/mmu-hash64.h     | 1 +
 target/ppc/translate_init.c | 3 ---
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9c26dc37e1..abf38c62e8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -263,7 +263,6 @@ static void spapr_populate_pa_features(sPAPRMachineSt=
ate *spapr,
                                        void *fdt, int offset,
                                        bool legacy_guest)
 {
-    CPUPPCState *env =3D &cpu->env;
     uint8_t pa_features_206[] =3D { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
     uint8_t pa_features_207[] =3D { 24, 0,
@@ -315,7 +314,7 @@ static void spapr_populate_pa_features(sPAPRMachineSt=
ate *spapr,
         return;
     }
=20
-    if (env->ci_large_pages) {
+    if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
         /*
          * Note: we keep CI large pages off by default because a 64K cap=
able
          * guest provisioned with large pages might otherwise try to map=
 a qemu
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 1c5c33ca11..c0c44fb91d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1090,7 +1090,6 @@ struct CPUPPCState {
 #if defined(TARGET_PPC64)
     ppc_slb_t vrma_slb;
     target_ulong rmls;
-    bool ci_large_pages;
 #endif
=20
 #if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index b53af75ecf..25f93dc708 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -448,7 +448,11 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
      * host page size is smaller than 64K.
      */
     if (smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL) {
-        env->ci_large_pages =3D getpagesize() >=3D 0x10000;
+        if (getpagesize() >=3D 0x10000) {
+            cpu->hash64_opts->flags |=3D PPC_HASH64_CI_LARGEPAGE;
+        } else {
+            cpu->hash64_opts->flags &=3D ~PPC_HASH64_CI_LARGEPAGE;
+        }
     }
=20
     /*
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index c9ee55e1ea..f341714550 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1128,7 +1128,7 @@ const PPCHash64Options ppc_hash64_opts_basic =3D {
 };
=20
 const PPCHash64Options ppc_hash64_opts_POWER7 =3D {
-    .flags =3D PPC_HASH64_1TSEG | PPC_HASH64_AMR,
+    .flags =3D PPC_HASH64_1TSEG | PPC_HASH64_AMR | PPC_HASH64_CI_LARGEPA=
GE,
     .sps =3D {
         {
             .page_shift =3D 12, /* 4K */
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index b2b5d25238..f1babb0afc 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -155,6 +155,7 @@ struct PPCHash64SegmentPageSizes {
 struct PPCHash64Options {
 #define PPC_HASH64_1TSEG        0x00001
 #define PPC_HASH64_AMR          0x00002
+#define PPC_HASH64_CI_LARGEPAGE 0x00004
     unsigned flags;
     PPCHash64SegmentPageSizes sps[PPC_PAGE_SIZES_MAX_SZ];
 };
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index ae005b2a54..a925cf5cd3 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8392,7 +8392,6 @@ static void init_proc_POWER7(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->slb_nr =3D 32;
 #endif
-    env->ci_large_pages =3D true;
     env->dcache_line_size =3D 128;
     env->icache_line_size =3D 128;
=20
@@ -8547,7 +8546,6 @@ static void init_proc_POWER8(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->slb_nr =3D 32;
 #endif
-    env->ci_large_pages =3D true;
     env->dcache_line_size =3D 128;
     env->icache_line_size =3D 128;
=20
@@ -8748,7 +8746,6 @@ static void init_proc_POWER9(CPUPPCState *env)
 #if !defined(CONFIG_USER_ONLY)
     env->slb_nr =3D 32;
 #endif
-    env->ci_large_pages =3D true;
     env->dcache_line_size =3D 128;
     env->icache_line_size =3D 128;
=20
--=20
2.14.3
