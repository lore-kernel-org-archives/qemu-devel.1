Received: from eggs.gnu.org ([209.51.188.92]:51457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gt78F-0007w7-H0
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gt78D-0007P9-CP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 03:40:03 -0500
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
	<e22e1a26-2dd7-cc4c-86cc-2a78adba409f@redhat.com>
	<dd56798a-e32f-d46f-4a5c-0f8728e64fbd@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <acd6a9f8-7353-416f-28eb-8fd559496ba1@redhat.com>
Date: Mon, 11 Feb 2019 09:39:49 +0100
MIME-Version: 1.0
In-Reply-To: <dd56798a-e32f-d46f-4a5c-0f8728e64fbd@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 01/15] s390 vfio-ccw: Add
 bootindex property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jjherne@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 2019-02-08 17:04, Jason J. Herne wrote:
> On 2/6/19 6:30 AM, Thomas Huth wrote:
>> On 2019-01-29 14:29, Jason J. Herne wrote:
>>> Add bootindex property and iplb data for vfio-ccw devices. This
>>> allows us to
>>> forward boot information into the bios for vfio-ccw devices.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 hw/s390x/ipl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++++++
>>> =C2=A0 hw/s390x/s390-ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 9 +++++++++
>>> =C2=A0 hw/vfio/ccw.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +------------
>>> =C2=A0 include/hw/s390x/s390-ccw.h |=C2=A0 1 +
>>> =C2=A0 include/hw/s390x/vfio-ccw.h | 38
>>> ++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 5 files changed, 63 insertions(+), 12 deletions(-)
>>> =C2=A0 create mode 100644 include/hw/s390x/vfio-ccw.h
>>>
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index 21f64ad..a993f65 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -19,6 +19,7 @@
>>> =C2=A0 #include "hw/loader.h"
>>> =C2=A0 #include "hw/boards.h"
>>> =C2=A0 #include "hw/s390x/virtio-ccw.h"
>>> +#include "hw/s390x/vfio-ccw.h"
>>> =C2=A0 #include "hw/s390x/css.h"
>>> =C2=A0 #include "hw/s390x/ebcdic.h"
>>> =C2=A0 #include "ipl.h"
>>> @@ -311,8 +312,12 @@ static CcwDevice
>>> *s390_get_ccw_device(DeviceState *dev_st)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VirtioCcwDevic=
e *virtio_ccw_dev =3D (VirtioCcwDevice *)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
>>> object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TYPE_VIRTIO_CCW_DE=
VICE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIOCCWDevice *vfio_ccw_d=
ev =3D (VFIOCCWDevice *)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
bject_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (virtio_ccw=
_dev) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ccw_dev =3D CCW_DEVICE(virtio_ccw_dev);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (vfio_ccw_dev) =
{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
cw_dev =3D CCW_DEVICE(vfio_ccw_dev);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 SCSIDevice *sd =3D (SCSIDevice *)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_dynamic_cast(OBJECT(dev_st),
>>> @@ -347,6 +352,8 @@ static bool s390_gen_initial_iplb(S390IPLState *i=
pl)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ccw_dev) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCSIDevice *sd=
 =3D (SCSIDevice *)
>>> object_dynamic_cast(OBJECT(dev_st),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> TYPE_SCSI_DEVICE);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIOCCWDevice *vc =3D (VF=
IOCCWDevice *)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 o=
bject_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sd)=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ipl->iplb.len =3D cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>>> @@ -358,6 +365,13 @@ static bool s390_gen_initial_iplb(S390IPLState
>>> *ipl)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ipl->iplb.scsi.channel =3D cpu_to_be16(sd->channel);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ipl->iplb.scsi.devno =3D cpu_to_be16(ccw_dev->sch->devno);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ipl->iplb.scsi.ssid =3D ccw_dev->sch->ssid & 3;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (vc) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C=
cwDevice *ccw_dev =3D CCW_DEVICE(vc);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
pl->iplb.len =3D cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
pl->iplb.pbt =3D S390_IPL_TYPE_CCW;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
pl->iplb.ccw.devno =3D cpu_to_be16(ccw_dev->sch->devno);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
pl->iplb.ccw.ssid =3D ccw_dev->sch->ssid & 3;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 VirtIONet *vn =3D (VirtIONet *)
>>> object_dynamic_cast(OBJECT(dev_st),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
>>> TYPE_VIRTIO_NET);
>>> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
>>> index cad91ee..f5f025d 100644
>>> --- a/hw/s390x/s390-ccw.c
>>> +++ b/hw/s390x/s390-ccw.c
>>> @@ -124,6 +124,14 @@ static void s390_ccw_unrealize(S390CCWDevice
>>> *cdev, Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(cdev->mdevid);
>>> =C2=A0 }
>>> =C2=A0 +static void s390_ccw_instance_init(Object *obj)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 S390CCWDevice *dev =3D S390_CCW_DEVICE(obj);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 device_add_bootindex_property(obj, &dev->bootinde=
x, "bootindex",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "/disk@0,0", DEVIC=
E(obj), NULL);
>>> +}
>>> +
>>> =C2=A0 static void s390_ccw_class_init(ObjectClass *klass, void *data=
)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass=
);
>>> @@ -137,6 +145,7 @@ static void s390_ccw_class_init(ObjectClass
>>> *klass, void *data)
>>> =C2=A0 static const TypeInfo s390_ccw_info =3D {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D TYPE_S390_CCW,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D TYPE_CCW_DEVICE,
>>> +=C2=A0=C2=A0=C2=A0 .instance_init =3D s390_ccw_instance_init,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(S390CCWDevic=
e),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_size=C2=A0=C2=A0=C2=A0 =3D size=
of(S390CCWDeviceClass),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .class_init=C2=A0=C2=A0=C2=A0 =3D s390=
_ccw_class_init,
>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>> index 9246729..d815a4f 100644
>>> --- a/hw/vfio/ccw.c
>>> +++ b/hw/vfio/ccw.c
>>> @@ -21,22 +21,11 @@
>>> =C2=A0 #include "hw/vfio/vfio.h"
>>> =C2=A0 #include "hw/vfio/vfio-common.h"
>>> =C2=A0 #include "hw/s390x/s390-ccw.h"
>>> +#include "hw/s390x/vfio-ccw.h"
>>> =C2=A0 #include "hw/s390x/ccw-device.h"
>>> =C2=A0 #include "exec/address-spaces.h"
>>> =C2=A0 #include "qemu/error-report.h"
>>> =C2=A0 -#define TYPE_VFIO_CCW "vfio-ccw"
>>> -typedef struct VFIOCCWDevice {
>>> -=C2=A0=C2=A0=C2=A0 S390CCWDevice cdev;
>>> -=C2=A0=C2=A0=C2=A0 VFIODevice vdev;
>>> -=C2=A0=C2=A0=C2=A0 uint64_t io_region_size;
>>> -=C2=A0=C2=A0=C2=A0 uint64_t io_region_offset;
>>> -=C2=A0=C2=A0=C2=A0 struct ccw_io_region *io_region;
>>> -=C2=A0=C2=A0=C2=A0 EventNotifier io_notifier;
>>> -=C2=A0=C2=A0=C2=A0 bool force_orb_pfch;
>>> -=C2=A0=C2=A0=C2=A0 bool warned_orb_pfch;
>>> -} VFIOCCWDevice;
>>> -
>>> =C2=A0 static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchD=
ev *sch,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const =
char *msg)
>>> =C2=A0 {
>>> diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.=
h
>>> index 7d15a1a..901d805 100644
>>> --- a/include/hw/s390x/s390-ccw.h
>>> +++ b/include/hw/s390x/s390-ccw.h
>>> @@ -27,6 +27,7 @@ typedef struct S390CCWDevice {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CcwDevice parent_obj;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CssDevId hostid;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *mdevid;
>>> +=C2=A0=C2=A0=C2=A0 int32_t bootindex;
>>> =C2=A0 } S390CCWDevice;
>>> =C2=A0 =C2=A0 typedef struct S390CCWDeviceClass {
>>> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.=
h
>>> new file mode 100644
>>> index 0000000..a7d699d
>>> --- /dev/null
>>> +++ b/include/hw/s390x/vfio-ccw.h
>>> @@ -0,0 +1,38 @@
>>> +/*
>>> + * vfio based subchannel assignment support
>>> + *
>>> + * Copyright 2018 IBM Corp.
>>> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 Pierre Morel <pmorel@linux.vnet.ibm.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2
>>> or (at
>>> + * your option) any later version. See the COPYING file in the
>>> top-level
>>> + * directory.
>>> + */
>>> +
>>> +#ifndef HW_VFIO_CCW_H
>>> +#define HW_VFIO_CCW_H
>>> +
>>> +#include "hw/vfio/vfio-common.h"
>>> +#include "hw/s390x/s390-ccw.h"
>>> +#include "hw/s390x/ccw-device.h"
>>> +
>>> +#define TYPE_VFIO_CCW "vfio-ccw"
>>> +#define VFIO_CCW(obj) \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT_CHECK(VFIOCCWDevic=
e, (obj), TYPE_VFIO_CCW)
>>> +
>>> +
>>
>> Remove one empty line, please.
>>
>>> +#define TYPE_VFIO_CCW "vfio-ccw"
>>> +typedef struct VFIOCCWDevice {
>>> +=C2=A0=C2=A0=C2=A0 S390CCWDevice cdev;
>>> +=C2=A0=C2=A0=C2=A0 VFIODevice vdev;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t io_region_size;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t io_region_offset;
>>> +=C2=A0=C2=A0=C2=A0 struct ccw_io_region *io_region;
>>> +=C2=A0=C2=A0=C2=A0 EventNotifier io_notifier;
>>> +=C2=A0=C2=A0=C2=A0 bool force_orb_pfch;
>>> +=C2=A0=C2=A0=C2=A0 bool warned_orb_pfch;
>>> +} VFIOCCWDevice;
>>
>> Do you really need to make the whole structure public here? If not, I
>> think it would be sufficient to only have the "anonymous" typedef here=
:
>>
>> typedef struct VFIOCCWDevice VFIOCCWDevice;
>>
>> =C2=A0 Thomas
> Perhaps the entire struct is not needed in ipl.c, and we could get by
> with only the typedef. But then the only thing in vfio-ccw.h will be th=
e
> one line. Seems a little confusing to me. What do we gain by doing this=
?

That's the coding principle of "information hiding". Don't expose
internal data to other parts of the code if it is not really necessary.
I'm fine with making the structure public here if it is really
necessary, but as far as I can see until now, it's not, so there is also
no need to expose those internal information to other parts of the code.

 Thomas
