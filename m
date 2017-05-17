Received: from eggs.gnu.org ([2001:4830:134:3::10]:36282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtJ-0001cu-D4
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtD-0001mI-FC
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:17 -0400
Received: from [59.151.112.132] (port=20783 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dAwtD-0001kb-1v
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:13:11 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 17 May 2017 19:12:25 +0800
Message-ID: <645c1b3e6fc23605365c0685d94ec50df7a7fd2b.1495018956.git.maozy.fnst@cn.fujitsu.com>
In-Reply-To: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1495018956.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 3/3] net/rocker: Convert to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, f4bug@amsat.org, armbru@redhat.com

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
errp argument. Also avoid the superfluous second error message. After
the patch, effect like this:

    $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=qemu-rocker
    qemu-system-x86_64: -device rocker,name=qemu-rocker: name too long; please shorten to at most 9 chars

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: f4bug@amsat.org
Cc: armbru@redhat.com
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/net/rocker/rocker.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index a382a6f..b9a77f1 100644
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
@@ -1319,10 +1317,9 @@ static int pci_rocker_init(PCIDevice *dev)
 
     r->world_dflt = rocker_world_type_by_name(r, r->world_name);
     if (!r->world_dflt) {
-        fprintf(stderr,
-                "rocker: requested world \"%s\" does not exist\n",
+        error_setg(errp,
+                "invalid argument requested world %s does not exist",
                 r->world_name);
-        err = -EINVAL;
         goto err_world_type_by_name;
     }
 
@@ -1342,7 +1339,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     /* MSI-X init */
 
-    err = rocker_msix_init(r);
+    err = rocker_msix_init(r, errp);
     if (err) {
         goto err_msix_init;
     }
@@ -1354,7 +1351,7 @@ static int pci_rocker_init(PCIDevice *dev)
     }
 
     if (rocker_find(r->name)) {
-        err = -EEXIST;
+        error_setg(errp, "%s already exists", r->name);
         goto err_duplicate;
     }
 
@@ -1368,10 +1365,9 @@ static int pci_rocker_init(PCIDevice *dev)
 #define ROCKER_IFNAMSIZ 16
 #define MAX_ROCKER_NAME_LEN  (ROCKER_IFNAMSIZ - 1 - 3 - 3)
     if (strlen(r->name) > MAX_ROCKER_NAME_LEN) {
-        fprintf(stderr,
-                "rocker: name too long; please shorten to at most %d chars\n",
+        error_setg(errp,
+                "name too long; please shorten to at most %d chars",
                 MAX_ROCKER_NAME_LEN);
-        err = -EINVAL;
         goto err_name_too_long;
     }
 
@@ -1429,7 +1425,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     QLIST_INSERT_HEAD(&rockers, r, next);
 
-    return 0;
+    return;
 
 err_name_too_long:
 err_duplicate:
@@ -1443,7 +1439,6 @@ err_world_type_by_name:
             world_free(r->worlds[i]);
         }
     }
-    return err;
 }
 
 static void pci_rocker_uninit(PCIDevice *dev)
@@ -1528,7 +1523,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->init = pci_rocker_init;
+    k->realize = pci_rocker_realize;
     k->exit = pci_rocker_uninit;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_ROCKER;
-- 
2.9.3
