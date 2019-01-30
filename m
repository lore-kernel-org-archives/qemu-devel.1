Received: from eggs.gnu.org ([209.51.188.92]:59218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gotAT-0007TG-BV
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gotAS-0004Tx-IB
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 11:56:53 -0500
Date: Wed, 30 Jan 2019 17:56:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190130175647.6a99ed62.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Tue, 29 Jan 2019 08:29:08 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c              | 14 ++++++++++++++
>  hw/s390x/s390-ccw.c         |  9 +++++++++
>  hw/vfio/ccw.c               | 13 +------------
>  include/hw/s390x/s390-ccw.h |  1 +
>  include/hw/s390x/vfio-ccw.h | 38 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 63 insertions(+), 12 deletions(-)
>  create mode 100644 include/hw/s390x/vfio-ccw.h

> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
> new file mode 100644
> index 0000000..a7d699d
> --- /dev/null
> +++ b/include/hw/s390x/vfio-ccw.h
> @@ -0,0 +1,38 @@
> +/*
> + * vfio based subchannel assignment support
> + *
> + * Copyright 2018 IBM Corp.

Why 2018? Should either be 2017 (the original date for hw/vfio/ccw.c)
or 2019.

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
