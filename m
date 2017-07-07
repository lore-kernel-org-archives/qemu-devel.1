Received: from eggs.gnu.org ([2001:4830:134:3::10]:52940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTT2u-0006pa-3R
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dTT2V-0002Rc-3l
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:11:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dTT2U-0002Qj-Q9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:11:18 -0400
References: <20170707122159.24714-1-cohuck@redhat.com>
	<20170707122159.24714-2-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9cf42975-297b-1011-ef72-67f512edebde@redhat.com>
Date: Fri, 7 Jul 2017 15:11:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170707122159.24714-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 1/7] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 07.07.2017 14:21, Cornelia Huck wrote:
> The msi routing code in kvm calls some pci functions: provide
> some stubs to enable builds without pci.
> 
> Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
> Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/pci/pci-stub.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index 36d2c430c5..ec12962d73 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -23,6 +23,7 @@
>  #include "monitor/monitor.h"
>  #include "qapi/qmp/qerror.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/msi.h"
>  #include "qmp-commands.h"
>  
>  PciInfoList *qmp_query_pci(Error **errp)
> @@ -35,3 +36,14 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
>  {
>      monitor_printf(mon, "PCI devices not supported\n");
>  }
> +
> +/* kvm-all wants this */
> +MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
> +{
> +    assert(false);
> +}
> +
> +uint16_t pci_requester_id(PCIDevice *dev)
> +{
> +    assert(false);
> +}

Do you need a dummy return statement in here in case somebody ever tries
to compile the code with NDEBUG ? Or maybe rather use abort() instead?

 Thomas
