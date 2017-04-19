Received: from eggs.gnu.org ([2001:4830:134:3::10]:44589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0win-0004uR-8R
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0wij-0007Ql-Df
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0wij-0007QI-7W
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 17:01:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2177712B24
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:01:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 19 Apr 2017 22:59:22 +0200
Message-Id: <20170419205923.8808-59-quintela@redhat.com>
In-Reply-To: <20170419205923.8808-1-quintela@redhat.com>
References: <20170419205923.8808-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 58/59] migration: Disable hotplug/unplug during
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Until we have reviewed what can/can't be hotplugged during migration,
disable it.  We can enable it later for the things that we know that
work.  For instance, memory hotplug during postcopy doesn't work
currently.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

--

- Fix typo.  Thanks Thomas.
- Delay migration check after we have checked that we can hotplug that
  device.
- more typos

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qdev-monitor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index bb3d8ba..e61d596 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
 #include "sysemu/block-backend.h"
+#include "migration/migration.h"
 
 /*
  * Aliases were a bad idea from the start.  Let's keep them
@@ -603,6 +604,11 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
+    if (!migration_is_idle()) {
+        error_setg(errp, "device_add not allowed while migrating");
+        return NULL;
+    }
+
     /* create device */
     dev = DEVICE(object_new(driver));
 
@@ -853,6 +859,11 @@ void qdev_unplug(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!migration_is_idle()) {
+        error_setg(errp, "device_del not allowed while migrating");
+        return;
+    }
+
     qdev_hot_removed = true;
 
     hotplug_ctrl = qdev_get_hotplug_handler(dev);
-- 
2.9.3
