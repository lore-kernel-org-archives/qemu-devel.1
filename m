Received: from eggs.gnu.org ([2001:4830:134:3::10]:41534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eACS3-0000PN-N7
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eACRz-0002dy-RV
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:10:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eACRz-0002cD-Le
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 06:10:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D26BF81E1A
	for <qemu-devel@nongnu.org>; Thu,  2 Nov 2017 10:10:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  2 Nov 2017 11:10:05 +0100
Message-Id: <1509617407-21191-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1509617407-21191-1-git-send-email-thuth@redhat.com>
References: <1509617407-21191-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] qdev_monitor: Simplify error handling
 in qdev_device_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, david@redhat.com

Instead of doing the clean-ups on errors multiple times, introduce
a jump label at the end of the function that can be used by all
error paths that need this cleanup.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qdev-monitor.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8fd6df9..9188d20 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -620,22 +620,22 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 
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
1.8.3.1
