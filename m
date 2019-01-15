Received: from eggs.gnu.org ([209.51.188.92]:45013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gjVmM-0007Zf-Hw
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gjVmL-0004jq-Gk
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:57:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35548
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gjVmL-0004hf-8u
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:57:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0FKrsWR106719
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 15:57:43 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q1p89aj01-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 15:57:43 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Tue, 15 Jan 2019 20:57:42 -0000
References: <20190114103110.10909-1-david@redhat.com>
	<20190114103110.10909-2-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Tue, 15 Jan 2019 15:57:38 -0500
MIME-Version: 1.0
In-Reply-To: <20190114103110.10909-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <05fdc8f0-b7d2-ff3d-0c0b-699864f0f7e9@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] s390x/pci: Use hotplug_dev instead
 of looking up the host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 1/14/19 5:31 AM, David Hildenbrand wrote:
> We directly have it in our hands.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 7f911b216a..86dda831f9 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -826,9 +826,9 @@ static bool s390_pci_alloc_idx(S390pciState *s, S390PCIBusDevice *pbdev)
>   static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                 Error **errp)
>   {
> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>       PCIDevice *pdev = NULL;
>       S390PCIBusDevice *pbdev = NULL;
> -    S390pciState *s = s390_get_phb();
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>           BusState *bus;
> @@ -935,11 +935,11 @@ static void s390_pcihost_timer_cb(void *opaque)
>   static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>                                   Error **errp)
>   {
> +    S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>       PCIDevice *pci_dev = NULL;
>       PCIBus *bus;
>       int32_t devfn;
>       S390PCIBusDevice *pbdev = NULL;
> -    S390pciState *s = s390_get_phb();
>   
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
>           error_setg(errp, "PCI bridge hot unplug currently not supported");
> 

Looks like the macro will do the same thing as the function does? I 
wonder if it makes sense to one day replace all function calls with the 
macro.

Reviewed-by: Collin Walling <walling@linux.ibm.com>
