Received: from eggs.gnu.org ([2001:4830:134:3::10]:48995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1e1Te4-0006Bg-Ss
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1e1Te0-0008Dq-TJ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:42:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53220
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1e1Te0-0008DO-O4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 04:42:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v998cpsJ020288
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 04:42:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dg4ywt6nq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 04:42:32 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 04:42:32 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
	[9.57.199.111])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v998gTK741877572
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 08:42:29 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DD06AC040
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 04:43:08 -0400 (EDT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.193.250])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id AE821AC03F
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 04:43:07 -0400 (EDT)
References: <1507206983-16096-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507206983-16096-2-git-send-email-pmorel@linux.vnet.ibm.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 16:42:26 +0800
MIME-Version: 1.0
In-Reply-To: <1507206983-16096-2-git-send-email-pmorel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <a98e74ba-549f-c76f-c53f-56e3b574fde1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] pci: Set PCI-bus device entry before
 initializing bus master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I strongly agree. This will make IOMMU assignment easier.


=D4=DA 2017/10/5 =CF=C2=CE=E78:36, Pierre Morel =D0=B4=B5=C0:
> When initializing the PCI-bus master pci_init_bus_master(PCIDevice *)
> calls pci_device_iommu_address_space(PCIDevice *) which in turn calls
> iommu_bus->iommu_fn(bus, opaque,devfn)
>
> If the device entry of the PCI-bus is not initialized to point to the
> PCIDevice structure, the iommu_fn() function, getting only bus and
> devno, is unable to retrieve the PCIDevice.
>
> Usually it is not a problem as the DMA address space is depending of
> the BUS but in an architecture like S390, each PCI Device can have
> its own DMA address space.
> Being able to setup the DMA address space at the right moment will
> greatly simplify the implementation.
>
> This patch proposes to setup the bus device entry before calling
> pci_init_bus_master() and reset the entry in case of error.
>
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> ---
>   hw/pci/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 1e6fb88..3e64492 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1026,6 +1026,7 @@ static PCIDevice *do_pci_register_device(PCIDevic=
e *pci_dev, PCIBus *bus,
>       address_space_init(&pci_dev->bus_master_as,
>                          &pci_dev->bus_master_container_region, pci_dev=
->name);
>
> +    bus->devices[devfn] =3D pci_dev;
>       if (qdev_hotplug) {
>           pci_init_bus_master(pci_dev);
>       }
> @@ -1062,6 +1063,7 @@ static PCIDevice *do_pci_register_device(PCIDevic=
e *pci_dev, PCIBus *bus,
>       if (local_err) {
>           error_propagate(errp, local_err);
>           do_pci_unregister_device(pci_dev);
> +        bus->devices[devfn] =3D NULL;
>           return NULL;
>       }
>
> @@ -1071,7 +1073,6 @@ static PCIDevice *do_pci_register_device(PCIDevic=
e *pci_dev, PCIBus *bus,
>           config_write =3D pci_default_write_config;
>       pci_dev->config_read =3D config_read;
>       pci_dev->config_write =3D config_write;
> -    bus->devices[devfn] =3D pci_dev;
>       pci_dev->version_id =3D 2; /* Current pci device vmstate version =
*/
>       return pci_dev;
>   }
