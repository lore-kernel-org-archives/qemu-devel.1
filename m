Received: from eggs.gnu.org ([2001:4830:134:3::10]:54559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGNs4-0006jy-Po
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dGNs1-0001OQ-J4
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:02:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34395
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dGNs1-0001O8-Cd
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:02:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51AwZXV031116
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 07:02:24 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2atfv7nsxm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:02:23 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 1 Jun 2017 12:02:22 +0100
References: <20170529131716.94338-1-pasic@linux.vnet.ibm.com>
	<20170601125241.2c11e95a.cornelia.huck@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 1 Jun 2017 13:02:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170601125241.2c11e95a.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <49c45fcc-c161-cb47-cf2b-86d39996c3d6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] s390x: vmstatify config migration for
 virtio-ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org



On 06/01/2017 12:52 PM, Cornelia Huck wrote:
> On Mon, 29 May 2017 15:17:16 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Let's vmstatify virtio_ccw_save_config and virtio_ccw_load_config for
>> flexibility (extending using subsections) and for fun.
> 
> You have interesting ideas of fun :)
> 
>>
>> To achieve this we need to hack the config_vector, which is VirtIODevice
>> (that is common virtio) state, in the middle of the VirtioCcwDevice state
>> representation.  This somewhat ugly, but we have no choice because the
>> stream format needs to be preserved.
>>
>> Almost no changes in behavior. Exception is everything that comes with
>> vmstate like extra bookkeeping about what's in the stream, and maybe some
>> extra checks and better error reporting.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
[..]
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
[..]
>> +static const VMStateDescription vmstate_sense_id = {
>> +    .name = "s390_sense_id",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT8(reserved, SenseId),
>> +        VMSTATE_UINT16(cu_type, SenseId),
>> +        VMSTATE_UINT8(cu_model, SenseId),
>> +        VMSTATE_UINT16(dev_type, SenseId),
>> +        VMSTATE_UINT8(dev_model, SenseId),
>> +        VMSTATE_UINT8(unused, SenseId),
> 
> This is strictly due to stream format preservation, right?
> 

Yes!

[..]
>> --- a/hw/s390x/virtio-ccw.c
>> +++ b/hw/s390x/virtio-ccw.c
>> @@ -34,9 +34,87 @@
>>  #include "virtio-ccw.h"
>>  #include "trace.h"
>>  #include "hw/s390x/css-bridge.h"
>> +#include "hw/s390x/s390-virtio-ccw.h"
>>
>>  #define NR_CLASSIC_INDICATOR_BITS 64
>>
>> +static int virtio_ccw_dev_post_load(void *opaque, int version_id)
>> +{
>> +    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(opaque);
>> +    CcwDevice *ccw_dev = CCW_DEVICE(dev);
>> +    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
>> +
>> +    ccw_dev->sch->driver_data = dev;
>> +    if (CCW_DEVICE(dev)->sch->thinint_active) {
> 
> Please use ccw_dev instead of CCW_DEVICE(dev).
>

Sure.
 
>> +        dev->routes.adapter.adapter_id = css_get_adapter_id(
>> +                                         CSS_IO_ADAPTER_VIRTIO,
>> +                                         dev->thinint_isc);
>> +    }
>> +    /* Re-fill subch_id after loading the subchannel states.*/
>> +    if (ck->refill_ids) {
>> +        ck->refill_ids(ccw_dev);
>> +    }
>> +    return 0;
>> +}
>> +
>> +typedef struct VirtioCcwDeviceTmp {
>> +    VirtioCcwDevice *parent;
>> +    uint16_t config_vector;
>> +} VirtioCcwDeviceTmp;
>> +
>> +static void virtio_ccw_dev_tmp_pre_save(void *opaque)
>> +{
>> +    VirtioCcwDeviceTmp *tmp = opaque;
>> +    VirtioCcwDevice *dev = tmp->parent;
>> +    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>> +
>> +    tmp->config_vector = vdev->config_vector;
>> +}
>> +
>> +static int virtio_ccw_dev_tmp_post_load(void *opaque, int version_id)
>> +{
>> +    VirtioCcwDeviceTmp *tmp = opaque;
>> +    VirtioCcwDevice *dev = tmp->parent;
>> +    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>> +
>> +    vdev->config_vector = tmp->config_vector;
>> +    return 0;
>> +}
>> +
>> +const VMStateDescription vmstate_virtio_ccw_dev_tmp = {
>> +    .name = "s390_virtio_ccw_dev_tmp",
>> +    .pre_save = virtio_ccw_dev_tmp_pre_save,
>> +    .post_load = virtio_ccw_dev_tmp_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT16(config_vector, VirtioCcwDeviceTmp),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +const VMStateDescription vmstate_virtio_ccw_dev = {
>> +    .name = "s390_virtio_ccw_dev",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .post_load = virtio_ccw_dev_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_CCW_DEVICE(parent_obj, VirtioCcwDevice),
>> +        VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
>> +        VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
>> +        VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
>> +        /*
>> +         * Ugly hack because VirtIODevice does not migrate itself.
>> +         * This also makes legacy via vmstate_save_state possible.
>> +         */
>> +        VMSTATE_WITH_TMP(VirtioCcwDevice, VirtioCcwDeviceTmp,
>> +                         vmstate_virtio_ccw_dev_tmp),
>> +        VMSTATE_STRUCT(routes, VirtioCcwDevice, 1, vmstate_adapter_routes, \
>> +                       AdapterRoutes),
>> +        VMSTATE_UINT8(thinint_isc, VirtioCcwDevice),
>> +        VMSTATE_INT32(revision, VirtioCcwDevice),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static void virtio_ccw_bus_new(VirtioBusState *bus, size_t bus_size,
>>                                 VirtioCcwDevice *dev);
>>
>> @@ -1234,85 +1312,13 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
>>  static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
>>  {
>>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
>> -    CcwDevice *ccw_dev = CCW_DEVICE(d);
>> -    SubchDev *s = ccw_dev->sch;
>> -    VirtIODevice *vdev = virtio_ccw_get_vdev(s);
>> -
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
>> +    vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL);
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
>> -
>> -    return 0;
>> +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
>>  }
>>
>>  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
>> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
>> index e61fa74d9b..d74e44d312 100644
>> --- a/include/hw/s390x/css.h
>> +++ b/include/hw/s390x/css.h
>> @@ -88,6 +88,7 @@ struct SubchDev {
>>      bool ccw_fmt_1;
>>      bool thinint_active;
>>      uint8_t ccw_no_data_cnt;
>> +    uint16_t migrated_schid; /* used for missmatch detection */
>>      /* transport-provided data: */
>>      int (*ccw_cb) (SubchDev *, CCW1);
>>      void (*disable_cb)(SubchDev *);
>> @@ -95,22 +96,27 @@ struct SubchDev {
>>      void *driver_data;
>>  };
>>
>> +extern const VMStateDescription vmstate_subch_dev;
>> +
>>  typedef struct IndAddr {
>>      hwaddr addr;
>>      uint64_t map;
>>      unsigned long refcnt;
>> -    int len;
>> +    int32_t len;
>>      QTAILQ_ENTRY(IndAddr) sibling;
>>  } IndAddr;
>>
>> +extern const VMStateDescription vmstate_ind_addr;
>> +
>> +#define VMSTATE_PTR_TO_IND_ADDR(_f, _s)                                   \
>> +    VMSTATE_STRUCT(_f, _s, 1, vmstate_ind_addr, IndAddr*)
>> +
>>  IndAddr *get_indicator(hwaddr ind_addr, int len);
>>  void release_indicator(AdapterInfo *adapter, IndAddr *indicator);
>>  int map_indicator(AdapterInfo *adapter, IndAddr *indicator);
>>
>>  typedef SubchDev *(*css_subch_cb_func)(uint8_t m, uint8_t cssid, uint8_t ssid,
>>                                         uint16_t schid);
>> -void subch_device_save(SubchDev *s, QEMUFile *f);
>> -int subch_device_load(SubchDev *s, QEMUFile *f);
>>  int css_create_css_image(uint8_t cssid, bool default_image);
>>  bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
>>  void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
>> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.h
>> index f9e6890c90..caa6fc608d 100644
>> --- a/include/hw/s390x/s390_flic.h
>> +++ b/include/hw/s390x/s390_flic.h
>> @@ -31,6 +31,11 @@ typedef struct AdapterRoutes {
>>      int gsi[ADAPTER_ROUTES_MAX_GSI];
>>  } AdapterRoutes;
>>
>> +extern const VMStateDescription vmstate_adapter_routes;
>> +
>> +#define VMSTATE_ADAPTER_ROUTES(_f, _s) \
>> +    VMSTATE_STRUCT(_f, _s, 1, vmstate_adapter_routes, AdapterRoutes)
>> +
>>  #define TYPE_S390_FLIC_COMMON "s390-flic"
>>  #define S390_FLIC_COMMON(obj) \
>>      OBJECT_CHECK(S390FLICState, (obj), TYPE_S390_FLIC_COMMON)
> 
> Other than the nit above, looks good to me. Especially the migration of
> the pmcw & co. is now more readable. So, with the nit fixed,
> 
> Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>

Thanks!

> 
> Christian, can you please take this?
> 

Should I do a re-spin with the nit's picked and the r-b's added?

Regards,
Halil
