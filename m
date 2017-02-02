Received: from eggs.gnu.org ([2001:4830:134:3::10]:41730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZGzo-0001G2-IX
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZGzb-000088-FX
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:00:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21623)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZGzb-00006P-A6
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 08:00:03 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 633F6C05092E
	for <qemu-devel@nongnu.org>; Thu,  2 Feb 2017 13:00:03 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu,  2 Feb 2017 12:59:56 +0000
Message-Id: <20170202125956.21942-4-dgilbert@redhat.com>
In-Reply-To: <20170202125956.21942-1-dgilbert@redhat.com>
References: <20170202125956.21942-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] vmstate registration: check return
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Check qdev's call to vmstate_register_with_alias_id; that gets
most of the common uses; there's hundreds of calls via vmstate_register
which could get fixed over time.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 hw/core/qdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ea97b15..06ba02e 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -933,10 +933,12 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         }
 
         if (qdev_get_vmsd(dev)) {
-            vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
-                                           dev->instance_id_alias,
-                                           dev->alias_required_for_version,
-                                           NULL);
+            if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
+                                               dev->instance_id_alias,
+                                               dev->alias_required_for_version,
+                                               &local_err) < 0) {
+                goto post_realize_fail;
+            }
         }
 
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-- 
2.9.3
