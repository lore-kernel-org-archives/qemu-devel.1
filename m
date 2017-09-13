Received: from eggs.gnu.org ([2001:4830:134:3::10]:37961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsCId-0001K3-MD
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dsCIc-0006kO-S5
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:22:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dsCIc-0006iE-Mh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:22:10 -0400
References: <cover.1505225353.git.alifm@linux.vnet.ibm.com>
	<a30f50d543182914e83cba5501f615a8ded2b858.1505225353.git.alifm@linux.vnet.ibm.com>
	<4c65d9e0-df2c-6838-22dc-46415cdd82f1@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dc3abfc6-4a62-9c2c-4f7a-371f8001e6b1@redhat.com>
Date: Wed, 13 Sep 2017 20:22:03 +0200
MIME-Version: 1.0
In-Reply-To: <4c65d9e0-df2c-6838-22dc-46415cdd82f1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] virtio-gpu-ccw: Create a virtio gpu
 device for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, kraxel@redhat.com

On 13.09.2017 14:09, David Hildenbrand wrote:
> On 12.09.2017 16:26, Farhan Ali wrote:
>> Wire up the virtio-gpu device for the CCW bus. The virtio-gpu
>> is a virtio-1 device, so disable revision 0.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  hw/s390x/virtio-ccw.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/s390x/virtio-ccw.h | 10 ++++++++++
>>  2 files changed, 64 insertions(+)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index b1976fd..3078bf0 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -1007,6 +1007,20 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
>>                               NULL);
>>  }
>>  
>> +static void virtio_ccw_gpu_realize(VirtioCcwDevice *ccw_dev, Error **errp)
>> +{
>> +    VirtIOGPUCcw *dev = VIRTIO_GPU_CCW(ccw_dev);
>> +    DeviceState *vdev = DEVICE(&dev->vdev);
>> +    Error *err = NULL;
>> +
>> +    qdev_set_parent_bus(vdev, BUS(&ccw_dev->bus));
>> +    object_property_set_bool(OBJECT(vdev), true, "realized", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
> 
> You can call error_propagate() unconditionally, it can deal with !err.

I think you even do not need error_propagate here - just pass errp
directly to object_property_set_bool. You exit the function afterwards
anyway.

 Thomas
