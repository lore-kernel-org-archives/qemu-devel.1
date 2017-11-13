Received: from eggs.gnu.org ([2001:4830:134:3::10]:41992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEGaJ-0005ik-F3
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:23:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEGaE-0001RA-Eu
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:23:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eEGaE-0001Qr-7Z
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:23:34 -0500
Date: Mon, 13 Nov 2017 16:23:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171113162328.3b94def6.cohuck@redhat.com>
In-Reply-To: <1510075479-17224-5-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-5-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] s390x/pci: rework PCI STORE BLOCK
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

On Tue,  7 Nov 2017 18:24:36 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Enhance the fault detection.
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
> 

> @@ -662,22 +664,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
>      fh = env->regs[r1] >> 32;
>      pcias = (env->regs[r1] >> 16) & 0xf;
>      len = env->regs[r1] & 0xff;
> +    offset = env->regs[r3];
>  
> -    if (pcias > 5) {
> -        DPRINTF("pcistb invalid space\n");
> -        setcc(cpu, ZPCI_PCI_LS_ERR);
> -        s390_set_status_code(env, r1, ZPCI_PCI_ST_INVAL_AS);
> -        return 0;
> -    }
> -
> -    switch (len) {
> -    case 16:
> -    case 32:
> -    case 64:
> -    case 128:
> -        break;
> -    default:
> -        program_interrupt(env, PGM_SPECIFICATION, 6);
> +    if (!(fh & FH_MASK_ENABLE)) {
> +        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);

So this means you move checking for the device before checking for the
parameters or the as.

>          return 0;
>      }
>  
> @@ -689,12 +679,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
>      }
>  
>      switch (pbdev->state) {
> -    case ZPCI_FS_RESERVED:
> -    case ZPCI_FS_STANDBY:
> -    case ZPCI_FS_DISABLED:
>      case ZPCI_FS_PERMANENT_ERROR:
> -        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
> -        return 0;
>      case ZPCI_FS_ERROR:
>          setcc(cpu, ZPCI_PCI_LS_ERR);
>          s390_set_status_code(env, r1, ZPCI_PCI_ST_BLOCKED);
> @@ -703,8 +688,33 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
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
> +    /* Length must be greater than 8, a multiple of 8, lower than maxstbl */
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

So the checks here are only evaluated if the instruction actually pokes
at a valid region?

> +
>      mr = pbdev->pdev->io_regions[pcias].memory;
> -    if (!memory_region_access_valid(mr, env->regs[r3], len, true)) {
> +    if (!memory_region_access_valid(mr, offset, len, true)) {
>          program_interrupt(env, PGM_OPERAND, 6);
>          return 0;
>      }
> @@ -714,9 +724,9 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
>      }
>  
>      for (i = 0; i < len / 8; i++) {
> -        result = memory_region_dispatch_write(mr, env->regs[r3] + i * 8,
> -                                     ldq_p(buffer + i * 8), 8,
> -                                     MEMTXATTRS_UNSPECIFIED);
> +        result = memory_region_dispatch_write(mr, offset + i * 8,
> +                                              ldq_p(buffer + i * 8), 8,
> +                                              MEMTXATTRS_UNSPECIFIED);
>          if (result != MEMTX_OK) {
>              program_interrupt(env, PGM_OPERAND, 6);
>              return 0;
> @@ -725,6 +735,10 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
>  
>      setcc(cpu, ZPCI_PCI_LS_OK);
>      return 0;
> +
> +addressing_error:
> +    program_interrupt(env, PGM_SPECIFICATION, 6);
> +    return 0;
>  }

This seems more readable; I can't verify whether it is actually correct
without access to the architecture, though :(
