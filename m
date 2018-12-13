Received: from eggs.gnu.org ([2001:4830:134:3::10]:40717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXOss-0005Es-4z
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXOsp-0001ij-32
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:10:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXOso-0001hY-Qe
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:10:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so1932259wmd.0
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:10:22 -0800 (PST)
References: <20181212222648.595-1-marcandre.lureau@redhat.com>
	<20181212222648.595-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0b0ad7c0-38c4-35be-3d98-571b319113bc@redhat.com>
Date: Thu, 13 Dec 2018 12:10:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181212222648.595-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 2/6] tpm: allocate/map buffer for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, stefanb@linux.vnet.ibm.com, f4bug@amsat.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>

On 12/12/18 11:26 PM, Marc-André Lureau wrote:
> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
> 
> Implement a virtual memory device for the TPM Physical Presence interface.
> The memory is located at 0xFED45000 and used by ACPI to send messages to the
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
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/tpm/tpm_ppi.h      | 37 +++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/tpm.h |  6 ++++++
>  hw/tpm/tpm_crb.c      |  7 +++++++
>  hw/tpm/tpm_ppi.c      | 31 +++++++++++++++++++++++++++++++
>  hw/tpm/tpm_tis.c      |  7 +++++++
>  hw/tpm/Makefile.objs  |  1 +
>  6 files changed, 89 insertions(+)
>  create mode 100644 hw/tpm/tpm_ppi.h
>  create mode 100644 hw/tpm/tpm_ppi.c
> 
> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> new file mode 100644
> index 0000000000..1598e28262
> --- /dev/null
> +++ b/hw/tpm/tpm_ppi.h
> @@ -0,0 +1,37 @@
> +/*
> + * TPM Physical Presence Interface
> + *
> + * Copyright (C) 2018 IBM Corporation
> + *
> + * Authors:
> + *  Stefan Berger    <stefanb@us.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
> +    uint8_t *buf;
> +} TPMPPI;
> +
> +/**
> + * tpm_ppi_init:
> + * @tpmppi: a TPMPPI
> + * @m: the address-space / MemoryRegion to use
> + * @addr: the address of the PPI region
> + * @obj: the owner object
> + * @errp: an Error**

You removed errp.

Without the'errp' line:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> + *
> + * Register the TPM PPI memory region at @addr on the given address
> + * space for the object @obj.
> + **/
> +void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> +                  hwaddr addr, Object *obj);
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
> index d5b0ac5920..012ec686d4 100644
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
> @@ -294,6 +296,11 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(get_system_memory(),
>          TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
>  
> +    if (s->ppi_enabled) {
> +        tpm_ppi_init(&s->ppi, get_system_memory(),
> +                     TPM_PPI_ADDR_BASE, OBJECT(s));
> +    }
> +
>      qemu_register_reset(tpm_crb_reset, dev);
>  }
>  
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> new file mode 100644
> index 0000000000..cf17779c20
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
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
> +void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> +                  hwaddr addr, Object *obj)
> +{
> +    tpmppi->buf = g_malloc0(HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
> +    memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
> +                                      TPM_PPI_ADDR_SIZE, tpmppi->buf);
> +    vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> +
> +    memory_region_add_subregion(m, addr, &tpmppi->ram);
> +}
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index cbb9a84a5b..da8af8e0e0 100644
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
> @@ -979,6 +981,11 @@ static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
>  
>      memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>                                  TPM_TIS_ADDR_BASE, &s->mmio);
> +
> +    if (s->ppi_enabled) {
> +        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
> +                     TPM_PPI_ADDR_BASE, OBJECT(s));
> +    }
>  }
>  
>  static void tpm_tis_initfn(Object *obj)
> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> index 1dc9f8bf2c..700c878622 100644
> --- a/hw/tpm/Makefile.objs
> +++ b/hw/tpm/Makefile.objs
> @@ -1,4 +1,5 @@
>  common-obj-y += tpm_util.o
> +obj-y += tpm_ppi.o
>  common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
>  common-obj-$(CONFIG_TPM_CRB) += tpm_crb.o
>  common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
> 
