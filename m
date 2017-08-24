Received: from eggs.gnu.org ([2001:4830:134:3::10]:33445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkgib-0005me-JU
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dkgiX-0004Rm-Ju
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:13:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dkgiX-0004RI-Af
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 21:13:53 -0400
References: <20170823155458.19601-1-cohuck@redhat.com>
	<20170823155458.19601-3-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3e2bce11-90f5-c1e3-6286-bad3478976da@redhat.com>
Date: Thu, 24 Aug 2017 03:13:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170823155458.19601-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/9] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On 23.08.2017 17:54, Cornelia Huck wrote:
> The msi routing code in kvm calls some pci functions: provide
> some stubs to enable builds without pci.
> 
> Also, to make this more obvious, guard them via a pci_available boolean
> (which also can be reused in other places).
> 
> Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
> Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions")
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  accel/kvm/kvm-all.c  |  6 +++---
>  hw/pci/pci-stub.c    | 16 +++++++++++++++-
>  hw/pci/pci.c         |  2 ++
>  include/hw/pci/pci.h |  2 ++
>  4 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 46ce479dc3..f85553a851 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1248,7 +1248,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>      int virq;
>      MSIMessage msg = {0, 0};
>  
> -    if (dev) {
> +    if (pci_available && dev) {
>          msg = pci_get_msi_message(dev, vector);
>      }
>  
> @@ -1271,7 +1271,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
>      kroute.u.msi.address_lo = (uint32_t)msg.address;
>      kroute.u.msi.address_hi = msg.address >> 32;
>      kroute.u.msi.data = le32_to_cpu(msg.data);
> -    if (kvm_msi_devid_required()) {
> +    if (pci_available && kvm_msi_devid_required()) {
>          kroute.flags = KVM_MSI_VALID_DEVID;
>          kroute.u.msi.devid = pci_requester_id(dev);
>      }
> @@ -1309,7 +1309,7 @@ int kvm_irqchip_update_msi_route(KVMState *s, int virq, MSIMessage msg,
>      kroute.u.msi.address_lo = (uint32_t)msg.address;
>      kroute.u.msi.address_hi = msg.address >> 32;
>      kroute.u.msi.data = le32_to_cpu(msg.data);
> -    if (kvm_msi_devid_required()) {
> +    if (pci_available && kvm_msi_devid_required()) {
>          kroute.flags = KVM_MSI_VALID_DEVID;
>          kroute.u.msi.devid = pci_requester_id(dev);
>      }
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index ecad664946..2d3b32c6ab 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -23,10 +23,11 @@
>  #include "monitor/monitor.h"
>  #include "qapi/qmp/qerror.h"
>  #include "hw/pci/pci.h"
> -#include "qmp-commands.h"
>  #include "hw/pci/msi.h"
> +#include "qmp-commands.h"

Nit: Unnecessary movement of the #include statement.

If you fix that:

Reviewed-by: Thomas Huth <thuth@redhat.com>
