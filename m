Received: from eggs.gnu.org ([2001:4830:134:3::10]:42275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHm-0000rB-Ge
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cvkHl-0001Ym-G7
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:42 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:40253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cvkHl-0001YC-AQ
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 08:43:41 -0400
Received: from player688.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4206749B6D
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 14:43:40 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  5 Apr 2017 14:41:42 +0200
Message-Id: <1491396106-26376-18-git-send-email-clg@kaod.org>
In-Reply-To: <1491396106-26376-1-git-send-email-clg@kaod.org>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/21] qdev: Add a hook for a bus to device if
 it can add devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This allows a bus class to tell whether a given bus has room for
any new device. max_dev isn't sufficient as the rules can depend
on some arguments or can differ between instances of a bus. This
will be used by PCI in subsequent patches

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[clg: updated for qemu-2.9 ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/qdev-core.h |  1 +
 qdev-monitor.c         | 14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index b44b47676576..867662ba5352 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -201,6 +201,7 @@ struct BusClass {
      */
     char *(*get_fw_dev_path)(DeviceState *dev);
     void (*reset)(BusState *bus);
+    bool (*can_add_device)(BusState *bus, QemuOpts *opts);
     BusRealize realize;
     BusUnrealize unrealize;
=20
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 5f2fcdfc4551..c6eca929c473 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -415,7 +415,7 @@ static inline bool qbus_is_full(BusState *bus)
  * Return the bus if found, else %NULL.
  */
 static BusState *qbus_find_recursive(BusState *bus, const char *name,
-                                     const char *bus_typename)
+                                     const char *bus_typename, QemuOpts =
*opts)
 {
     BusChild *kid;
     BusState *pick, *child, *ret;
@@ -429,7 +429,10 @@ static BusState *qbus_find_recursive(BusState *bus, =
const char *name,
     }
=20
     if (match && !qbus_is_full(bus)) {
-        return bus;             /* root matches and isn't full */
+        BusClass *bc =3D BUS_GET_CLASS(bus);
+        if (!bc->can_add_device || bc->can_add_device(bus, opts)) {
+            return bus;             /* root matches and isn't full */
+        }
     }
=20
     pick =3D match ? bus : NULL;
@@ -437,7 +440,7 @@ static BusState *qbus_find_recursive(BusState *bus, c=
onst char *name,
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
         DeviceState *dev =3D kid->child;
         QLIST_FOREACH(child, &dev->child_bus, sibling) {
-            ret =3D qbus_find_recursive(child, name, bus_typename);
+            ret =3D qbus_find_recursive(child, name, bus_typename, opts)=
;
             if (ret && !qbus_is_full(ret)) {
                 return ret;     /* a descendant matches and isn't full *=
/
             }
@@ -467,7 +470,7 @@ static BusState *qbus_find(const char *path, Error **=
errp)
             assert(!path[0]);
             elem[0] =3D len =3D 0;
         }
-        bus =3D qbus_find_recursive(sysbus_get_default(), elem, NULL);
+        bus =3D qbus_find_recursive(sysbus_get_default(), elem, NULL, NU=
LL);
         if (!bus) {
             error_setg(errp, "Bus '%s' not found", elem);
             return NULL;
@@ -591,7 +594,8 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **=
errp)
             return NULL;
         }
     } else if (dc->bus_type !=3D NULL) {
-        bus =3D qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_=
type);
+        bus =3D qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_=
type,
+                                  opts);
         if (!bus || qbus_is_full(bus)) {
             error_setg(errp, "No '%s' bus found for device '%s'",
                        dc->bus_type, driver);
--=20
2.7.4
