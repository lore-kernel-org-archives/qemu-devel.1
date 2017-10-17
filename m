Received: from eggs.gnu.org ([2001:4830:134:3::10]:50391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOT-0008IC-S2
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOS-0006vc-AY
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:17 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:26 +1100
Message-Id: <20171017042152.29443-9-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/34] hw/ppc/spapr.c: abort unplug_request if
 previous unplug isn't done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

LMB removal is completed only when the spapr_lmb_release callback
is called after all DRCs of the dimm are detached. During this
time, it is possible that a unplug request for the same dimm
arrives, trying to detach DRCs that were detached by the guest
in the first unplug_request.

BQL doesn't help in this case - the lock will prevent any concurrent
removal from happening until the end of spapr_memory_unplug_request
only. What happens is that the second unplug_request ends up calling
spapr_drc_detach in a DRC that were detached already, causing an
assert error in spapr_drc_detach (e.g
https://bugs.launchpad.net/qemu/+bug/1718118).

spapr_lmb_release uses a structure called sPAPRDIMMState, stored in the
spapr->pending_dimm_unplugs QTAIL, to track how many LMB DRCs are left
to be detached by the guest. When there are no more DRCs left, this
structure is deleted and the pc-dimm unplug handler is called to
finish the process.

This patch reuses the sPAPRDIMMState to allow unplug_request to know
if there is an ongoing unplug process for a given dimm, aborting the
unplug request in this case, by doing the following changes:

- in spapr_lmb_release callback, move the dimm state removal to the
end, after pc-dimm unplug handler. With this change we can check for
the existence of the dimm state to see if the unplug process is
done.

- use spapr_pending_dimm_unplugs_find in spapr_memory_unplug_request
to check if the dimm state exists. If positive, there is an unplug
operation already in progress for this dimm, meaning that we should
abort it and warn the user about it.

Fixes: https://bugs.launchpad.net/qemu/+bug/1718118
Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 079e493ef4..147fd2cfd3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3061,14 +3061,13 @@ void spapr_lmb_release(DeviceState *dev)
         return;
     }
 
-    spapr_pending_dimm_unplugs_remove(spapr, ds);
-
     /*
      * Now that all the LMBs have been removed by the guest, call the
      * pc-dimm unplug handler to cleanup up the pc-dimm device.
      */
     pc_dimm_memory_unplug(dev, &spapr->hotplug_memory, mr);
     object_unparent(OBJECT(dev));
+    spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
 
 static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
@@ -3097,6 +3096,19 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
         goto out;
     }
 
+    /*
+     * An existing pending dimm state for this DIMM means that there is an
+     * unplug operation in progress, waiting for the spapr_lmb_release
+     * callback to complete the job (BQL can't cover that far). In this case,
+     * bail out to avoid detaching DRCs that were already released.
+     */
+    if (spapr_pending_dimm_unplugs_find(spapr, dimm)) {
+        error_setg(&local_err,
+                   "Memory unplug already in progress for device %s",
+                   dev->id);
+        goto out;
+    }
+
     spapr_pending_dimm_unplugs_add(spapr, nr_lmbs, dimm);
 
     addr = addr_start;
-- 
2.13.6
