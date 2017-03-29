Received: from eggs.gnu.org ([2001:4830:134:3::10]:38427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct4NQ-000847-LB
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 23:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct4NP-0005fR-I4
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 23:34:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 29 Mar 2017 14:34:15 +1100
Message-Id: <20170329033415.891-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170329033415.891-1-david@gibson.dropbear.id.au>
References: <20170329033415.891-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 2/2] spapr: fix memory hot-unplugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, agraf@suse.de, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

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

    4- QEMU receive the the hotplug notification while it
       is trying to hot-unplug the memory. This moves the memory
       DRC to an invalid state

This patch prevents this by not allowing to set the allocation
state to USABLE while the DRC is awaiting release.

RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1432382

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 20 +++++++++++++++++---
 include/hw/ppc/spapr_drc.h |  1 +
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 150f6bf..a1cdc87 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -135,6 +135,17 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
         if (!drc->dev) {
             return RTAS_OUT_NO_SUCH_INDICATOR;
         }
+        if (drc->awaiting_release && drc->awaiting_allocation) {
+            /* kernel is acknowledging a previous hotplug event
+             * while we are already removing it.
+             * it's safe to ignore awaiting_allocation here since we know the
+             * situation is predicated on the guest either already having done
+             * so (boot-time hotplug), or never being able to acquire in the
+             * first place (hotplug followed by immediate unplug).
+             */
+            drc->awaiting_allocation_skippable = true;
+            return RTAS_OUT_NO_SUCH_INDICATOR;
+        }
     }
 
     if (drc->type != SPAPR_DR_CONNECTOR_TYPE_PCI) {
@@ -436,9 +447,11 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d,
     }
 
     if (drc->awaiting_allocation) {
-        drc->awaiting_release = true;
-        trace_spapr_drc_awaiting_allocation(get_index(drc));
-        return;
+        if (!drc->awaiting_allocation_skippable) {
+            drc->awaiting_release = true;
+            trace_spapr_drc_awaiting_allocation(get_index(drc));
+            return;
+        }
     }
 
     drc->indicator_state = SPAPR_DR_INDICATOR_STATE_INACTIVE;
@@ -448,6 +461,7 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d,
     }
 
     drc->awaiting_release = false;
+    drc->awaiting_allocation_skippable = false;
     g_free(drc->fdt);
     drc->fdt = NULL;
     drc->fdt_start_offset = 0;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index fa531d5..5524247 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -154,6 +154,7 @@ typedef struct sPAPRDRConnector {
     bool awaiting_release;
     bool signalled;
     bool awaiting_allocation;
+    bool awaiting_allocation_skippable;
 
     /* device pointer, via link property */
     DeviceState *dev;
-- 
2.9.3
