Received: from eggs.gnu.org ([2001:4830:134:3::10]:46234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfp-0001Em-0U
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ebzfj-0004ya-Ur
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ebzfj-0004yA-Oh
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 21:11:19 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Jan 2018 00:09:53 -0200
Message-Id: <20180118021000.27203-13-ehabkost@redhat.com>
In-Reply-To: <20180118021000.27203-1-ehabkost@redhat.com>
References: <20180118021000.27203-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 12/19] qdev_monitor: Simplify error handling in
 qdev_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Instead of doing the clean-ups on errors multiple times, introduce
a jump label at the end of the function that can be used by all
error paths that need this cleanup.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1509617407-21191-2-git-send-email-thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qdev-monitor.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index b4abb4b5ea..2abb80d7e4 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -619,22 +619,22 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 
     /* set properties */
     if (qemu_opt_foreach(opts, set_property, dev, &err)) {
-        error_propagate(errp, err);
-        object_unparent(OBJECT(dev));
-        object_unref(OBJECT(dev));
-        return NULL;
+        goto err_del_dev;
     }
 
     dev->opts = opts;
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err != NULL) {
-        error_propagate(errp, err);
         dev->opts = NULL;
-        object_unparent(OBJECT(dev));
-        object_unref(OBJECT(dev));
-        return NULL;
+        goto err_del_dev;
     }
     return dev;
+
+err_del_dev:
+    error_propagate(errp, err);
+    object_unparent(OBJECT(dev));
+    object_unref(OBJECT(dev));
+    return NULL;
 }
 
 
-- 
2.14.3
