Received: from eggs.gnu.org ([2001:4830:134:3::10]:51555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e0ZGk-0005yn-Uq
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e0ZGh-0001gs-Qe
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:30:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e0ZGh-0001gQ-Hm
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 16:30:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v96KTE1k111965
	for <qemu-devel@nongnu.org>; Fri, 6 Oct 2017 16:30:42 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2deeuqdu61-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 16:30:41 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 6 Oct 2017 14:30:40 -0600
References: <150730254473.16260.6484345241358746630.stgit@bahia>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 6 Oct 2017 17:30:34 -0300
MIME-Version: 1.0
In-Reply-To: <150730254473.16260.6484345241358746630.stgit@bahia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <26557b12-750c-02bf-a8a3-ae887ceca9d4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr_pci: fail gracefully with
 non-pseries machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>



On 10/06/2017 12:09 PM, Greg Kurz wrote:
> QEMU currently crashes when the user tries to add a spapr-pci-host-bridge
> on a non-pseries machine:
>
> $ qemu-system-ppc64 -M ppce500 -device spapr-pci-host-bridge,index=1
> hw/ppc/spapr_pci.c:1535:spapr_phb_realize:
> Object 0x1003dacae60 is not an instance of type spapr-machine
> Aborted (core dumped)
>
> The same thing happens with the deprecated but still available child type
> spapr-pci-vfio-host-bridge.
>
> Fix both by checking the machine type with object_dynamic_cast().
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

>   hw/ppc/spapr_pci.c |    8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5049ced4e8b4..9e85106f51f8 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1507,7 +1507,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>
>   static void spapr_phb_realize(DeviceState *dev, Error **errp)
>   {
> -    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
> +    sPAPRMachineState *spapr;
>       SysBusDevice *s = SYS_BUS_DEVICE(dev);
>       sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(s);
>       PCIHostState *phb = PCI_HOST_BRIDGE(s);
> @@ -1519,6 +1519,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>       const unsigned windows_supported =
>           sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
>
> +    spapr = (sPAPRMachineState *) qdev_get_machine();
> +    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
> +        error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries machine");
> +        return;
> +    }
> +
>       if (sphb->index != (uint32_t)-1) {
>           sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
>           Error *local_err = NULL;
>
>
