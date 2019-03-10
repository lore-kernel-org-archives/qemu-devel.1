Received: from eggs.gnu.org ([209.51.188.92]:54049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1h2nP8-0001x9-7M
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 20:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1h2nP7-0008If-BZ
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 20:37:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:51622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1h2nP7-0008Hp-4K
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 20:37:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id n19so1099689wmi.1
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 17:37:28 -0800 (PST)
Date: Sun, 10 Mar 2019 02:39:13 +0100
From: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190310013913.GA16519@erokenlabserver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] Replace calls to object_child_foreach() with
 object_child_foreach_recursive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com

Replace calls to object_child_foreach() with object_child_foreach_recursive()
when applicable: nvdimm_device_list, nmi_monitor_handle, find_sysbus_device,
pc_dimm_slot2bitmap, build_dimm_list.

Signed-off-by: Ernest Esene <eroken1@gmail.com>
---
 hw/acpi/nvdimm.c           | 5 +++--
 hw/core/sysbus.c           | 2 +-
 hw/mem/pc-dimm.c           | 5 +++--
 hw/virtio/virtio-balloon.c | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index e53b2cb..846f44b 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -41,7 +41,7 @@ static int nvdimm_device_list(Object *obj, void *opaque)
         *list = g_slist_append(*list, DEVICE(obj));
     }
 
-    object_child_foreach(obj, nvdimm_device_list, opaque);
+    object_child_foreach_recursive(obj, nvdimm_device_list, opaque);
     return 0;
 }
 
@@ -56,7 +56,8 @@ static GSList *nvdimm_get_device_list(void)
 {
     GSList *list = NULL;
 
-    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
+    object_child_foreach_recursive(qdev_get_machine(),
+                                   nvdimm_device_list, &list);
     return list;
 }
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 9f9edbc..c16d57c 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -43,7 +43,7 @@ static int find_sysbus_device(Object *obj, void *opaque)
 
     if (!sbdev) {
         /* Container, traverse it for children */
-        return object_child_foreach(obj, find_sysbus_device, opaque);
+        return object_child_foreach_recursive(obj, find_sysbus_device, opaque);
     }
 
     find->func(sbdev, find->opaque);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 152400b..844c8ac 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -84,7 +84,7 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
         }
     }
 
-    object_child_foreach(obj, pc_dimm_slot2bitmap, opaque);
+    object_child_foreach_recursive(obj, pc_dimm_slot2bitmap, opaque);
     return 0;
 }
 
@@ -100,7 +100,8 @@ static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
     }
 
     bitmap = bitmap_new(max_slots);
-    object_child_foreach(qdev_get_machine(), pc_dimm_slot2bitmap, bitmap);
+    object_child_foreach_recursive(qdev_get_machine(),
+                                   pc_dimm_slot2bitmap, bitmap);
 
     /* check if requested slot is not occupied */
     if (hint) {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index e3a6594..ce4b8a5 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -591,7 +591,7 @@ static int build_dimm_list(Object *obj, void *opaque)
         }
     }
 
-    object_child_foreach(obj, build_dimm_list, opaque);
+    object_child_foreach_recursive(obj, build_dimm_list, opaque);
     return 0;
 }
 
-- 
2.14.2
