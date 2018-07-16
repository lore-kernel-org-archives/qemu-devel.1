Received: from eggs.gnu.org ([2001:4830:134:3::10]:49751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ff4vY-000657-Rz
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ff4vX-0007bW-JW
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:56:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ff4vX-0007b4-0F
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:56:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id t6-v6so32225943wrn.7
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 07:56:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180716164422.79b977f9@redhat.com>
References: <20180716125948.11666-1-marcandre.lureau@redhat.com>
	<20180716125948.11666-3-marcandre.lureau@redhat.com>
	<20180716164422.79b977f9@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 16 Jul 2018 16:56:36 +0200
Message-ID: <CAJ+F1C+6dgSOJJ7xk3CY-YTF6sCxoT8awcKD7ebLTqjsM4a+wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 2/5] tpm: implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Mon, Jul 16, 2018 at 4:44 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Mon, 16 Jul 2018 14:59:45 +0200
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>
>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>
>> Implement a virtual memory device for the TPM Physical Presence interfac=
e.
>> The memory is located at 0xFED45000 and used by ACPI to send messages to=
 the
>> firmware (BIOS) and by the firmware to provide parameters for each one o=
f
>> the supported codes.
> it doesn't implement anything, maybe something like this would be better?
>
> tpm: allocate/map buffer for TPM Physical Presence interface
>
> ...
>
>>
>> This device should be used by all TPM interfaces on x86 and can be added
>> by calling tpm_ppi_init_io().
> Did you mean:
>  This *interface* should be used by all TPM *devices* on x86 and can be a=
dded
>  by calling tpm_ppi_init_io().
>
>
>> Note: bios_linker cannot be used to allocate the PPI memory region,
>> since the reserved memory should stay stable across reboots, and might
>> be needed before the ACPI tables are installed.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  hw/tpm/tpm_ppi.h      | 26 ++++++++++++++++++++++++++
>>  include/hw/acpi/tpm.h |  6 ++++++
>>  hw/tpm/tpm_crb.c      |  8 ++++++++
>>  hw/tpm/tpm_ppi.c      | 31 +++++++++++++++++++++++++++++++
>>  hw/tpm/tpm_tis.c      |  8 ++++++++
>>  hw/tpm/Makefile.objs  |  1 +
>>  6 files changed, 80 insertions(+)
>>  create mode 100644 hw/tpm/tpm_ppi.h
>>  create mode 100644 hw/tpm/tpm_ppi.c
>>
>> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
>> new file mode 100644
>> index 0000000000..f6458bf87e
>> --- /dev/null
>> +++ b/hw/tpm/tpm_ppi.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * TPM Physical Presence Interface
>> + *
>> + * Copyright (C) 2018 IBM Corporation
>> + *
>> + * Authors:
>> + *  Stefan Berger    <stefanb@us.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +#ifndef TPM_TPM_PPI_H
>> +#define TPM_TPM_PPI_H
>> +
>> +#include "hw/acpi/tpm.h"
>> +#include "exec/address-spaces.h"
>> +
>> +typedef struct TPMPPI {
>> +    MemoryRegion ram;
>> +    uint8_t buf[TPM_PPI_ADDR_SIZE];
>> +} TPMPPI;
>> +
>> +bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>> +                  hwaddr addr, Object *obj, Error **errp);
>> +
>> +#endif /* TPM_TPM_PPI_H */
>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>> index 3580ffd50c..b8796df916 100644
>> --- a/include/hw/acpi/tpm.h
>> +++ b/include/hw/acpi/tpm.h
>> @@ -188,4 +188,10 @@ REG32(CRB_DATA_BUFFER, 0x80)
>>  #define TPM2_START_METHOD_MMIO      6
>>  #define TPM2_START_METHOD_CRB       7
>>
>> +/*
>> + * Physical Presence Interface
>> + */
>> +#define TPM_PPI_ADDR_SIZE           0x400
>> +#define TPM_PPI_ADDR_BASE           0xFED45000
>> +
>>  #endif /* HW_ACPI_TPM_H */
>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>> index d5b0ac5920..b243222fd6 100644
>> --- a/hw/tpm/tpm_crb.c
>> +++ b/hw/tpm/tpm_crb.c
>> @@ -29,6 +29,7 @@
>>  #include "sysemu/reset.h"
>>  #include "tpm_int.h"
>>  #include "tpm_util.h"
>> +#include "tpm_ppi.h"
>>  #include "trace.h"
>>
>>  typedef struct CRBState {
>> @@ -43,6 +44,7 @@ typedef struct CRBState {
>>      size_t be_buffer_size;
>>
>>      bool ppi_enabled;
>> +    TPMPPI ppi;
>>  } CRBState;
>>
>>  #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
>> @@ -294,6 +296,12 @@ static void tpm_crb_realize(DeviceState *dev, Error=
 **errp)
>>      memory_region_add_subregion(get_system_memory(),
>>          TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
>>
>> +    if (s->ppi_enabled &&
>> +        !tpm_ppi_init(&s->ppi, get_system_memory(),
>> +                      TPM_PPI_ADDR_BASE, OBJECT(s), errp)) {
>> +        return;
>> +    }
>> +
>>      qemu_register_reset(tpm_crb_reset, dev);
>>  }
>>
>> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
>> new file mode 100644
>> index 0000000000..8b46b9dd4b
>> --- /dev/null
>> +++ b/hw/tpm/tpm_ppi.c
>> @@ -0,0 +1,31 @@
>> +/*
>> + * tpm_ppi.c - TPM Physical Presence Interface
>> + *
>> + * Copyright (C) 2018 IBM Corporation
>> + *
>> + * Authors:
>> + *  Stefan Berger <stefanb@us.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or l=
ater.
>> + * See the COPYING file in the top-level directory.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "cpu.h"
>> +#include "sysemu/memory_mapping.h"
>> +#include "migration/vmstate.h"
>> +#include "tpm_ppi.h"
>> +
>> +bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>> +                  hwaddr addr, Object *obj, Error **errp)
>> +{
>> +    memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
>> +                                      TPM_PPI_ADDR_SIZE, tpmppi->buf);
> why use buf and not a plain ram memory region?

It shouldn't be treated as regular RAM. (for example when iterating
guest_phys_blocks for dump or memory clear in last patch)

>
>> +    vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
>> +
>> +    memory_region_add_subregion(m, addr, &tpmppi->ram);
>> +    return true;
>> +}
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index d9ddf9b723..70432ffe8b 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -31,6 +31,7 @@
>>  #include "sysemu/tpm_backend.h"
>>  #include "tpm_int.h"
>>  #include "tpm_util.h"
>> +#include "tpm_ppi.h"
>>  #include "trace.h"
>>
>>  #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>> @@ -83,6 +84,7 @@ typedef struct TPMState {
>>      size_t be_buffer_size;
>>
>>      bool ppi_enabled;
>> +    TPMPPI ppi;
>>  } TPMState;
>>
>>  #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
>> @@ -979,6 +981,12 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
>>
>>      memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>>                                  TPM_TIS_ADDR_BASE, &s->mmio);
>> +
>> +    if (s->ppi_enabled &&
>> +        !tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
>> +                      TPM_PPI_ADDR_BASE, OBJECT(s), errp)) {
>> +        return;
>> +    }
>>  }
>>
>>  static void tpm_tis_initfn(Object *obj)
>> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
>> index 1dc9f8bf2c..700c878622 100644
>> --- a/hw/tpm/Makefile.objs
>> +++ b/hw/tpm/Makefile.objs
>> @@ -1,4 +1,5 @@
>>  common-obj-y +=3D tpm_util.o
>> +obj-y +=3D tpm_ppi.o
>>  common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>>  common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>>  common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>
>



--=20
Marc-Andr=C3=A9 Lureau
