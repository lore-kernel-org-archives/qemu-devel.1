Received: from eggs.gnu.org ([2001:4830:134:3::10]:58718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d7mqb-0002X2-3d
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1d7mqW-0000hT-7A
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:53:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1d7mqV-0000gi-UK
	for qemu-devel@nongnu.org; Mon, 08 May 2017 13:53:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v48HnDwO026506
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 13:53:17 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aakg4wrja-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 13:53:17 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 8 May 2017 18:53:15 +0100
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-7-pasic@linux.vnet.ibm.com>
	<20170508173650.GJ2120@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 8 May 2017 19:53:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170508173650.GJ2120@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <877c80d1-fa63-0fd1-e394-fb649281aea1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] virtio-ccw: use vmstate way for
 config migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org



On 05/08/2017 07:36 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>> Let us use the freshly introduced vmstate migration helpers instead of
>> saving/loading the config manually.
>>
>> To achieve this we need to hack the config_vector which is a common
>> VirtIO state in the middle of the VirtioCcwDevice state representation.
>> This somewhat ugly but we have no choice because the stream format needs
>> to be preserved.
>>
>> Still no changes in behavior, but the dead code we added previously is
>> finally awakening to life.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>> ---
>>  hw/s390x/virtio-ccw.c | 116 +++++++++++++++++++-------------------------------
>>  1 file changed, 44 insertions(+), 72 deletions(-)
>>
>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>> index c2badfe..8ab655c 100644
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -57,6 +57,32 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
>>      return 0;
>>  }
>>  
>> +static int get_config_vector(QEMUFile *f, void *pv, size_t size,
>> +                             VMStateField *field)
>> +{
>> +    VirtioCcwDevice *dev = pv;
>> +    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>> +
>> +    qemu_get_be16s(f, &vdev->config_vector);
>> +    return 0;
>> +}
>> +
>> +static int put_config_vector(QEMUFile *f, void *pv, size_t size,
>> +                             VMStateField *field, QJSON *vmdesc)
>> +{
>> +    VirtioCcwDevice *dev = pv;
>> +    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>> +
>> +    qemu_put_be16(f, vdev->config_vector);
>> +    return 0;
>> +}
>> +
>> +const VMStateInfo vmstate_info_config_vector = {
>> +    .name = "config_vector",
>> +    .get = get_config_vector,
>> +    .put = put_config_vector,
>> +};
>> +
>>  const VMStateDescription vmstate_virtio_ccw_dev = {
>>      .name = "s390_virtio_ccw_dev",
>>      .version_id = 1,
>> @@ -67,6 +93,14 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
>>          VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
>>          VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
>>          VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
>> +        {
>> +        /*
>> +         * Ugly hack because VirtIODevice does not migrate itself.
>> +         * This also makes legacy via vmstate_save_state possible.
>> +         */
>> +            .name         = "virtio/config_vector",
>> +            .info         = &vmstate_info_config_vector,
>> +        },
> 
> I'm a bit confused - isn't just this bit the bit going
> through the vdev->load_config hook?
> 

Exactly! If you examine the part underscored with ============== in
virtio_ccw_(load|save)_config  (that is what is behind vdev->load_config)
you should see that we use vmstate_virtio_ccw_dev (that is this
VMStateDescription to implement these function. 

Actually virtio_ccw_(load|save)_config won't do anything after patch 9
and for new machines since the VirtIOCcwDevice is going to migrate
itself via DeviceClass.vmsd like other "normal" devices, and we fall
back to the VirtIO specific callbacks only in "legacy mode".

I hope this helps!

Halil


> 
>>          VMSTATE_STRUCT(routes, VirtioCcwDevice, 1, vmstate_adapter_routes, \
>>                         AdapterRoutes),
>>          VMSTATE_UINT8(thinint_isc, VirtioCcwDevice),
>> @@ -1272,85 +1306,23 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
>>  static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
>>  {
>>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
>> -    CcwDevice *ccw_dev = CCW_DEVICE(d);
>> -    SubchDev *s = ccw_dev->sch;
>> -    VirtIODevice *vdev = virtio_ccw_get_vdev(s);
>>  
>> -    subch_device_save(s, f);
>> -    if (dev->indicators != NULL) {
>> -        qemu_put_be32(f, dev->indicators->len);
>> -        qemu_put_be64(f, dev->indicators->addr);
>> -    } else {
>> -        qemu_put_be32(f, 0);
>> -        qemu_put_be64(f, 0UL);
>> -    }
>> -    if (dev->indicators2 != NULL) {
>> -        qemu_put_be32(f, dev->indicators2->len);
>> -        qemu_put_be64(f, dev->indicators2->addr);
>> -    } else {
>> -        qemu_put_be32(f, 0);
>> -        qemu_put_be64(f, 0UL);
>> -    }
>> -    if (dev->summary_indicator != NULL) {
>> -        qemu_put_be32(f, dev->summary_indicator->len);
>> -        qemu_put_be64(f, dev->summary_indicator->addr);
>> -    } else {
>> -        qemu_put_be32(f, 0);
>> -        qemu_put_be64(f, 0UL);
>> -    }
>> -    qemu_put_be16(f, vdev->config_vector);
>> -    qemu_put_be64(f, dev->routes.adapter.ind_offset);
>> -    qemu_put_byte(f, dev->thinint_isc);
>> -    qemu_put_be32(f, dev->revision);
>> +    /*
>> +     * We save in legacy mode. The components take care of their own
>> +     * compat. representation (based on css_migration_enabled).
>> +     */
>> +    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
====================================================================
   
>>  }
>>  
>>  static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
>>  {
>>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
>> -    CcwDevice *ccw_dev = CCW_DEVICE(d);
>> -    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
>> -    SubchDev *s = ccw_dev->sch;
>> -    VirtIODevice *vdev = virtio_ccw_get_vdev(s);
>> -    int len;
>> -
>> -    s->driver_data = dev;
>> -    subch_device_load(s, f);
>> -    /* Re-fill subch_id after loading the subchannel states.*/
>> -    if (ck->refill_ids) {
>> -        ck->refill_ids(ccw_dev);
>> -    }
>> -    len = qemu_get_be32(f);
>> -    if (len != 0) {
>> -        dev->indicators = get_indicator(qemu_get_be64(f), len);
>> -    } else {
>> -        qemu_get_be64(f);
>> -        dev->indicators = NULL;
>> -    }
>> -    len = qemu_get_be32(f);
>> -    if (len != 0) {
>> -        dev->indicators2 = get_indicator(qemu_get_be64(f), len);
>> -    } else {
>> -        qemu_get_be64(f);
>> -        dev->indicators2 = NULL;
>> -    }
>> -    len = qemu_get_be32(f);
>> -    if (len != 0) {
>> -        dev->summary_indicator = get_indicator(qemu_get_be64(f), len);
>> -    } else {
>> -        qemu_get_be64(f);
>> -        dev->summary_indicator = NULL;
>> -    }
>> -    qemu_get_be16s(f, &vdev->config_vector);
>> -    dev->routes.adapter.ind_offset = qemu_get_be64(f);
>> -    dev->thinint_isc = qemu_get_byte(f);
>> -    dev->revision = qemu_get_be32(f);
>> -    if (s->thinint_active) {
>> -        dev->routes.adapter.adapter_id = css_get_adapter_id(
>> -                                         CSS_IO_ADAPTER_VIRTIO,
>> -                                         dev->thinint_isc);
>> -    }
>>  
>> -    return 0;
>> +    /*
>> +     * We load in legacy mode. The components take take care to read
>> +     * only stuff which is actually there (based on css_migration_enabled).
>> +     */
>> +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
========================================================================

>>  }
>>  
>>  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
>> -- 
>> 2.10.2
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
