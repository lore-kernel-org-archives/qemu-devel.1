Received: from eggs.gnu.org ([2001:4830:134:3::10]:35355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cMjLA-0006ab-DG
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cMjL7-0006Wg-AE
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:38:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cMjL7-0006VT-3t
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 17:38:25 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 29 Dec 2016 20:38:15 -0200
Message-Id: <20161229223815.13705-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] qdev: Make "hotplugged" property read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The "hotplugged" property is user visible, but it was never meant
to be set by the user. There are probably multiple ways to break
or crash device code by overriding the property. One example:

  $ qemu-system-x86_64 -cpu qemu64,hotplugged=true
  Segmentation fault (core dumped)

The DeviceState::hotplugged struct field is set directly by
device_initfn(), there's no need to provide a setter for the
property.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 57834423b9..f5989c41cb 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1013,13 +1013,6 @@ static bool device_get_hotplugged(Object *obj, Error **err)
     return dev->hotplugged;
 }
 
-static void device_set_hotplugged(Object *obj, bool value, Error **err)
-{
-    DeviceState *dev = DEVICE(obj);
-
-    dev->hotplugged = value;
-}
-
 static void device_initfn(Object *obj)
 {
     DeviceState *dev = DEVICE(obj);
@@ -1039,7 +1032,7 @@ static void device_initfn(Object *obj)
     object_property_add_bool(obj, "hotpluggable",
                              device_get_hotpluggable, NULL, NULL);
     object_property_add_bool(obj, "hotplugged",
-                             device_get_hotplugged, device_set_hotplugged,
+                             device_get_hotplugged, NULL,
                              &error_abort);
 
     class = object_get_class(OBJECT(dev));
-- 
2.11.0.259.g40922b1
