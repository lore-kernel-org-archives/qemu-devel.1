Received: from eggs.gnu.org ([2001:4830:134:3::10]:50348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gFbzT-0007Zu-0a
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gFbzO-0008Ui-1C
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gFbzM-0008Ik-CB
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 05:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9015230C9EE8
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 09:31:30 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 25 Oct 2018 10:52:54 +0200
Message-Id: <20181025085256.20522-2-kraxel@redhat.com>
In-Reply-To: <20181025085256.20522-1-kraxel@redhat.com>
References: <20181025085256.20522-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qdev: add deprecation_reason to DeviceClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Prasad J Pandit <ppandit@redhat.com>

Simliar to deprecated machine types.
Print a warning when creating a deprecated device.
Add deprecation notice to -device help.

TODO: add to intospection.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/core/qdev.c         | 9 ++++++++-
 include/hw/qdev-core.h | 1 +
 qdev-monitor.c         | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 046d8f1..3b27a74 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -133,11 +133,18 @@ DeviceState *qdev_create(BusState *bus, const char *name)
 
 DeviceState *qdev_try_create(BusState *bus, const char *type)
 {
+    DeviceClass *dc;
     DeviceState *dev;
 
-    if (object_class_by_name(type) == NULL) {
+    dc = DEVICE_CLASS(object_class_by_name(type));
+    if (dc == NULL) {
         return NULL;
     }
+    if (dc->deprecation_reason) {
+        warn_report("device %s is deprecated (%s)",
+                    type, dc->deprecation_reason);
+    }
+
     dev = DEVICE(object_new(type));
     if (!dev) {
         return NULL;
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index a24d0dd..a352eaa 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -105,6 +105,7 @@ typedef struct DeviceClass {
      */
     bool user_creatable;
     bool hotpluggable;
+    const char *deprecation_reason;
 
     /* callbacks */
     DeviceReset reset;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 802c18a..bbba2bc 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -128,6 +128,9 @@ static void qdev_print_devinfo(DeviceClass *dc)
     if (!dc->user_creatable) {
         out_printf(", no-user");
     }
+    if (!dc->deprecation_reason) {
+        out_printf(", deprecated");
+    }
     out_printf("\n");
 }
 
@@ -579,6 +582,10 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     if (!dc) {
         return NULL;
     }
+    if (dc->deprecation_reason) {
+        warn_report("device %s is deprecated (%s)",
+                    driver, dc->deprecation_reason);
+    }
 
     /* find bus */
     path = qemu_opt_get(opts, "bus");
-- 
2.9.3
