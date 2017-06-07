Received: from eggs.gnu.org ([2001:4830:134:3::10]:45022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIeaE-0000lU-US
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIeaA-0000k5-Tp
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:26 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:36627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIeaA-0000j2-Nl
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 13:17:22 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 4241D3DCC5
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 19:17:21 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 07 Jun 2017 19:17:17 +0200
Message-ID: <149685583778.12025.272004316108066026.stgit@bahia.lan>
In-Reply-To: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 4/5] xics: directly register ICPState
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
index 330441ff7fe8..3d76b43876c5 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -348,10 +348,14 @@ static void icp_realize(DeviceState *dev, Error **errp)
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
 
@@ -359,7 +363,6 @@ static void icp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->vmsd = &vmstate_icp_server;
     dc->realize = icp_realize;
     dc->unrealize = icp_unrealize;
 }
