Received: from eggs.gnu.org ([2001:4830:134:3::10]:54405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dJ1Dt-00075s-97
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dJ1Ds-00064i-1j
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 13:27:53 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu,  8 Jun 2017 19:27:43 +0200
Message-Id: <20170608172743.10132-3-lvivier@redhat.com>
In-Reply-To: <20170608172743.10132-1-lvivier@redhat.com>
References: <20170608172743.10132-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] Revert "spapr: fix memory
 hot-unplugging"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Laurent Vivier <lvivier@redhat.com>

This reverts commit fe6824d12642b005c69123ecf8631f9b13553f8b.

Conflicts hw/ppc/spapr_drc.c, because get_index() has been renamed
spapr_get_index().

This didn't fix the problem. Once the hotplug has been started
some memory is allocated and some structures are allocated.
We don't free it when we ignore the unplug, and we can't because
they can be in use by the kernel.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/spapr_drc.c         | 20 +++-----------------
 include/hw/ppc/spapr_drc.h |  1 -
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 39e7f30..7605977 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -140,17 +140,6 @@ static uint32_t set_allocation_state(sPAPRDRConnector *drc,
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
@@ -401,11 +390,9 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
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
 
     drc->indicator_state = SPAPR_DR_INDICATOR_STATE_INACTIVE;
@@ -428,7 +415,6 @@ static void detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp)
     }
 
     drc->awaiting_release = false;
-    drc->awaiting_allocation_skippable = false;
     g_free(drc->fdt);
     drc->fdt = NULL;
     drc->fdt_start_offset = 0;
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index c88e1be..84b58f0 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -200,7 +200,6 @@ typedef struct sPAPRDRConnector {
     bool awaiting_release;
     bool signalled;
     bool awaiting_allocation;
-    bool awaiting_allocation_skippable;
 
     /* device pointer, via link property */
     DeviceState *dev;
-- 
2.9.4
