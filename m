Received: from eggs.gnu.org ([2001:4830:134:3::10]:43831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX7aS-00009Z-PY
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX7aP-00034q-QB
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:33:12 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:34985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX7aP-00032V-Ha
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:33:09 -0500
Received: by mail-wm0-x232.google.com with SMTP id r126so119731196wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:33:09 -0800 (PST)
References: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
	<1484247815-15279-3-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1484247815-15279-3-git-send-email-peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 14:33:05 +0000
Message-ID: <87vat08tem.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/misc: New "unimplemented" sysbus
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Paolo Bonzini <bonzini@gnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Create a new "unimplemented" sysbus device, which simply accepts
> all read and write accesses, and implements them as read-as-zero,
> write-ignored, with logging of the access as LOG_UNIMP.
>
> This is useful for stubbing out bits of an SoC or board model
> which haven't been written yet.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

This looks good:

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Is there any millage at being able to define areas on the command line
or would we expect every usage of this to be from a board file in the
source?

It would be useful to link to this somewhere from the docs/wiki as a
good example of a modern QDEV device boilerplate. It would make a change
from telling people to "find a recent device and use it as a template"
on IRC ;-)

Paolo,

Would this be in docs/ or on somewhere else?

> ---
>  hw/misc/Makefile.objs   |   2 +
>  include/hw/misc/unimp.h |  39 ++++++++++++++++++
>  hw/misc/unimp.c         | 107 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 include/hw/misc/unimp.h
>  create mode 100644 hw/misc/unimp.c
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 1a89615..898e4cc 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -6,6 +6,8 @@ common-obj-$(CONFIG_SGA) += sga.o
>  common-obj-$(CONFIG_ISA_TESTDEV) += pc-testdev.o
>  common-obj-$(CONFIG_PCI_TESTDEV) += pci-testdev.o
>
> +common-obj-y += unimp.o
> +
>  obj-$(CONFIG_VMPORT) += vmport.o
>
>  # ARM devices
> diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
> new file mode 100644
> index 0000000..3462d85
> --- /dev/null
> +++ b/include/hw/misc/unimp.h
> @@ -0,0 +1,39 @@
> +/*
> + * "Unimplemented" device
> + *
> + * Copyright Linaro Limited, 2017
> + * Written by Peter Maydell
> + */
> +
> +#ifndef HW_MISC_UNIMP_H
> +#define HW_MISC_UNIMP_H
> +
> +#define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
> +
> +/**
> + * create_unimplemented_device: create and map a dummy device
> + * @name: name of the device for debug logging
> + * @base: base address of the device's MMIO region
> + * @size: size of the device's MMIO region
> + *
> + * This utility function creates and maps an instance of unimplemented-device,
> + * which is a dummy device which simply logs all guest accesses to
> + * it via the qemu_log LOG_UNIMP debug log.
> + * The device is mapped at priority -1000, which means that you can
> + * use it to cover a large region and then map other devices on top of it
> + * if necessary.
> + */
> +static inline void create_unimplemented_device(const char *name,
> +                                               hwaddr base,
> +                                               hwaddr size)
> +{
> +    DeviceState *dev = qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
> +
> +    qdev_prop_set_string(dev, "name", name);
> +    qdev_prop_set_uint64(dev, "size", size);
> +    qdev_init_nofail(dev);
> +
> +    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(dev), 0, base, -1000);
> +}
> +
> +#endif
> diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
> new file mode 100644
> index 0000000..bcbb585
> --- /dev/null
> +++ b/hw/misc/unimp.c
> @@ -0,0 +1,107 @@
> +/* "Unimplemented" device
> + *
> + * This is a dummy device which accepts and logs all accesses.
> + * It's useful for stubbing out regions of an SoC or board
> + * map which correspond to devices that have not yet been
> + * implemented. This is often sufficient to placate initial
> + * guest device driver probing such that the system will
> + * come up.
> + *
> + * Copyright Linaro Limited, 2017
> + * Written by Peter Maydell
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/hw.h"
> +#include "hw/sysbus.h"
> +#include "hw/misc/unimp.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +
> +#define UNIMPLEMENTED_DEVICE(obj) \
> +    OBJECT_CHECK(UnimplementedDeviceState, (obj), TYPE_UNIMPLEMENTED_DEVICE)
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +    char *name;
> +    uint64_t size;
> +} UnimplementedDeviceState;
> +
> +static uint64_t unimp_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
> +                  "(size %d, offset 0x%" HWADDR_PRIx ")\n",
> +                  s->name, size, offset);
> +    return 0;
> +}
> +
> +static void unimp_write(void *opaque, hwaddr offset,
> +                        uint64_t value, unsigned size)
> +{
> +    UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
> +
> +    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> +                  "(size %d, value 0x%" PRIx64
> +                  ", offset 0x%" HWADDR_PRIx ")\n",
> +                  s->name, size, value, offset);
> +}
> +
> +static const MemoryRegionOps unimp_ops = {
> +    .read = unimp_read,
> +    .write = unimp_write,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 8,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 8,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +};
> +
> +static void unimp_realize(DeviceState *dev, Error **errp)
> +{
> +    UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(dev);
> +
> +    if (s->size == 0) {
> +        error_setg(errp, "property 'size' not specified or zero");
> +        return;
> +    }
> +
> +    if (s->name == NULL) {
> +        error_setg(errp, "property 'name' not specified");
> +        return;
> +    }
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &unimp_ops, s,
> +                          s->name, s->size);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
> +}
> +
> +static Property unimp_properties[] = {
> +    DEFINE_PROP_UINT64("size", UnimplementedDeviceState, size, 0),
> +    DEFINE_PROP_STRING("name", UnimplementedDeviceState, name),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void unimp_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->realize = unimp_realize;
> +    dc->props = unimp_properties;
> +}
> +
> +static const TypeInfo unimp_info = {
> +    .name = TYPE_UNIMPLEMENTED_DEVICE,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(UnimplementedDeviceState),
> +    .class_init = unimp_class_init,
> +};
> +
> +static void unimp_register_types(void)
> +{
> +    type_register_static(&unimp_info);
> +}
> +
> +type_init(unimp_register_types)


--
Alex Bennée
