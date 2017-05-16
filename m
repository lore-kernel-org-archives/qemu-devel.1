Received: from eggs.gnu.org ([2001:4830:134:3::10]:46799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAbkF-0006Av-RR
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAbkB-0002y8-PS
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:38:31 -0400
Received: from [59.151.112.132] (port=24045 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAbk9-0002vs-U4
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:38:27 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Tue, 16 May 2017 20:37:43 +0800
Message-ID: <22f56a33f9774a678c72dc5c0920a5c562cc6ea2.1494937835.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] net/rocker: Convert to realize
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

The rocker device still implements the old PCIDeviceClass .init()
instead of the new .realize(). All devices need to be converted to
.realize().

.init() reports errors with fprintf() and return 0 on success, negative
number on failure. Meanwhile, when -device rocker fails, it first report
a specific error, then a generic one, like this:

    $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=qemu-rocker
    rocker: name too long; please shorten to at most 9 chars
    qemu-system-x86_64: -device rocker,name=qemu-rocker: Device initialization failed

Now, convert it to .realize() that passes errors to its callers via its
errp argument. Also avoid the superfluous second error message.

Cc: jiri@resnulli.us
Cc: jasowang@redhat.com
Cc: f4bug@amsat.org
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/net/rocker/rocker.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 6e70fdd..c446cda 100644
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
+            error_setg(errp, "rocker: memory allocation for worlds failed");
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
@@ -1397,6 +1394,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     r->rings = g_new(DescRing *, rocker_pci_ring_count(r));
     if (!r->rings) {
+        error_setg(errp, "rocker: memory allocation for rings failed");
         goto err_rings_alloc;
     }
 
@@ -1410,11 +1408,11 @@ static int pci_rocker_init(PCIDevice *dev)
      * .....
      */
 
-    err = -ENOMEM;
     for (i = 0; i < rocker_pci_ring_count(r); i++) {
         DescRing *ring = desc_ring_alloc(r, i);
 
         if (!ring) {
+            error_setg(errp, "rocker: memory allocation for ring failed");
             goto err_ring_alloc;
         }
 
@@ -1438,6 +1436,7 @@ static int pci_rocker_init(PCIDevice *dev)
                           i, &r->fp_ports_peers[i]);
 
         if (!port) {
+            error_setg(errp, "rocker: memory allocation for port failed");
             goto err_port_alloc;
         }
 
@@ -1447,7 +1446,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     QLIST_INSERT_HEAD(&rockers, r, next);
 
-    return 0;
+    return;
 
 err_port_alloc:
     for (--i; i >= 0; i--) {
@@ -1461,6 +1460,7 @@ err_ring_alloc:
     }
     g_free(r->rings);
 err_rings_alloc:
+err_name_too_long:
 err_duplicate:
     rocker_msix_uninit(r);
 err_msix_init:
@@ -1473,7 +1473,6 @@ err_world_alloc:
             world_free(r->worlds[i]);
         }
     }
-    return err;
 }
 
 static void pci_rocker_uninit(PCIDevice *dev)
@@ -1558,7 +1557,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->init = pci_rocker_init;
+    k->realize = pci_rocker_realize;
     k->exit = pci_rocker_uninit;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_ROCKER;
-- 
2.9.3
