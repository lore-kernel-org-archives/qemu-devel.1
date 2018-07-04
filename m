Received: from eggs.gnu.org ([2001:4830:134:3::10]:59727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faebH-0006b5-Cq
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1faebB-0000CL-F2
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 06:01:27 -0400
Date: Wed, 4 Jul 2018 12:01:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180704120108.5e975fd2.cohuck@redhat.com>
In-Reply-To: <1530312483-23864-4-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530312483-23864-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1530312483-23864-4-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 3/5] s390x/ap: base Adjunct Processor
 (AP) object model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, Tony Krowiak <akrowiak@linux.ibm.com>

On Fri, 29 Jun 2018 18:48:01 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Tony Krowiak <akrowiak@linux.ibm.com>

You may want to switch your sending address to this one as well.

> 
> Introduces the base object model for virtualizing AP devices.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  MAINTAINERS                  |   12 +++++++
>  hw/s390x/Makefile.objs       |    2 +
>  hw/s390x/ap-bridge.c         |   76 ++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/ap-device.c         |   39 +++++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c   |    4 ++
>  include/hw/s390x/ap-bridge.h |   37 ++++++++++++++++++++
>  include/hw/s390x/ap-device.h |   38 +++++++++++++++++++++
>  7 files changed, 208 insertions(+), 0 deletions(-)
>  create mode 100644 hw/s390x/ap-bridge.c
>  create mode 100644 hw/s390x/ap-device.c
>  create mode 100644 include/hw/s390x/ap-bridge.h
>  create mode 100644 include/hw/s390x/ap-device.h
> 

> diff --git a/hw/s390x/ap-bridge.c b/hw/s390x/ap-bridge.c
> new file mode 100644
> index 0000000..4f10425
> --- /dev/null
> +++ b/hw/s390x/ap-bridge.c
> @@ -0,0 +1,76 @@
> +/*
> + * ap bridge
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Halil Pasic <pasic@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "qemu/bitops.h"
> +#include "hw/s390x/ap-bridge.h"
> +#include "cpu.h"
> +
> +static char *vfio_ap_bus_get_dev_path(DeviceState *dev)
> +{
> +    /* at most one */
> +    return g_strdup_printf("/1");

Looks a bit odd... add 'ap'? Start counting with 0?

> +}
> +

(...)

> diff --git a/include/hw/s390x/ap-bridge.h b/include/hw/s390x/ap-bridge.h
> new file mode 100644
> index 0000000..7841ec2
> --- /dev/null
> +++ b/include/hw/s390x/ap-bridge.h
> @@ -0,0 +1,37 @@
> +/*
> + * ap bridge
> + *
> + * Copyright 2018 IBM Corp.
> + * Author(s): Halil Pasic <pasic@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.
> + */
> +
> +#ifndef HW_S390X_AP_BRIDGE_H
> +#define HW_S390X_AP_BRIDGE_H
> +#include "qom/object.h"
> +#include "hw/qdev-core.h"
> +#include "hw/sysbus.h"
> +
> +typedef struct APBridge {
> +    SysBusDevice sysbus_dev;
> +    bool css_dev_path;

Probable copy-and-paste error?

> +} APBridge;
> +
> +#define TYPE_AP_BRIDGE "ap-bridge"
> +#define AP_BRIDGE(obj) \
> +    OBJECT_CHECK(APBridge, (obj), TYPE_AP_BRIDGE)
> +
> +typedef struct VFIOAPBus {
> +    BusState parent_obj;
> +} VFIOAPBus;
> +
> +#define TYPE_VFIO_AP_BUS "vfio-ap-bus"
> +#define VFIO_AP_BUS(obj) \
> +     OBJECT_CHECK(VFIOAPBus, (obj), TYPE_VFIO_AP_BUS)
> +
> +void s390_init_ap(void);
> +
> +#endif

Else, looks sane to me.
