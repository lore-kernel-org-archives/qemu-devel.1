Received: from eggs.gnu.org ([2001:4830:134:3::10]:45351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHnrx-0007KP-U6
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHnrs-0004HH-Uy
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:32:29 -0500
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-6-git-send-email-pmorel@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8a6d96f7-ca15-c8b9-0c0d-e78b84b27e21@redhat.com>
Date: Thu, 23 Nov 2017 10:32:20 +0100
MIME-Version: 1.0
In-Reply-To: <1511388334-16347-6-git-send-email-pmorel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x/pci: move the memory region
 read from pcilg
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
> Let's move the memory region read from pcilg into a dedicated function.
> This allows us to prepare a later patch.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index fe6e042..69ff7b8 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -345,13 +345,22 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
>      return 0;
>  }
>  
> +static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcias,
> +                                 uint64_t offset, uint64_t *data, uint8_t len)
> +{
> +    MemoryRegion *mr;
> +
> +    mr = pbdev->pdev->io_regions[pcias].memory;
> +    return memory_region_dispatch_read(mr, offset, data, len,
> +                                       MEMTXATTRS_UNSPECIFIED);
> +}
> +
>  int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>  {
>      CPUS390XState *env = &cpu->env;
>      S390PCIBusDevice *pbdev;
>      uint64_t offset;
>      uint64_t data;
> -    MemoryRegion *mr;
>      MemTxResult result;
>      uint8_t len;
>      uint32_t fh;
> @@ -402,9 +411,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>              program_interrupt(env, PGM_OPERAND, 4);
>              return 0;
>          }
> -        mr = pbdev->pdev->io_regions[pcias].memory;
> -        result = memory_region_dispatch_read(mr, offset, &data, len,
> -                                             MEMTXATTRS_UNSPECIFIED);
> +        result = zpci_read_bar(pbdev, pcias, offset, &data, len);
>          if (result != MEMTX_OK) {
>              program_interrupt(env, PGM_OPERAND, 4);
>              return 0;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
