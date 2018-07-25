Received: from eggs.gnu.org ([2001:4830:134:3::10]:48519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1fiKrx-00016S-4g
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1fiKru-00066r-4Z
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:25 -0400
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15]:47406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1fiKrt-00065c-QV
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:34:22 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 25 Jul 2018 16:34:10 +0200
Message-Id: <20180725143413.9728-2-geert+renesas@glider.be>
In-Reply-To: <20180725143413.9728-1-geert+renesas@glider.be>
References: <20180725143413.9728-1-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH v3 1/4] vfio/platform: Make the vfio-platform
 device non-abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Magnus Damm <damm+renesas@opensource.se>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Auger Eric <eric.auger@redhat.com>

Up to now the vfio-platform device has been abstract and could not be
instantiated.  The integration of a new vfio platform device required
creating a dummy derived device which only set the compatible string.

Following the few vfio-platform device integrations we have seen the
actual requested adaptation happens on device tree node creation
(sysbus-fdt).

Hence remove the abstract setting, and read the list of compatible
values from sysfs if not set by a derived device.

Update the amd-xgbe and calxeda-xgmac drivers to fill in the number of
compatible values, as there can now be more than one.

Note that sysbus-fdt does not support the instantiation of the
vfio-platform device yet.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
[geert: Rebase, set user_creatable=true, use compatible values in sysfs
	instead of user-supplied manufacturer/model options, reword]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Read all compatible values from sysfs instead of using user-supplied
    manufacturer and model options,
  - Reword patch description,
  - Drop RFC state,

v2:
  - No changes,

v1:
  - Rebase, Set user_creatable=true,

v0:
  - Original version from Eric.
---
 hw/vfio/amd-xgbe.c              |  1 +
 hw/vfio/calxeda-xgmac.c         |  1 +
 hw/vfio/platform.c              | 22 +++++++++++++++++++++-
 include/hw/vfio/vfio-platform.h |  3 ++-
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index 0c4ec4ba25170366..ee64a3b4a2e45bf5 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -20,6 +20,7 @@ static void amd_xgbe_realize(DeviceState *dev, Error **errp)
     VFIOAmdXgbeDeviceClass *k = VFIO_AMD_XGBE_DEVICE_GET_CLASS(dev);
 
     vdev->compat = g_strdup("amd,xgbe-seattle-v1a");
+    vdev->num_compat = 1;
 
     k->parent_realize(dev, errp);
 }
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index 24cee6d06512c1b6..e7767c4b021be566 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -20,6 +20,7 @@ static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
     VFIOCalxedaXgmacDeviceClass *k = VFIO_CALXEDA_XGMAC_DEVICE_GET_CLASS(dev);
 
     vdev->compat = g_strdup("calxeda,hb-xgmac");
+    vdev->num_compat = 1;
 
     k->parent_realize(dev, errp);
 }
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 57c4a0ee2b58da70..e264555cd5dafb16 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -655,6 +655,25 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
         goto out;
     }
 
+    if (!vdev->compat) {
+        gchar *contents;
+        gsize length;
+        char *tmp;
+
+        tmp = g_strdup_printf("%s/of_node/compatible", vbasedev->sysfsdev);
+        if (!g_file_get_contents(tmp, &contents, &length, NULL)) {
+            error_report("failed to load \"%s\"", tmp);
+            exit(1);
+        }
+        g_free(tmp);
+        vdev->compat = contents;
+        for (vdev->num_compat = 0; length; vdev->num_compat++) {
+            size_t skip = strlen(contents) + 1;
+            contents += skip;
+            length -= skip;
+        }
+    }
+
     for (i = 0; i < vbasedev->num_regions; i++) {
         if (vfio_region_mmap(vdev->regions[i])) {
             error_report("%s mmap unsupported. Performance may be slow",
@@ -700,6 +719,8 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /* Supported by TYPE_VIRT_MACHINE */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_platform_dev_info = {
@@ -708,7 +729,6 @@ static const TypeInfo vfio_platform_dev_info = {
     .instance_size = sizeof(VFIOPlatformDevice),
     .class_init = vfio_platform_class_init,
     .class_size = sizeof(VFIOPlatformDeviceClass),
-    .abstract   = true,
 };
 
 static void register_vfio_platform_dev_type(void)
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index 9baaa2db09b84f3e..0ee10b1d71ed2503 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -54,7 +54,8 @@ typedef struct VFIOPlatformDevice {
     QLIST_HEAD(, VFIOINTp) intp_list; /* list of IRQs */
     /* queue of pending IRQs */
     QSIMPLEQ_HEAD(pending_intp_queue, VFIOINTp) pending_intp_queue;
-    char *compat; /* compatibility string */
+    char *compat; /* DT compatible values, separated by NUL */
+    unsigned int num_compat; /* number of compatible values */
     uint32_t mmap_timeout; /* delay to re-enable mmaps after interrupt */
     QEMUTimer *mmap_timer; /* allows fast-path resume after IRQ hit */
     QemuMutex intp_mutex; /* protect the intp_list IRQ state */
-- 
2.17.1
