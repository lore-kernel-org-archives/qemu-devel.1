Received: from eggs.gnu.org ([2001:4830:134:3::10]:48314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxie-0006T0-Jl
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIxid-0007V0-Me
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:24 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:42735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIxid-0007Ua-Fg
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:43:23 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 2A1923EAE1
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 15:43:22 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 08 Jun 2017 15:43:18 +0200
Message-ID: <149692939833.12119.5229563110691809599.stgit@bahia>
In-Reply-To: <149692935202.12119.3614006195497745877.stgit@bahia>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 5/6] xics: directly register ICPState
 objects to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

The ICPState objects are currently registered to vmstate as qdev objects.
Their instance ids are hence computed automatically in the migration code,
and thus depends on the order the CPU cores were plugged.

If the destination had its CPU cores plugged in a different order than the
source, then ICPState objects will have different instance_ids and load
the wrong state.

Since CPU objects have a reliable cpu_index which is already used as
instance_id in vmstate, let's use it for ICPState as well.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 7ccfb53c55a0..faa5c631f655 100644
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
