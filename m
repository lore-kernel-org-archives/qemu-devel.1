Received: from eggs.gnu.org ([2001:4830:134:3::10]:43964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e4DnY-0002Tp-Ro
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:23:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e4DnT-0002Is-N6
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:23:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e4DnT-0002Hq-DF
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 18:23:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9GMNa7x031119
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 18:23:38 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dn4jy9y60-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 18:23:38 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 16 Oct 2017 16:23:36 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 16 Oct 2017 17:23:14 -0500
In-Reply-To: <20171016222315.407-1-mdroth@linux.vnet.ibm.com>
References: <20171016222315.407-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171016222315.407-3-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 2/3] Revert "qdev: Free QemuOpts when the
 QOM path goes away"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, groug@kaod.org, armbru@redhat.com, alex.williamson@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

This reverts commit abed886ec60cf239a03515cf0b30fb11fa964c44.

This patch originally addressed an issue where a DEVICE_DELETED
event could be emitted (in device_unparent()) before a Device's
QemuOpts were cleaned up (in device_finalize()), leading to a
"duplicate ID" error if management attempted to immediately add
a device with the same ID in response to the DEVICE_DELETED event.

An alternative will be implemented in a subsequent patch where we
defer the DEVICE_DELETED event until device_finalize(), which would
also prevent the race, so we revert the original fix in preparation.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/core/qdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ebf9d822b5..0aa66a2e3c 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1068,6 +1068,7 @@ static void device_finalize(Object *obj)
     NamedGPIOList *ngl, *next;
 
     DeviceState *dev = DEVICE(obj);
+    qemu_opts_del(dev->opts);
 
     QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
         QLIST_REMOVE(ngl, node);
@@ -1117,9 +1118,6 @@ static void device_unparent(Object *obj)
         g_free(dev->canonical_path);
         dev->canonical_path = NULL;
     }
-
-    qemu_opts_del(dev->opts);
-    dev->opts = NULL;
 }
 
 static void device_class_init(ObjectClass *class, void *data)
-- 
2.11.0
