Received: from eggs.gnu.org ([2001:4830:134:3::10]:59481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBZ-0006Qm-7E
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fORBW-00049v-21
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fORBV-00048m-UZ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 13:16:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91D6B401EF10
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:21 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-47.ams2.redhat.com
	[10.36.117.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1E69B39D63
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 17:16:20 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 May 2018 19:16:03 +0200
Message-Id: <20180531171606.21604-12-pbonzini@redhat.com>
In-Reply-To: <20180531171606.21604-1-pbonzini@redhat.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171606.21604-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 50/53] qdev: Simplify the
 SysBusDeviceClass::init path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Instead of using
  SysBusDeviceClass::realize
   -> DeviceClass::realize
       -> DeviceClass::init
           -> sysbus_device_init
              -> SysBusDeviceClass::init

Simplify the path by directly calling SysBusDeviceClass::init
in SysBusDeviceClass::realize:

  SysBusDeviceClass::realize
   -> SysBusDeviceClass::init

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180419212727.26095-4-f4bug@amsat.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Removal of DeviceClass::init() moved into next patch,
sysbus_realize() tweaked for clarity]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180528144509.15812-4-armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/sysbus.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 5d0887f499..ecfb0cfc0e 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -18,6 +18,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "monitor/monitor.h"
 #include "exec/address-spaces.h"
@@ -200,15 +201,18 @@ void sysbus_init_ioports(SysBusDevice *dev, uint32_=
t ioport, uint32_t size)
     }
 }
=20
-static int sysbus_device_init(DeviceState *dev)
+/* TODO remove once all sysbus devices have been converted to realize */
+static void sysbus_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sd =3D SYS_BUS_DEVICE(dev);
     SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_GET_CLASS(sd);
=20
     if (!sbc->init) {
-        return 0;
+        return;
+    }
+    if (sbc->init(sd) < 0) {
+        error_setg(errp, "Device initialization failed");
     }
-    return sbc->init(sd);
 }
=20
 DeviceState *sysbus_create_varargs(const char *name,
@@ -324,7 +328,7 @@ MemoryRegion *sysbus_address_space(SysBusDevice *dev)
 static void sysbus_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k =3D DEVICE_CLASS(klass);
-    k->init =3D sysbus_device_init;
+    k->realize =3D sysbus_realize;
     k->bus_type =3D TYPE_SYSTEM_BUS;
     /*
      * device_add plugs devices into a suitable bus.  For "real" buses,
--=20
2.17.0
