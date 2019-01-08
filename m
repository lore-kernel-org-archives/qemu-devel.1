Received: from eggs.gnu.org ([209.51.188.92]:56186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggxwg-0007XR-BI
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 15:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ggxwf-00048l-B4
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 15:25:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ggxwf-00048M-56
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 15:25:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so5797709wml.3
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 12:25:53 -0800 (PST)
References: <20190108084039.9254-1-marcandre.lureau@redhat.com>
	<20190108084039.9254-7-marcandre.lureau@redhat.com>
	<8a2f71b4-fe55-2bf7-20db-85b17335b0de@linux.ibm.com>
	<CAMxuvaxqRAywowErCU0oEmgg1nT+rVfE56uf3XtAY5LeM6re8A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1d52289b-0ac1-4254-28b5-e0e05b01d384@redhat.com>
Date: Tue, 8 Jan 2019 21:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAMxuvaxqRAywowErCU0oEmgg1nT+rVfE56uf3XtAY5LeM6re8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v14 6/6] tpm: clear RAM when "memory
 overwrite" requested
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Mathieu-Daud=c3=a9=2c_Philippe?= <f4bug@amsat.org>, qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 1/8/19 9:17 PM, Marc-André Lureau wrote:
> On Tue, Jan 8, 2019 at 11:25 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>> On 1/8/19 3:40 AM, Marc-André Lureau wrote:
>>> Note: the "Platform Reset Attack Mitigation" specification isn't
>>> explicit about NVDIMM, since they could have different usages. It uses
>>> the term "system memory" generally (and also "volatile memory RAM" in
>>> its introduction). For initial support, I propose to consider
>>> non-volatile memory as not being subject to the memory clear. There is
>>> an on-going discussion in the TCG "pcclientwg" working group for
>>> future revisions.
>>>
>>> CPU cache clearing is done unconditionally in edk2 since commit
>>> d20ae95a13e851 (edk2-stable201811).
>>
>>
>> I just tried to test the series(from level of virt-manager).
>> Unfortunately this patch here seems to break QEMU...

Thanks Stefan for testing this patch.

>>
>>
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   hw/tpm/tpm_ppi.h    | 10 ++++++++++
>>>   hw/tpm/tpm_crb.c    |  1 +
>>>   hw/tpm/tpm_ppi.c    | 22 ++++++++++++++++++++++
>>>   hw/tpm/tpm_tis.c    |  1 +
>>>   hw/tpm/trace-events |  3 +++
>>>   5 files changed, 37 insertions(+)
>>>
>>> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
>>> index c5e555fe2c..d33ef27de6 100644
>>> --- a/hw/tpm/tpm_ppi.h
>>> +++ b/hw/tpm/tpm_ppi.h
>>> @@ -33,4 +33,14 @@ typedef struct TPMPPI {
>>>   void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>>>                     hwaddr addr, Object *obj);
>>>
>>> +/**
>>> + * tpm_ppi_reset:
>>> + * @tpmppi: a TPMPPI
>>> + *
>>> + * Function to call on machine reset. It will check if the "Memory
>>> + * overwrite" variable is set, and perform a memory clear on volatile
>>> + * memory if requested.
>>> + **/
>>> +void tpm_ppi_reset(TPMPPI *tpmppi);
>>> +
>>>   #endif /* TPM_TPM_PPI_H */
>>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>>> index 012ec686d4..663469bd20 100644
>>> --- a/hw/tpm/tpm_crb.c
>>> +++ b/hw/tpm/tpm_crb.c
>>> @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
>>>   {
>>>       CRBState *s = CRB(dev);
>>>
>>> +    tpm_ppi_reset(&s->ppi);
>>>       tpm_backend_reset(s->tpmbe);
>>>
>>>       memset(s->regs, 0, sizeof(s->regs));
>>> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
>>> index cf17779c20..cd8205f212 100644
>>> --- a/hw/tpm/tpm_ppi.c
>>> +++ b/hw/tpm/tpm_ppi.c
>>> @@ -16,8 +16,30 @@
>>>   #include "qapi/error.h"
>>>   #include "cpu.h"
>>>   #include "sysemu/memory_mapping.h"
>>> +#include "sysemu/reset.h"
>>>   #include "migration/vmstate.h"
>>>   #include "tpm_ppi.h"
>>> +#include "trace.h"
>>> +
>>> +void tpm_ppi_reset(TPMPPI *tpmppi)
>>> +{
>>> +    if (tpmppi->buf[0x15a /* movv, docs/specs/tpm.txt */] & 0x1) {
>>
>> this has to be:
>>
>> if (tpmppi->buf && tpmppi->buf[0x15a ...])
> 
> Oh I see, if ppi is disabled (that is with older machines).. Sorry for
> not noticing! This is imho a better fix:
> 
> 
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 663469bd20..3087acc4ab 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -233,7 +233,9 @@ static void tpm_crb_reset(void *dev)
>  {
>      CRBState *s = CRB(dev);
> 
> -    tpm_ppi_reset(&s->ppi);
> +    if (s->ppi_enabled) {
> +        tpm_ppi_reset(&s->ppi);
> +    }
>      tpm_backend_reset(s->tpmbe);
> 
>      memset(s->regs, 0, sizeof(s->regs));
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 6a5511e042..fd6bb9b59a 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -872,7 +872,9 @@ static void tpm_tis_reset(DeviceState *dev)
>      s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
>                              TPM_TIS_BUFFER_MAX);
> 
> -    tpm_ppi_reset(&s->ppi);
> +    if (s->ppi_enabled) {
> +        tpm_ppi_reset(&s->ppi);
> +    }
>      tpm_backend_reset(s->be_driver);
> 
>      s->active_locty = TPM_TIS_NO_LOCALITY;
> 
> 
> Philippe, do I retain your reviewed-by with this change?

Yes, with your change.

Thanks!

Phil.

>>
>>
>>> +        GuestPhysBlockList guest_phys_blocks;
>>> +        GuestPhysBlock *block;
>>> +
>>> +        guest_phys_blocks_init(&guest_phys_blocks);
>>> +        guest_phys_blocks_append(&guest_phys_blocks);
>>> +        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
>>> +            trace_tpm_ppi_memset(block->host_addr,
>>> +                                 block->target_end - block->target_start);
>>> +            memset(block->host_addr, 0,
>>> +                   block->target_end - block->target_start);
>>> +            memory_region_set_dirty(block->mr, 0,
>>> +                                    block->target_end - block->target_start);
>>> +        }
>>> +        guest_phys_blocks_free(&guest_phys_blocks);
>>> +    }
>>> +}
>>>
>>>   void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>>>                     hwaddr addr, Object *obj)
>>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>>> index 02d9d5c911..6a5511e042 100644
>>> --- a/hw/tpm/tpm_tis.c
>>> +++ b/hw/tpm/tpm_tis.c
>>> @@ -872,6 +872,7 @@ static void tpm_tis_reset(DeviceState *dev)
>>>       s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
>>>                               TPM_TIS_BUFFER_MAX);
>>>
>>> +    tpm_ppi_reset(&s->ppi);
>>>       tpm_backend_reset(s->be_driver);
>>>
>>>       s->active_locty = TPM_TIS_NO_LOCALITY;
>>> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
>>> index 25bee0cecf..920d32ad55 100644
>>> --- a/hw/tpm/trace-events
>>> +++ b/hw/tpm/trace-events
>>> @@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "Initiating abort"
>>>   tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
>>>   tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to send to TPM: 0x%08x (size=%d)"
>>>   tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offset = %u"
>>> +
>>> +# hw/tpm/tpm_ppi.c
>>> +tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
>>
>>
> 
