Received: from eggs.gnu.org ([2001:4830:134:3::10]:34257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH5y7-0007K1-UP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eH5y4-0000DE-NJ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:39:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eH5y4-0000D0-EP
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 05:39:52 -0500
Date: Tue, 21 Nov 2017 11:39:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171121113947.3b439818.cohuck@redhat.com>
In-Reply-To: <1510854715-7081-4-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1510854715-7081-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510854715-7081-4-git-send-email-pmorel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] s390x/pci: rework PCI LOAD
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

On Thu, 16 Nov 2017 18:51:51 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> Enhance the fault detection, correction of the fault reporting.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>

Same as last patch...

> ---
>  hw/s390x/s390-pci-inst.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index df0c8f0..cbc6421 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -373,6 +373,11 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>      len = env->regs[r2] & 0xf;
>      offset = env->regs[r2 + 1];
>  
> +    if (!(fh & FH_MASK_ENABLE)) {
> +        setcc(cpu, ZPCI_PCI_LS_INVAL_HANDLE);
> +        return 0;
> +    }
> +
>      pbdev = s390_pci_find_dev_by_fh(s390_get_phb(), fh);
>      if (!pbdev) {
>          DPRINTF("pcilg no pci dev\n");
> @@ -381,12 +386,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
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
>          s390_set_status_code(env, r2, ZPCI_PCI_ST_BLOCKED);
> @@ -395,8 +395,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>          break;
>      }
>  
> -    if (pcias < 6) {
> -        if ((8 - (offset & 0x7)) < len) {
> +    switch (pcias) {
> +    case 0 ... 5:

...and here...

> +        if (!len || (len > (8 - (offset & 0x7)))) {
>              program_interrupt(env, PGM_OPERAND, 4);
>              return 0;
>          }
> @@ -407,8 +408,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>              program_interrupt(env, PGM_OPERAND, 4);
>              return 0;
>          }
> -    } else if (pcias == 15) {
> -        if ((4 - (offset & 0x3)) < len) {
> +        break;
> +    case 15:
> +        if (!len || (len > (4 - (offset & 0x3))) || len == 3) {
>              program_interrupt(env, PGM_OPERAND, 4);
>              return 0;
>          }
> @@ -419,8 +421,9 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
>              program_interrupt(env, PGM_OPERAND, 4);
>              return 0;
>          }
> -    } else {
> -        DPRINTF("invalid space\n");
> +        break;
> +    default:
> +        DPRINTF("pcilg invalid space\n");
>          setcc(cpu, ZPCI_PCI_LS_ERR);
>          s390_set_status_code(env, r2, ZPCI_PCI_ST_INVAL_AS);
>          return 0;

...and again here :) (good other than the nits)
