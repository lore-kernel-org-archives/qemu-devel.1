Received: from eggs.gnu.org ([2001:4830:134:3::10]:45804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPw-0000iH-Be
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPt-0003TT-9e
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 20:35:23 +1000
Message-Id: <20180622103528.28598-21-david@gibson.dropbear.id.au>
In-Reply-To: <20180622103528.28598-1-david@gibson.dropbear.id.au>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/25] spapr: Use maximum page size capability
 to simplify memory backend checking
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

The way we used to handle KVM allowable guest pagesizes for PAPR guests
required some convoluted checking of memory attached to the guest.

The allowable pagesizes advertised to the guest cpus depended on the memo=
ry
which was attached at boot, but then we needed to ensure that any memory
later hotplugged didn't change which pagesizes were allowed.

Now that we have an explicit machine option to control the allowable
maximum pagesize we can simplify this.  We just check all memory backends
against that declared pagesize.  We check base and cold-plugged memory at
reset time, and hotplugged memory at pre_plug() time.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         | 17 +++++++----------
 hw/ppc/spapr_caps.c    | 21 +++++++++++++++++++++
 include/hw/ppc/spapr.h |  3 +++
 target/ppc/kvm.c       | 14 --------------
 target/ppc/kvm_ppc.h   |  6 ------
 5 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 70b150b098..0d032a1ad0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3192,11 +3192,13 @@ static void spapr_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
                                   Error **errp)
 {
     const sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(hotplug_dev=
);
+    sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm =3D PC_DIMM(dev);
     PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
     MemoryRegion *mr;
     uint64_t size;
-    char *mem_dev;
+    Object *memdev;
+    hwaddr pagesize;
=20
     if (!smc->dr_lmb_enabled) {
         error_setg(errp, "Memory hotplug not supported for this machine"=
);
@@ -3215,15 +3217,10 @@ static void spapr_memory_pre_plug(HotplugHandler =
*hotplug_dev, DeviceState *dev,
         return;
     }
=20
-    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P, NULL);
-    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
-        error_setg(errp, "Memory backend has bad page size. "
-                   "Use 'memory-backend-file' with correct mem-path.");
-        goto out;
-    }
-
-out:
-    g_free(mem_dev);
+    memdev =3D object_property_get_link(OBJECT(dimm), PC_DIMM_MEMDEV_PRO=
P,
+                                      &error_abort);
+    pagesize =3D host_memory_backend_pagesize(MEMORY_BACKEND(memdev));
+    spapr_check_pagesize(spapr, pagesize, errp);
 }
=20
 struct sPAPRDIMMState {
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 6cdc0c94e7..722b213d9a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "sysemu/hw_accel.h"
+#include "exec/ram_addr.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
@@ -304,14 +305,34 @@ static void cap_safe_indirect_branch_apply(sPAPRMac=
hineState *spapr,
=20
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
=20
+void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
+                          Error **errp)
+{
+    hwaddr maxpagesize =3D (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MAXPAG=
ESIZE]);
+
+    if (!kvmppc_hpt_needs_host_contiguous_pages()) {
+        return;
+    }
+
+    if (maxpagesize > pagesize) {
+        error_setg(errp,
+                   "Can't support %"HWADDR_PRIu" kiB guest pages with %"
+                   HWADDR_PRIu" kiB host pages with this KVM implementat=
ion",
+                   maxpagesize >> 10, pagesize >> 10);
+    }
+}
+
 static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
                                       uint8_t val, Error **errp)
 {
     if (val < 12) {
         error_setg(errp, "Require at least 4kiB hpt-max-page-size");
+        return;
     } else if (val < 16) {
         warn_report("Many guests require at least 64kiB hpt-max-page-siz=
e");
     }
+
+    spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
 }
=20
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 4bc9dbff96..7e028164ba 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -806,4 +806,7 @@ void spapr_caps_cpu_apply(sPAPRMachineState *spapr, P=
owerPCCPU *cpu);
 void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
 int spapr_caps_post_migration(sPAPRMachineState *spapr);
=20
+void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
+                          Error **errp);
+
 #endif /* HW_SPAPR_H */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 50b5d01432..9cfbd388ad 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -500,26 +500,12 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
         cpu->hash64_opts->flags &=3D ~PPC_HASH64_1TSEG;
     }
 }
-
-bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
-{
-    Object *mem_obj =3D object_resolve_path(obj_path, NULL);
-    long pagesize =3D host_memory_backend_pagesize(MEMORY_BACKEND(mem_ob=
j));
-
-    return pagesize >=3D max_cpu_page_size;
-}
-
 #else /* defined (TARGET_PPC64) */
=20
 static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
 {
 }
=20
-bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
-{
-    return true;
-}
-
 #endif /* !defined (TARGET_PPC64) */
=20
 unsigned long kvm_arch_vcpu_id(CPUState *cpu)
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index a7ddb8a5d6..443fca0a4e 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -71,7 +71,6 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_ul=
ong flags, int shift);
 bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
=20
 bool kvmppc_hpt_needs_host_contiguous_pages(void);
-bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
=20
 #else
=20
@@ -228,11 +227,6 @@ static inline bool kvmppc_hpt_needs_host_contiguous_=
pages(void)
     return false;
 }
=20
-static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_pa=
th)
-{
-    return true;
-}
-
 static inline bool kvmppc_has_cap_spapr_vfio(void)
 {
     return false;
--=20
2.17.1
