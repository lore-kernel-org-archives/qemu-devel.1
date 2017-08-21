Received: from eggs.gnu.org ([2001:4830:134:3::10]:34498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1djp9l-0000En-Dx
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:02:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1djp9f-0008NU-SJ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:02:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35211)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1djp9f-0008N9-KT
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 12:02:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7LFxHE8146665
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 12:02:18 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cfvyrktx9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 12:02:18 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 21 Aug 2017 17:02:15 +0100
References: <20170821091614.28251-1-cohuck@redhat.com>
	<20170821091614.28251-3-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 21 Aug 2017 18:02:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170821091614.28251-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <cb66ce20-c407-2462-0e51-8d6751af9f7b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/10] kvm: remove hard dependency on pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, zyimin@linux.vnet.ibm.com, david@redhat.com, agraf@suse.de, borntraeger@de.ibm.com

On 21/08/2017 11:16, Cornelia Huck wrote:
> The msi routing code in kvm calls some pci functions: provide
> some stubs to enable builds without pci.
>=20
> Also, to make this more obvious, guard them via a pci_available boolean
> (which also can be reused in other places).
>=20
> Fixes: e1d4fb2de ("kvm-irqchip: x86: add msi route notify fn")
> Fixes: 767a554a0 ("kvm-all: Pass requester ID to MSI routing functions"=
)
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   accel/kvm/kvm-all.c  |  6 +++---
>   hw/pci/pci-stub.c    | 15 +++++++++++++++
>   hw/pci/pci.c         |  2 ++
>   include/hw/pci/pci.h |  2 ++
>   4 files changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 46ce479dc3..f85553a851 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1248,7 +1248,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int ve=
ctor, PCIDevice *dev)
>       int virq;
>       MSIMessage msg =3D {0, 0};
>=20
> -    if (dev) {
> +    if (pci_available && dev) {
>           msg =3D pci_get_msi_message(dev, vector);
>       }

Hi Conny,

I did not find a case where pci_available is false and dev is true.
but anyway, sure is sure.


>=20
> @@ -1271,7 +1271,7 @@ int kvm_irqchip_add_msi_route(KVMState *s, int ve=
ctor, PCIDevice *dev)
>       kroute.u.msi.address_lo =3D (uint32_t)msg.address;
>       kroute.u.msi.address_hi =3D msg.address >> 32;
>       kroute.u.msi.data =3D le32_to_cpu(msg.data);
> -    if (kvm_msi_devid_required()) {
> +    if (pci_available && kvm_msi_devid_required()) {
>           kroute.flags =3D KVM_MSI_VALID_DEVID;
>           kroute.u.msi.devid =3D pci_requester_id(dev);
>       }
> @@ -1309,7 +1309,7 @@ int kvm_irqchip_update_msi_route(KVMState *s, int=
 virq, MSIMessage msg,
>       kroute.u.msi.address_lo =3D (uint32_t)msg.address;
>       kroute.u.msi.address_hi =3D msg.address >> 32;
>       kroute.u.msi.data =3D le32_to_cpu(msg.data);
> -    if (kvm_msi_devid_required()) {
> +    if (pci_available && kvm_msi_devid_required()) {
>           kroute.flags =3D KVM_MSI_VALID_DEVID;
>           kroute.u.msi.devid =3D pci_requester_id(dev);
>       }
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index ecad664946..ace43821ca 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -23,10 +23,12 @@
>   #include "monitor/monitor.h"
>   #include "qapi/qmp/qerror.h"
>   #include "hw/pci/pci.h"
> +#include "hw/pci/msi.h"

I think you forgot that...

>   #include "qmp-commands.h"
>   #include "hw/pci/msi.h"

...you already have it included here. Didn't you ?

>=20
>   bool msi_nonbroken;
> +bool pci_available;
>=20
>   PciInfoList *qmp_query_pci(Error **errp)
>   {
> @@ -38,3 +40,16 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const Q=
Dict *qdict)
>   {
>       monitor_printf(mon, "PCI devices not supported\n");
>   }
> +
> +/* kvm-all wants this */
> +MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
> +{
> +    g_assert(false);
> +    return (MSIMessage){};
> +}
> +
> +uint16_t pci_requester_id(PCIDevice *dev)
> +{
> +    g_assert(false);
> +    return 0;
> +}
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 258fbe51e2..26f346db2c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -49,6 +49,8 @@
>   # define PCI_DPRINTF(format, ...)       do { } while (0)
>   #endif
>=20
> +bool pci_available =3D true;
> +
>   static void pcibus_dev_print(Monitor *mon, DeviceState *dev, int inde=
nt);
>   static char *pcibus_get_dev_path(DeviceState *dev);
>   static char *pcibus_get_fw_dev_path(DeviceState *dev);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index e598b095eb..8bb6449dd7 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -10,6 +10,8 @@
>=20
>   #include "hw/pci/pcie.h"
>=20
> +extern bool pci_available;
> +
>   /* PCI bus */
>=20
>   #define PCI_DEVFN(slot, func)   ((((slot) & 0x1f) << 3) | ((func) & 0=
x07))
>=20

otherwise LGTM

Regards,

Pierre


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
