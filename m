Received: from eggs.gnu.org ([2001:4830:134:3::10]:50916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6nw-0003O4-U3
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6nq-0003qr-32
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gC6no-0003p8-Tt
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:13 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 15 Oct 2018 11:36:58 -0600
Message-ID: <153962501804.21502.18120266679271950498.stgit@gimli.home>
In-Reply-To: <153962488126.21502.17134983449941187881.stgit@gimli.home>
References: <153962488126.21502.17134983449941187881.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 3/6] vfio/platform: Make the vfio-platform
 device non-abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>Eric Auger <eric.auger@redhat.com>Eric Auger <eric.auger@redhat.com>

From: Eric Auger <eric.auger@redhat.com>

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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/amd-xgbe.c              |    1 +
 hw/vfio/calxeda-xgmac.c         |    1 +
 hw/vfio/platform.c              |   25 ++++++++++++++++++++++++-
 include/hw/vfio/vfio-platform.h |    3 ++-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index 0c4ec4ba2517..ee64a3b4a2e4 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -20,6 +20,7 @@ static void amd_xgbe_realize(DeviceState *dev, Error **errp)
     VFIOAmdXgbeDeviceClass *k = VFIO_AMD_XGBE_DEVICE_GET_CLASS(dev);
 
     vdev->compat = g_strdup("amd,xgbe-seattle-v1a");
+    vdev->num_compat = 1;
 
     k->parent_realize(dev, errp);
 }
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index 24cee6d06512..e7767c4b021b 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -20,6 +20,7 @@ static void calxeda_xgmac_realize(DeviceState *dev, Error **errp)
     VFIOCalxedaXgmacDeviceClass *k = VFIO_CALXEDA_XGMAC_DEVICE_GET_CLASS(dev);
 
     vdev->compat = g_strdup("calxeda,hb-xgmac");
+    vdev->num_compat = 1;
 
     k->parent_realize(dev, errp);
 }
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 57c4a0ee2b58..64c1af653d14 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -655,6 +655,28 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
         goto out;
     }
 
+    if (!vdev->compat) {
+        GError *gerr = NULL;
+        gchar *contents;
+        gsize length;
+        char *path;
+
+        path = g_strdup_printf("%s/of_node/compatible", vbasedev->sysfsdev);
+        if (!g_file_get_contents(path, &contents, &length, &gerr)) {
+            error_setg(errp, "%s", gerr->message);
+            g_error_free(gerr);
+            g_free(path);
+            return;
+        }
+        g_free(path);
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
@@ -700,6 +722,8 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
     dc->desc = "VFIO-based platform device assignment";
     sbc->connect_irq_notifier = vfio_start_irqfd_injection;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /* Supported by TYPE_VIRT_MACHINE */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_platform_dev_info = {
@@ -708,7 +732,6 @@ static const TypeInfo vfio_platform_dev_info = {
     .instance_size = sizeof(VFIOPlatformDevice),
     .class_init = vfio_platform_class_init,
     .class_size = sizeof(VFIOPlatformDeviceClass),
-    .abstract   = true,
 };
 
 static void register_vfio_platform_dev_type(void)
diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index 9baaa2db09b8..0ee10b1d71ed 100644
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
