Received: from eggs.gnu.org ([2001:4830:134:3::10]:57128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVF2b-0007im-5L
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87219212e=anthony.perard@citrix.com>)
	id 1gVF2X-00034A-Tt
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:15:33 -0500
Date: Fri, 7 Dec 2018 12:15:19 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181207121519.GE18875@perard.uk.xensource.com>
References: <1544108924-10841-1-git-send-email-paul.durrant@citrix.com>
	<1544108924-10841-3-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544108924-10841-3-git-send-email-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v2 02/18] xen: introduce new 'XenBus' and
 'XenDevice' object hierarchy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, Dec 06, 2018 at 03:08:28PM +0000, Paul Durrant wrote:
> This patch adds the basic boilerplate for a 'XenBus' object that will act
> as a parent to 'XenDevice' PV backends.
> A new 'XenBridge' object is also added to connect XenBus to the system bus.
> 
> The XenBus object is instantiated by a new xen_bus_init() function called
> from the same sites as the legacy xen_be_init() function.
> 
> Subsequent patches will flesh-out the functionality of these objects.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> 
> v2:
>  - Fix boilerplate
>  - Make xen-bus hotplug capable
> ---
>  hw/i386/xen/xen-hvm.c     |   3 ++
>  hw/xen/Makefile.objs      |   2 +-
>  hw/xen/trace-events       |   6 +++
>  hw/xen/xen-bus.c          | 131 ++++++++++++++++++++++++++++++++++++++++++++++
>  hw/xenpv/xen_machine_pv.c |   3 ++
>  include/hw/xen/xen-bus.h  |  55 +++++++++++++++++++
>  6 files changed, 199 insertions(+), 1 deletion(-)
>  create mode 100644 hw/xen/xen-bus.c
>  create mode 100644 include/hw/xen/xen-bus.h
> 
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 1d63763..4497f75 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -17,6 +17,7 @@
>  #include "hw/i386/apic-msidef.h"
>  #include "hw/xen/xen_common.h"
>  #include "hw/xen/xen-legacy-backend.h"
> +#include "hw/xen/xen-bus.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc.h"
>  #include "qemu/error-report.h"
> @@ -1479,6 +1480,8 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
>      QLIST_INIT(&state->dev_list);
>      device_listener_register(&state->device_listener);
>  
> +    xen_bus_init();
> +
>      /* Initialize backend core & drivers */
>      if (xen_be_init() != 0) {
>          error_report("xen backend core setup failed");
> diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
> index 3f64a44..d9d6d7b 100644
> --- a/hw/xen/Makefile.objs
> +++ b/hw/xen/Makefile.objs
> @@ -1,5 +1,5 @@
>  # xen backend driver support
> -common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o
> +common-obj-$(CONFIG_XEN) += xen-legacy-backend.o xen_devconfig.o xen_pvdev.o xen-common.o xen-bus.o
>  
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
> diff --git a/hw/xen/trace-events b/hw/xen/trace-events
> index c7e7a3b..0172cd4 100644
> --- a/hw/xen/trace-events
> +++ b/hw/xen/trace-events
> @@ -12,3 +12,9 @@ xen_unmap_portio_range(uint32_t id, uint64_t start_addr, uint64_t end_addr) "id:
>  xen_map_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
>  xen_unmap_pcidev(uint32_t id, uint8_t bus, uint8_t dev, uint8_t func) "id: %u bdf: %02x.%02x.%02x"
>  xen_domid_restrict(int err) "err: %u"
> +
> +# include/hw/xen/xen-bus.c
> +xen_bus_realize(void) ""
> +xen_bus_unrealize(void) ""
> +xen_device_realize(const char *type) "type: %s"
> +xen_device_unrealize(const char *type) "type: %s"
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> new file mode 100644
> index 0000000..1385bab
> --- /dev/null
> +++ b/hw/xen/xen-bus.c
> @@ -0,0 +1,131 @@
> +/*
> + * Copyright (c) 2018  Citrix Systems Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/xen/xen-bus.h"
> +#include "qapi/error.h"
> +#include "trace.h"
> +
> +static void xen_bus_unrealize(BusState *bus, Error **errp)
> +{
> +    trace_xen_bus_unrealize();
> +}
> +
> +static void xen_bus_realize(BusState *bus, Error **errp)
> +{
> +    trace_xen_bus_realize();
> +}
> +
> +static void xen_bus_class_init(ObjectClass *class, void *data)
> +{
> +    BusClass *bus_class = BUS_CLASS(class);
> +
> +    bus_class->realize = xen_bus_realize;
> +    bus_class->unrealize = xen_bus_unrealize;
> +}
> +
> +static const TypeInfo xen_bus_type_info = {
> +    .name = TYPE_XEN_BUS,
> +    .parent = TYPE_BUS,
> +    .instance_size = sizeof(XenBus),
> +    .class_size = sizeof(XenBusClass),
> +    .class_init = xen_bus_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_HOTPLUG_HANDLER },
> +        { }
> +    },
> +};
> +
> +static void xen_device_unrealize(DeviceState *dev, Error **errp)
> +{
> +    XenDevice *xendev = XEN_DEVICE(dev);
> +    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
> +    const char *type = object_get_typename(OBJECT(xendev));
> +    Error *local_err = NULL;
> +
> +    trace_xen_device_unrealize(type);
> +
> +    if (xendev_class->unrealize) {
> +        xendev_class->unrealize(xendev, &local_err);

Since all you do here is propagate the error, you could even pass `errp'
to unrealize(), instead of having `local_err'. That "for readability",
as explained in "qapi/error.h".

> +        if (local_err) {
> +            error_propagate(errp, local_err);
> +        }
> +    }
> +}
> +

With that nit fixed:
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
