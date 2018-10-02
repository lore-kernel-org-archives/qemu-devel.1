Received: from eggs.gnu.org ([2001:4830:134:3::10]:46033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7UDO-00071I-Sm
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7UDL-00070O-LG
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:36:30 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7UDL-0006xi-7J
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:36:27 -0400
Received: by mail-wm1-f44.google.com with SMTP id 185-v6so3798341wmt.2
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 16:36:20 -0700 (PDT)
References: <20181002142443.30976-1-damien.hedde@greensocs.com>
	<20181002142443.30976-3-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <99faa294-71f8-c40f-4828-d4d2a32ad7a3@redhat.com>
Date: Wed, 3 Oct 2018 01:36:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181002142443.30976-3-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 2/9] qdev: add clock input&output
 support to devices.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, alistair@alistair23.me, mark.burton@greensocs.com, saipava@xilinx.com, qemu-arm@nongnu.org, pbonzini@redhat.com, konrad@adacore.com, luc.michel@greensocs.com

Hi Damien,

On 10/2/18 4:24 PM, Damien Hedde wrote:
> Add functions to easily add input or output clocks to a device.
> The clock port objects are added as children of the device.
> 
> A function allows to connect two clocks together.
> It should be called by some toplevel to make a connection between
> 2 (sub-)devices.
> 
> Also add a function which forwards a port to another device. This
> function allows, in the case of device composition, to expose a
> sub-device clock port as its own clock port.
> This is really an alias: when forwarding an input, only one callback can
> be registered on it since there is only one Clockin object behind all
> aliases.
> 
> This is based on the original work of Frederic Konrad.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
>  include/hw/qdev-clock.h |  62 ++++++++++++++++++
>  include/hw/qdev-core.h  |  14 ++++
>  include/hw/qdev.h       |   1 +
>  hw/core/qdev-clock.c    | 140 ++++++++++++++++++++++++++++++++++++++++
>  hw/core/qdev.c          |  29 +++++++++
>  hw/core/Makefile.objs   |   2 +-
>  6 files changed, 247 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/qdev-clock.h
>  create mode 100644 hw/core/qdev-clock.c
> 
> diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
> new file mode 100644
> index 0000000000..d76aa9f479
> --- /dev/null
> +++ b/include/hw/qdev-clock.h
> @@ -0,0 +1,62 @@
> +#ifndef QDEV_CLOCK_H
> +#define QDEV_CLOCK_H
> +
> +#include "hw/clock-port.h"
> +#include "hw/qdev-core.h"
> +#include "qapi/error.h"
> +
> +/**
> + * qdev_init_clock_in:
> + * @dev: the device in which to add a clock
> + * @name: the name of the clock (can't be NULL).
> + * @callback: optional callback to be called on update or NULL.
> + * @opaque:   argument for the callback
> + * @returns: a pointer to the newly added clock
> + *
> + * Add a input clock to device @dev as a clock named @name.
> + * This adds a child<> property.
> + * The callback will be called with @dev as opaque parameter.
> + */
> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
> +                            ClockCallback *callback, void *opaque);
> +
> +/**
> + * qdev_init_clock_out:
> + * @dev: the device to add a clock to
> + * @name: the name of the clock (can't be NULL).
> + * @callback: optional callback to be called on update or NULL.
> + * @returns: a pointer to the newly added clock
> + *
> + * Add a output clock to device @dev as a clock named @name.
> + * This adds a child<> property.
> + */
> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name);
> +
> +/**
> + * qdev_pass_clock:
> + * @dev: the device to forward the clock to
> + * @name: the name of the clock to be added (can't be NULL)
> + * @container: the device which already has the clock
> + * @cont_name: the name of the clock in the container device
> + *
> + * Add a clock @name to @dev which forward to the clock @cont_name in @container
> + */
> +void qdev_pass_clock(DeviceState *dev, const char *name,
> +        DeviceState *container, const char *cont_name);

Indent ;)

> +
> +/**
> + * qdev_connect_clock:
> + * @dev: the drived clock device.
> + * @name: the drived clock name.
> + * @driver: the driving clock device.
> + * @driver_name: the driving clock name.
> + * @errp: error report
> + *
> + * Setup @driver_name output clock of @driver to drive @name input clock of
> + * @dev. Errors are trigerred if clock does not exists
> + */
> +void qdev_connect_clock(DeviceState *dev, const char *name,
> +                        DeviceState *driver, const char *driver_name,
> +                        Error **errp);
> +
> +#endif /* QDEV_CLOCK_H */
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index f1fd0f8736..e6014d3a41 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -127,6 +127,19 @@ struct NamedGPIOList {
>      QLIST_ENTRY(NamedGPIOList) node;
>  };
>  
> +typedef struct NamedClockList NamedClockList;
> +
> +typedef struct ClockIn ClockIn;
> +typedef struct ClockOut ClockOut;
> +
> +struct NamedClockList {
> +    char *name;
> +    bool forward;
> +    ClockIn *in;
> +    ClockOut *out;
> +    QLIST_ENTRY(NamedClockList) node;
> +};
> +
>  /**
>   * DeviceState:
>   * @realized: Indicates whether the device has been fully constructed.
> @@ -147,6 +160,7 @@ struct DeviceState {
>      int hotplugged;
>      BusState *parent_bus;
>      QLIST_HEAD(, NamedGPIOList) gpios;
> +    QLIST_HEAD(, NamedClockList) clocks;
>      QLIST_HEAD(, BusState) child_bus;
>      int num_child_bus;
>      int instance_id_alias;
> diff --git a/include/hw/qdev.h b/include/hw/qdev.h
> index 5cb8b080a6..b031da7b41 100644
> --- a/include/hw/qdev.h
> +++ b/include/hw/qdev.h
> @@ -4,5 +4,6 @@
>  #include "hw/hw.h"
>  #include "hw/qdev-core.h"
>  #include "hw/qdev-properties.h"
> +#include "hw/qdev-clock.h"
>  
>  #endif
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> new file mode 100644
> index 0000000000..f0e4839aed
> --- /dev/null
> +++ b/hw/core/qdev-clock.c
> @@ -0,0 +1,140 @@
> +/*
> + * Device's clock
> + *
> + * Copyright GreenSocs 2016-2018
> + *
> + * Authors:
> + *  Frederic Konrad <fred.konrad@greensocs.com>
> + *  Damien Hedde <damien.hedde@greensocs.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "hw/qdev-clock.h"
> +#include "qapi/error.h"
> +
> +static NamedClockList *qdev_init_clocklist(DeviceState *dev, const char *name,
> +        bool forward)
> +{
> +    NamedClockList *ncl;
> +
> +    /*
> +     * The clock path will be computed by the device's realize function call.
> +     * This is required to ensure the clock's canonical path is right and log
> +     * messages are meaningfull.
> +     */
> +    assert(name);
> +    assert(!dev->realized);
> +

Maybe add a comment "This will be free'd in device_finalize()".

> +    ncl = g_malloc0(sizeof(*ncl));
> +    ncl->name = g_strdup(name);
> +    ncl->forward = forward;
> +
> +    QLIST_INSERT_HEAD(&dev->clocks, ncl, node);
> +    return ncl;
> +}
> +
> +ClockOut *qdev_init_clock_out(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +    Object *clk;
> +
> +    ncl = qdev_init_clocklist(dev, name, false);
> +
> +    clk = object_new(TYPE_CLOCK_OUT);
> +
> +    /* will fail if name already exists */
> +    object_property_add_child(OBJECT(dev), name, clk, &error_abort);
> +    object_unref(clk); /* remove the initial ref made by object_new */
> +
> +    ncl->out = CLOCK_OUT(clk);
> +    return ncl->out;
> +}
> +
> +ClockIn *qdev_init_clock_in(DeviceState *dev, const char *name,
> +                        ClockCallback *callback, void *opaque)
> +{
> +    NamedClockList *ncl;
> +    Object *clk;
> +
> +    ncl = qdev_init_clocklist(dev, name, false);
> +
> +    clk = object_new(TYPE_CLOCK_IN);
> +    /*
> +     * the ref initialized by object_new will be cleared during dev finalize.
> +     * It allows us to safely remove the callback.
> +     */
> +
> +    /* will fail if name already exists */
> +    object_property_add_child(OBJECT(dev), name, clk, &error_abort);
> +
> +    ncl->in = CLOCK_IN(clk);
> +    if (callback) {
> +        clock_set_callback(ncl->in, callback, opaque);
> +    }
> +    return ncl->in;
> +}
> +
> +static NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *name)
> +{
> +    NamedClockList *ncl;
> +
> +    QLIST_FOREACH(ncl, &dev->clocks, node) {
> +        if (strcmp(name, ncl->name) == 0) {
> +            return ncl;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +void qdev_pass_clock(DeviceState *dev, const char *name,
> +                     DeviceState *container, const char *cont_name)
> +{
> +    NamedClockList *original_ncl, *ncl;
> +    Object **clk;
> +
> +    assert(container && cont_name);
> +
> +    original_ncl = qdev_get_clocklist(container, cont_name);
> +    assert(original_ncl); /* clock must exist in origin */
> +
> +    ncl = qdev_init_clocklist(dev, name, true);
> +
> +    if (ncl->out) {
> +        clk = (Object **)&ncl->out;
> +    } else {
> +        clk = (Object **)&ncl->in;
> +    }
> +
> +    /* will fail if name already exists */
> +    object_property_add_link(OBJECT(dev), name, object_get_typename(*clk),
> +            clk, NULL, OBJ_PROP_LINK_STRONG, &error_abort);

Indent.

> +}
> +
> +void qdev_connect_clock(DeviceState *dev, const char *name,
> +                        DeviceState *driver, const char *driver_name,
> +                        Error **errp)
> +{
> +    NamedClockList *ncl, *drv_ncl;
> +
> +    assert(dev && name);
> +    assert(driver && driver_name);
> +
> +    ncl = qdev_get_clocklist(dev, name);
> +    if (!ncl || !ncl->in) {
> +        error_setg(errp, "no input clock '%s' in device", name);
> +        return;
> +    }
> +
> +    drv_ncl = qdev_get_clocklist(driver, driver_name);
> +    if (!drv_ncl || !drv_ncl->out) {
> +        error_setg(errp, "no output clock '%s' in driver", driver_name);
> +        return;
> +    }
> +
> +    clock_connect(ncl->in , drv_ncl->out);
> +}
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 529b82de18..c48edf180f 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -790,6 +790,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
>      HotplugHandler *hotplug_ctrl;
>      BusState *bus;
> +    NamedClockList *clk;
>      Error *local_err = NULL;
>      bool unattached_parent = false;
>      static int unattached_count;
> @@ -846,6 +847,15 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
>           */
>          g_free(dev->canonical_path);
>          dev->canonical_path = object_get_canonical_path(OBJECT(dev));
> +        QLIST_FOREACH(clk, &dev->clocks, node) {
> +            if (clk->forward) {
> +                continue;
> +            } else if (clk->in != NULL) {
> +                clock_in_setup_canonical_path(clk->in);
> +            } else {
> +                clock_out_setup_canonical_path(clk->out);
> +            }
> +        }
>  
>          if (qdev_get_vmsd(dev)) {
>              if (vmstate_register_with_alias_id(dev, -1, qdev_get_vmsd(dev), dev,
> @@ -972,6 +982,7 @@ static void device_initfn(Object *obj)
>                               (Object **)&dev->parent_bus, NULL, 0,
>                               &error_abort);
>      QLIST_INIT(&dev->gpios);
> +    QLIST_INIT(&dev->clocks);
>  }
>  
>  static void device_post_init(Object *obj)
> @@ -983,6 +994,7 @@ static void device_post_init(Object *obj)
>  static void device_finalize(Object *obj)
>  {
>      NamedGPIOList *ngl, *next;
> +    NamedClockList *clk, *clk_next;
>  
>      DeviceState *dev = DEVICE(obj);
>  
> @@ -996,6 +1008,23 @@ static void device_finalize(Object *obj)
>           */
>      }
>  
> +    QLIST_FOREACH_SAFE(clk, &dev->clocks, node, clk_next) {
> +        QLIST_REMOVE(clk, node);
> +        if (!clk->forward && clk->in) {
> +            /*
> +             * if this clock is not forwarded, clk->in & clk->out are child of
> +             * dev.
> +             * At this point the properties and associated reference are
> +             * already deleted but we kept a ref on clk->in to ensure we
> +             * don't have a lost callback to a deleted device somewhere.
> +             */
> +            clock_clear_callback(clk->in);
> +            object_unref(OBJECT(clk->in));
> +        }
> +        g_free(clk->name);
> +        g_free(clk);

OK.

> +    }
> +
>      /* Only send event if the device had been completely realized */
>      if (dev->pending_deleted_event) {
>          g_assert(dev->canonical_path);
> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
> index f7102121f4..fc0505e716 100644
> --- a/hw/core/Makefile.objs
> +++ b/hw/core/Makefile.objs
> @@ -1,5 +1,5 @@
>  # core qdev-related obj files, also used by *-user:
> -common-obj-y += qdev.o qdev-properties.o
> +common-obj-y += qdev.o qdev-properties.o qdev-clock.o
>  common-obj-y += bus.o reset.o
>  common-obj-$(CONFIG_SOFTMMU) += qdev-fw.o
>  common-obj-$(CONFIG_SOFTMMU) += fw-path-provider.o
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
