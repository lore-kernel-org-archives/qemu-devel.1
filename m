Received: from eggs.gnu.org ([2001:4830:134:3::10]:39724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDd0-0007jE-4F
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDcy-0003aR-1F
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 14:24:24 +1000
Message-Id: <20180622042437.14259-10-david@gibson.dropbear.id.au>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 10/23] target/ppc: Add
 kvmppc_hpt_needs_host_contiguous_pages() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

KVM HV has a restriction that for HPT mode guests, guest pages must be hp=
a
contiguous as well as gpa contiguous.  We have to account for that in
various places.  We determine whether we're subject to this restriction
from the SMMU information exposed by KVM.

Planned cleanups to the way we handle this will require knowing whether
this restriction is in play in wider parts of the code.  So, expose a
helper function which returns it.

This does mean some redundant calls to kvm_get_smmu_info(), but they'll g=
o
away again with future cleanups.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/kvm.c     | 17 +++++++++++++++--
 target/ppc/kvm_ppc.h |  6 ++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 5c0e313ca6..50b5d01432 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -406,9 +406,22 @@ target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu=
,
     }
 }
=20
+bool kvmppc_hpt_needs_host_contiguous_pages(void)
+{
+    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
+    static struct kvm_ppc_smmu_info smmu_info;
+
+    if (!kvm_enabled()) {
+        return false;
+    }
+
+    kvm_get_smmu_info(cpu, &smmu_info);
+    return !!(smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL);
+}
+
 static bool kvm_valid_page_size(uint32_t flags, long rampgsize, uint32_t=
 shift)
 {
-    if (!(flags & KVM_PPC_PAGE_SIZES_REAL)) {
+    if (!kvmppc_hpt_needs_host_contiguous_pages()) {
         return true;
     }
=20
@@ -445,7 +458,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     /* If we have HV KVM, we need to forbid CI large pages if our
      * host page size is smaller than 64K.
      */
-    if (smmu_info.flags & KVM_PPC_PAGE_SIZES_REAL) {
+    if (kvmppc_hpt_needs_host_contiguous_pages()) {
         if (getpagesize() >=3D 0x10000) {
             cpu->hash64_opts->flags |=3D PPC_HASH64_CI_LARGEPAGE;
         } else {
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index e2840e1d33..a7ddb8a5d6 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -70,6 +70,7 @@ int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu, target_u=
long flags, int shift);
 int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ulong flags, int sh=
ift);
 bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
=20
+bool kvmppc_hpt_needs_host_contiguous_pages(void);
 bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
=20
 #else
@@ -222,6 +223,11 @@ static inline uint64_t kvmppc_rma_size(uint64_t curr=
ent_size,
     return ram_size;
 }
=20
+static inline bool kvmppc_hpt_needs_host_contiguous_pages(void)
+{
+    return false;
+}
+
 static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_pa=
th)
 {
     return true;
--=20
2.17.1
