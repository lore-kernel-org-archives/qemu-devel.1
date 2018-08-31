Received: from eggs.gnu.org ([2001:4830:134:3::10]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvsqK-0005Tx-Lx
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 19:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fvsqJ-0008BD-HR
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 19:28:44 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fvsqJ-0008B0-AW
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 19:28:43 -0400
Received: by mail-wm0-x243.google.com with SMTP id y2-v6so6567847wma.1
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 16:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180831172424.12029-1-marcandre.lureau@redhat.com>
	<20180831172424.12029-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180831172424.12029-4-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 1 Sep 2018 01:28:28 +0200
Message-ID: <CAJ+F1CKEjAnQDtt2n0LOu4MKT94fqWnfjXUprp3vqYY=JghfsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 3/6] tpm: allocate/map buffer for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, xiaoguangrong@tencent.com, Juan Quintela <quintela@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Fri, Aug 31, 2018 at 7:32 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> Implement a virtual memory device for the TPM Physical Presence interface=
.
> The memory is located at 0xFED45000 and used by ACPI to send messages to =
the
> firmware (BIOS) and by the firmware to provide parameters for each one of
> the supported codes.
>
> This interface should be used by all TPM devices on x86 and can be
> added by calling tpm_ppi_init_io().
>
> Note: bios_linker cannot be used to allocate the PPI memory region,
> since the reserved memory should stay stable across reboots, and might
> be needed before the ACPI tables are installed.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/tpm/tpm_ppi.h      | 26 ++++++++++++++++++++++++++
>  include/hw/acpi/tpm.h |  6 ++++++
>  hw/tpm/tpm_crb.c      |  8 ++++++++
>  hw/tpm/tpm_ppi.c      | 31 +++++++++++++++++++++++++++++++
>  hw/tpm/tpm_tis.c      |  8 ++++++++
>  hw/tpm/Makefile.objs  |  1 +
>  6 files changed, 80 insertions(+)
>  create mode 100644 hw/tpm/tpm_ppi.h
>  create mode 100644 hw/tpm/tpm_ppi.c
>
> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> new file mode 100644
> index 0000000000..f6458bf87e
> --- /dev/null
> +++ b/hw/tpm/tpm_ppi.h
> @@ -0,0 +1,26 @@
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
> +#include "exec/address-spaces.h"
> +
> +typedef struct TPMPPI {
> +    MemoryRegion ram;
> +    uint8_t buf[TPM_PPI_ADDR_SIZE];
> +} TPMPPI;
> +
> +bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> +                  hwaddr addr, Object *obj, Error **errp);
> +
> +#endif /* TPM_TPM_PPI_H */
> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
> index 3580ffd50c..b8796df916 100644
> --- a/include/hw/acpi/tpm.h
> +++ b/include/hw/acpi/tpm.h
> @@ -188,4 +188,10 @@ REG32(CRB_DATA_BUFFER, 0x80)
>  #define TPM2_START_METHOD_MMIO      6
>  #define TPM2_START_METHOD_CRB       7
>
> +/*
> + * Physical Presence Interface
> + */
> +#define TPM_PPI_ADDR_SIZE           0x400
> +#define TPM_PPI_ADDR_BASE           0xFED45000
> +
>  #endif /* HW_ACPI_TPM_H */
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index d5b0ac5920..b243222fd6 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -29,6 +29,7 @@
>  #include "sysemu/reset.h"
>  #include "tpm_int.h"
>  #include "tpm_util.h"
> +#include "tpm_ppi.h"
>  #include "trace.h"
>
>  typedef struct CRBState {
> @@ -43,6 +44,7 @@ typedef struct CRBState {
>      size_t be_buffer_size;
>
>      bool ppi_enabled;
> +    TPMPPI ppi;
>  } CRBState;
>
>  #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
> @@ -294,6 +296,12 @@ static void tpm_crb_realize(DeviceState *dev, Error =
**errp)
>      memory_region_add_subregion(get_system_memory(),
>          TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
>
> +    if (s->ppi_enabled &&
> +        !tpm_ppi_init(&s->ppi, get_system_memory(),
> +                      TPM_PPI_ADDR_BASE, OBJECT(s), errp)) {
> +        return;
> +    }
> +
>      qemu_register_reset(tpm_crb_reset, dev);
>  }
>
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> new file mode 100644
> index 0000000000..8b46b9dd4b
> --- /dev/null
> +++ b/hw/tpm/tpm_ppi.c
> @@ -0,0 +1,31 @@
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
> +
> +#include "qapi/error.h"
> +#include "cpu.h"
> +#include "sysemu/memory_mapping.h"
> +#include "migration/vmstate.h"
> +#include "tpm_ppi.h"
> +
> +bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> +                  hwaddr addr, Object *obj, Error **errp)
> +{
> +    memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
> +                                      TPM_PPI_ADDR_SIZE, tpmppi->buf);

There is a (new) issue with the PPI ram region:

READ of size 32 at 0x61d000090480 thread T6
    #0 0x5622bd8de0f4 in buffer_zero_avx2
/home/elmarco/src/qq/util/bufferiszero.c:169
    #1 0x5622bd8de899 in select_accel_fn
/home/elmarco/src/qq/util/bufferiszero.c:282
    #2 0x5622bd8de8f1 in buffer_is_zero
/home/elmarco/src/qq/util/bufferiszero.c:309
    #3 0x5622bc209f94 in is_zero_range /home/elmarco/src/qq/migration/ram.c=
:82
    #4 0x5622bc21938d in save_zero_page_to_file
/home/elmarco/src/qq/migration/ram.c:1694
    #5 0x5622bc219452 in save_zero_page
/home/elmarco/src/qq/migration/ram.c:1713
    #6 0x5622bc21db67 in ram_save_target_page
/home/elmarco/src/qq/migration/ram.c:2289
    #7 0x5622bc21e13e in ram_save_host_page
/home/elmarco/src/qq/migration/ram.c:2351
    #8 0x5622bc21ea3a in ram_find_and_save_block
/home/elmarco/src/qq/migration/ram.c:2413
    #9 0x5622bc223b5d in ram_save_iterate
/home/elmarco/src/qq/migration/ram.c:3193
    #10 0x5622bd16f544 in qemu_savevm_state_iterate
/home/elmarco/src/qq/migration/savevm.c:1103
    #11 0x5622bd157e75 in migration_iteration_run
/home/elmarco/src/qq/migration/migration.c:2897
    #12 0x5622bd15892e in migration_thread
/home/elmarco/src/qq/migration/migration.c:3018
    #13 0x5622bd902f31 in qemu_thread_start
/home/elmarco/src/qq/util/qemu-thread-posix.c:504
    #14 0x7f42f0ef4593 in start_thread (/lib64/libpthread.so.0+0x7593)
    #15 0x7f42f0c280de in clone (/lib64/libc.so.6+0xfa0de)
0x61d000090490 is located 0 bytes to the right of 2064-byte region
[0x61d00008fc80,0x61d000090490)

migration code is assuming RAM is multiple of TARGET_PAGE_SIZE.

Should the migration code be fixed, or should the TPM code allocate
ram differently?

In all case, I think the migration code should either be fixed or have
an assert.


> +    vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> +
> +    memory_region_add_subregion(m, addr, &tpmppi->ram);
> +    return true;
> +}
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index d9ddf9b723..70432ffe8b 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -31,6 +31,7 @@
>  #include "sysemu/tpm_backend.h"
>  #include "tpm_int.h"
>  #include "tpm_util.h"
> +#include "tpm_ppi.h"
>  #include "trace.h"
>
>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
> @@ -83,6 +84,7 @@ typedef struct TPMState {
>      size_t be_buffer_size;
>
>      bool ppi_enabled;
> +    TPMPPI ppi;
>  } TPMState;
>
>  #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> @@ -979,6 +981,12 @@ static void tpm_tis_realizefn(DeviceState *dev, Erro=
r **errp)
>
>      memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>                                  TPM_TIS_ADDR_BASE, &s->mmio);
> +
> +    if (s->ppi_enabled &&
> +        !tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
> +                      TPM_PPI_ADDR_BASE, OBJECT(s), errp)) {
> +        return;
> +    }
>  }
>
>  static void tpm_tis_initfn(Object *obj)
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 1dc9f8bf2c..700c878622 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,4 +1,5 @@
>  common-obj-y +=3D tpm_util.o
> +obj-y +=3D tpm_ppi.o
>  common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>  common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>  common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
> --
> 2.19.0.rc1
>
>


--=20
Marc-Andr=C3=A9 Lureau
