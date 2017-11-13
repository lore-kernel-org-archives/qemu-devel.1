Received: from eggs.gnu.org ([2001:4830:134:3::10]:54640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEHCa-00085t-6H
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:03:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEHCU-0002Kz-FJ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:03:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eEHCU-0002KZ-73
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:03:06 -0500
Date: Mon, 13 Nov 2017 17:03:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171113170300.5b42c9ad.cohuck@redhat.com>
In-Reply-To: <1510075479-17224-8-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-8-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] s390x/pci: search for subregion inside
 the BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Tue,  7 Nov 2017 18:24:39 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> When dispatching memory access to PCI BAR region, we must
> look for eventual subregion, used by the PCI device to map

s/eventual subregion/possible subregions/ ?

> different memory areas inside the same PCI BAR.
> 
> Since the data offset we received is calculated starting at the
> region start address we need to adjust the offset for the subregion.
> 
> The data offset inside the subregion is calculated by substracting
> the subregion's starting address from the data offset in the region.
> 
> The function trap_msix() was used, despite not really useful since we
> removed the index from the msix message. With this patch we can
> definitively suppress this function.

Suggest rewording this (see below).

> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 44 +++++++++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 97f62b5..b59ceef 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -344,12 +344,31 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>      return 0;
>  }
>  
> +static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
> +                                        uint8_t len)
> +{
> +    MemoryRegion *other;
> +    uint64_t subregion_size;
> +
> +    QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
> +        subregion_size = int128_get64(other->size);
> +        if ((offset >= other->addr) &&
> +            (offset + len) <= (other->addr + subregion_size)) {
> +            mr = other;
> +            break;
> +        }
> +    }
> +    return mr;
> +}
> +

So, this works for the msix stuff because it is a subregion?

This means you can remove trap_msix() because it is handled in a
generic way now, doesn't it?

>  static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
>                                   uint64_t offset, uint64_t *data, uint8_t len)
>  {
>      MemoryRegion *mr;
>  
>      mr = pbdev->pdev->io_regions[pcias].memory;
> +    mr = s390_get_subregion(mr, offset, len);
> +    offset -= mr->addr;
>      return memory_region_dispatch_read(mr, offset, data, len,
>                                         MEMTXATTRS_UNSPECIFIED);
>  }
> @@ -443,30 +462,14 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>      return 0;
>  }
>  
> -static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
> -{
> -    if (pbdev->msix.available && pbdev->msix.table_bar == pcias &&
> -        offset >= pbdev->msix.table_offset &&
> -        offset < (pbdev->msix.table_offset +
> -                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
> -        return 1;
> -    } else {
> -        return 0;
> -    }
> -}
> -
>  static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
>                                    uint64_t offset, uint64_t data, uint8_t len)
>  {
>      MemoryRegion *mr;
>  
> -    if (trap_msix(pbdev, offset, pcias)) {
> -        offset = offset - pbdev->msix.table_offset;
> -        mr = &pbdev->pdev->msix_table_mmio;
> -    } else {
> -        mr = pbdev->pdev->io_regions[pcias].memory;
> -    }
> -
> +    mr = pbdev->pdev->io_regions[pcias].memory;
> +    mr = s390_get_subregion(mr, offset, len);
> +    offset -= mr->addr;
>      return memory_region_dispatch_write(mr, offset, data, len,
>                                          MEMTXATTRS_UNSPECIFIED);
>  }
> @@ -728,6 +731,9 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
>      }
>  
>      mr = pbdev->pdev->io_regions[pcias].memory;
> +    mr = s390_get_subregion(mr, offset, len);
> +    offset -= mr->addr;
> +
>      if (!memory_region_access_valid(mr, offset, len, true)) {
>          program_interrupt(env, PGM_OPERAND, 6);
>          return 0;
