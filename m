Received: from eggs.gnu.org ([2001:4830:134:3::10]:50877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1daXei-0002sn-A5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1daXed-000884-D9
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:32:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40881
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1daXed-000878-8F
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:31:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6R1Si4F049106
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:31:54 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bxyxvgmjp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:31:54 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 19:31:53 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 20:30:54 -0500
In-Reply-To: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1501119055-4060-3-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH for-2.10 2/3] Revert "qdev: Free QemuOpts when
 the QOM path goes away"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au, groug@kaod.org, armbru@redhat.com

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
---
 hw/core/qdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index a64b35c..08c4061 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1067,6 +1067,7 @@ static void device_finalize(Object *obj)
     NamedGPIOList *ngl, *next;
 
     DeviceState *dev = DEVICE(obj);
+    qemu_opts_del(dev->opts);
 
     QLIST_FOREACH_SAFE(ngl, &dev->gpios, node, next) {
         QLIST_REMOVE(ngl, node);
@@ -1116,9 +1117,6 @@ static void device_unparent(Object *obj)
         g_free(dev->canonical_path);
         dev->canonical_path = NULL;
     }
-
-    qemu_opts_del(dev->opts);
-    dev->opts = NULL;
 }
 
 static void device_class_init(ObjectClass *class, void *data)
-- 
2.7.4
