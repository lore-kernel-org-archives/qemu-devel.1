Received: from eggs.gnu.org ([2001:4830:134:3::10]:42901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXOzj-0007wM-Lv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXOzh-0001Th-0t
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:17:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXOzg-0001Fc-Ku
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:17:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so1588857wrw.5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:17:18 -0800 (PST)
References: <20181212222648.595-1-marcandre.lureau@redhat.com>
	<20181212222648.595-7-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f0dd066d-40b5-aee0-d623-b5490713b1e1@redhat.com>
Date: Thu, 13 Dec 2018 12:17:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181212222648.595-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v13 6/6] tpm: clear RAM when "memory
 overwrite" requested
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
> Note: the "Platform Reset Attack Mitigation" specification isn't
> explicit about NVDIMM, since they could have different usages. It uses
> the term "system memory" generally (and also "volatile memory RAM" in
> its introduction). For initial support, I propose to consider
> non-volatile memory as not being subject to the memory clear. There is
> an on-going discussion in the TCG "pcclientwg" working group for
> future revisions.
> 
> CPU cache clearing is done unconditionally in edk2 since commit
> d20ae95a13e851 (edk2-stable201811).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/tpm/tpm_ppi.h    | 10 ++++++++++
>  hw/tpm/tpm_crb.c    |  1 +
>  hw/tpm/tpm_ppi.c    | 22 ++++++++++++++++++++++
>  hw/tpm/tpm_tis.c    |  1 +
>  hw/tpm/trace-events |  3 +++
>  5 files changed, 37 insertions(+)
> 
> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> index 1598e28262..0b4a5adcf8 100644
> --- a/hw/tpm/tpm_ppi.h
> +++ b/hw/tpm/tpm_ppi.h
> @@ -34,4 +34,14 @@ typedef struct TPMPPI {
>  void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>                    hwaddr addr, Object *obj);
>  
> +/**
> + * tpm_ppi_reset:
> + * @tpmppi: a TPMPPI
> + *
> + * Function to call on machine reset. It will check if the "Memory
> + * overwrite" variable is set, and perform a memory clear on volatile
> + * memory if requested.
> + **/
> +void tpm_ppi_reset(TPMPPI *tpmppi);
> +
>  #endif /* TPM_TPM_PPI_H */
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 012ec686d4..663469bd20 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
>  {
>      CRBState *s = CRB(dev);
>  
> +    tpm_ppi_reset(&s->ppi);
>      tpm_backend_reset(s->tpmbe);
>  
>      memset(s->regs, 0, sizeof(s->regs));
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> index cf17779c20..914762c014 100644
> --- a/hw/tpm/tpm_ppi.c
> +++ b/hw/tpm/tpm_ppi.c
> @@ -16,8 +16,30 @@
>  #include "qapi/error.h"
>  #include "cpu.h"
>  #include "sysemu/memory_mapping.h"
> +#include "sysemu/reset.h"
>  #include "migration/vmstate.h"
>  #include "tpm_ppi.h"
> +#include "trace.h"
> +
> +void tpm_ppi_reset(TPMPPI *tpmppi)
> +{
> +    if (tpmppi->buf[TPM_PPI_MOVV_OFFSET] & 0x1) {
> +        GuestPhysBlockList guest_phys_blocks;
> +        GuestPhysBlock *block;
> +
> +        guest_phys_blocks_init(&guest_phys_blocks);
> +        guest_phys_blocks_append(&guest_phys_blocks);
> +        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
> +            trace_tpm_ppi_memset(block->host_addr,
> +                             block->target_end - block->target_start);

Add 3 spaces to align :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +            memset(block->host_addr, 0,
> +                   block->target_end - block->target_start);
> +            memory_region_set_dirty(block->mr, 0,
> +                                    block->target_end - block->target_start);
> +        }
> +        guest_phys_blocks_free(&guest_phys_blocks);
> +    }
> +}
>  
>  void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
>                    hwaddr addr, Object *obj)
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index da8af8e0e0..225c675302 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -868,6 +868,7 @@ static void tpm_tis_reset(DeviceState *dev)
>      s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
>                              TPM_TIS_BUFFER_MAX);
>  
> +    tpm_ppi_reset(&s->ppi);
>      tpm_backend_reset(s->be_driver);
>  
>      s->active_locty = TPM_TIS_NO_LOCALITY;
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index 25bee0cecf..920d32ad55 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "Initiating abort"
>  tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
>  tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to send to TPM: 0x%08x (size=%d)"
>  tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offset = %u"
> +
> +# hw/tpm/tpm_ppi.c
> +tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
> 
