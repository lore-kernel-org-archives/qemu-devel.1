Received: from eggs.gnu.org ([2001:4830:134:3::10]:51219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e9DPg-0002qy-75
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e9DPd-0001Ns-6v
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:59:48 -0400
Date: Mon, 30 Oct 2017 17:59:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171030175937.23ef49a8.cohuck@redhat.com>
In-Reply-To: <b0bd0d34-548d-b461-7397-9ab92fb4e6fc@de.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<feea3ded-fecc-50ff-fe70-09e63966933b@de.ibm.com>
	<20171030134233.6aaa81a1.cohuck@redhat.com>
	<54504556-d508-e86f-388b-b07fa7576978@de.ibm.com>
	<90f3e3b9-be67-cda8-4ff8-20dac42090c7@linux.vnet.ibm.com>
	<b0bd0d34-548d-b461-7397-9ab92fb4e6fc@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5][RFC] Refactoring of AIS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On Mon, 30 Oct 2017 14:48:23 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:


> FWIW, I am testing a guest patch that enables zPCI without AIS. Its as simple as
> 
> 
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 7b30af5..9b24836 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -953,7 +953,7 @@ static int __init pci_base_init(void)
>         if (!s390_pci_probe)
>                 return 0;
>  
> -       if (!test_facility(69) || !test_facility(71) || !test_facility(72))
> +       if (!test_facility(69) || !test_facility(71))
>                 return 0;
>  
>         rc = zpci_debug_init();
> diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
> index ea34086..61f8c82 100644
> --- a/arch/s390/pci/pci_insn.c
> +++ b/arch/s390/pci/pci_insn.c
> @@ -7,6 +7,7 @@
>  #include <linux/export.h>
>  #include <linux/errno.h>
>  #include <linux/delay.h>
> +#include <asm/facility.h>
>  #include <asm/pci_insn.h>
>  #include <asm/pci_debug.h>
>  #include <asm/processor.h>
> @@ -93,6 +94,8 @@ int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
>  /* Set Interruption Controls */
>  void zpci_set_irq_ctrl(u16 ctl, char *unused, u8 isc)
>  {
> +       if (!test_facility(72))
> +               return;
>         asm volatile (
>                 "       .insn   rsy,0xeb00000000d1,%[ctl],%[isc],%[u]\n"
>                 : : [ctl] "d" (ctl), [isc] "d" (isc << 27), [u] "Q" (*unused));
> 

Sounds good. Presumably this makes the adapter interrupt handling work
as for virtio (and qdio)? Is there any ais-less pci hardware out in the
wild?
