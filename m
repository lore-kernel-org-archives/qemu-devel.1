Received: from eggs.gnu.org ([2001:4830:134:3::10]:44004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgcYx-0007R4-G7
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:26:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgcYu-0003ed-Dj
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:26:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgcYu-0003eO-7p
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:26:52 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 22 Feb 2017 16:26:47 -0300
Message-Id: <20170222192647.19690-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH RESEND] qdev: Make "hotplugged" property
 read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, libvir-list@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

The "hotplugged" property is user visible, but it was never meant
to be set by the user. There are probably multiple ways to break
or crash device code by overriding the property. For example, we
recently fixed a crash in rtc_set_memory() related to the
property (commit 26ef65beab852caf2b1ef4976e3473f2d525164d).

There has been some discussion about making management software
use "hotplugged=on" on migration, to indicate devices that were
hotplugged in the migration source. There were other suggestions
to address this, like including the "hotplugged" field in the
migration stream instead of requiring it to be set propertly.

Whatever solution we choose in the future, this patch disables
setting "hotplugged" explicitly in the command-line by now,
because the ability to set the property is unused, untested, and
undocumented.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/qdev.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 06ba02e2a3..800c9ca23f 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1016,13 +1016,6 @@ static bool device_get_hotplugged(Object *obj, Error **err)
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
@@ -1042,7 +1035,7 @@ static void device_initfn(Object *obj)
     object_property_add_bool(obj, "hotpluggable",
                              device_get_hotpluggable, NULL, NULL);
     object_property_add_bool(obj, "hotplugged",
-                             device_get_hotplugged, device_set_hotplugged,
+                             device_get_hotplugged, NULL,
                              &error_abort);
 
     class = object_get_class(OBJECT(dev));
-- 
2.11.0.259.g40922b1
