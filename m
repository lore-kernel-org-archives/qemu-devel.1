Received: from eggs.gnu.org ([2001:4830:134:3::10]:52747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edapp-0004AA-Nz
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edapm-0000LZ-Kp
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:04:21 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edapm-0000LD-HL
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:04:18 -0500
Received: by mail-qt0-x241.google.com with SMTP id x27so20016035qtm.12
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 04:04:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 22 Jan 2018 09:03:50 -0300
Message-Id: <20180122120351.22369-7-f4bug@amsat.org>
In-Reply-To: <20180122120351.22369-1-f4bug@amsat.org>
References: <20180122120351.22369-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 6/7] qdev: remove DeviceClass::exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

it has no users.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h |  2 --
 hw/core/qdev.c         | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fd386b5d49..0bcba3b785 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -30,7 +30,6 @@ typedef enum DeviceCategory {
     DEVICE_CATEGORY_MAX
 } DeviceCategory;
 
-typedef int (*qdev_event)(DeviceState *dev);
 typedef void (*qdev_resetfn)(DeviceState *dev);
 typedef void (*DeviceRealize)(DeviceState *dev, Error **errp);
 typedef void (*DeviceUnrealize)(DeviceState *dev, Error **errp);
@@ -124,7 +123,6 @@ typedef struct DeviceClass {
     const struct VMStateDescription *vmsd;
 
     /* Private to qdev / bus.  */
-    qdev_event exit; /* TODO remove, once users are converted to unrealize */
     const char *bus_type;
 } DeviceClass;
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 1a985a511e..0ee86d2db8 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -219,19 +219,6 @@ void device_listener_unregister(DeviceListener *listener)
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
@@ -1126,7 +1113,6 @@ static void device_class_init(ObjectClass *class, void *data)
     DeviceClass *dc = DEVICE_CLASS(class);
 
     class->unparent = device_unparent;
-    dc->unrealize = device_unrealize;
 
     /* by default all devices were considered as hotpluggable,
      * so with intent to check it in generic qdev_unplug() /
-- 
2.15.1
