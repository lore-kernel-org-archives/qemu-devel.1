Received: from eggs.gnu.org ([2001:4830:134:3::10]:58215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e1fLG-0007ye-Eb
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:12:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e1fLD-0001CJ-3X
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:12:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55378
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e1fLC-0001Bx-Tk
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:11:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99L8rxl042740
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 17:11:54 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgayvj6th-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:11:54 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 15:11:53 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon,  9 Oct 2017 18:11:36 -0300
In-Reply-To: <20171009211136.31640-1-danielhb@linux.vnet.ibm.com>
References: <20171009211136.31640-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171009211136.31640-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] hw/ppc/spapr.c: abort unplug_request if
 previous unplug isn't done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

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
---
 hw/ppc/spapr.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff87f155d5..7f9274d57d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3054,14 +3054,13 @@ void spapr_lmb_release(DeviceState *dev)
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
@@ -3090,6 +3089,19 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
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
