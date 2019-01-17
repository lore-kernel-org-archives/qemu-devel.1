Received: from eggs.gnu.org ([209.51.188.92]:42517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gk6vd-0000rB-Qs
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gk6iJ-0004Tx-OD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:24:04 -0500
References: <20190116113523.9213-1-david@redhat.com>
	<20190116113523.9213-5-david@redhat.com>
	<20190116192025.GB27437@kermit-br-ibm-com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e76b42e6-c7bb-2ed4-bfa3-07d979bb9da4@redhat.com>
Date: Thu, 17 Jan 2019 13:23:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190116192025.GB27437@kermit-br-ibm-com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC 04/10] virtio-pmem: Prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>

>> +static void virtio_pmem_realize(DeviceState *dev, Error **errp)
>> +{
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
>> +
>> +    if (!pmem->memdev) {
>> +        error_setg(errp, "virtio-pmem memdev not set");
>> +        return;
>> +    } else if (host_memory_backend_is_mapped(pmem->memdev)) {
>> +        char *path = object_get_canonical_path_component(OBJECT(pmem->memdev));
>> +        error_setg(errp, "can't use already busy memdev: %s", path);
>> +        g_free(path);
>> +        return;
>> +    }
> 
> Perhaps splitting this if-else block could improve readability:

Makes sense, this was kept similar to from
hw/mem/pc-dimm.c:pc_dimm_realize()

> 
>     if (!pmem->memdev) {
>         error_setg(...);
> 	return;
>     }
> 
>     if (host_memory_backend_is_mapped(pmem->memdev)) {
>        /* do stuff */
>        return;
>     }
> 
>     /* do other stuffs */
> 
>> +
>> +    host_memory_backend_set_mapped(pmem->memdev, true);
>> +    virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
>> +                                          sizeof(struct virtio_pmem_config));
> 
> I'm not quite sure what's the QEMU style for indenting this.  There
> are, for example, calls to warn_report() in other source files that
> are indented at the left side after the opening parenthesis.
> 
> Perhaps indenting it like this is preferable?
> 
>     virtio_init(vdev, TYPE_VIRTIO_PMEM, VIRTIO_ID_PMEM,
>                 sizeof(struct virtio_pmem_config));

Indeed, that looks weird.

> 
>> +    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
>> +}
>> +
>> +static void virtio_pmem_unrealize(DeviceState *dev, Error **errp)
>> +{
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>> +    VirtIOPMEM *pmem = VIRTIO_PMEM(dev);
>> +
>> +    host_memory_backend_set_mapped(pmem->memdev, false);
>> +    pmem->rq_vq = virtio_add_queue(vdev, 128, virtio_pmem_flush);
>> +    virtio_cleanup(vdev);
>> +}
>> +
>> +static void virtio_pmem_fill_device_info(const VirtIOPMEM *pmem,
>> +                                         VirtioPMEMDeviceInfo *vi)
>> +{
>> +    vi->memaddr = pmem->start;
>> +    vi->size = pmem->memdev ? memory_region_size(&pmem->memdev->mr) : 0;
>> +    vi->memdev = object_get_canonical_path(OBJECT(pmem->memdev));
>> +}
>> +
>> +static MemoryRegion *virtio_pmem_get_memory_region(VirtIOPMEM *pmem,
>> +                                                   Error **errp)
>> +{
>> +    if (!pmem->memdev) {
>> +        error_setg(errp, "'%s' property must be set", VIRTIO_PMEM_MEMDEV_PROP);
>> +        return NULL;
>> +    }
>> +
>> +    return &pmem->memdev->mr;
>> +}
>> +
>> +static Property virtio_pmem_properties[] = {
>> +    DEFINE_PROP_UINT64(VIRTIO_PMEM_ADDR_PROP, VirtIOPMEM, start, 0),
>> +    DEFINE_PROP_LINK(VIRTIO_PMEM_MEMDEV_PROP, VirtIOPMEM, memdev,
>> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void virtio_pmem_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
>> +    VirtIOPMEMClass *vpc = VIRTIO_PMEM_CLASS(klass);
>> +
>> +    dc->props = virtio_pmem_properties;
>> +
>> +    vdc->realize = virtio_pmem_realize;
>> +    vdc->unrealize = virtio_pmem_unrealize;
>> +    vdc->get_config = virtio_pmem_get_config;
>> +    vdc->get_features = virtio_pmem_get_features;
>> +
>> +    vpc->fill_device_info = virtio_pmem_fill_device_info;
>> +    vpc->get_memory_region = virtio_pmem_get_memory_region;
>> +}
>> +
>> +static TypeInfo virtio_pmem_info = {
>> +    .name          = TYPE_VIRTIO_PMEM,
>> +    .parent        = TYPE_VIRTIO_DEVICE,
>> +    .class_size    = sizeof(VirtIOPMEMClass),
>> +    .class_init    = virtio_pmem_class_init,
>> +    .instance_size = sizeof(VirtIOPMEM),
>> +};
>> +
>> +static void virtio_register_types(void)
>> +{
>> +    type_register_static(&virtio_pmem_info);
>> +}
>> +
>> +type_init(virtio_register_types)
>> diff --git a/include/hw/virtio/virtio-pmem.h b/include/hw/virtio/virtio-pmem.h
>> new file mode 100644
>> index 0000000000..85cee3ef39
>> --- /dev/null
>> +++ b/include/hw/virtio/virtio-pmem.h
>> @@ -0,0 +1,54 @@
>> +/*
>> + * Virtio pmem device
> 
> What if "pmem" was in upper case to match the header in virtio-pmem.c?
> 
>> + *
>> + * Copyright Red Hat, Inc. 2018
> 
> This is slightly different from what is in virtio-pmem.c header.
> Perhaps "(C)" is missing here.

Thanks for the hint, that is indeed not consistent.

[...]
>> +#define TYPE_VIRTIO_PMEM "virtio-pmem"
>> +
>> +#define VIRTIO_PMEM(obj) \
>> +        OBJECT_CHECK(VirtIOPMEM, (obj), TYPE_VIRTIO_PMEM)
> 
> This indentation is slightly different from the other two macros
> below.

Will be made consistent.

Thanks!

-- 

Thanks,

David / dhildenb
