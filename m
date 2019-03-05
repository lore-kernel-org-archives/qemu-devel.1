Received: from eggs.gnu.org ([209.51.188.92]:52480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h19Dt-0004yb-05
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h19Ds-0004Kn-53
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 07:31:04 -0500
Date: Tue, 5 Mar 2019 13:30:58 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190305133058.536c2eeb.cohuck@redhat.com>
In-Reply-To: <1551466776-29123-13-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
	<1551466776-29123-13-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/16] s390-bios: Refactor virtio to run
 channel programs via cio
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

On Fri,  1 Mar 2019 13:59:32 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Now that we have a Channel I/O library let's modify virtio boot code to
> make use of it for running channel programs.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio.c | 49 +++++++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index aa9da72..711daf5 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -14,6 +14,7 @@
>  #include "virtio.h"
>  #include "virtio-scsi.h"
>  #include "bswap.h"
> +#include "helper.h"
>  
>  #define VRING_WAIT_REPLY_TIMEOUT 30
>  
> @@ -89,33 +90,20 @@ int drain_irqs(SubChannelId schid)
>      }
>  }
>  
> -static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
> +static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
>  {
>      Ccw1 ccw = {};
> -    CmdOrb orb = {};
> -    int r;
> -
> -    enable_subchannel(vdev->schid);
> -
> -    /* start subchannel command */
> -    orb.fmt = 1;
> -    orb.cpa = (u32)(long)&ccw;
> -    orb.lpm = 0x80;
>  
>      ccw.cmd_code = cmd;
>      ccw.cda = (long)ptr;
>      ccw.count = len;
>  
> -    r = ssch(vdev->schid, &orb);
> -    /*
> -     * XXX Wait until device is done processing the CCW. For now we can
> -     *     assume that a simple tsch will have finished the CCW processing,
> -     *     but the architecture allows for asynchronous operation
> -     */
> -    if (!r) {
> -        r = drain_irqs(vdev->schid);
> +    if (sli) {
> +        ccw.flags |= CCW_FLAG_SLI;
>      }
> -    return r;
> +
> +    enable_subchannel(vdev->schid);

As said, maybe just move this to the main routine, instead of having to
call this here again and again.

> +    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);
>  }
>  
>  static void vring_init(VRing *vr, VqInfo *info)

(...)

> @@ -324,7 +314,8 @@ bool virtio_is_supported(SubChannelId schid)
>      vdev.schid = schid;
>      memset(&vdev.senseid, 0, sizeof(vdev.senseid));
>      /* run sense id command */
> -    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid))) {
> +    if (run_ccw(&vdev, CCW_CMD_SENSE_ID, &vdev.senseid, sizeof(vdev.senseid),
> +                true)) {
>          return false;
>      }
>      if (vdev.senseid.cu_type == 0x3832) {

Can't you use the new routine for obtaining the cu type here?
