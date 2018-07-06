Received: from eggs.gnu.org ([2001:4830:134:3::10]:49081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbLEz-0007Db-3z
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fbLEy-0001Uj-5n
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 03:33:17 -0400
Date: Fri, 6 Jul 2018 09:33:11 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180706093311.726797f2.cohuck@redhat.com>
In-Reply-To: <1530811543-6881-2-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-2-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 01/15] s390 vfio-ccw: Add bootindex property
 and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Thu,  5 Jul 2018 13:25:29 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  hw/s390x/ipl.c              | 15 +++++++++++++++
>  hw/s390x/s390-ccw.c         |  9 +++++++++
>  hw/vfio/ccw.c               | 13 +------------
>  hw/vfio/ccw.h               | 38 ++++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/s390-ccw.h |  1 +
>  5 files changed, 64 insertions(+), 12 deletions(-)
>  create mode 100644 hw/vfio/ccw.h

> diff --git a/hw/vfio/ccw.h b/hw/vfio/ccw.h
> new file mode 100644
> index 0000000..a7d699d
> --- /dev/null
> +++ b/hw/vfio/ccw.h

Put this under include/hw/s390x/ ?

> @@ -0,0 +1,38 @@
> +/*
> + * vfio based subchannel assignment support
> + *
> + * Copyright 2018 IBM Corp.
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
> +
> +#define TYPE_VFIO_CCW "vfio-ccw"
> +typedef struct VFIOCCWDevice {
> +    S390CCWDevice cdev;
> +    VFIODevice vdev;
> +    uint64_t io_region_size;
> +    uint64_t io_region_offset;
> +    struct ccw_io_region *io_region;
> +    EventNotifier io_notifier;
> +    bool force_orb_pfch;
> +    bool warned_orb_pfch;
> +} VFIOCCWDevice;
> +
> +#endif
