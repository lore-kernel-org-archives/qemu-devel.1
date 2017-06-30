Received: from eggs.gnu.org ([2001:4830:134:3::10]:34396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRk-0008T3-QW
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRj-0007vf-Gm
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:44 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:21 +1000
Message-Id: <20170630104632.27942-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/21] xics: directly register ICPState objects
 to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The ICPState objects are currently registered to vmstate as qdev objects.
Their instance ids are hence computed automatically in the migration code,
and thus depends on the order the CPU cores were plugged.

If the destination had its CPU cores plugged in a different order than the
source, then ICPState objects will have different instance_ids and load
the wrong state.

Since CPU objects have a reliable cpu_index which is already used as
instance_id in vmstate, let's use it for ICPState as well.

Please note that this doesn't break migration. Older machine types used to
allocate and realize all ICPState objects at machine init time, for the whole
lifetime of the machine. The qdev instance ids are thus 0,1,2... nr_servers
and happen to map to the vCPU indexes.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index d4194d6..a84ba51 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -344,10 +344,14 @@ static void icp_realize(DeviceState *dev, Error **errp)
     }
 
     qemu_register_reset(icp_reset, dev);
+    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
 }
 
 static void icp_unrealize(DeviceState *dev, Error **errp)
 {
+    ICPState *icp = ICP(dev);
+
+    vmstate_unregister(NULL, &vmstate_icp_server, icp);
     qemu_unregister_reset(icp_reset, dev);
 }
 
@@ -355,7 +359,6 @@ static void icp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->vmsd = &vmstate_icp_server;
     dc->realize = icp_realize;
     dc->unrealize = icp_unrealize;
 }
-- 
2.9.4
