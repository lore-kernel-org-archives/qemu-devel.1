Received: from eggs.gnu.org ([2001:4830:134:3::10]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQgKE-0005Mg-EI
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cQgKD-0001Kb-FW
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cQgKD-0001KT-8u
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 15:13:49 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F60E4E047
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 20:13:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  9 Jan 2017 20:13:40 +0000
Message-Id: <20170109201340.16593-4-dgilbert@redhat.com>
In-Reply-To: <20170109201340.16593-1-dgilbert@redhat.com>
References: <20170109201340.16593-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] vmstate registration: check return values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, quintela@redhat.com, amit.shah@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Check qdev's call to vmstate_register_with_alias_id; that gets
most of the common uses; there's hundreds of calls via vmstate_register
which could get fixed over time.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/core/qdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index ea97b15..df633d0 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -933,10 +933,12 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         }
 
         if (qdev_get_vmsd(dev)) {
-            vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
+            if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
                                            dev->instance_id_alias,
                                            dev->alias_required_for_version,
-                                           NULL);
+                                           &local_err) < 0) {
+                goto post_realize_fail;
+            }
         }
 
         QLIST_FOREACH(bus, &dev->child_bus, sibling) {
-- 
2.9.3
