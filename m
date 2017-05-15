Received: from eggs.gnu.org ([2001:4830:134:3::10]:56522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dA694-00010V-JB
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:54:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dA690-0006ve-LB
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:54:02 -0400
Received: from [59.151.112.132] (port=25524 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dA68z-0006sL-KS
	for qemu-devel@nongnu.org; Sun, 14 May 2017 22:53:58 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Mon, 15 May 2017 10:53:19 +0800
Message-ID: <271c246e5d92be095de3dc28dcaf85184e05264a.1494816085.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] net/rocker: Convert pci device .init() to
 .realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jiri@resnulli.us, jasowang@redhat.com, f4bug@amsat.org

Convert pci device .init() to .realize(). Also improve -device rocker
error reporting. Because when -device rocker fails, it first reports
a specific error, then a generic one, like this:

    $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=qemu-rocker
    rocker: name too long; please shorten to at most 9 chars
    qemu-system-x86_64: -device rocker,name=qemu-rocker: Device initialization failed

Convert pci_rocker_init() to Error to get rid of the unwanted second
error message.

Cc: jiri@resnulli.us
Cc: jasowang@redhat.com
Cc: f4bug@amsat.org
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/net/rocker/rocker.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 6e70fdd..a1de705 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1252,20 +1252,18 @@ rollback:
     return err;
 }
 
-static int rocker_msix_init(Rocker *r)
+static int rocker_msix_init(Rocker *r, Error **errp)
 {
     PCIDevice *dev = PCI_DEVICE(r);
     int err;
-    Error *local_err = NULL;
 
     err = msix_init(dev, ROCKER_MSIX_VEC_COUNT(r->fp_ports),
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_TABLE_OFFSET,
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
-                    0, &local_err);
+                    0, errp);
     if (err) {
-        error_report_err(local_err);
         return err;
     }
 
@@ -1301,7 +1299,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
     return NULL;
 }
 
-static int pci_rocker_init(PCIDevice *dev)
+static void pci_rocker_realize(PCIDevice *dev, Error **errp)
 {
     Rocker *r = to_rocker(dev);
     const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
@@ -1315,7 +1313,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     for (i = 0; i < ROCKER_WORLD_TYPE_MAX; i++) {
         if (!r->worlds[i]) {
-            err = -ENOMEM;
+            error_setg(errp, "allocate worlds failed");
             goto err_world_alloc;
         }
     }
@@ -1326,10 +1324,9 @@ static int pci_rocker_init(PCIDevice *dev)
 
     r->world_dflt = rocker_world_type_by_name(r, r->world_name);
     if (!r->world_dflt) {
-        fprintf(stderr,
-                "rocker: requested world \"%s\" does not exist\n",
+        error_setg(errp,
+                "rocker: invalid argument, requested world %s does not exist",
                 r->world_name);
-        err = -EINVAL;
         goto err_world_type_by_name;
     }
 
@@ -1349,7 +1346,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     /* MSI-X init */
 
-    err = rocker_msix_init(r);
+    err = rocker_msix_init(r, errp);
     if (err) {
         goto err_msix_init;
     }
@@ -1361,7 +1358,7 @@ static int pci_rocker_init(PCIDevice *dev)
     }
 
     if (rocker_find(r->name)) {
-        err = -EEXIST;
+        error_setg(errp, "rocker: %s already exists", r->name);
         goto err_duplicate;
     }
 
@@ -1375,10 +1372,10 @@ static int pci_rocker_init(PCIDevice *dev)
 #define ROCKER_IFNAMSIZ 16
 #define MAX_ROCKER_NAME_LEN  (ROCKER_IFNAMSIZ - 1 - 3 - 3)
     if (strlen(r->name) > MAX_ROCKER_NAME_LEN) {
-        fprintf(stderr,
-                "rocker: name too long; please shorten to at most %d chars\n",
+        error_setg(errp,
+                "rocker: name too long; please shorten to at most %d chars",
                 MAX_ROCKER_NAME_LEN);
-        return -EINVAL;
+        goto err_name_too_long;
     }
 
     if (memcmp(&r->fp_start_macaddr, &zero, sizeof(zero)) == 0) {
@@ -1410,7 +1407,6 @@ static int pci_rocker_init(PCIDevice *dev)
      * .....
      */
 
-    err = -ENOMEM;
     for (i = 0; i < rocker_pci_ring_count(r); i++) {
         DescRing *ring = desc_ring_alloc(r, i);
 
@@ -1447,7 +1443,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     QLIST_INSERT_HEAD(&rockers, r, next);
 
-    return 0;
+    return;
 
 err_port_alloc:
     for (--i; i >= 0; i--) {
@@ -1461,6 +1457,7 @@ err_ring_alloc:
     }
     g_free(r->rings);
 err_rings_alloc:
+err_name_too_long:
 err_duplicate:
     rocker_msix_uninit(r);
 err_msix_init:
@@ -1473,7 +1470,6 @@ err_world_alloc:
             world_free(r->worlds[i]);
         }
     }
-    return err;
 }
 
 static void pci_rocker_uninit(PCIDevice *dev)
@@ -1558,7 +1554,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->init = pci_rocker_init;
+    k->realize = pci_rocker_realize;
     k->exit = pci_rocker_uninit;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_ROCKER;
-- 
2.9.3
