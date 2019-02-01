Received: from eggs.gnu.org ([209.51.188.92]:44563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpYtE-0002aI-II
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gpYtD-0005hV-PF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 08:29:52 -0500
References: <20190201124543.5945-1-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <85a78565-b721-3868-a256-807cf742c82d@redhat.com>
Date: Fri, 1 Feb 2019 14:29:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190201124543.5945-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 01.02.19 13:45, Cornelia Huck wrote:
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
> 
> ---
>  hw/s390x/s390-pci-bus.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index c96a7cba34..96c7c18f3f 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1253,6 +1253,15 @@ static Property s390_pci_device_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
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
>  static void s390_pci_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -1263,6 +1272,7 @@ static void s390_pci_device_class_init(ObjectClass *klass, void *data)
>      dc->bus_type = TYPE_S390_PCI_BUS;
>      dc->realize = s390_pci_device_realize;
>      dc->props = s390_pci_device_properties;
> +    dc->vmsd = &s390_pci_device_vmstate;
>  }
>  
>  static const TypeInfo s390_pci_device_info = {
> 

I guess this should be good enough (e.g. pci-bridge without a zpci
device should migrate "itself" I assume).

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
