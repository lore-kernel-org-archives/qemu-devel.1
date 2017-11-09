Received: from eggs.gnu.org ([2001:4830:134:3::10]:48979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCsQ1-0001mG-9q
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCsPy-00018y-40
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:23:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eCsPx-00018V-TX
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:23:14 -0500
Date: Thu, 9 Nov 2017 20:23:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171109202308.06a8bc45.cohuck@redhat.com>
In-Reply-To: <1510075479-17224-7-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-7-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] s390x/pci: move the memory region
 write from pcistg
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

On Tue,  7 Nov 2017 18:24:38 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Let's move the memory region write from pcistg into a dedicated
> function.
> This allows us to prepare a later patch searching for subregions
> inside of the memory region.

OK, so here is the memory region write. Do we have any sleeping
endianness bugs in there for when we wire up tcg? I'm not sure how this
plays with the bswaps (see patch 1). 

But maybe I've just gotten lost somewhere.

> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 50135a0..97f62b5 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -455,12 +455,27 @@ static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
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
> @@ -517,15 +532,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
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
