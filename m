Received: from eggs.gnu.org ([2001:4830:134:3::10]:44608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fy9pU-0001iC-Q5
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fy9pR-0002bF-Ih
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:01:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fy9pR-0002ZL-Cf
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:01:13 -0400
Received: by mail-io1-f68.google.com with SMTP id y12-v6so683558ioj.13
	for <qemu-devel@nongnu.org>; Thu, 06 Sep 2018 23:01:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <13e351e8-5037-ad9a-e49b-31e364cb0245@linux.vnet.ibm.com>
References: <20180906032949.13753-1-marcandre.lureau@redhat.com>
	<20180906032949.13753-7-marcandre.lureau@redhat.com>
	<13e351e8-5037-ad9a-e49b-31e364cb0245@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 7 Sep 2018 10:01:11 +0400
Message-ID: <CAMxuvazxEioKjJ5Ce2+kVpvTVczT8L3uWQJP=WSFTSgk_7NLJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 6/6] tpm: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Fri, Sep 7, 2018 at 12:09 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> On 09/05/2018 11:29 PM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> This allows to pass the last failing test from the Windows HLK TPM 2.0
>> TCG PPI 1.3 tests.
>>
>> The interface is described in the "TCG Platform Reset Attack
>> Mitigation Specification", chapter 6 "ACPI _DSM Function". According
>> to Laszlo, it's not so easy to implement in OVMF, he suggested to do
>> it in qemu instead.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   hw/tpm/tpm_ppi.h     |  2 ++
>>   hw/i386/acpi-build.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
>>   hw/tpm/tpm_crb.c     |  1 +
>>   hw/tpm/tpm_ppi.c     | 23 ++++++++++++++++++++++
>>   hw/tpm/tpm_tis.c     |  1 +
>>   docs/specs/tpm.txt   |  2 ++
>>   hw/tpm/trace-events  |  3 +++
>>   7 files changed, 78 insertions(+)
>>
>> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
>> index c2ab2ed300..b8f67962c7 100644
>> --- a/hw/tpm/tpm_ppi.h
>> +++ b/hw/tpm/tpm_ppi.h
>> @@ -23,4 +23,6 @@ typedef struct TPMPPI {
>>   bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>>                     hwaddr addr, Object *obj, Error **errp);
>>   +void tpm_ppi_reset(TPMPPI *tpmppi);
>> +
>>   #endif /* TPM_TPM_PPI_H */
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index c5e9a6e11d..2ab3e8fae7 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1824,6 +1824,13 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
>>       pprq =3D aml_name("PPRQ");
>>       pprm =3D aml_name("PPRM");
>>   +    aml_append(dev,
>> +               aml_operation_region("TPP3", AML_SYSTEM_MEMORY,
>> +                                    aml_int(TPM_PPI_ADDR_BASE + 0x15a),
>> +                                    0x1));
>> +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE)=
;
>> +    aml_append(field, aml_named_field("MOVV", 8));
>> +    aml_append(dev, field);
>>       /*
>>        * DerefOf in Windows is broken with SYSTEM_MEMORY.  Use a dynamic
>>        * operation region inside of a method for getting FUNC[op].
>> @@ -2166,7 +2173,46 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
>>               aml_append(ifctx, aml_return(aml_buffer(1, zerobyte)));
>>           }
>>           aml_append(method, ifctx);
>> +
>> +        ifctx =3D aml_if(
>> +            aml_equal(uuid,
>> +
>> aml_touuid("376054ED-CC13-4675-901C-4756D7F2D45D")));
>> +        {
>> +            /* standard DSM query function */
>> +            ifctx2 =3D aml_if(aml_equal(function, zero));
>> +            {
>> +                uint8_t byte_list[1] =3D { 0x03 };
>> +                aml_append(ifctx2, aml_return(aml_buffer(1, byte_list))=
);
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +
>> +            /*
>> +             * TCG Platform Reset Attack Mitigation Specification 1.0
>> Ch.6
>> +             *
>> +             * Arg 2 (Integer): Function Index =3D 1
>> +             * Arg 3 (Package): Arguments =3D Package: Type: Integer
>> +             *                  Operation Value of the Request
>> +             * Returns: Type: Integer
>> +             *          0: Success
>> +             *          1: General Failure
>> +             */
>> +            ifctx2 =3D aml_if(aml_equal(function, one));
>> +            {
>> +                aml_append(ifctx2,
>> +                           aml_store(aml_derefof(aml_index(arguments,
>> zero)),
>> +                                     op));
>> +                {
>> +                    aml_append(ifctx2, aml_store(op, aml_name("MOVV")))=
;
>> +
>> +                    /* 0: success */
>> +                    aml_append(ifctx2, aml_return(zero));
>> +                }
>> +            }
>> +            aml_append(ifctx, ifctx2);
>> +        }
>> +        aml_append(method, ifctx);
>>       }
>> +
>>       aml_append(dev, method);
>>   }
>>   diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>> index b243222fd6..48f6a716ad 100644
>> --- a/hw/tpm/tpm_crb.c
>> +++ b/hw/tpm/tpm_crb.c
>> @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
>>   {
>>       CRBState *s =3D CRB(dev);
>>   +    tpm_ppi_reset(&s->ppi);
>>       tpm_backend_reset(s->tpmbe);
>>         memset(s->regs, 0, sizeof(s->regs));
>> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
>> index f2f07f895e..46ca8ea3ea 100644
>> --- a/hw/tpm/tpm_ppi.c
>> +++ b/hw/tpm/tpm_ppi.c
>> @@ -16,8 +16,30 @@
>>   #include "qapi/error.h"
>>   #include "cpu.h"
>>   #include "sysemu/memory_mapping.h"
>> +#include "sysemu/reset.h"
>>   #include "migration/vmstate.h"
>>   #include "tpm_ppi.h"
>> +#include "trace.h"
>> +
>> +void tpm_ppi_reset(TPMPPI *tpmppi)
>> +{
>> +    char *ptr =3D memory_region_get_ram_ptr(&tpmppi->ram);
>> +
>> +    if (ptr[0x15a] & 0x1) {
>> +        GuestPhysBlockList guest_phys_blocks;
>> +        GuestPhysBlock *block;
>> +
>> +        guest_phys_blocks_init(&guest_phys_blocks);
>> +        guest_phys_blocks_append(&guest_phys_blocks);
>> +        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
>> +            trace_tpm_ppi_memset(block->host_addr,
>> +                             block->target_end - block->target_start);
>> +            memset(block->host_addr, 0,
>> +                   block->target_end - block->target_start);
>
>
> Does this also clear the PPI memory? If so, could we create a backup of t=
he
> few relevant bytes the firmware will look at and restore them after the
> loop? The PPI device likely contains the only data that may need to be
> preserved across a rebbot, and we are running this loop here in the ppi
> module itself, so should be able to do that.

guest_phys_blocks_append() doesn't gather device ram, so it will skip
TPM PPI buf.

thanks
