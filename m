Received: from eggs.gnu.org ([2001:4830:134:3::10]:34196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fqiOd-0003u7-NX
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fqiOc-0004kq-Fu
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:18:47 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fqiOc-0004kK-4W
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:18:46 -0400
Received: by mail-lf1-x141.google.com with SMTP id b22-v6so6405540lfa.3
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 10:18:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817114619.22354-4-peter.maydell@linaro.org>
References: <20180817114619.22354-1-peter.maydell@linaro.org>
	<20180817114619.22354-4-peter.maydell@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Aug 2018 10:18:14 -0700
Message-ID: <CAKmqyKPr1UU=ZqW9DDkR+0mg8nCcF5ibMmDTAt_s4LQ7u3vDjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/misc: Remove mmio_interface device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, KONRAD Frederic <frederic.konrad@adacore.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On Fri, Aug 17, 2018 at 4:46 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> The mmio_interface device was a purely internal artifact
> of the implementation of the memory subsystem's request_ptr
> APIs. Now that we have removed those APIs, we can remove
> the mmio_interface device too.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/Makefile.objs            |   1 -
>  include/hw/misc/mmio_interface.h |  49 -----------
>  hw/misc/mmio_interface.c         | 135 -------------------------------
>  3 files changed, 185 deletions(-)
>  delete mode 100644 include/hw/misc/mmio_interface.h
>  delete mode 100644 hw/misc/mmio_interface.c
>
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 51d27b3af1e..22714b08510 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -71,5 +71,4 @@ obj-$(CONFIG_PVPANIC) += pvpanic.o
>  obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
>  obj-$(CONFIG_AUX) += auxbus.o
>  obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
> -obj-y += mmio_interface.o
>  obj-$(CONFIG_MSF2) += msf2-sysreg.o
> diff --git a/include/hw/misc/mmio_interface.h b/include/hw/misc/mmio_interface.h
> deleted file mode 100644
> index 90d34fb2286..00000000000
> --- a/include/hw/misc/mmio_interface.h
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -/*
> - * mmio_interface.h
> - *
> - *  Copyright (C) 2017 : GreenSocs
> - *      http://www.greensocs.com/ , email: info@greensocs.com
> - *
> - *  Developed by :
> - *  Frederic Konrad   <fred.konrad@greensocs.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation, either version 2 of the License, or
> - * (at your option)any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
> - */
> -
> -#ifndef MMIO_INTERFACE_H
> -#define MMIO_INTERFACE_H
> -
> -#include "exec/memory.h"
> -
> -#define TYPE_MMIO_INTERFACE "mmio_interface"
> -#define MMIO_INTERFACE(obj) OBJECT_CHECK(MMIOInterface, (obj),                 \
> -                                         TYPE_MMIO_INTERFACE)
> -
> -typedef struct MMIOInterface {
> -    DeviceState parent_obj;
> -
> -    MemoryRegion *subregion;
> -    MemoryRegion ram_mem;
> -    uint64_t start;
> -    uint64_t end;
> -    bool ro;
> -    uint64_t id;
> -    void *host_ptr;
> -} MMIOInterface;
> -
> -void mmio_interface_map(MMIOInterface *s);
> -void mmio_interface_unmap(MMIOInterface *s);
> -
> -#endif /* MMIO_INTERFACE_H */
> diff --git a/hw/misc/mmio_interface.c b/hw/misc/mmio_interface.c
> deleted file mode 100644
> index 3b0e2039a36..00000000000
> --- a/hw/misc/mmio_interface.c
> +++ /dev/null
> @@ -1,135 +0,0 @@
> -/*
> - * mmio_interface.c
> - *
> - *  Copyright (C) 2017 : GreenSocs
> - *      http://www.greensocs.com/ , email: info@greensocs.com
> - *
> - *  Developed by :
> - *  Frederic Konrad   <fred.konrad@greensocs.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation, either version 2 of the License, or
> - * (at your option)any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/log.h"
> -#include "trace.h"
> -#include "hw/qdev-properties.h"
> -#include "hw/misc/mmio_interface.h"
> -#include "qapi/error.h"
> -
> -#ifndef DEBUG_MMIO_INTERFACE
> -#define DEBUG_MMIO_INTERFACE 0
> -#endif
> -
> -static uint64_t mmio_interface_counter;
> -
> -#define DPRINTF(fmt, ...) do {                                                 \
> -    if (DEBUG_MMIO_INTERFACE) {                                                \
> -        qemu_log("mmio_interface: 0x%" PRIX64 ": " fmt, s->id, ## __VA_ARGS__);\
> -    }                                                                          \
> -} while (0)
> -
> -static void mmio_interface_init(Object *obj)
> -{
> -    MMIOInterface *s = MMIO_INTERFACE(obj);
> -
> -    if (DEBUG_MMIO_INTERFACE) {
> -        s->id = mmio_interface_counter++;
> -    }
> -
> -    DPRINTF("interface created\n");
> -    s->host_ptr = 0;
> -    s->subregion = 0;
> -}
> -
> -static void mmio_interface_realize(DeviceState *dev, Error **errp)
> -{
> -    MMIOInterface *s = MMIO_INTERFACE(dev);
> -
> -    DPRINTF("realize from 0x%" PRIX64 " to 0x%" PRIX64 " map host pointer"
> -            " %p\n", s->start, s->end, s->host_ptr);
> -
> -    if (!s->host_ptr) {
> -        error_setg(errp, "host_ptr property must be set");
> -        return;
> -    }
> -
> -    if (!s->subregion) {
> -        error_setg(errp, "subregion property must be set");
> -        return;
> -    }
> -
> -    memory_region_init_ram_ptr(&s->ram_mem, OBJECT(s), "ram",
> -                               s->end - s->start + 1, s->host_ptr);
> -    memory_region_set_readonly(&s->ram_mem, s->ro);
> -    memory_region_add_subregion(s->subregion, s->start, &s->ram_mem);
> -}
> -
> -static void mmio_interface_unrealize(DeviceState *dev, Error **errp)
> -{
> -    MMIOInterface *s = MMIO_INTERFACE(dev);
> -
> -    DPRINTF("unrealize from 0x%" PRIX64 " to 0x%" PRIX64 " map host pointer"
> -            " %p\n", s->start, s->end, s->host_ptr);
> -    memory_region_del_subregion(s->subregion, &s->ram_mem);
> -}
> -
> -static void mmio_interface_finalize(Object *obj)
> -{
> -    MMIOInterface *s = MMIO_INTERFACE(obj);
> -
> -    DPRINTF("finalize from 0x%" PRIX64 " to 0x%" PRIX64 " map host pointer"
> -            " %p\n", s->start, s->end, s->host_ptr);
> -    object_unparent(OBJECT(&s->ram_mem));
> -}
> -
> -static Property mmio_interface_properties[] = {
> -    DEFINE_PROP_UINT64("start", MMIOInterface, start, 0),
> -    DEFINE_PROP_UINT64("end", MMIOInterface, end, 0),
> -    DEFINE_PROP_PTR("host_ptr", MMIOInterface, host_ptr),
> -    DEFINE_PROP_BOOL("ro", MMIOInterface, ro, false),
> -    DEFINE_PROP_MEMORY_REGION("subregion", MMIOInterface, subregion),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void mmio_interface_class_init(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(oc);
> -
> -    dc->realize = mmio_interface_realize;
> -    dc->unrealize = mmio_interface_unrealize;
> -    dc->props = mmio_interface_properties;
> -    /* Reason: pointer property "host_ptr", and this device
> -     * is an implementation detail of the memory subsystem,
> -     * not intended to be created directly by the user.
> -     */
> -    dc->user_creatable = false;
> -}
> -
> -static const TypeInfo mmio_interface_info = {
> -    .name          = TYPE_MMIO_INTERFACE,
> -    .parent        = TYPE_DEVICE,
> -    .instance_size = sizeof(MMIOInterface),
> -    .instance_init = mmio_interface_init,
> -    .instance_finalize = mmio_interface_finalize,
> -    .class_init    = mmio_interface_class_init,
> -};
> -
> -static void mmio_interface_register_types(void)
> -{
> -    type_register_static(&mmio_interface_info);
> -}
> -
> -type_init(mmio_interface_register_types)
> --
> 2.18.0
>
>
