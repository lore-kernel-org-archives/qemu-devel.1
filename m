Received: from eggs.gnu.org ([2001:4830:134:3::10]:43706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdw1E-0005Lq-2a
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdw1D-0002Jk-07
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 07:13:48 -0400
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-7-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d76b1a42-e232-f8a3-48dc-d71238403c94@redhat.com>
Date: Fri, 13 Jul 2018 13:13:33 +0200
MIME-Version: 1.0
In-Reply-To: <1531470464-21522-7-git-send-email-thuth@redhat.com>
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

On 13/07/2018 10:27, Thomas Huth wrote:
> aux_create_slave() calls qdev_init_nofail() which in turn "realizes"
> the corresponding object. Thus this most not be called from an
> instance_init function. Move the code to the realize function instead.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/display/xlnx_dp.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

> +    s->aux_bus =3D aux_init_bus(dev, "aux");

aux_init_bus can remain in the same place, and likewise the qdev_create
that assigns to s->edid.

The only thing that has to move is the qdev_init_nofail and
aux_bus_map_device, like this:

----------------- 8< ------------------
From: Paolo Bonzini <pbonzinI@redhat.com>
Subject: [PATCH] hw/display/xlnx_dp: Move problematic code from instance_=
init to realize

aux_create_slave() calls qdev_init_nofail() which in turn "realizes"
the corresponding object. This is unlike qdev_create(), and it is wrong
because qdev_init_nofail() must not be called from an instance_init
function.  Move qdev_init_nofail() and the subsequent aux_map_slave into
the caller's realize function.
=20
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 51301220e8..589ef59dfd 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1234,7 +1234,7 @@ static void xlnx_dp_init(Object *obj)
     /*
      * Initialize DPCD and EDID..
      */
-    s->dpcd =3D DPCD(aux_create_slave(s->aux_bus, "dpcd", 0x00000));
+    s->dpcd =3D DPCD(aux_create_slave(s->aux_bus, "dpcd"));
     s->edid =3D I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "i2=
c-ddc"));
     i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
=20
@@ -1248,6 +1248,9 @@ static void xlnx_dp_realize(DeviceState *dev, Error=
 **errp)
     DisplaySurface *surface;
     struct audsettings as;
=20
+    qdev_init_nofail(DEVICE(s->dpcd));
+    aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
+
     s->console =3D graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
     surface =3D qemu_console_surface(s->console);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index b8a8721201..2fe807d42f 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -74,9 +74,11 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *=
name)
     return bus;
 }
=20
-static void aux_bus_map_device(AUXBus *bus, AUXSlave *dev, hwaddr addr)
+void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
 {
-    memory_region_add_subregion(bus->aux_io, addr, dev->mmio);
+    DeviceState *dev =3D DEVICE(aux_dev);
+    AUXBus *bus =3D AUX_BUS(qdev_get_parent_bus(dev));
+    memory_region_add_subregion(bus->aux_io, addr, aux_dev->mmio);
 }
=20
 static bool aux_bus_is_bridge(AUXBus *bus, DeviceState *dev)
@@ -260,15 +262,13 @@ static void aux_slave_dev_print(Monitor *mon, Devic=
eState *dev, int indent)
                    memory_region_size(s->mmio));
 }
=20
-DeviceState *aux_create_slave(AUXBus *bus, const char *type, uint32_t ad=
dr)
+DeviceState *aux_create_slave(AUXBus *bus, const char *type)
 {
     DeviceState *dev;
=20
     dev =3D DEVICE(object_new(type));
     assert(dev);
     qdev_set_parent_bus(dev, &bus->qbus);
-    qdev_init_nofail(dev);
-    aux_bus_map_device(AUX_BUS(qdev_get_parent_bus(dev)), AUX_SLAVE(dev)=
, addr);
     return dev;
 }
=20
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index 68ade8a90f..c15b444748 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -123,6 +123,18 @@ I2CBus *aux_get_i2c_bus(AUXBus *bus);
  */
 void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio);
=20
-DeviceState *aux_create_slave(AUXBus *bus, const char *name, uint32_t ad=
dr);
+/* aux_create_slave: Create a new device on an AUX bus
+ *
+ * @bus The AUX bus for the new device.
+ * @name The type of the device to be created.
+ */
+DeviceState *aux_create_slave(AUXBus *bus, const char *name);
+
+/* aux_map_slave: Map the mmio for an AUX slave on the bus.
+ *
+ * @dev The AUX slave.
+ * @addr The address for the slave's mmio.
+ */
+void aux_map_slave(AUXSlave *dev, hwaddr addr);
=20
 #endif /* HW_MISC_AUXBUS_H */


Paolo

> +    /* Initialize DPCD and EDID */
>      s->dpcd =3D DPCD(aux_create_slave(s->aux_bus, "dpcd", 0x00000));
>      s->edid =3D I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "=
i2c-ddc"));
>      i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
> =20
>      fifo8_create(&s->rx_fifo, 16);
>      fifo8_create(&s->tx_fifo, 16);
> -}
> -
> -static void xlnx_dp_realize(DeviceState *dev, Error **errp)
> -{
> -    XlnxDPState *s =3D XLNX_DP(dev);
> -    DisplaySurface *surface;
> -    struct audsettings as;
> =20
>      s->console =3D graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>      surface =3D qemu_console_surface(s->console);
>=20
