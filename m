Received: from eggs.gnu.org ([2001:4830:134:3::10]:41829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fYD09-0005Zn-SQ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fYD06-0001rE-J9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:09:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fYD06-0001oA-EA
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 12:08:58 -0400
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
	<20180626122343.13473-3-marcandre.lureau@redhat.com>
	<20180627134438.3016259b@redhat.com>
	<d5dd8b75-377a-4e68-59e6-49b1d3e2176e@linux.vnet.ibm.com>
	<20180627161914.024ddd2b@redhat.com>
	<2f797866-d096-f66a-d2b2-2aeb0db59e46@linux.vnet.ibm.com>
	<20180627170540.5c5c1cf0@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <03b693c2-ac54-e6b2-377f-020abf64ad1e@redhat.com>
Date: Wed, 27 Jun 2018 18:08:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180627170540.5c5c1cf0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/4] tpm: implement virtual memory
 device for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On 06/27/18 17:05, Igor Mammedov wrote:
> On Wed, 27 Jun 2018 10:36:52 -0400
> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>=20
>> On 06/27/2018 10:19 AM, Igor Mammedov wrote:
>>> On Wed, 27 Jun 2018 08:53:28 -0400
>>> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>>> =20
>>>> On 06/27/2018 07:44 AM, Igor Mammedov wrote: =20
>>>>> On Tue, 26 Jun 2018 14:23:41 +0200
>>>>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
>>>>>    =20
>>>>>> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>>>
>>>>>> Implement a virtual memory device for the TPM Physical Presence in=
terface.
>>>>>> The memory is located at 0xFED45000 and used by ACPI to send messa=
ges to the
>>>>>> firmware (BIOS) and by the firmware to provide parameters for each=
 one of
>>>>>> the supported codes.
>>>>>>
>>>>>> This device should be used by all TPM interfaces on x86 and can be=
 added
>>>>>> by calling tpm_ppi_init_io().
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>>>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com=
>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> v4 (Marc-Andr=C3=A9):
>>>>>>    - pass TPM_PPI_ADDR_BASE as argument to tpm_ppi_init_io()
>>>>>>    - only enable PPI if property is set
>>>>>>
>>>>>> v3 (Marc-Andr=C3=A9):
>>>>>>    - merge CRB support
>>>>>>    - use trace events instead of DEBUG printf
>>>>>>    - headers inclusion simplification
>>>>>>
>>>>>> v2:
>>>>>>    - moved to byte access since an infrequently used device;
>>>>>>      this simplifies code
>>>>>>    - increase size of device to 0x400
>>>>>>    - move device to 0xfffef000 since SeaBIOS has some code at 0xff=
ff0000:
>>>>>>      'On the emulators, the bios at 0xf0000 is also at 0xffff0000'
>>>>>> ---
>>>>>>    hw/tpm/tpm_ppi.h      | 27 ++++++++++++++++++++
>>>>>>    include/hw/acpi/tpm.h |  6 +++++
>>>>>>    hw/tpm/tpm_crb.c      |  7 ++++++
>>>>>>    hw/tpm/tpm_ppi.c      | 57 ++++++++++++++++++++++++++++++++++++=
+++++++
>>>>>>    hw/tpm/tpm_tis.c      |  7 ++++++
>>>>>>    hw/tpm/Makefile.objs  |  2 +-
>>>>>>    hw/tpm/trace-events   |  4 +++
>>>>>>    7 files changed, 109 insertions(+), 1 deletion(-)
>>>>>>    create mode 100644 hw/tpm/tpm_ppi.h
>>>>>>    create mode 100644 hw/tpm/tpm_ppi.c
>>>>>>
>>>>>> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
>>>>>> new file mode 100644
>>>>>> index 0000000000..ac7ad47238
>>>>>> --- /dev/null
>>>>>> +++ b/hw/tpm/tpm_ppi.h
>>>>>> @@ -0,0 +1,27 @@
>>>>>> +/*
>>>>>> + * TPM Physical Presence Interface
>>>>>> + *
>>>>>> + * Copyright (C) 2018 IBM Corporation
>>>>>> + *
>>>>>> + * Authors:
>>>>>> + *  Stefan Berger    <stefanb@us.ibm.com>
>>>>>> + *
>>>>>> + * This work is licensed under the terms of the GNU GPL, version =
2 or later.
>>>>>> + * See the COPYING file in the top-level directory.
>>>>>> + */
>>>>>> +#ifndef TPM_TPM_PPI_H
>>>>>> +#define TPM_TPM_PPI_H
>>>>>> +
>>>>>> +#include "hw/acpi/tpm.h"
>>>>>> +#include "exec/address-spaces.h"
>>>>>> +
>>>>>> +typedef struct TPMPPI {
>>>>>> +    MemoryRegion mmio;
>>>>>> +
>>>>>> +    uint8_t ram[TPM_PPI_ADDR_SIZE];
>>>>>> +} TPMPPI; =20
>>>>> I probably miss something obvious here,
>>>>> 1st:
>>>>> commit message says that memory reion is supposed to be interface
>>>>> between FW and OSPM (i.e. totally guest internal thingy).
>>>>> So question is:
>>>>>     why do we register memory region at all? =20
>>>> One reason for the device itself was being able to debug the interac=
tion
>>>> of the guest with ACPI though I had additional instrumentation for t=
hat
>>>> showing register contents.
>>>> We need it to have some memory in the region where we place it. I
>>>> suppose a memory_region_init_ram() would provide migration support
>>>> automatically but cannot be used on memory where we have
>>>> MemoryRegionOps. So we could drop most parts of the device and only =
run
>>>> memory_region_init_ram() ? =20
>>> if QEMU doesn't need to touch it ever, you could do even better. =20
>>
>> QEMU does indirectly touch it in 4/4 where we define the=20
>> OperationRegion()s and need to know where they are located in memory. =
We=20
>> could read the base address that is now TPM_PPI_ADDR_BASE from a hard=20
>> coded memory location
> that's done for you by bios_linker_loader_add_pointer() when
> ACPI tables are installed by FW.
>=20
>> and pass it into OperationRegion(), but I doubt we=20
>> would want that.
>>
>> +    aml_append(dev,
>> +               aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
>> +                                    aml_int(TPM_PPI_ADDR_BASE), 0x100=
));
>>
>>
>> +    aml_append(dev,
>> +               aml_operation_region("TPP2", AML_SYSTEM_MEMORY,
>> +                                    aml_int(TPM_PPI_ADDR_BASE + 0x100=
),
>> +                                    0x5A));
> that's possible, usually it works as dynamic memory region where region
> lives within scope of a method.
>=20
> but scratch it.
> As Andre pointed out reserved memory should stay at the same place
> across reboots and might be needed before ACPI tables are installed,
> which probably is impossible.
>=20
> CCing Laszlo just in case if I'm wrong.

Stability of reserved memory areas is only guaranteed across S3 resume.
Through a normal reboot, all DRAM is considered invalidated.

Thanks
Laszlo
