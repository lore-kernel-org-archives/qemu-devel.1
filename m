Received: from eggs.gnu.org ([2001:4830:134:3::10]:37064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1d59Rn-00076P-Qm
	for qemu-devel@nongnu.org; Mon, 01 May 2017 07:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1d59Rk-0004Nq-K1
	for qemu-devel@nongnu.org; Mon, 01 May 2017 07:24:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1d59Rk-0004NX-B6
	for qemu-devel@nongnu.org; Mon, 01 May 2017 07:24:52 -0400
References: <20170428130951.44771-1-bjsdjshi@linux.vnet.ibm.com>
	<20170428130951.44771-7-bjsdjshi@linux.vnet.ibm.com>
	<a0ff3179-8161-47dc-5a28-74ddf6e2271a@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <106564bb-baaa-f04b-b8c6-d17781d576e7@redhat.com>
Date: Mon, 1 May 2017 13:24:47 +0200
MIME-Version: 1.0
In-Reply-To: <a0ff3179-8161-47dc-5a28-74ddf6e2271a@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 06/13] s390x/css: device support for
 s390-ccw passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org

Hi Dong,

On 01/05/2017 13:20, Auger Eric wrote:
> Hi Dong,
> 
> On 28/04/2017 15:09, Dong Jia Shi wrote:
>> In order to support subchannels pass-through, we introduce a s390
>> subchannel device called "s390-ccw" to hold the real subchannel info.
>> The s390-ccw devices inherit from the abstract CcwDevice which connect
>> to the existing virtual-css-bus.

Forget that one. Thought my first reply has not been sent.

Thanks

Eric
>>
>> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/Makefile.objs |   1 +
>>  hw/s390x/s390-ccw.c    | 135 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/s390x/s390-ccw.h    |  38 ++++++++++++++
>>  3 files changed, 174 insertions(+)
>>  create mode 100644 hw/s390x/s390-ccw.c
>>  create mode 100644 hw/s390x/s390-ccw.h
>>
>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>> index 41ac4ec..72a3d37 100644
>> --- a/hw/s390x/Makefile.objs
>> +++ b/hw/s390x/Makefile.objs
>> @@ -13,3 +13,4 @@ obj-y += ccw-device.o
>>  obj-y += s390-pci-bus.o s390-pci-inst.o
>>  obj-y += s390-skeys.o
>>  obj-$(CONFIG_KVM) += s390-skeys-kvm.o
>> +obj-y += s390-ccw.o
>> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
>> new file mode 100644
>> index 0000000..8b4b9cf
>> --- /dev/null
>> +++ b/hw/s390x/s390-ccw.c
>> @@ -0,0 +1,135 @@
>> +/*
>> + * s390 CCW Assignment Support
>> + *
>> + * Copyright 2017 IBM Corp
>> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>> + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>> + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2
>> + * or (at your option) any later version. See the COPYING file in the
>> + * top-level directory.
>> + */
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/sysbus.h"
>> +#include "libgen.h"
>> +#include "hw/s390x/css.h"
>> +#include "hw/s390x/css-bridge.h"
>> +#include "s390-ccw.h"
>> +
>> +static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
>> +                                  char *sysfsdev,
>> +                                  Error **errp)
>> +{
>> +    unsigned int cssid, ssid, devid;
>> +    char dev_path[PATH_MAX] = {0}, *tmp;
>> +
>> +    if (!sysfsdev) {
>> +        error_setg(errp, "No host device provided");
>> +        error_append_hint(errp,
>> +                          "Use -device vfio-ccw,sysfsdev=PATH_TO_DEVICE\n");
>> +        return;
>> +    }
>> +
>> +    if (!realpath(sysfsdev, dev_path)) {
>> +        error_setg(errp, "Host device '%s' not found", sysfsdev);
>> +        return;
>> +    }
>> +
>> +    cdev->mdevid = g_strdup(basename(dev_path));
>> +
>> +    tmp = basename(dirname(dev_path));
>> +    sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid);
> I guess you don't need to check sscanf succeeded?
>> +
>> +    cdev->hostid.cssid = cssid;
>> +    cdev->hostid.ssid = ssid;
>> +    cdev->hostid.devid = devid;
>> +    cdev->hostid.valid = true;
>> +}
>> +
>> +static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
>> +{
>> +    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
>> +    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
>> +    DeviceState *parent = DEVICE(ccw_dev);
>> +    BusState *qbus = qdev_get_parent_bus(parent);
>> +    VirtualCssBus *cbus = VIRTUAL_CSS_BUS(qbus);
>> +    SubchDev *sch;
>> +    int ret;
>> +    Error *err = NULL;
>> +
>> +    s390_ccw_get_dev_info(cdev, sysfsdev, errp);
>> +    if (*errp) {
> In the past, I was told by Markus that derefencing errp was not clean in
> general since caller could pass NULL to ignore errors (although qdev
> core doesn't). You may use a local error instead.
>> +        return;
>> +    }
>> +
>> +    sch = css_create_sch(ccw_dev->devno, false, cbus->squash_mcss, errp);
>> +    if (!sch) {
>> +        return;
>> +    }
>> +    sch->driver_data = cdev;
>> +
>> +    ccw_dev->sch = sch;
>> +    ret = css_sch_build_schib(sch, &cdev->hostid);
>> +    if (ret) {
>> +        error_setg(&err, "%s: Failed to build initial schib: %d",
>> +                   __func__, ret);
>> +        goto out_err;
>> +    }
>> +
>> +    ck->realize(ccw_dev, &err);
>> +    if (err) {
>> +        goto out_err;
>> +    }
>> +
>> +    css_generate_sch_crws(sch->cssid, sch->ssid, sch->schid,
>> +                          parent->hotplugged, 1);
>> +    return;
>> +
>> +out_err:
>> +    error_propagate(errp, err);
>> +    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
>> +    ccw_dev->sch = NULL;
>> +    g_free(sch);
> don't you want to free cdev->mdevid too?
> 
> Thanks
> 
> Eric
>> +}
>> +
>> +static void s390_ccw_unrealize(S390CCWDevice *cdev, Error **errp)
>> +{
>> +    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
>> +    SubchDev *sch = ccw_dev->sch;
>> +
>> +    if (sch) {
>> +        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
>> +        g_free(sch);
>> +        ccw_dev->sch = NULL;
>> +    }
>> +
>> +    g_free(cdev->mdevid);
>> +}
>> +
>> +static void s390_ccw_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
>> +
>> +    dc->bus_type = TYPE_VIRTUAL_CSS_BUS;
>> +    cdc->realize = s390_ccw_realize;
>> +    cdc->unrealize = s390_ccw_unrealize;
>> +}
>> +
>> +static const TypeInfo s390_ccw_info = {
>> +    .name          = TYPE_S390_CCW,
>> +    .parent        = TYPE_CCW_DEVICE,
>> +    .instance_size = sizeof(S390CCWDevice),
>> +    .class_size    = sizeof(S390CCWDeviceClass),
>> +    .class_init    = s390_ccw_class_init,
>> +    .abstract      = true,
>> +};
>> +
>> +static void register_s390_ccw_type(void)
>> +{
>> +    type_register_static(&s390_ccw_info);
>> +}
>> +
>> +type_init(register_s390_ccw_type)
>> diff --git a/hw/s390x/s390-ccw.h b/hw/s390x/s390-ccw.h
>> new file mode 100644
>> index 0000000..b58d8e9
>> --- /dev/null
>> +++ b/hw/s390x/s390-ccw.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * s390 CCW Assignment Support
>> + *
>> + * Copyright 2017 IBM Corp.
>> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>> + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
>> + * your option) any later version. See the COPYING file in the top-level
>> + * directory.
>> + */
>> +
>> +#ifndef HW_S390_CCW_H
>> +#define HW_S390_CCW_H
>> +
>> +#include "hw/s390x/ccw-device.h"
>> +
>> +#define TYPE_S390_CCW "s390-ccw"
>> +#define S390_CCW_DEVICE(obj) \
>> +    OBJECT_CHECK(S390CCWDevice, (obj), TYPE_S390_CCW)
>> +#define S390_CCW_DEVICE_CLASS(klass) \
>> +    OBJECT_CLASS_CHECK(S390CCWDeviceClass, (klass), TYPE_S390_CCW)
>> +#define S390_CCW_DEVICE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(S390CCWDeviceClass, (obj), TYPE_S390_CCW)
>> +
>> +typedef struct S390CCWDevice {
>> +    CcwDevice parent_obj;
>> +    CssDevId hostid;
>> +    char *mdevid;
>> +} S390CCWDevice;
>> +
>> +typedef struct S390CCWDeviceClass {
>> +    CCWDeviceClass parent_class;
>> +    void (*realize)(S390CCWDevice *dev, char *sysfsdev, Error **errp);
>> +    void (*unrealize)(S390CCWDevice *dev, Error **errp);
>> +} S390CCWDeviceClass;
>> +
>> +#endif
>>
