Received: from eggs.gnu.org ([2001:4830:134:3::10]:60775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8g5-00036K-5q
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8g0-00024N-9R
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8g0-00023v-1F
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:05:48 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:10 +0800
Message-Id: <1504836324-4871-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/18] net/rocker: Convert to realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, jasowang@redhat.com, jiri@resnulli.us, armbru@redhat.com, f4bug@amsat.org

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

The rocker device still implements the old PCIDeviceClass .init()
instead of the new .realize(). All devices need to be converted to
.realize().

.init() reports errors with fprintf() and return 0 on success, negative
number on failure. Meanwhile, when -device rocker fails, it first report
a specific error, then a generic one, like this:

    $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=3Dqemu-rocker
    rocker: name too long; please shorten to at most 9 chars
    qemu-system-x86_64: -device rocker,name=3Dqemu-rocker: Device initial=
ization failed

Now, convert it to .realize() that passes errors to its callers via its
errp argument. Also avoid the superfluous second error message. After
the patch, effect like this:

    $ x86_64-softmmu/qemu-system-x86_64 -device rocker,name=3Dqemu-rocker
    qemu-system-x86_64: -device rocker,name=3Dqemu-rocker: name too long;=
 please shorten to at most 9 chars

Cc: jasowang@redhat.com
Cc: jiri@resnulli.us
Cc: armbru@redhat.com
Cc: f4bug@amsat.org
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
=20
-static int rocker_msix_init(Rocker *r)
+static int rocker_msix_init(Rocker *r, Error **errp)
 {
     PCIDevice *dev =3D PCI_DEVICE(r);
     int err;
-    Error *local_err =3D NULL;
=20
     err =3D msix_init(dev, ROCKER_MSIX_VEC_COUNT(r->fp_ports),
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_TABLE_OFFSE=
T,
                     &r->msix_bar,
                     ROCKER_PCI_MSIX_BAR_IDX, ROCKER_PCI_MSIX_PBA_OFFSET,
-                    0, &local_err);
+                    0, errp);
     if (err) {
-        error_report_err(local_err);
         return err;
     }
=20
@@ -1285,7 +1283,7 @@ static World *rocker_world_type_by_name(Rocker *r, =
const char *name)
     return NULL;
 }
=20
-static int pci_rocker_init(PCIDevice *dev)
+static void pci_rocker_realize(PCIDevice *dev, Error **errp)
 {
     Rocker *r =3D to_rocker(dev);
     const MACAddr zero =3D { .a =3D { 0, 0, 0, 0, 0, 0 } };
@@ -1303,10 +1301,9 @@ static int pci_rocker_init(PCIDevice *dev)
=20
     r->world_dflt =3D rocker_world_type_by_name(r, r->world_name);
     if (!r->world_dflt) {
-        fprintf(stderr,
-                "rocker: requested world \"%s\" does not exist\n",
+        error_setg(errp,
+                "invalid argument requested world %s does not exist",
                 r->world_name);
-        err =3D -EINVAL;
         goto err_world_type_by_name;
     }
=20
@@ -1326,7 +1323,7 @@ static int pci_rocker_init(PCIDevice *dev)
=20
     /* MSI-X init */
=20
-    err =3D rocker_msix_init(r);
+    err =3D rocker_msix_init(r, errp);
     if (err) {
         goto err_msix_init;
     }
@@ -1338,7 +1335,7 @@ static int pci_rocker_init(PCIDevice *dev)
     }
=20
     if (rocker_find(r->name)) {
-        err =3D -EEXIST;
+        error_setg(errp, "%s already exists", r->name);
         goto err_duplicate;
     }
=20
@@ -1352,10 +1349,9 @@ static int pci_rocker_init(PCIDevice *dev)
 #define ROCKER_IFNAMSIZ 16
 #define MAX_ROCKER_NAME_LEN  (ROCKER_IFNAMSIZ - 1 - 3 - 3)
     if (strlen(r->name) > MAX_ROCKER_NAME_LEN) {
-        fprintf(stderr,
-                "rocker: name too long; please shorten to at most %d cha=
rs\n",
+        error_setg(errp,
+                "name too long; please shorten to at most %d chars",
                 MAX_ROCKER_NAME_LEN);
-        err =3D -EINVAL;
         goto err_name_too_long;
     }
=20
@@ -1413,7 +1409,7 @@ static int pci_rocker_init(PCIDevice *dev)
=20
     QLIST_INSERT_HEAD(&rockers, r, next);
=20
-    return 0;
+    return;
=20
 err_name_too_long:
 err_duplicate:
@@ -1427,7 +1423,6 @@ err_world_type_by_name:
             world_free(r->worlds[i]);
         }
     }
-    return err;
 }
=20
 static void pci_rocker_uninit(PCIDevice *dev)
@@ -1512,7 +1507,7 @@ static void rocker_class_init(ObjectClass *klass, v=
oid *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
-    k->init =3D pci_rocker_init;
+    k->realize =3D pci_rocker_realize;
     k->exit =3D pci_rocker_uninit;
     k->vendor_id =3D PCI_VENDOR_ID_REDHAT;
     k->device_id =3D PCI_DEVICE_ID_REDHAT_ROCKER;
--=20
2.7.4
