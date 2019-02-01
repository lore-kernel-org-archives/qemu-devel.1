Received: from eggs.gnu.org ([209.51.188.92]:53157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpawU-0000Sx-4a
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1gpawR-0007hL-DO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:41:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56736
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1gpawR-0007gS-6T
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 10:41:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x11FT8Dq007828
	for <qemu-devel@nongnu.org>; Fri, 1 Feb 2019 10:41:16 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qcpp906jb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 10:41:15 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Fri, 1 Feb 2019 15:41:15 -0000
References: <20190201124543.5945-1-cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Fri, 1 Feb 2019 10:41:10 -0500
MIME-Version: 1.0
In-Reply-To: <20190201124543.5945-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <6239c630-24d1-f68f-ec16-023e1f37148d@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/pci: mark zpci devices as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2/1/19 7:45 AM, Cornelia Huck wrote:
> We currently don't migrate any state for zpci devices, which are
> coupled with standard pci devices. This means funny things happen
> when we e.g. try to migrate with a virtio-pci device but the s390x-
> specific zpci state is not migrated (vfio-pci is not affected, as
> it is not migratable anyway.)
> 
> Until this is fixed, mark zpci devices as unmigratable.
> 
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> This is just a stop-gap measure to give us time to implement the
> needed migration code properly.

I imagine this means we'll want a single migration handler that will
take care of PCI and zPCI in one go, that way the data stays coupled?

Just throwing thoughts out there.

> 
> ---
>   hw/s390x/s390-pci-bus.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index c96a7cba34..96c7c18f3f 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1253,6 +1253,15 @@ static Property s390_pci_device_properties[] = {
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> +static const VMStateDescription s390_pci_device_vmstate = {
> +    .name = TYPE_S390_PCI_DEVICE,
> +    /*
> +     * TODO: add state handling here, so migration works at least with
> +     * emulated pci devices on s390x
> +     */
> +    .unmigratable = 1,
> +};
> +
>   static void s390_pci_device_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1263,6 +1272,7 @@ static void s390_pci_device_class_init(ObjectClass *klass, void *data)
>       dc->bus_type = TYPE_S390_PCI_BUS;
>       dc->realize = s390_pci_device_realize;
>       dc->props = s390_pci_device_properties;
> +    dc->vmsd = &s390_pci_device_vmstate;
>   }
>   
>   static const TypeInfo s390_pci_device_info = {
> 

Good band-aid patch.!

Reviewed-by: Collin Walling <walling@linux.ibm.com>
