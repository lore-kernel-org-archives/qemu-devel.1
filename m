Received: from eggs.gnu.org ([2001:4830:134:3::10]:57274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoP-0006Ur-Pm
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDjoO-0007TT-Fa
	for qemu-devel@nongnu.org; Wed, 24 May 2017 23:51:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 25 May 2017 13:51:21 +1000
Message-Id: <20170525035132.24268-8-david@gibson.dropbear.id.au>
In-Reply-To: <20170525035132.24268-1-david@gibson.dropbear.id.au>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 07/18] spapr: ensure core_slot isn't NULL in
 spapr_core_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, sbobroff@redhat.com, sursingh@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

If we go that far on the path of hot-removing a core and we find out that
the core-id is invalid, then we have a serious bug.

Let's make it explicit with an assert() instead of dereferencing a NULL
pointer.

This fixes Coverity issue CID 1375404.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 35dceb0..c912eaa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2725,6 +2725,7 @@ static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     CPUCore *cc = CPU_CORE(dev);
     CPUArchId *core_slot = spapr_find_cpu_slot(ms, cc->core_id, NULL);
 
+    assert(core_slot);
     core_slot->cpu = NULL;
     object_unparent(OBJECT(dev));
 }
-- 
2.9.4
