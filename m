Received: from eggs.gnu.org ([2001:4830:134:3::10]:51864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7EG-0000y0-Fm
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7EF-0001aj-Hp
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7EF-0001aF-Cl
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:13:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69722C04BD50
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:13:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:13:25 +0200
Message-Id: <20170406131326.2418-5-quintela@redhat.com>
In-Reply-To: <20170406131326.2418-1-quintela@redhat.com>
References: <20170406131326.2418-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] migration: Disable hotplug/unplug during
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

Until we have reviewed what can/can't be hotplug during migration,
disable it.  We can enable it later for the things that we know that
work.  For instance, memory hotplug during postcopy don't work
currently.

Signed-off-by: Juan Quintela <quintela@redhat.com>

--

- Fix typo.  Thanks Thomas.
- Delay migration check after we have checked that we can hotplug that
  device.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 qdev-monitor.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index bb3d8ba..752c362 100644
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
+        error_setg(errp, "device_add not allowed while migrating");
+        return;
+    }
+
     qdev_hot_removed = true;
 
     hotplug_ctrl = qdev_get_hotplug_handler(dev);
-- 
2.9.3
