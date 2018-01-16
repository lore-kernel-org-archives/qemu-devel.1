Received: from eggs.gnu.org ([2001:4830:134:3::10]:46531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebRu5-0002S5-HF
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebRu0-0007b4-6m
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:07:53 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-6-f4bug@amsat.org>
	<21f570e0-eae6-e93d-c011-4742d777d843@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <18def10c-ca89-6628-34db-c62b071b3277@amsat.org>
Date: Tue, 16 Jan 2018 11:07:35 -0300
MIME-Version: 1.0
In-Reply-To: <21f570e0-eae6-e93d-c011-4742d777d843@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/11] virtio-ccw: convert
 VirtIOCCWDeviceClass::init -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 01/16/2018 10:41 AM, Farhan Ali wrote:
> shouldn't the commit message say exit -> unrealize?

Oops, indeed :|

Thanks :)

Phil.

> 
> 
> Thanks
> Farhan
> 
> On 01/16/2018 08:15 AM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   hw/s390x/virtio-ccw.h |  2 +-
>>   hw/s390x/virtio-ccw.c | 35 +++++++++++++++++------------------
>>   2 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
>> index 3905f3a3d6..2fc513001e 100644
>> --- a/hw/s390x/virtio-ccw.h
>> +++ b/hw/s390x/virtio-ccw.h
>> @@ -76,7 +76,7 @@ typedef struct VirtioCcwDevice VirtioCcwDevice;
>>   typedef struct VirtIOCCWDeviceClass {
>>       CCWDeviceClass parent_class;
>>       void (*realize)(VirtioCcwDevice *dev, Error **errp);
>> -    int (*exit)(VirtioCcwDevice *dev);
>> +    void (*unrealize)(VirtioCcwDevice *dev, Error **errp);
>>   } VirtIOCCWDeviceClass;
>>
>>   /* Performance improves when virtqueue kick processing is decoupled
>> from the
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index 38f6a8afc9..a71c3feeb5 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -751,7 +751,7 @@ out_err:
>>       g_free(sch);
>>   }
>>
>> -static int virtio_ccw_exit(VirtioCcwDevice *dev)
>> +static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
>>   {
>>       CcwDevice *ccw_dev = CCW_DEVICE(dev);
>>       SubchDev *sch = ccw_dev->sch;
>> @@ -764,7 +764,6 @@ static int virtio_ccw_exit(VirtioCcwDevice *dev)
>>           release_indicator(&dev->routes.adapter, dev->indicators);
>>           dev->indicators = NULL;
>>       }
>> -    return 0;
>>   }
>>
>>   static void virtio_ccw_net_realize(VirtioCcwDevice *ccw_dev, Error
>> **errp)
>> @@ -1343,7 +1342,7 @@ static void
>> virtio_ccw_net_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_net_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_net_properties;
>>       set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>> @@ -1371,7 +1370,7 @@ static void
>> virtio_ccw_blk_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_blk_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_blk_properties;
>>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>> @@ -1399,7 +1398,7 @@ static void
>> virtio_ccw_serial_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_serial_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_serial_properties;
>>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>> @@ -1427,7 +1426,7 @@ static void
>> virtio_ccw_balloon_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_balloon_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_balloon_properties;
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> @@ -1455,7 +1454,7 @@ static void
>> virtio_ccw_scsi_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_scsi_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_scsi_properties;
>>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>> @@ -1482,7 +1481,7 @@ static void
>> vhost_ccw_scsi_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = vhost_ccw_scsi_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = vhost_ccw_scsi_properties;
>>       set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>> @@ -1519,7 +1518,7 @@ static void
>> virtio_ccw_rng_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_rng_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_rng_properties;
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> @@ -1557,7 +1556,7 @@ static void
>> virtio_ccw_crypto_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_crypto_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_crypto_properties;
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>> @@ -1595,7 +1594,7 @@ static void
>> virtio_ccw_gpu_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_gpu_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_gpu_properties;
>>       dc->hotpluggable = false;
>> @@ -1624,7 +1623,7 @@ static void
>> virtio_ccw_input_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = virtio_ccw_input_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_input_properties;
>>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>> @@ -1704,12 +1703,12 @@ static void
>> virtio_ccw_busdev_realize(DeviceState *dev, Error **errp)
>>       virtio_ccw_device_realize(_dev, errp);
>>   }
>>
>> -static int virtio_ccw_busdev_exit(DeviceState *dev)
>> +static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **errp)
>>   {
>>       VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
>> -    VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>> +    VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>>
>> -    return _info->exit(_dev);
>> +    k->unrealize(_dev, errp);
>>   }
>>
>>   static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
>> @@ -1727,7 +1726,7 @@ static void
>> virtio_ccw_device_class_init(ObjectClass *klass, void *data)
>>
>>       k->unplug = virtio_ccw_busdev_unplug;
>>       dc->realize = virtio_ccw_busdev_realize;
>> -    dc->exit = virtio_ccw_busdev_exit;
>> +    dc->unrealize = virtio_ccw_busdev_unrealize;
>>       dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
>>   }
>>
>> @@ -1803,7 +1802,7 @@ static void virtio_ccw_9p_class_init(ObjectClass
>> *klass, void *data)
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       k->realize = virtio_ccw_9p_realize;
>>       dc->reset = virtio_ccw_reset;
>>       dc->props = virtio_ccw_9p_properties;
>> @@ -1852,7 +1851,7 @@ static void
>> vhost_vsock_ccw_class_init(ObjectClass *klass, void *data)
>>       VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_CLASS(klass);
>>
>>       k->realize = vhost_vsock_ccw_realize;
>> -    k->exit = virtio_ccw_exit;
>> +    k->unrealize = virtio_ccw_unrealize;
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       dc->props = vhost_vsock_ccw_properties;
>>       dc->reset = virtio_ccw_reset;
>>
> 
