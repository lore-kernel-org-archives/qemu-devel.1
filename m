Received: from eggs.gnu.org ([2001:4830:134:3::10]:49389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXUAb-00080d-Fi
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXUAV-0005xs-IB
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:49:03 -0500
Date: Thu, 13 Dec 2018 17:48:49 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181213174849.64de85d4.cohuck@redhat.com>
In-Reply-To: <1544623878-11248-2-git-send-email-jjherne@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-2-git-send-email-jjherne@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Wed, 12 Dec 2018 09:11:04 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
> forward boot information into the bios for vfio-ccw devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c              | 15 +++++++++++++++
>  hw/s390x/s390-ccw.c         |  9 +++++++++
>  hw/vfio/ccw.c               | 13 +------------
>  include/hw/s390x/s390-ccw.h |  1 +
>  include/hw/s390x/vfio-ccw.h | 38 ++++++++++++++++++++++++++++++++++++++
>  roms/SLOF                   |  2 +-
>  6 files changed, 65 insertions(+), 13 deletions(-)
>  create mode 100644 include/hw/s390x/vfio-ccw.h
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 21f64ad..31592e7 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -19,6 +19,7 @@
>  #include "hw/loader.h"
>  #include "hw/boards.h"
>  #include "hw/s390x/virtio-ccw.h"
> +#include "hw/s390x/vfio-ccw.h"
>  #include "hw/s390x/css.h"
>  #include "hw/s390x/ebcdic.h"
>  #include "ipl.h"
> @@ -311,8 +312,13 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
>          VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
>              object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
>                                  TYPE_VIRTIO_CCW_DEVICE);
> +        VFIOCCWDevice *vc = (VFIOCCWDevice *)
> +            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
> +
>          if (virtio_ccw_dev) {
>              ccw_dev = CCW_DEVICE(virtio_ccw_dev);
> +        } else if (vc) {
> +            ccw_dev = CCW_DEVICE(vc);

Maybe call it "vfio_ccw_dev" instead? But that's definitely bikeshed
territory...

>          } else {
>              SCSIDevice *sd = (SCSIDevice *)
>                  object_dynamic_cast(OBJECT(dev_st),

You already pointed out the other problems yourself :)

Otherwise, looks good.
