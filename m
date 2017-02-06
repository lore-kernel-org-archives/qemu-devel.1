Received: from eggs.gnu.org ([2001:4830:134:3::10]:35261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWQ-0004B2-WA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1camWQ-0005mK-Am
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1camWQ-0005lx-5b
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:52:10 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C1DBC01C107
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 16:52:10 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon,  6 Feb 2017 17:51:47 +0100
Message-Id: <1486399909-16338-5-git-send-email-quintela@redhat.com>
In-Reply-To: <1486399909-16338-1-git-send-email-quintela@redhat.com>
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] vmstate registration: check return values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Check qdev's call to vmstate_register_with_alias_id; that gets
most of the common uses; there's hundreds of calls via vmstate_register
which could get fixed over time.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20170202125956.21942-4-dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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
2.7.4
