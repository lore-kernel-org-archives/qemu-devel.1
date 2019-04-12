Received: from eggs.gnu.org ([209.51.188.92]:46947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEtZo-0001U7-3s
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEtZm-0004oS-UM
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:38:32 -0400
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
	<1554388475-18329-2-git-send-email-jjherne@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f70b7eea-c72c-e8d4-8a91-ec999c45ee09@redhat.com>
Date: Fri, 12 Apr 2019 12:38:25 +0200
MIME-Version: 1.0
In-Reply-To: <1554388475-18329-2-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 01/16] s390 vfio-ccw: Add bootindex
 property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 04/04/2019 16.34, Jason J. Herne wrote:
> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Refactor s390_get_ccw_device() to return device type. This prevents us from
> having to use messy casting logic in several places.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
[...]
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 9246729..507d513 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -21,11 +21,11 @@
>  #include "hw/vfio/vfio.h"
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/s390x/s390-ccw.h"
> +#include "hw/s390x/vfio-ccw.h"
>  #include "hw/s390x/ccw-device.h"
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
>  
> -#define TYPE_VFIO_CCW "vfio-ccw"
>  typedef struct VFIOCCWDevice {
>      S390CCWDevice cdev;
>      VFIODevice vdev;
> diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
> index 7d15a1a..901d805 100644
> --- a/include/hw/s390x/s390-ccw.h
> +++ b/include/hw/s390x/s390-ccw.h
> @@ -27,6 +27,7 @@ typedef struct S390CCWDevice {
>      CcwDevice parent_obj;
>      CssDevId hostid;
>      char *mdevid;
> +    int32_t bootindex;
>  } S390CCWDevice;
>  
>  typedef struct S390CCWDeviceClass {
> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
> new file mode 100644
> index 0000000..ee5250d
> --- /dev/null
> +++ b/include/hw/s390x/vfio-ccw.h
> @@ -0,0 +1,28 @@
> +/*
> + * vfio based subchannel assignment support
> + *
> + * Copyright 2017, 2019 IBM Corp.
> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef HW_VFIO_CCW_H
> +#define HW_VFIO_CCW_H
> +
> +#include "hw/vfio/vfio-common.h"
> +#include "hw/s390x/s390-ccw.h"
> +#include "hw/s390x/ccw-device.h"
> +
> +#define TYPE_VFIO_CCW "vfio-ccw"
> +#define VFIO_CCW(obj) \
> +        OBJECT_CHECK(VFIOCCWDevice, (obj), TYPE_VFIO_CCW)
> +
> +#define TYPE_VFIO_CCW "vfio-ccw"
> +typedef struct VFIOCCWDevice VFIOCCWDevice;
> +
> +#endif
> 

This causes a build failure with clang:

 https://gitlab.com/huth/qemu/-/jobs/195530081

I'll squash the following patch to fix this issue:

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e6ac21d006..31dd3a2a87 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -26,7 +26,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"

-typedef struct VFIOCCWDevice {
+struct VFIOCCWDevice {
     S390CCWDevice cdev;
     VFIODevice vdev;
     uint64_t io_region_size;
@@ -35,7 +35,7 @@ typedef struct VFIOCCWDevice {
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
-} VFIOCCWDevice;
+};


 Thomas
