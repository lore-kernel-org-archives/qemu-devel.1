Received: from eggs.gnu.org ([2001:4830:134:3::10]:40890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSl-0001QY-Rj
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSk-0007ID-1i
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:35 -0400
Received: from [59.151.112.132] (port=30802 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHSj-0007El-LG
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:14:33 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 16:13:34 +0800
Message-ID: <8f6ed7f3f793bad355074ebd97b4f4ac5190a787.1501052660.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
References: <cover.1501052660.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 3/4] net/rocker: Convert to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

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
Cc: armbru@redhat.com
Cc: f4bug@amsat.org
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/rocker/rocker.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 9a538a9..bb38cba 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1236,20 +1236,18 @@ rollback:
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
 
@@ -1285,7 +1283,7 @@ static World *rocker_world_type_by_name(Rocker *r, const char *name)
     return NULL;
 }
 
-static int pci_rocker_init(PCIDevice *dev)
+static void pci_rocker_realize(PCIDevice *dev, Error **errp)
 {
     Rocker *r = to_rocker(dev);
     const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
@@ -1303,10 +1301,9 @@ static int pci_rocker_init(PCIDevice *dev)
 
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
 
@@ -1326,7 +1323,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     /* MSI-X init */
 
-    err = rocker_msix_init(r);
+    err = rocker_msix_init(r, errp);
     if (err) {
         goto err_msix_init;
     }
@@ -1338,7 +1335,7 @@ static int pci_rocker_init(PCIDevice *dev)
     }
 
     if (rocker_find(r->name)) {
-        err = -EEXIST;
+        error_setg(errp, "%s already exists", r->name);
         goto err_duplicate;
     }
 
@@ -1352,10 +1349,9 @@ static int pci_rocker_init(PCIDevice *dev)
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
 
@@ -1413,7 +1409,7 @@ static int pci_rocker_init(PCIDevice *dev)
 
     QLIST_INSERT_HEAD(&rockers, r, next);
 
-    return 0;
+    return;
 
 err_name_too_long:
 err_duplicate:
@@ -1427,7 +1423,6 @@ err_world_type_by_name:
             world_free(r->worlds[i]);
         }
     }
-    return err;
 }
 
 static void pci_rocker_uninit(PCIDevice *dev)
@@ -1512,7 +1507,7 @@ static void rocker_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->init = pci_rocker_init;
+    k->realize = pci_rocker_realize;
     k->exit = pci_rocker_uninit;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_ROCKER;
-- 
2.9.4
