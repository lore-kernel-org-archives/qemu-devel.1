Received: from eggs.gnu.org ([209.51.188.92]:33029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gqkiq-00060R-71
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gqkip-00023X-CM
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:20:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gqkip-00022C-1s
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 15:20:03 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x14KJ9ml065251
	for <qemu-devel@nongnu.org>; Mon, 4 Feb 2019 15:20:00 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qev64rcat-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 15:20:00 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Mon, 4 Feb 2019 20:19:59 -0000
References: <20190130155733.32742-1-david@redhat.com>
	<20190130155733.32742-4-david@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Mon, 4 Feb 2019 15:19:53 -0500
MIME-Version: 1.0
In-Reply-To: <20190130155733.32742-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <80dae41f-f3f0-1acd-1fd6-8e7473712802@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 3/6] s390x/pci: Warn when
 adding PCI devices without the 'zpci' feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 1/30/19 10:57 AM, David Hildenbrand wrote:
> We decided to always create the PCI host bridge, even if 'zpci' is not
> enabled (due to migration compatibility). This however right now allows
> to add zPCI/PCI devices to a VM although the guest will never actually see
> them, confusing people that are using a simple CPU model that has no
> 'zpci' enabled - "Why isn't this working" (David Hildenbrand)
> 
> Let's check for 'zpci' and at least print a warning that this will not
> work as expected. We could also bail out, however that might break
> existing QEMU commandlines.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/s390x/s390-pci-bus.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 9b5c5fff60..2efd9186c2 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -826,6 +826,11 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>   {
>       S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
>   
> +    if (!s390_has_feat(S390_FEAT_ZPCI)) {
> +        warn_report("PCI/zPCI device without the 'zpci' CPU feature."
> +                    " The guest will not be able to see/use this device");
> +    }
> +
>       if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>           PCIDevice *pdev = PCI_DEVICE(dev);
>   
> 

I wonder if someone might misconstrue this as "the _PCI device_ needs
the zpci feature." I think "'zpci' CPU feature required to support
PCI/zPCI devices." reads better. The last sentence is fine to me.
