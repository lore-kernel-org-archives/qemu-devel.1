Received: from eggs.gnu.org ([2001:4830:134:3::10]:38146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dooCV-0001Wf-Le
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dooCO-0003KV-2J
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:01:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dooCN-0003Ij-P6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:01:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v84A09hW145193
	for <qemu-devel@nongnu.org>; Mon, 4 Sep 2017 06:01:41 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cs1d69nxn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 06:01:41 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Mon, 4 Sep 2017 04:01:40 -0600
Received: from b03ledav001.gho.boulder.ibm.com
	(b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v84A1c0564815194
	for <qemu-devel@nongnu.org>; Mon, 4 Sep 2017 03:01:38 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8966B6E041
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 04:01:38 -0600 (MDT)
Received: from zyimindembp.cn.ibm.com (unknown [9.115.193.63])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id E396F6E04E
	for <qemu-devel@nongnu.org>; Mon,  4 Sep 2017 04:01:37 -0600 (MDT)
References: <1500236854-28271-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500236854-28271-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Mon, 4 Sep 2017 18:01:36 +0800
MIME-Version: 1.0
In-Reply-To: <1500236854-28271-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <66bd157d-02d4-5d87-5774-71fd995652f6@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv3 1/2] pci: move check for existing devfn
 into new pci_bus_devfn_available() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



=D4=DA 2017/7/17 =C9=CF=CE=E74:27, Mark Cave-Ayland =D0=B4=B5=C0:
> Also touch up the logic in do_pci_register_device() accordingly.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/pci/pci.c |   10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 0c6f74a..efc9c86 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -951,6 +951,11 @@ uint16_t pci_requester_id(PCIDevice *dev)
>       return pci_req_id_cache_extract(&dev->requester_id_cache);
>   }
>
> +static bool pci_bus_devfn_available(PCIBus *bus, int devfn)
> +{
> +    return !(bus->devices[devfn]);
Hi,

I want to ask a question. According to the next patch, you check=20
bus->devices[devfn]
and reserved bit separately. Why not move the reserved bit check here?
I think bus->devices[devfn] !=3D NULL or revsered bit set means slot is=20
unavailable.

Regards,

Yi Min
> +}
> +
>   /* -1 for devfn means auto assign */
>   static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *=
bus,
>                                            const char *name, int devfn,
> @@ -974,14 +979,15 @@ static PCIDevice *do_pci_register_device(PCIDevic=
e *pci_dev, PCIBus *bus,
>       if (devfn < 0) {
>           for(devfn =3D bus->devfn_min ; devfn < ARRAY_SIZE(bus->device=
s);
>               devfn +=3D PCI_FUNC_MAX) {
> -            if (!bus->devices[devfn])
> +            if (pci_bus_devfn_available(bus, devfn)) {
>                   goto found;
> +            }
>           }
>           error_setg(errp, "PCI: no slot/function available for %s, all=
 in use",
>                      name);
>           return NULL;
>       found: ;
> -    } else if (bus->devices[devfn]) {
> +    } else if (!pci_bus_devfn_available(bus, devfn)) {
>           error_setg(errp, "PCI: slot %d function %d not available for =
%s,"
>                      " in use by %s",
>                      PCI_SLOT(devfn), PCI_FUNC(devfn), name,
