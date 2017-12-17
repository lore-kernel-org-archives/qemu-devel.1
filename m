Received: from eggs.gnu.org ([2001:4830:134:3::10]:59767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQfsK-0001HN-HS
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:49:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eQfsJ-0005cR-HT
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 15:49:32 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 17 Dec 2017 17:49:10 -0300
Message-Id: <20171217204912.12420-3-f4bug@amsat.org>
In-Reply-To: <20171217204912.12420-1-f4bug@amsat.org>
References: <20171217204912.12420-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] hw/pci-host/piix: QOM'ify the IGD
 Passthrough host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/pci-host/piix.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index a684a7cca9..0153f32a32 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -804,7 +804,7 @@ static const IGDHostInfo igd_host_bridge_infos[] = {
     {0xa8, 4},  /* SNB: base of GTT stolen memory */
 };
 
-static int host_pci_config_read(int pos, int len, uint32_t *val)
+static void host_pci_config_read(int pos, int len, uint32_t *val, Error **errp)
 {
     char path[PATH_MAX];
     int config_fd;
@@ -812,19 +812,19 @@ static int host_pci_config_read(int pos, int len, uint32_t *val)
     /* Access real host bridge. */
     int rc = snprintf(path, size, "/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
                       0, 0, 0, 0, "config");
-    int ret = 0;
 
     if (rc >= size || rc < 0) {
-        return -ENODEV;
+        error_setg(&error_abort, "Invalid PCI device");
     }
 
     config_fd = open(path, O_RDWR);
     if (config_fd < 0) {
-        return -ENODEV;
+        error_setg_errno(errp, errno, "Failed to open: %s", path);
+        return;
     }
 
     if (lseek(config_fd, pos, SEEK_SET) != pos) {
-        ret = -errno;
+        error_setg_errno(errp, errno, "Failed to seek: %s", path);
         goto out;
     }
 
@@ -832,32 +832,31 @@ static int host_pci_config_read(int pos, int len, uint32_t *val)
         rc = read(config_fd, (uint8_t *)val, len);
     } while (rc < 0 && (errno == EINTR || errno == EAGAIN));
     if (rc != len) {
-        ret = -errno;
+        error_setg_errno(errp, errno, "Failed to read: %s", path);
     }
 
 out:
     close(config_fd);
-    return ret;
 }
 
-static int igd_pt_i440fx_initfn(struct PCIDevice *pci_dev)
+static void igd_pt_i440fx_realize(PCIDevice *pci, Error **errp)
 {
     uint32_t val = 0;
-    int rc, i, num;
+    int i, num;
     int pos, len;
+    Error *local_err = NULL;
 
     num = ARRAY_SIZE(igd_host_bridge_infos);
     for (i = 0; i < num; i++) {
         pos = igd_host_bridge_infos[i].offset;
         len = igd_host_bridge_infos[i].len;
-        rc = host_pci_config_read(pos, len, &val);
-        if (rc) {
-            return -ENODEV;
+        host_pci_config_read(pos, len, &val, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
         }
-        pci_default_write_config(pci_dev, pos, val, len);
+        pci_default_write_config(pci, pos, val, len);
     }
-
-    return 0;
 }
 
 static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *data)
@@ -865,7 +864,7 @@ static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->init = igd_pt_i440fx_initfn;
+    k->realize = igd_pt_i440fx_realize;
     dc->desc = "IGD Passthrough Host bridge";
 }
 
-- 
2.15.1
