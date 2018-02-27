Received: from eggs.gnu.org ([2001:4830:134:3::10]:49298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqih1-0001SY-Hg
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqigy-0001j8-BV
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:05:31 -0500
Date: Tue, 27 Feb 2018 18:04:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180227180458.64ea3d61.cohuck@redhat.com>
In-Reply-To: <1519746259-27710-5-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-5-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/5] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On Tue, 27 Feb 2018 10:44:18 -0500
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Introduces a VFIO based AP device. The device is defined via
> the QEMU command line by specifying:
> 
>     -device vfio-ap,sysfsdev=<path-to-mediated-matrix-device>
> 
> The mediated matrix device is created by the VFIO AP device
> driver by writing a UUID to a sysfs attribute file (see
> docs/vfio-ap.txt). The mediated matrix device will be named
> after the UUID. Symbolic links to the $uuid are created in
> many places, so the path to the mediated matrix device $uuid
> can be specified in any of the following ways:
> 
> /sys/devices/vfio_ap/matrix/$uuid
> /sys/devices/vfio_ap/matrix/mdev_supported_types/vfio_ap-passthrough/devices/$uuid
> /sys/bus/mdev/devices/$uuid
> /sys/bus/mdev/drivers/vfio_mdev/$uuid
> 
> When the vfio-ap device is realized, it acquires and opens the
> VFIO iommu group to which the mediated matrix device is
> bound. This causes a VFIO group notification event to be
> signaled. The vfio_ap device driver's group notification
> handler will get called at which time the device driver
> will configure the the AP devices to which the guest will
> be granted access.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  default-configs/s390x-softmmu.mak |    1 +
>  hw/vfio/Makefile.objs             |    1 +
>  hw/vfio/ap.c                      |  167 +++++++++++++++++++++++++++++++++++++
>  include/hw/vfio/vfio-common.h     |    1 +
>  4 files changed, 170 insertions(+), 0 deletions(-)
>  create mode 100644 hw/vfio/ap.c
> 

> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> new file mode 100644
> index 0000000..8aa5221
> --- /dev/null
> +++ b/hw/vfio/ap.c
> @@ -0,0 +1,167 @@
> +/*
> + * VFIO based AP matrix device assignment
> + *
> + * Copyright 2017 IBM Corp.

Happy new year?

[Also the other new files, here and in the Linux part.]

> + * Author(s): Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or(at
> + * your option) any version. See the COPYING file in the top-level

That probably should be "any later version" (I'm not even sure what GPL
v1 says :)

And I just noticed that the vfio-ccw code has the same problem...

> + * directory.
> + */
> +
> +#include <linux/vfio.h>
> +#include <sys/ioctl.h>
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "hw/vfio/vfio.h"
> +#include "hw/vfio/vfio-common.h"
> +#include "hw/s390x/ap-device.h"
> +#include "qemu/error-report.h"
> +#include "qemu/queue.h"
> +
> +#define VFIO_AP_DEVICE_TYPE      "vfio-ap"
> +#define AP_SYSFSDEV_PROP_NAME    "sysfsdev"

Using a #define for a property name seems unusual (and I think it
decreases readability).

Otherwise, looks fine (on first read-through).
