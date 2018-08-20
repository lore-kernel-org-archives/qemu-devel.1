Received: from eggs.gnu.org ([2001:4830:134:3::10]:36485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1frfts-0004DQ-QO
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1frftp-0007G3-Fj
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:51:00 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:41563
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1frfto-0007FA-Up
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 04:50:57 -0400
References: <20180817114619.22354-1-peter.maydell@linaro.org>
	<20180817114619.22354-4-peter.maydell@linaro.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <7a9769f7-dfef-2fbb-9cf3-79f72a615ca8@adacore.com>
Date: Mon, 20 Aug 2018 10:50:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180817114619.22354-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/misc: Remove mmio_interface device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>


Le 08/17/2018 =C3=A0 01:46 PM, Peter Maydell a =C3=A9crit=C2=A0:
> The mmio_interface device was a purely internal artifact
> of the implementation of the memory subsystem's request_ptr
> APIs. Now that we have removed those APIs, we can remove
> the mmio_interface device too.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>   hw/misc/Makefile.objs            |   1 -
>   include/hw/misc/mmio_interface.h |  49 -----------
>   hw/misc/mmio_interface.c         | 135 ------------------------------=
-
>   3 files changed, 185 deletions(-)
>   delete mode 100644 include/hw/misc/mmio_interface.h
>   delete mode 100644 hw/misc/mmio_interface.c
>=20
> diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
> index 51d27b3af1e..22714b08510 100644
> --- a/hw/misc/Makefile.objs
> +++ b/hw/misc/Makefile.objs
> @@ -71,5 +71,4 @@ obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
>   obj-$(CONFIG_HYPERV_TESTDEV) +=3D hyperv_testdev.o
>   obj-$(CONFIG_AUX) +=3D auxbus.o
>   obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
> -obj-y +=3D mmio_interface.o
>   obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
> diff --git a/include/hw/misc/mmio_interface.h b/include/hw/misc/mmio_in=
terface.h
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
> - * This program is free software; you can redistribute it and/or modif=
y
> - * it under the terms of the GNU General Public License as published b=
y
> - * the Free Software Foundation, either version 2 of the License, or
> - * (at your option)any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License a=
long
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
> -#define MMIO_INTERFACE(obj) OBJECT_CHECK(MMIOInterface, (obj),        =
         \
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
> - * This program is free software; you can redistribute it and/or modif=
y
> - * it under the terms of the GNU General Public License as published b=
y
> - * the Free Software Foundation, either version 2 of the License, or
> - * (at your option)any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License a=
long
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
> -#define DPRINTF(fmt, ...) do {                                        =
         \
> -    if (DEBUG_MMIO_INTERFACE) {                                       =
         \
> -        qemu_log("mmio_interface: 0x%" PRIX64 ": " fmt, s->id, ## __VA=
_ARGS__);\
> -    }                                                                 =
         \
> -} while (0)
> -
> -static void mmio_interface_init(Object *obj)
> -{
> -    MMIOInterface *s =3D MMIO_INTERFACE(obj);
> -
> -    if (DEBUG_MMIO_INTERFACE) {
> -        s->id =3D mmio_interface_counter++;
> -    }
> -
> -    DPRINTF("interface created\n");
> -    s->host_ptr =3D 0;
> -    s->subregion =3D 0;
> -}
> -
> -static void mmio_interface_realize(DeviceState *dev, Error **errp)
> -{
> -    MMIOInterface *s =3D MMIO_INTERFACE(dev);
> -
> -    DPRINTF("realize from 0x%" PRIX64 " to 0x%" PRIX64 " map host poin=
ter"
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
> -    MMIOInterface *s =3D MMIO_INTERFACE(dev);
> -
> -    DPRINTF("unrealize from 0x%" PRIX64 " to 0x%" PRIX64 " map host po=
inter"
> -            " %p\n", s->start, s->end, s->host_ptr);
> -    memory_region_del_subregion(s->subregion, &s->ram_mem);
> -}
> -
> -static void mmio_interface_finalize(Object *obj)
> -{
> -    MMIOInterface *s =3D MMIO_INTERFACE(obj);
> -
> -    DPRINTF("finalize from 0x%" PRIX64 " to 0x%" PRIX64 " map host poi=
nter"
> -            " %p\n", s->start, s->end, s->host_ptr);
> -    object_unparent(OBJECT(&s->ram_mem));
> -}
> -
> -static Property mmio_interface_properties[] =3D {
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
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -
> -    dc->realize =3D mmio_interface_realize;
> -    dc->unrealize =3D mmio_interface_unrealize;
> -    dc->props =3D mmio_interface_properties;
> -    /* Reason: pointer property "host_ptr", and this device
> -     * is an implementation detail of the memory subsystem,
> -     * not intended to be created directly by the user.
> -     */
> -    dc->user_creatable =3D false;
> -}
> -
> -static const TypeInfo mmio_interface_info =3D {
> -    .name          =3D TYPE_MMIO_INTERFACE,
> -    .parent        =3D TYPE_DEVICE,
> -    .instance_size =3D sizeof(MMIOInterface),
> -    .instance_init =3D mmio_interface_init,
> -    .instance_finalize =3D mmio_interface_finalize,
> -    .class_init    =3D mmio_interface_class_init,
> -};
> -
> -static void mmio_interface_register_types(void)
> -{
> -    type_register_static(&mmio_interface_info);
> -}
> -
> -type_init(mmio_interface_register_types)
>=20
