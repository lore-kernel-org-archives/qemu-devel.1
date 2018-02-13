Received: from eggs.gnu.org ([2001:4830:134:3::10]:37122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eleWP-0004kB-14
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eleWL-0004CF-3h
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:37:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eleWK-0004AS-R1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:37:33 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1DHYP6v084254
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:37:31 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g42sew5ty-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:37:30 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 13 Feb 2018 12:37:29 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 15:37:16 -0200
Message-Id: <20180213173716.21358-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] hw/ppc/spapr_hcall: set htab_shift after
 kvmppc_resize_hpt_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

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
