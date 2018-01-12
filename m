Received: from eggs.gnu.org ([2001:4830:134:3::10]:42524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea0kM-0006EL-EL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea0kL-0007Xj-5T
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:55:54 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:42255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ea0kK-0007Wn-Rl
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:55:53 -0500
Received: by mail-wm0-x242.google.com with SMTP id b141so12744019wme.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 06:55:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515609318-1897-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 15:55:50 +0100
Message-ID: <CAJ+F1C+wFaPWov+sM_UveO92s3tEUDxo1OzSKyMGyS1tRqm+2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] tpm: Implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, kevin@koconnor.net, "Michael S. Tsirkin" <mst@redhat.com>

Hi

On Wed, Jan 10, 2018 at 7:35 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Implement a virtual memory device for the TPM physical
> presence interface. The memory is located at 0xffff0000
> and used by ACPI to send messages to the firmware (BIOS).
>
> This device should be used by all TPM interfaces on x86 and
> can be added through by calling tpm_ppi_init_io().
>

I haven't followed closely the current design discussion on seabios
ML, so this is just a quick review:

> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/Makefile.objs  |  2 +-
>  hw/tpm/tpm_ppi.c      | 79 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  hw/tpm/tpm_ppi.h      | 25 ++++++++++++++++
>  hw/tpm/tpm_tis.c      |  5 ++++
>  include/hw/acpi/tpm.h |  6 ++++
>  5 files changed, 116 insertions(+), 1 deletion(-)
>  create mode 100644 hw/tpm/tpm_ppi.c
>  create mode 100644 hw/tpm/tpm_ppi.h
>
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 7a93b24..3eb0558 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-y +=3D tpm_util.o
> +common-obj-y +=3D tpm_util.o tpm_ppi.o
>  common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>  common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>  common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> new file mode 100644
> index 0000000..fa8c3c3
> --- /dev/null
> +++ b/hw/tpm/tpm_ppi.c
> @@ -0,0 +1,79 @@
> +/*
> + * tpm_ppi.c - TPM Physical Presence Interface
> + *
> + * Copyright (C) 2018 IBM Corporation
> + *
> + * Authors:
> + *  Stefan Berger <stefanb@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/memory.h"
> +#include "exec/address-spaces.h"
> +
> +#include "tpm_ppi.h"
> +
> +#define DEBUG_PPI 1

to be switched to 0

> +
> +#define DPRINTF(fmt, ...) do { \
> +    if (DEBUG_PPI) { \
> +        printf(fmt, ## __VA_ARGS__); \
> +    } \
> +} while (0);
> +
> +static uint64_t tpm_ppi_mmio_read(void *opaque, hwaddr addr,
> +                                  unsigned size)
> +{
> +    TPMPPI *s =3D opaque;
> +    uint32_t val =3D 0;
> +    int c;
> +
> +    for (c =3D size - 1; c >=3D 0; c--) {

I would rather put the -1,

> +        val <<=3D 8;
> +        val |=3D s->ram[addr + c];

^ here, ymmv

> +    }
> +
> +    DPRINTF("tpm_ppi: read.%u(%08x) =3D %08x\n", size,
> +            (unsigned int)addr, (unsigned int)val);
> +
> +    return val;
> +}
> +
> +static void tpm_ppi_mmio_write(void *opaque, hwaddr addr,
> +                               uint64_t val, unsigned size)
> +{
> +    TPMPPI *s =3D opaque;
> +    int c;
> +
> +    DPRINTF("tpm_ppi: write.%u(%08x) =3D %08x\n", size,
> +            (unsigned int)addr, (unsigned int)val);
> +
> +    for (c =3D 0; c <=3D size - 1; c++) {

same

(alternatively, why not cast the addr pointer?)

> +        s->ram[addr + c] =3D val;
> +        val >>=3D 8;
> +    }
> +}
> +
> +static const MemoryRegionOps tpm_ppi_memory_ops =3D {
> +    .read =3D tpm_ppi_mmio_read,
> +    .write =3D tpm_ppi_mmio_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,

Shouldn't it be native endian?

> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +    },
> +};
> +
> +void tpm_ppi_init_io(TPMPPI *tpmppi, Object *obj)
> +{
> +    memory_region_init_io(&tpmppi->mmio, obj, &tpm_ppi_memory_ops,
> +                          tpmppi, "tpm-ppi-mmio",
> +                          TPM_PPI_ADDR_SIZE);
> +
> +    memory_region_add_subregion(get_system_memory(),
> +                                TPM_PPI_ADDR_BASE, &tpmppi->mmio);
> +}
> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> new file mode 100644
> index 0000000..8959912
> --- /dev/null
> +++ b/hw/tpm/tpm_ppi.h
> @@ -0,0 +1,25 @@
> +/*
> + * TPM Physical Presence Interface
> + *
> + * Copyright (C) 2018 IBM Corporation
> + *
> + * Authors:
> + *  Stefan Berger    <stefanb@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef TPM_TPM_PPI_H
> +#define TPM_TPM_PPI_H
> +
> +#include "hw/acpi/tpm.h"
> +
> +typedef struct TPMPPI {
> +    MemoryRegion mmio;
> +
> +    uint8_t ram[TPM_PPI_ADDR_SIZE];
> +} TPMPPI;
> +
> +void tpm_ppi_init_io(TPMPPI *tpmppi, Object *obj);
> +
> +#endif /* TPM_TPM_PPI_H */
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 561384c..f980972 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -31,6 +31,7 @@
>  #include "sysemu/tpm_backend.h"
>  #include "tpm_int.h"
>  #include "tpm_util.h"
> +#include "tpm_ppi.h"
>
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>  #define TPM_TIS_LOCALITY_SHIFT      12
> @@ -80,6 +81,8 @@ typedef struct TPMState {
>      TPMVersion be_tpm_version;
>
>      size_t be_buffer_size;
> +
> +    TPMPPI ppi;
>  } TPMState;
>
>  #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> @@ -1050,6 +1053,8 @@ static void tpm_tis_initfn(Object *obj)
>      memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_memory_ops,
>                            s, "tpm-tis-mmio",
>                            TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHI=
FT);
> +
> +    tpm_ppi_init_io(&s->ppi, obj);

I suggest to pass the device isa address space there (instead of
hooking the PPI only on system_memory).

>  }
>
>  static void tpm_tis_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index 6d516c6..d9b7452 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -31,4 +31,10 @@
>
>  #define TPM2_START_METHOD_MMIO      6
>
> +/*
> + * Physical Presence Interface
> + */
> +#define TPM_PPI_ADDR_SIZE           0x100
> +#define TPM_PPI_ADDR_BASE           0xffff0000
> +
>  #endif /* HW_ACPI_TPM_H */
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
