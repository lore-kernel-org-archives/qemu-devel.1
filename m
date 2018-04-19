Received: from eggs.gnu.org ([2001:4830:134:3::10]:53437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5q-0002gc-4b
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5o-0007xJ-Us
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:50 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9H5o-0007wx-Qx
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:48 -0400
Received: by mail-qt0-x244.google.com with SMTP id s2-v6so7445041qti.2
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:27:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 18:27:27 -0300
Message-Id: <20180419212727.26095-5-f4bug@amsat.org>
In-Reply-To: <20180419212727.26095-1-f4bug@amsat.org>
References: <20180419212727.26095-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/4] qdev: Remove DeviceClass::exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

Since no devices use it, we can safely remove it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h |  2 --
 hw/core/qdev.c         | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 6f60748043..88b52be8fb 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -29,7 +29,6 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
 
-typedef int (*qdev_event)(DeviceState *dev);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceReset)(DeviceState *dev);
@@ -123,7 +122,6 @@ typedef struct DeviceClass {
     const struct VMStateDescription *vmsd;
 
     /* Private to qdev / bus.  */
-    qdev_event exit; /* TODO remove, once users are converted to unrealize */
     const char *bus_type;
 } DeviceClass;
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 4153b733c8..ffec461791 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -208,19 +208,6 @@ void device_listener_unregister(DeviceListener *listener)
     QTAILQ_REMOVE(&device_listeners, listener, link);
 }
 
-static void device_unrealize(DeviceState *dev, Error **errp)
-{
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
-
-    if (dc->exit) {
-        int rc = dc->exit(dev);
-        if (rc < 0) {
-            error_setg(errp, "Device exit failed.");
-            return;
-        }
-    }
-}
-
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version)
 {
@@ -1052,7 +1039,6 @@ static void device_class_init(ObjectClass *class, void *data)
     DeviceClass *dc = DEVICE_CLASS(class);
 
     class->unparent = device_unparent;
-    dc->unrealize = device_unrealize;
 
     /* by default all devices were considered as hotpluggable,
      * so with intent to check it in generic qdev_unplug() /
-- 
2.17.0
