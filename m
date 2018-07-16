Received: from eggs.gnu.org ([2001:4830:134:3::10]:60853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBda-0005XX-0B
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ffBdY-00050g-K7
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 18:06:33 -0400
MIME-Version: 1.0
In-Reply-To: <1531745974-17187-17-git-send-email-thuth@redhat.com>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-17-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Jul 2018 15:06:00 -0700
Message-ID: <CAKmqyKOe_0-BJS9XvFbwXa2KiDkpNwYX+Bkf4_fW8=JaFWS3Yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 16/17] hw/display/xlnx_dp: Move
 problematic code from instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On Mon, Jul 16, 2018 at 5:59 AM, Thomas Huth <thuth@redhat.com> wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> aux_create_slave() calls qdev_init_nofail() which in turn "realizes"
> the corresponding object. This is unlike qdev_create(), and it is wrong
> because qdev_init_nofail() must not be called from an instance_init
> function.  Move qdev_init_nofail() and the subsequent aux_map_slave into
> the caller's realize function.
>
> There are two more bugs that needs to be fixed here, too, where the
> objects are created but not added as children.  Therefore when
> you call object_unparent on them, nothing happens.
>
> In particular dpcd and edid give you an infinite loop in bus_unparent,
> because device_unparent is not called and does not remove them from
> the list of devices on the bus.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [thuth: Added Paolo's fixup for the dpcd and edid unparenting]
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/xlnx_dp.c     |  8 +++++++-
>  hw/misc/auxbus.c         | 18 ++++++++++++------
>  include/hw/misc/auxbus.h | 14 +++++++++++++-
>  3 files changed, 32 insertions(+), 8 deletions(-)
>
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 5130122..6439bd0 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1234,9 +1234,12 @@ static void xlnx_dp_init(Object *obj)
>      /*
>       * Initialize DPCD and EDID..
>       */
> -    s->dpcd = DPCD(aux_create_slave(s->aux_bus, "dpcd", 0x00000));
> +    s->dpcd = DPCD(aux_create_slave(s->aux_bus, "dpcd"));
> +    object_property_add_child(OBJECT(s), "dpcd", OBJECT(s->dpcd), NULL);
> +
>      s->edid = I2CDDC(qdev_create(BUS(aux_get_i2c_bus(s->aux_bus)), "i2c-ddc"));
>      i2c_set_slave_address(I2C_SLAVE(s->edid), 0x50);
> +    object_property_add_child(OBJECT(s), "edid", OBJECT(s->edid), NULL);
>
>      fifo8_create(&s->rx_fifo, 16);
>      fifo8_create(&s->tx_fifo, 16);
> @@ -1248,6 +1251,9 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
>      DisplaySurface *surface;
>      struct audsettings as;
>
> +    qdev_init_nofail(DEVICE(s->dpcd));
> +    aux_map_slave(AUX_SLAVE(s->dpcd), 0x0000);
> +
>      s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
>      surface = qemu_console_surface(s->console);
>      xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index b8a8721..0e56d9a 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -32,6 +32,7 @@
>  #include "hw/misc/auxbus.h"
>  #include "hw/i2c/i2c.h"
>  #include "monitor/monitor.h"
> +#include "qapi/error.h"
>
>  #ifndef DEBUG_AUX
>  #define DEBUG_AUX 0
> @@ -63,9 +64,14 @@ static void aux_bus_class_init(ObjectClass *klass, void *data)
>  AUXBus *aux_init_bus(DeviceState *parent, const char *name)
>  {
>      AUXBus *bus;
> +    Object *auxtoi2c;
>
>      bus = AUX_BUS(qbus_create(TYPE_AUX_BUS, parent, name));
> -    bus->bridge = AUXTOI2C(qdev_create(BUS(bus), TYPE_AUXTOI2C));
> +    auxtoi2c = object_new_with_props(TYPE_AUXTOI2C, OBJECT(bus), "i2c",
> +                                     &error_abort, NULL);
> +    qdev_set_parent_bus(DEVICE(auxtoi2c), BUS(bus));
> +
> +    bus->bridge = AUXTOI2C(auxtoi2c);
>
>      /* Memory related. */
>      bus->aux_io = g_malloc(sizeof(*bus->aux_io));
> @@ -74,9 +80,11 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
>      return bus;
>  }
>
> -static void aux_bus_map_device(AUXBus *bus, AUXSlave *dev, hwaddr addr)
> +void aux_map_slave(AUXSlave *aux_dev, hwaddr addr)
>  {
> -    memory_region_add_subregion(bus->aux_io, addr, dev->mmio);
> +    DeviceState *dev = DEVICE(aux_dev);
> +    AUXBus *bus = AUX_BUS(qdev_get_parent_bus(dev));
> +    memory_region_add_subregion(bus->aux_io, addr, aux_dev->mmio);
>  }
>
>  static bool aux_bus_is_bridge(AUXBus *bus, DeviceState *dev)
> @@ -260,15 +268,13 @@ static void aux_slave_dev_print(Monitor *mon, DeviceState *dev, int indent)
>                     memory_region_size(s->mmio));
>  }
>
> -DeviceState *aux_create_slave(AUXBus *bus, const char *type, uint32_t addr)
> +DeviceState *aux_create_slave(AUXBus *bus, const char *type)
>  {
>      DeviceState *dev;
>
>      dev = DEVICE(object_new(type));
>      assert(dev);
>      qdev_set_parent_bus(dev, &bus->qbus);
> -    qdev_init_nofail(dev);
> -    aux_bus_map_device(AUX_BUS(qdev_get_parent_bus(dev)), AUX_SLAVE(dev), addr);
>      return dev;
>  }
>
> diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
> index 68ade8a..c15b444 100644
> --- a/include/hw/misc/auxbus.h
> +++ b/include/hw/misc/auxbus.h
> @@ -123,6 +123,18 @@ I2CBus *aux_get_i2c_bus(AUXBus *bus);
>   */
>  void aux_init_mmio(AUXSlave *aux_slave, MemoryRegion *mmio);
>
> -DeviceState *aux_create_slave(AUXBus *bus, const char *name, uint32_t addr);
> +/* aux_create_slave: Create a new device on an AUX bus
> + *
> + * @bus The AUX bus for the new device.
> + * @name The type of the device to be created.
> + */
> +DeviceState *aux_create_slave(AUXBus *bus, const char *name);
> +
> +/* aux_map_slave: Map the mmio for an AUX slave on the bus.
> + *
> + * @dev The AUX slave.
> + * @addr The address for the slave's mmio.
> + */
> +void aux_map_slave(AUXSlave *dev, hwaddr addr);
>
>  #endif /* HW_MISC_AUXBUS_H */
> --
> 1.8.3.1
>
>
