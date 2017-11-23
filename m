Received: from eggs.gnu.org ([2001:4830:134:3::10]:48711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHnw7-00009X-Je
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHnw2-0000Sn-Id
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:36:47 -0500
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-7-git-send-email-pmorel@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d1083416-5453-980d-6756-d000623d937c@redhat.com>
Date: Thu, 23 Nov 2017 10:36:37 +0100
MIME-Version: 1.0
In-Reply-To: <1511388334-16347-7-git-send-email-pmorel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/pci: move the memory region
 write from pcistg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de, qemu-s390x@nongnu.org

On 22.11.2017 23:05, Pierre Morel wrote:
> Let's move the memory region write from pcistg into a dedicated
> function.
> This allows us to prepare a later patch searching for subregions
> inside of the memory region.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 69ff7b8..8d35f8f 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -454,12 +454,27 @@ static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
>      }
>  }
>  
> +static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
> +                                  uint64_t offset, uint64_t data, uint8_t len)
> +{
> +    MemoryRegion *mr;
> +
> +    if (trap_msix(pbdev, offset, pcias)) {
> +        offset = offset - pbdev->msix.table_offset;
> +        mr = &pbdev->pdev->msix_table_mmio;
> +    } else {
> +        mr = pbdev->pdev->io_regions[pcias].memory;
> +    }
> +
> +    return memory_region_dispatch_write(mr, offset, data, len,
> +                                        MEMTXATTRS_UNSPECIFIED);
> +}
> +
>  int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>  {
>      CPUS390XState *env = &cpu->env;
>      uint64_t offset, data;
>      S390PCIBusDevice *pbdev;
> -    MemoryRegion *mr;
>      MemTxResult result;
>      uint8_t len;
>      uint32_t fh;
> @@ -516,15 +531,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>              return 0;
>          }
>  
> -        if (trap_msix(pbdev, offset, pcias)) {
> -            offset = offset - pbdev->msix.table_offset;
> -            mr = &pbdev->pdev->msix_table_mmio;
> -        } else {
> -            mr = pbdev->pdev->io_regions[pcias].memory;
> -        }
> -
> -        result = memory_region_dispatch_write(mr, offset, data, len,
> -                                     MEMTXATTRS_UNSPECIFIED);
> +        result = zpci_write_bar(pbdev, pcias, offset, data, len);
>          if (result != MEMTX_OK) {
>              program_interrupt(env, PGM_OPERAND, 4);
>              return 0;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
