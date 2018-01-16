Received: from eggs.gnu.org ([2001:4830:134:3::10]:59401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6X-0003MZ-D6
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6R-0007Xt-Dt
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:41 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebR6R-0007Xd-9w
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:16:35 -0500
Received: by mail-qk0-x243.google.com with SMTP id l29so11163865qkj.8
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:16:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 16 Jan 2018 10:15:50 -0300
Message-Id: <20180116131555.14242-7-f4bug@amsat.org>
In-Reply-To: <20180116131555.14242-1-f4bug@amsat.org>
References: <20180116131555.14242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/11] sysbus: add realize() and unrealize()
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/sysbus.h |  4 ++++
 hw/core/sysbus.c    | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index e88bb6dae0..c87a6df29e 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -40,6 +40,10 @@ typedef struct SysBusDeviceClass {
     DeviceClass parent_class;
     /*< public >*/
 
+    void (*realize)(SysBusDevice *dev, Error **errp);
+    void (*unrealize)(SysBusDevice *dev, Error **errp);
+
+    /* TODO remove, once users are converted to realize */
     int (*init)(SysBusDevice *dev);
 
     /*
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 5d0887f499..04d6061f76 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -200,6 +200,7 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_t ioport, uint32_t size)
     }
 }
 
+/* TODO remove, once users are converted to realize */
 static int sysbus_device_init(DeviceState *dev)
 {
     SysBusDevice *sd = SYS_BUS_DEVICE(dev);
@@ -211,6 +212,26 @@ static int sysbus_device_init(DeviceState *dev)
     return sbc->init(sd);
 }
 
+static void sysbus_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
+    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
+
+    if (sbc->realize) {
+        sbc->realize(sd, errp);
+    }
+}
+
+static void sysbus_unrealize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
+    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
+
+    if (sbc->unrealize) {
+        sbc->unrealize(sd, errp);
+    }
+}
+
 DeviceState *sysbus_create_varargs(const char *name,
                                    hwaddr addr, ...)
 {
@@ -325,6 +346,8 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
     k->init = sysbus_device_init;
+    k->realize = sysbus_realize;
+    k->unrealize = sysbus_unrealize;
     k->bus_type = TYPE_SYSTEM_BUS;
     /*
      * device_add plugs devices into a suitable bus.  For "real" buses,
-- 
2.15.1
