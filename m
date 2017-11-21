Received: from eggs.gnu.org ([2001:4830:134:3::10]:35183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH60w-00015x-Nz
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH60t-0001SZ-JE
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:42:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eH60t-0001SO-CF
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:42:47 -0500
Date: Tue, 21 Nov 2017 11:42:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121114243.7ac15767.cohuck@redhat.com>
In-Reply-To: <1510854715-7081-5-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-5-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] s390x/pci: rework PCI STORE BLOCK
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

On Thu, 16 Nov 2017 18:51:52 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Enhance the fault detection.
> 
> Fixup the precedence to check the destination path existance
> before checking for the source accessibility.
> 
> Add the maxstbl entry to both the Query PCI Function Group
> response and the PCIBusDevice structure.
> 
> Initialize the maxstbl to 128 per default until we get
> the actual data from the hardware.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.h  |  1 +
>  hw/s390x/s390-pci-inst.c | 62 +++++++++++++++++++++++++++++-------------------
>  hw/s390x/s390-pci-inst.h |  2 +-
>  3 files changed, 40 insertions(+), 25 deletions(-)

> @@ -700,8 +685,33 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
>          break;
>      }
>  
> +    if (pcias > 5) {
> +        DPRINTF("pcistb invalid space\n");
> +        setcc(cpu, ZPCI_PCI_LS_ERR);
> +        s390_set_status_code(env, r1, ZPCI_PCI_ST_INVAL_AS);
> +        return 0;
> +    }
> +
> +    /* Verify the address, offset and length */
> +    /* offset must be a multiple of 8 */
> +    if (offset % 8) {
> +        goto addressing_error;
> +    }
> +    /* Length must be greater than 8, a multiple of 8, not greater maxstbl */

"not greater than maxstlb"

> +    if ((len <= 8) || (len % 8) || (len > pbdev->maxstbl)) {
> +        goto addressing_error;
> +    }
> +    /* Do not cross a 4K-byte boundary */
> +    if (((offset & 0xfff) + len) > 0x1000) {
> +        goto addressing_error;
> +    }
> +    /* Guest address must be double word aligned */
> +    if (gaddr & 0x07UL) {
> +        goto addressing_error;
> +    }
> +
>      mr = pbdev->pdev->io_regions[pcias].memory;
> -    if (!memory_region_access_valid(mr, env->regs[r3], len, true)) {
> +    if (!memory_region_access_valid(mr, offset, len, true)) {
>          program_interrupt(env, PGM_OPERAND, 6);
>          return 0;
>      }

Looks good.
