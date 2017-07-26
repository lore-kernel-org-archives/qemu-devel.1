Received: from eggs.gnu.org ([2001:4830:134:3::10]:52980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daGBk-0000WV-3F
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1daGBh-0004LL-0a
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:52:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1daGBg-0004L1-Q5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:52:52 -0400
References: <20170725153330.14966-1-cohuck@redhat.com>
	<20170725153330.14966-2-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f914a2ea-2958-406f-f68f-511027bc30be@redhat.com>
Date: Wed, 26 Jul 2017 08:52:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170725153330.14966-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/9] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 25.07.2017 17:33, Cornelia Huck wrote:
> The msi routing code in kvm calls some pci functions: provide
> some stubs to enable builds without pci.
>=20
> Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
> Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions"=
)
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/pci/pci-stub.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index ecad664946..bc228ce91e 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -23,6 +23,7 @@
>  #include "monitor/monitor.h"
>  #include "qapi/qmp/qerror.h"
>  #include "hw/pci/pci.h"
> +#include "hw/pci/msi.h"
>  #include "qmp-commands.h"
>  #include "hw/pci/msi.h"
> =20
> @@ -38,3 +39,14 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const Q=
Dict *qdict)
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

Since this missed the 2.10 freeze anyway and we've got some more time to
discuss it: I still think it would be much cleaner to move the functions
from kvm-all.c that use these PCI functions into a separate file
kvm-pci.c instead and compile that only with CONFIG_PCI=3Dy. That way we
likely also could prevent that more dependencies on CONFIG_PCI creep
into kvm-all.c again at later points in time.

I've now had a closer look, and it seems like the only affected
functions are kvm_irqchip_add_msi_route() and
kvm_irqchip_update_msi_route() ... and these seems only to be used in
code we would not care about on s390x with CONFIG_PCI=3Dn. So could you
please have at least a try to move these two functions (and other
related msi functions) to a new file kvm-pci.c instead to see whether
that would work, too?

 Thanks,
  Thomas
