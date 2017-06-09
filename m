Received: from eggs.gnu.org ([2001:4830:134:3::10]:47184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCS1-00041k-6D
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJCRz-0006gv-9u
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:27:13 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  9 Jun 2017 15:26:52 +1000
Message-Id: <20170609052652.23200-21-david@gibson.dropbear.id.au>
In-Reply-To: <20170609052652.23200-1-david@gibson.dropbear.id.au>
References: <20170609052652.23200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 20/20] Revert "spapr: fix memory hot-unplugging"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

This reverts commit fe6824d12642b005c69123ecf8631f9b13553f8b.

Conflicts hw/ppc/spapr_drc.c, because get_index() has been renamed
spapr_get_index().

This didn't fix the problem. Once the hotplug has been started
some memory is allocated and some structures are allocated.
We don't free it when we ignore the unplug, and we can't because
they can be in use by the kernel.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c         | 20 +++-----------------
 include/hw/ppc/spapr_drc.h |  1 -
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 15ef67d..5cb75bb 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -128,17 +128,6 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
         if (!drc->dev) {
             return RTAS_OUT_NO_SUCH_INDICATOR;
         }
-        if (drc->awaiting_release && drc->awaiting_allocation) {
-            /* kernel is acknowledging a previous hotplug event
-             * while we are already removing it.
-             * it's safe to ignore awaiting_allocation here since we know the
-             * situation is predicated on the guest either already having done
-             * so (boot-time hotplug), or never being able to acquire in the
-             * first place (hotplug followed by immediate unplug).
-             */
-            drc->awaiting_allocation_skippable = true;
-            return RTAS_OUT_NO_SUCH_INDICATOR;
-        }
     }
 
     if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
@@ -391,11 +380,9 @@ void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
     }
 
     if (drc->awaiting_allocation) {
-        if (!drc->awaiting_allocation_skippable) {
-            drc->awaiting_release = true;
-            trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
-            return;
-        }
+        drc->awaiting_release = true;
+        trace_spapr_drc_awaiting_allocation(spapr_drc_index(drc));
+        return;
     }
 
     drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
@@ -418,7 +405,6 @@ void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
     }
 
     drc->awaiting_release = false;
-    drc->awaiting_allocation_skippable = false;
     g_free(drc->fdt);
     drc->fdt = NULL;
     drc->fdt_start_offset = 0;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index c487123..bc9f988 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -201,7 +201,6 @@ typedef struct sPAPRDRConnector {
     bool awaiting_release;
     bool signalled;
     bool awaiting_allocation;
-    bool awaiting_allocation_skippable;
 
     /* device pointer, via link property */
     DeviceState *dev;
-- 
2.9.4
