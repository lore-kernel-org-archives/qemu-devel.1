Received: from eggs.gnu.org ([2001:4830:134:3::10]:47276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7j-00022z-Cs
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d1H7i-0004br-LW
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d1H7i-0004bd-FN
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 14:48:10 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Apr 2017 15:47:00 -0300
Message-Id: <20170420184705.25018-11-ehabkost@redhat.com>
In-Reply-To: <20170420184705.25018-1-ehabkost@redhat.com>
References: <20170420184705.25018-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 10/15] qdev: Make "hotplugged" property read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The "hotplugged" property is user visible, but it was never meant
to be set by the user. There are probably multiple ways to break
or crash device code by overriding the property. For example, we
recently fixed a crash in rtc_set_memory() related to the
property (commit 26ef65beab852caf2b1ef4976e3473f2d525164d).

There has been some discussion about making management software
use "hotplugged=on" on migration, to indicate devices that were
hotplugged in the migration source. There were other suggestions
to address this, like including the "hotplugged" field in the
migration stream instead of requiring it to be set explicitly.

Whatever solution we choose in the future, this patch disables
setting "hotplugged" explicitly in the command-line by now,
because the ability to set the property is unused, untested, and
undocumented.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170222192647.19690-1-ehabkost@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 1e7fb33246..695d7c4216 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1037,13 +1037,6 @@ static bool device_get_hotplugged(Object *obj, Error **err)
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
@@ -1063,7 +1056,7 @@ static void device_initfn(Object *obj)
     object_property_add_bool(obj, "hotpluggable",
                              device_get_hotpluggable, NULL, NULL);
     object_property_add_bool(obj, "hotplugged",
-                             device_get_hotplugged, device_set_hotplugged,
+                             device_get_hotplugged, NULL,
                              &error_abort);
 
     class = object_get_class(OBJECT(dev));
-- 
2.11.0.259.g40922b1
