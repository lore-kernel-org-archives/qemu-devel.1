Received: from eggs.gnu.org ([2001:4830:134:3::10]:59032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1csUbi-0000BC-Uc
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1csUbf-0005CQ-Ow
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:22:50 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 27 Mar 2017 15:22:42 +0200
Message-Id: <20170327132242.17104-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] spapr: fix memory hot-unplugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

If, once the kernel has booted, we try to remove a memory
hotplugged while the kernel was not started, QEMU crashes on
an assert:

    qemu-system-ppc64: hw/virtio/vhost.c:651:
                       vhost_commit: Assertion `r >= 0' failed.
    ...
    #4  in vhost_commit
    #5  in memory_region_transaction_commit
    #6  in pc_dimm_memory_unplug
    #7  in spapr_memory_unplug
    #8  spapr_machine_device_unplug
    #9  in hotplug_handler_unplug
    #10 in spapr_lmb_release
    #11 in detach
    #12 in set_allocation_state
    #13 in rtas_set_indicator
    ...

If we take a closer look to the guest kernel log, we can see when
we try to unplug the memory:

    pseries-hotplug-mem: Attempting to hot-add 4 LMB(s)

What happens:

    1- The kernel has ignored the memory hotplug event because
       it was not started when it was generated.

    2- When we hot-unplug the memory,
       QEMU starts to remove the memory,
            generates an hot-unplug event,
        and signals the kernel of the incoming new event

    3- as the kernel is started, on the QEMU signal, it reads
       the event list, decodes the hotplug event and tries to
       finish the hotplugging.

    4- QEMU receives the hotplug notification while it
       is trying to hot-unplug the memory. This moves the memory
       DRC to an invalid state

This patch prevents this by not allowing to set the allocation
state to USABLE while the DRC is awaiting release and allocation.

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1432382

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr_drc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 150f6bf..377ea65 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -135,6 +135,12 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
         if (!drc->dev) {
             return RTAS_OUT_NO_SUCH_INDICATOR;
         }
+        if (drc->awaiting_release && drc->awaiting_allocation) {
+            /* kernel is acknowledging a previous hotplug event
+             * while we are already removing it.
+             */
+            return RTAS_OUT_NO_SUCH_INDICATOR;
+        }
     }
 
     if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI) {
-- 
2.9.3
