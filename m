Received: from eggs.gnu.org ([2001:4830:134:3::10]:46555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7q-00085M-1e
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7n-00008a-SK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:30 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:40 +1100
Message-Id: <20170301044405.1792-26-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/50] xics: XICS should not be a SysBusDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Currently xics - the component of the IBM POWER interrupt controller
representing the overall interrupt fabric / architecture is
represented as a descendent of SysBusDevice.  However, this is not
really correct - the xics presents nothing in MMIO space so it should
be an "unattached" device in the current QOM model.

Since this device will always be created by the machine type, not created
specifically from the command line, and because it has no migrated state
it should be safe to move it around the device composition tree.

Therefore this patch changes it to a descendent of TYPE_DEVICE, and
makes it an unattached device.  So that its reset handler still gets
called correctly, we add a qdev_set_parent_bus() to attach it to
sysbus.  It's not really clear that's correct (instead of using
register_reset()) but it appears to a common technique.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[clg corrected problems with reset]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
[dwg folded together and updated commit message]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 2 +-
 hw/ppc/spapr.c        | 3 ++-
 include/hw/ppc/xics.h | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 095c16a..372b831 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -260,7 +260,7 @@ static void xics_common_class_init(ObjectClass *oc, v=
oid *data)
=20
 static const TypeInfo xics_common_info =3D {
     .name          =3D TYPE_XICS_COMMON,
-    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .parent        =3D TYPE_DEVICE,
     .instance_size =3D sizeof(XICSState),
     .class_size    =3D sizeof(XICSStateClass),
     .instance_init =3D xics_common_initfn,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e0bb9bc..0c475f4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -101,9 +101,10 @@ static XICSState *try_create_xics(const char *type, =
int nr_servers,
     Error *err =3D NULL;
     DeviceState *dev;
=20
-    dev =3D qdev_create(NULL, type);
+    dev =3D DEVICE(object_new(type));
     qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
     qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
+    qdev_set_parent_bus(dev, sysbus_get_default());
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 3f0c316..1aefd3d 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -80,7 +80,7 @@ struct XICSStateClass {
=20
 struct XICSState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    DeviceState parent_obj;
     /*< public >*/
     uint32_t nr_servers;
     uint32_t nr_irqs;
--=20
2.9.3
