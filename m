Received: from eggs.gnu.org ([209.51.188.92]:56252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqcjX-0007BQ-GE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqcfu-0002GD-SE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:44:34 -0500
Date: Mon, 4 Feb 2019 12:44:16 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190204124416.42a023bc.cohuck@redhat.com>
In-Reply-To: <1548768562-20007-13-git-send-email-jjherne@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-13-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/15] s390-bios: Refactor virtio to run
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

On Tue, 29 Jan 2019 08:29:19 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Now that we have a Channel I/O library let's modify virtio boot code to
> make use of it for running channel programs.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio.c | 48 +++++++++++++++++++----------------------------
>  1 file changed, 19 insertions(+), 29 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index aa9da72..f8d71ed 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -89,33 +89,20 @@ int drain_irqs(SubChannelId schid)
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
> +    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);

That still has the very odd pattern that you enable the subchannel
every time you run a channel program...

>  }
>  
>  static void vring_init(VRing *vr, VqInfo *info)
