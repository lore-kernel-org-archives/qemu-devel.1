Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6f-0003Rq-0N
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6b-0007hO-1c
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:48 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:47094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6a-0007gr-Te
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:44 -0500
Received: by mail-qk0-x241.google.com with SMTP id l64so20678864qke.13
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:53 -0300
Message-Id: <20180116131555.14242-10-f4bug@amsat.org>
In-Reply-To: <20180116131555.14242-1-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/11] qdev: remove DeviceClass::exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

it has no users.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/qdev-core.h | 2 --
 hw/core/qdev.c         | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index de063b232f..de7fe2e6e0 100644
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
index a4f76c8f5d..985f890a74 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -225,15 +225,6 @@ static void device_realize(DeviceState *dev, Error **errp)
 
 static void device_unrealize(DeviceState *dev, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
-
-    if (dc->exit) {
-        int rc = dc->exit(dev);
-        if (rc < 0) {
-            error_setg(errp, "Device exit failed.");
-            return;
-        }
-    }
 }
 
 void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
-- 
2.15.1
