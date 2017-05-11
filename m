Received: from eggs.gnu.org ([2001:4830:134:3::10]:39159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d8vPT-0002h4-Ex
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:14:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1d8vPO-0002gL-CN
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:14:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1d8vPO-0002ew-3j
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:14:02 -0400
Date: Thu, 11 May 2017 15:13:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170511151356.78516f2b@w520.home>
In-Reply-To: <20170505020352.8984-7-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-7-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 06/13] s390x/css: device support for
 s390-ccw passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, eric.auger@redhat.com

On Fri,  5 May 2017 04:03:45 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> In order to support subchannels pass-through, we introduce a s390
> subchannel device called "s390-ccw" to hold the real subchannel info.
> The s390-ccw devices inherit from the abstract CcwDevice which connect
> to the existing virtual-css-bus.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/s390x/Makefile.objs |   1 +
>  hw/s390x/s390-ccw.c    | 138 +++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/s390-ccw.h    |  38 ++++++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100644 hw/s390x/s390-ccw.c
>  create mode 100644 hw/s390x/s390-ccw.h
> 
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index 41ac4ec..72a3d37 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -13,3 +13,4 @@ obj-y += ccw-device.o
>  obj-y += s390-pci-bus.o s390-pci-inst.o
>  obj-y += s390-skeys.o
>  obj-$(CONFIG_KVM) += s390-skeys-kvm.o
> +obj-y += s390-ccw.o
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> new file mode 100644
> index 0000000..b1aadcd
> --- /dev/null
> +++ b/hw/s390x/s390-ccw.c
> @@ -0,0 +1,138 @@
> +/*
> + * s390 CCW Assignment Support
> + *
> + * Copyright 2017 IBM Corp
> + * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> + *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> + *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2
> + * or (at your option) any later version. See the COPYING file in the
> + * top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/sysbus.h"
> +#include "libgen.h"
> +#include "hw/s390x/css.h"
> +#include "hw/s390x/css-bridge.h"
> +#include "s390-ccw.h"
> +
> +static void s390_ccw_get_dev_info(S390CCWDevice *cdev,
> +                                  char *sysfsdev,
> +                                  Error **errp)
> +{
> +    unsigned int cssid, ssid, devid;
> +    char dev_path[PATH_MAX] = {0}, *tmp;
> +
> +    if (!sysfsdev) {
> +        error_setg(errp, "No host device provided");
> +        error_append_hint(errp,
> +                          "Use -device vfio-ccw,sysfsdev=PATH_TO_DEVICE\n");
> +        return;
> +    }
> +
> +    if (!realpath(sysfsdev, dev_path)) {
> +        error_setg_errno(errp, errno, "Host device '%s' not found", sysfsdev);
> +        return;
> +    }
> +
> +    cdev->mdevid = g_strdup(basename(dev_path));
> +
> +    tmp = basename(dirname(dev_path));
> +    sscanf(tmp, "%2x.%1x.%4x", &cssid, &ssid, &devid);


Seems like an oversight not to check this return value.


> +
> +    cdev->hostid.cssid = cssid;
> +    cdev->hostid.ssid = ssid;
> +    cdev->hostid.devid = devid;
> +    cdev->hostid.valid = true;
> +}
> +
