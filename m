Received: from eggs.gnu.org ([2001:4830:134:3::10]:35381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuT-0001aU-GJ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1emcuQ-00056A-8y
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:06:29 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 16 Feb 2018 21:06:07 +1100
Message-Id: <20180216100617.25265-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180216100617.25265-1-david@gibson.dropbear.id.au>
References: <20180216100617.25265-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/14] hw/ppc/spapr_hcall: set htab_shift after
 kvmppc_resize_hpt_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, surajjs@au1.ibm.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Newer kernels have a htab resize capability when adding or remove
memory. At these situations, the guest kernel might reallocate its
htab to a more suitable size based on the resulting memory.

However, we're not setting the new value back into the machine state
when a KVM guest resizes its htab. At first this doesn't seem harmful,
but when migrating or saving the guest state (via virsh managedsave,
for instance) this mismatch between the htab size of QEMU and the
kernel makes the guest hangs when trying to load its state.

Inside h_resize_hpt_commit, the hypercall that commits the hash page
resize changes, let's set spapr->htab_shift to the new value if we're
sure that kvmppc_resize_hpt_commit were successful.

While we're here, add a "not RADIX" sanity check as it is already done
in the related hypercall h_resize_hpt_prepare.

Fixes: https://github.com/open-power-host-os/qemu/issues/28
Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_hcall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 76422cfac1..1986560480 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -731,11 +731,21 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
         return H_AUTHORITY;
     }
 
+    if (!spapr->htab_shift) {
+        /* Radix guest, no HPT */
+        return H_NOT_AVAILABLE;
+    }
+
     trace_spapr_h_resize_hpt_commit(flags, shift);
 
     rc = kvmppc_resize_hpt_commit(cpu, flags, shift);
     if (rc != -ENOSYS) {
-        return resize_hpt_convert_rc(rc);
+        rc = resize_hpt_convert_rc(rc);
+        if (rc == H_SUCCESS) {
+            /* Need to set the new htab_shift in the machine state */
+            spapr->htab_shift = shift;
+        }
+        return rc;
     }
 
     if (flags != 0) {
-- 
2.14.3
