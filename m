Received: from eggs.gnu.org ([2001:4830:134:3::10]:50626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1enjPk-0001qO-3L
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1enjPf-0003p9-46
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:15:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1enjPe-0003ou-Uz
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 06:15:15 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 19 Feb 2018 12:14:55 +0100
Message-Id: <20180219111458.25983-5-kraxel@redhat.com>
In-Reply-To: <20180219111458.25983-1-kraxel@redhat.com>
References: <20180219111458.25983-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v4 4/7] qdev: add hotpluggable to DeviceState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>

vfio display support wants disable hotplug for certain devices, because
qemu doesn't support hotplugging display devices and qemu consoles.

Add a hotpluggable bool to DeviceState, initialize it from
DeviceClass->hotpluggable, update device_get_hotpluggable accordingly.

Devices can flip the new variable from true to false if needed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/qdev-core.h | 1 +
 hw/core/qdev.c         | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index fc9d617a76..37d86f26e5 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -154,6 +154,7 @@ struct DeviceState {
     const char *id;
     char *canonical_path;
     bool realized;
+    bool hotpluggable;
     bool pending_deleted_event;
     QemuOpts *opts;
     int hotplugged;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 7ed1f431f0..89e03c7b47 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -946,8 +946,8 @@ static bool device_get_hotpluggable(Object *obj, Error **errp)
     DeviceClass *dc = DEVICE_GET_CLASS(obj);
     DeviceState *dev = DEVICE(obj);
 
-    return dc->hotpluggable && (dev->parent_bus == NULL ||
-                                qbus_is_hotpluggable(dev->parent_bus));
+    return dc->hotpluggable && dev->hotpluggable &&
+        (dev->parent_bus == NULL || qbus_is_hotpluggable(dev->parent_bus));
 }
 
 static bool device_get_hotplugged(Object *obj, Error **err)
@@ -988,6 +988,7 @@ static void device_initfn(Object *obj)
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
 
+    dev->hotpluggable = DEVICE_CLASS(class)->hotpluggable;
     object_property_add_link(OBJECT(dev), "parent_bus", TYPE_BUS,
                              (Object **)&dev->parent_bus, NULL, 0,
                              &error_abort);
-- 
2.9.3
