Received: from eggs.gnu.org ([209.51.188.92]:42041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1h0qAL-0003CP-46
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1h0qAD-0001n7-Gh
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:10:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60426
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1h0qAD-0001bD-9r
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:10:01 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x24G4u6P124002
	for <qemu-devel@nongnu.org>; Mon, 4 Mar 2019 11:09:46 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r16c135se-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 11:09:46 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Mon, 4 Mar 2019 16:09:45 -0000
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-2-git-send-email-jjherne@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Mon, 4 Mar 2019 11:09:41 -0500
MIME-Version: 1.0
In-Reply-To: <1551466776-29123-2-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b05950f4-f490-8874-79c4-169b900557d8@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/16] s390 vfio-ccw: Add bootindex
 property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com



On 03/01/2019 01:59 PM, Jason J. Herne wrote:
> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Refactor s390_get_ccw_device() to return device type. This prevents us from
> having to use messy casting logic in several places.
> 
> Signed-off-by: Jason J. Herne<jjherne@linux.ibm.com>
> Acked-by: Halil Pasic<pasic@linux.vnet.ibm.com>
> ---
>   MAINTAINERS                 |  1 +
>   hw/s390x/ipl.c              | 39 +++++++++++++++++++++++++++++++++------
>   hw/s390x/s390-ccw.c         |  9 +++++++++
>   hw/vfio/ccw.c               |  2 +-
>   include/hw/s390x/s390-ccw.h |  1 +
>   include/hw/s390x/vfio-ccw.h | 28 ++++++++++++++++++++++++++++
>   6 files changed, 73 insertions(+), 7 deletions(-)
>   create mode 100644 include/hw/s390x/vfio-ccw.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9a76845..a780916 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1400,6 +1400,7 @@ S: Supported
>   F: hw/vfio/ccw.c
>   F: hw/s390x/s390-ccw.c
>   F: include/hw/s390x/s390-ccw.h
> +F: include/hw/s390x/vfio-ccw.h
>   T: githttps://github.com/cohuck/qemu.git  s390-next
>   L:qemu-s390x@nongnu.org
>   
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 896888b..df891bb 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -19,6 +19,7 @@
>   #include "hw/loader.h"
>   #include "hw/boards.h"
>   #include "hw/s390x/virtio-ccw.h"
> +#include "hw/s390x/vfio-ccw.h"
>   #include "hw/s390x/css.h"
>   #include "hw/s390x/ebcdic.h"
>   #include "ipl.h"
> @@ -305,16 +306,29 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
>       *timeout = cpu_to_be32(splash_time);
>   }
>   
> -static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
> +#define CCW_DEVTYPE_NONE    0x00
> +#define CCW_DEVTYPE_VIRTIO  0x01
> +#define CCW_DEVTYPE_SCSI    0x02
> +#define CCW_DEVTYPE_VFIO    0x03
> +
> +static CcwDevice*s390_get_ccw_device(DeviceState *dev_st, int*  devtype)
>   {
>       CcwDevice *ccw_dev = NULL;
>   
> +    *devtype = CCW_DEVTYPE_NONE;
> +
>       if (dev_st) {
>           VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
>               object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
>                                   TYPE_VIRTIO_CCW_DEVICE);
> +        VFIOCCWDevice *vfio_ccw_dev = (VFIOCCWDevice *)
> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
>           if (virtio_ccw_dev) {
>               ccw_dev = CCW_DEVICE(virtio_ccw_dev);
> +            *devtype = CCW_DEVTYPE_VIRTIO;
> +        } else if (vfio_ccw_dev) {
> +            ccw_dev = CCW_DEVICE(vfio_ccw_dev);
> +            *devtype = CCW_DEVTYPE_VFIO;
>           } else {
>               SCSIDevice *sd = (SCSIDevice *)
>                   object_dynamic_cast(OBJECT(dev_st),
> @@ -327,6 +341,7 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
>   
>                   ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
>                                                              TYPE_CCW_DEVICE);
> +                *devtype = CCW_DEVTYPE_SCSI;
>               }
>           }
>       }
> @@ -337,10 +352,11 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>   {
>       DeviceState *dev_st;
>       CcwDevice *ccw_dev = NULL;
> +    int devtype;
>   
>       dev_st = get_boot_device(0);
>       if (dev_st) {
> -        ccw_dev = s390_get_ccw_device(dev_st);
> +        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
>       }
>   
>       /*
> @@ -349,8 +365,10 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>       if (ccw_dev) {
>           SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
>                                                               TYPE_SCSI_DEVICE);
> +        VirtIONet *vn;
>   
> -        if (sd) {
> +        switch (devtype) {
> +        case CCW_DEVTYPE_SCSI:
>               ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
>               ipl->iplb.blk0_len =
>                   cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
> @@ -360,8 +378,15 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>               ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
>               ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
>               ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
> -        } else {
> -            VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
> +            break;
> +        case CCW_DEVTYPE_VFIO:
> +            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
> +            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
> +            break;

Also for vfio-ccw we are not setting the ipl->iplb.blk0_len like we do 
for virtio. Is there a reason?

I know we don't reference the value in the bios for both virtio and vfio.

> +        case CCW_DEVTYPE_VIRTIO:
> +            vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
>                                                                 TYPE_VIRTIO_NET);
>   
>               ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> @@ -374,6 +399,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>               if (vn) {
>                   ipl->netboot = true;
>               }
> +            break;
>           }
