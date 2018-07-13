Received: from eggs.gnu.org ([2001:4830:134:3::10]:52069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fe1dX-0003Wg-D7
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fe1dW-0001A5-8i
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:13:43 -0400
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-7-git-send-email-thuth@redhat.com>
	<d76b1a42-e232-f8a3-48dc-d71238403c94@redhat.com>
	<49dcf89e-6f5a-7497-e5fd-e54d4fcd59eb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9133dc89-5f24-0802-caa6-bf73b2c229d1@redhat.com>
Date: Fri, 13 Jul 2018 19:13:29 +0200
MIME-Version: 1.0
In-Reply-To: <49dcf89e-6f5a-7497-e5fd-e54d4fcd59eb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 06/16] hw/display/xlnx_dp: Move
 problematic code from instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 13/07/2018 17:59, Thomas Huth wrote:
> Your patch looks good at a first quick glance, but it seems not to work=
 as expected: When I now run QEMU like this:
>=20
> echo "{'execute':'qmp_capabilities'}" \
>  "{'execute':'device-list-properties'," \
>  "'arguments':{'typename':'xlnx,zynqmp'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  aarch64-softmmu/qemu-system-aarch64 -M none,accel=3Dqtest -qmp stdio
>=20
> then QEMU ends up in an endless loop and I've got to kill it.

There are two more bugs that my patch makes un-latent, where the
objects are created but not added as children.  Therefore when
you call object_unparent on them, nothing happens.

In particular dpcd and edid give you an infinite loop in bus_unparent,
because device_unparent is not called and does not remove them from
the list of devices on the bus.

The following incremental changes fix everything for me.  Note that
aux_create_slave/qdev_create already do the unref for you.

Thanks,

Paolo

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 589ef59dfd..6439bd05ef 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1235,8 +1235,11 @@ static void xlnx_dp_init(Object *obj)
      * Initialize DPCD and EDID..
      */
     s->dpcd =3D DPCD(aux_create_slave(s->aux_bus, "dpcd"));
+    object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd), NULL);
+
     s->edid =3D I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "i2=
c-ddc"));
     i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
+    object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid), NULL);
=20
     fifo8_create(&s->rx_fifo, 16);
     fifo8_create(&s->tx_fifo, 16);
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 2fe807d42f..0e56d9a8a4 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -32,6 +32,7 @@
 #include "hw/misc/auxbus.h"
 #include "hw/i2c/i2c.h"
 #include "monitor/monitor.h"
+#include "qapi/error.h"
=20
 #ifndef DEBUG_AUX
 #define DEBUG_AUX 0
@@ -63,9 +64,14 @@ static void aux_bus_class_init(ObjectClass *klass, voi=
d *data)
 AUXBus *aux_init_bus(DeviceState *parent, const char *name)
 {
     AUXBus *bus;
+    Object *auxtoi2c;
=20
     bus =3D AUX_BUS(qbus_create(TYPE_AUX_BUS, parent, name));
-    bus->bridge =3D AUXTOI2C(qdev_create(BUS(bus), TYPE_AUXTOI2C));
+    auxtoi2c =3D object_new_with_props(TYPE_AUXTOI2C, OBJECT(bus), "i2c"=
,
+                                     &error_abort, NULL);
+    qdev_set_parent_bus(DEVICE(auxtoi2c), BUS(bus));
+
+    bus->bridge =3D AUXTOI2C(auxtoi2c);
=20
     /* Memory related. */
     bus->aux_io =3D g_malloc(sizeof(*bus->aux_io));
