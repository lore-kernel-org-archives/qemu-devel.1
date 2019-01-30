Received: from eggs.gnu.org ([209.51.188.92]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1goyEv-0004LJ-FS
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1goyEu-000547-Hk
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:21:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55744
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1goyEu-00052m-CI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 17:21:48 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0UMK9bi054486
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 17:21:47 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qbj845p6w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 17:21:47 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 30 Jan 2019 22:21:46 -0000
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 30 Jan 2019 17:21:39 -0500
MIME-Version: 1.0
In-Reply-To: <1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <18fcb6cc-01aa-3461-6595-85e946b77bc7@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 01/15] s390 vfio-ccw: Add bootindex
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



On 01/29/2019 08:29 AM, Jason J. Herne wrote:
> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Signed-off-by: Jason J. Herne<jjherne@linux.ibm.com>
> Acked-by: Halil Pasic<pasic@linux.vnet.ibm.com>
> ---
>   hw/s390x/ipl.c              | 14 ++++++++++++++
>   hw/s390x/s390-ccw.c         |  9 +++++++++
>   hw/vfio/ccw.c               | 13 +------------
>   include/hw/s390x/s390-ccw.h |  1 +
>   include/hw/s390x/vfio-ccw.h | 38 ++++++++++++++++++++++++++++++++++++++
>   5 files changed, 63 insertions(+), 12 deletions(-)
>   create mode 100644 include/hw/s390x/vfio-ccw.h
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 21f64ad..a993f65 100644
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
> @@ -311,8 +312,12 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
>           VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
>               object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
>                                   TYPE_VIRTIO_CCW_DEVICE);
> +        VFIOCCWDevice *vfio_ccw_dev = (VFIOCCWDevice *)
> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
>           if (virtio_ccw_dev) {
>               ccw_dev = CCW_DEVICE(virtio_ccw_dev);
> +        } else if (vfio_ccw_dev) {
> +            ccw_dev = CCW_DEVICE(vfio_ccw_dev);
>           } else {
>               SCSIDevice *sd = (SCSIDevice *)
>                   object_dynamic_cast(OBJECT(dev_st),
> @@ -347,6 +352,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>       if (ccw_dev) {
>           SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
>                                                               TYPE_SCSI_DEVICE);
> +        VFIOCCWDevice *vc = (VFIOCCWDevice *)
> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
>   
>           if (sd) {
>               ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
> @@ -358,6 +365,13 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>               ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
>               ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
>               ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
> +        } else if (vc) {
> +            CcwDevice *ccw_dev = CCW_DEVICE(vc);

Do we need this line here? I though ccw_dev was already correctly casted 
in s390_get_ccw_device?

> +
> +            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
> +            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
> +            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
> +            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
>           } else {
>               VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
>                                                                 TYPE_VIRTIO_NET);
