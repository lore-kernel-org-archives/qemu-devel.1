Received: from eggs.gnu.org ([2001:4830:134:3::10]:58460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLjG-0001GE-7N
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPLjE-0002qP-Pm
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 00:34:26 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170623220926.11479-3-jsnow@redhat.com>
References: <20170623220926.11479-1-jsnow@redhat.com>
	<20170623220926.11479-3-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 26 Jun 2017 01:34:19 -0300
Message-ID: <CAAdtpL4Uzbg_FdKraANpqTc6V4tW702Xeu3Y0JrHoE+A2xEZYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] ahci: Isolate public AHCI interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Fri, Jun 23, 2017 at 7:09 PM, John Snow <jsnow@redhat.com> wrote:
> Begin separating the public/private interface by removing the minimum
> set of information used by code outside of hw/ide/ and calling this
> a new ahci_public.h file, which will be renamed to ahci.h in a future
> patch.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  include/hw/ide/ahci.h        | 57 +++------------------------
>  include/hw/ide/ahci_public.h | 91 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 96 insertions(+), 52 deletions(-)
>  create mode 100644 include/hw/ide/ahci_public.h
>
> diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
> index f866bbf..70a0140 100644
> --- a/include/hw/ide/ahci.h
> +++ b/include/hw/ide/ahci.h
> @@ -21,9 +21,10 @@
>   *
>   */
>
> -#ifndef HW_IDE_AHCI_H
> -#define HW_IDE_AHCI_H
> +#ifndef HW_IDE_AHCI_INTERNAL_H
> +#define HW_IDE_AHCI_INTERNAL_H
>
> +#include "hw/ide/ahci_public.h"
>  #include "hw/sysbus.h"
>
>  #define AHCI_MEM_BAR_SIZE         0x1000
> @@ -210,14 +211,6 @@
>  #define SATA_CAP_REV            0x2
>  #define SATA_CAP_BAR            0x4
>
> -typedef struct AHCIControlRegs {
> -    uint32_t    cap;
> -    uint32_t    ghc;
> -    uint32_t    irqstatus;
> -    uint32_t    impl;
> -    uint32_t    version;
> -} AHCIControlRegs;
> -
>  typedef struct AHCIPortRegs {
>      uint32_t    lst_addr;
>      uint32_t    lst_addr_hi;
> @@ -251,8 +244,6 @@ typedef struct AHCI_SG {
>      uint32_t    flags_size;
>  } QEMU_PACKED AHCI_SG;
>
> -typedef struct AHCIDevice AHCIDevice;
> -
>  typedef struct NCQTransferState {
>      AHCIDevice *drive;
>      BlockAIOCB *aiocb;
> @@ -286,27 +277,13 @@ struct AHCIDevice {
>      NCQTransferState ncq_tfs[AHCI_MAX_CMDS];
>  };
>
> -typedef struct AHCIState {
> -    DeviceState *container;
> -
> -    AHCIDevice *dev;
> -    AHCIControlRegs control_regs;
> -    MemoryRegion mem;
> -    MemoryRegion idp;       /* Index-Data Pair I/O port space */
> -    unsigned idp_offset;    /* Offset of index in I/O port space */
> -    uint32_t idp_index;     /* Current IDP index */
> -    int32_t ports;
> -    qemu_irq irq;
> -    AddressSpace *as;
> -} AHCIState;
> -
> -typedef struct AHCIPCIState {
> +struct AHCIPCIState {
>      /*< private >*/
>      PCIDevice parent_obj;
>      /*< public >*/
>
>      AHCIState ahci;
> -} AHCIPCIState;
> +};
>
>  #define TYPE_ICH9_AHCI "ich9-ahci"
>
> @@ -372,35 +349,11 @@ void ahci_uninit(AHCIState *s);
>
>  void ahci_reset(AHCIState *s);
>
> -int32_t ahci_get_num_ports(PCIDevice *dev);
> -void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
> -
>  #define TYPE_SYSBUS_AHCI "sysbus-ahci"
>  #define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBU=
S_AHCI)
>
> -typedef struct SysbusAHCIState {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    AHCIState ahci;
> -    uint32_t num_ports;
> -} SysbusAHCIState;
> -
>  #define TYPE_ALLWINNER_AHCI "allwinner-ahci"
>  #define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
>                         TYPE_ALLWINNER_AHCI)
>
> -#define ALLWINNER_AHCI_MMIO_OFF  0x80
> -#define ALLWINNER_AHCI_MMIO_SIZE 0x80
> -
> -struct AllwinnerAHCIState {
> -    /*< private >*/
> -    SysbusAHCIState parent_obj;
> -    /*< public >*/
> -
> -    MemoryRegion mmio;
> -    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
> -};
> -
>  #endif /* HW_IDE_AHCI_H */
> diff --git a/include/hw/ide/ahci_public.h b/include/hw/ide/ahci_public.h
> new file mode 100644
> index 0000000..5a06537
> --- /dev/null
> +++ b/include/hw/ide/ahci_public.h
> @@ -0,0 +1,91 @@
> +/*
> + * QEMU AHCI Emulation
> + *
> + * Copyright (c) 2010 qiaochong@loongson.cn
> + * Copyright (c) 2010 Roland Elek <elek.roland@gmail.com>
> + * Copyright (c) 2010 Sebastian Herbszt <herbszt@gmx.de>
> + * Copyright (c) 2010 Alexander Graf <agraf@suse.de>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +#ifndef HW_IDE_AHCI_H
> +#define HW_IDE_AHCI_H
> +
> +#include "hw/sysbus.h"
> +
> +typedef struct AHCIDevice AHCIDevice;
> +
> +typedef struct AHCIControlRegs {
> +    uint32_t    cap;
> +    uint32_t    ghc;
> +    uint32_t    irqstatus;
> +    uint32_t    impl;
> +    uint32_t    version;
> +} AHCIControlRegs;
> +
> +typedef struct AHCIState {
> +    DeviceState *container;
> +
> +    AHCIDevice *dev;
> +    AHCIControlRegs control_regs;
> +    MemoryRegion mem;
> +    MemoryRegion idp;       /* Index-Data Pair I/O port space */
> +    unsigned idp_offset;    /* Offset of index in I/O port space */
> +    uint32_t idp_index;     /* Current IDP index */
> +    int32_t ports;
> +    qemu_irq irq;
> +    AddressSpace *as;
> +} AHCIState;
> +
> +typedef struct AHCIPCIState AHCIPCIState;
> +
> +#define TYPE_ICH9_AHCI "ich9-ahci"
> +
> +#define ICH_AHCI(obj) \
> +    OBJECT_CHECK(AHCIPCIState, (obj), TYPE_ICH9_AHCI)
> +
> +int32_t ahci_get_num_ports(PCIDevice *dev);
> +void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
> +
> +#define TYPE_SYSBUS_AHCI "sysbus-ahci"
> +#define SYSBUS_AHCI(obj) OBJECT_CHECK(SysbusAHCIState, (obj), TYPE_SYSBU=
S_AHCI)
> +
> +typedef struct SysbusAHCIState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    AHCIState ahci;
> +    uint32_t num_ports;
> +} SysbusAHCIState;
> +
> +#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
> +#define ALLWINNER_AHCI(obj) OBJECT_CHECK(AllwinnerAHCIState, (obj), \
> +                       TYPE_ALLWINNER_AHCI)
> +
> +#define ALLWINNER_AHCI_MMIO_OFF  0x80
> +#define ALLWINNER_AHCI_MMIO_SIZE 0x80
> +
> +struct AllwinnerAHCIState {
> +    /*< private >*/
> +    SysbusAHCIState parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion mmio;
> +    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
> +};
> +
> +#endif /* HW_IDE_AHCI_H */
> --
> 2.9.4
>
