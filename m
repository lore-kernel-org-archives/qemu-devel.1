Received: from eggs.gnu.org ([2001:4830:134:3::10]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX6uW-0005Na-1M
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX6uS-0004Z9-PF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:58:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gX6uS-0004Xl-AY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:58:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id y1so6262009wmi.3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:58:51 -0800 (PST)
References: <20180910083222.8245-1-marcandre.lureau@redhat.com>
	<20180910083222.8245-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d67240e3-7dd0-732f-62b4-bb6b332d8dfe@redhat.com>
Date: Wed, 12 Dec 2018 16:58:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180910083222.8245-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 3/6] tpm: allocate/map buffer for TPM
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Stefan, Marc-André,

On 9/10/18 10:32 AM, Marc-André Lureau wrote:
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
>  hw/tpm/tpm_ppi.h      | 26 ++++++++++++++++++++++++++
>  include/hw/acpi/tpm.h |  6 ++++++
>  hw/tpm/tpm_crb.c      |  8 ++++++++
>  hw/tpm/tpm_ppi.c      | 32 ++++++++++++++++++++++++++++++++
>  hw/tpm/tpm_tis.c      |  8 ++++++++
>  hw/tpm/Makefile.objs  |  1 +
>  6 files changed, 81 insertions(+)
>  create mode 100644 hw/tpm/tpm_ppi.h
>  create mode 100644 hw/tpm/tpm_ppi.c
> 
> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> new file mode 100644
> index 0000000000..c2ab2ed300
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

Can you add a description for this public function?

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
> @@ -294,6 +296,12 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
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
> index 0000000000..f2f07f895e
> --- /dev/null
> +++ b/hw/tpm/tpm_ppi.c
> @@ -0,0 +1,32 @@
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
> +bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> +                  hwaddr addr, Object *obj, Error **errp)
> +{
> +    tpmppi->buf = g_malloc0(HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
> +    memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
> +                                      TPM_PPI_ADDR_SIZE, tpmppi->buf);
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
> @@ -979,6 +981,12 @@ static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
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

Shouldn't you implement the unrealize() function, destroying the PPI buffer?

Patch looks good otherwise.

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
