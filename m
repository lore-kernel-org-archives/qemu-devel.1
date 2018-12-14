Received: from eggs.gnu.org ([2001:4830:134:3::10]:60481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXn8v-0003aM-4d
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gXn8r-0006Nz-T8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:04:36 -0500
Date: Fri, 14 Dec 2018 14:04:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181214140428.6c677a48.cohuck@redhat.com>
In-Reply-To: <1544623878-11248-13-git-send-email-jjherne@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-13-git-send-email-jjherne@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On Wed, 12 Dec 2018 09:11:15 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Now that we have a Channel I/O library let's modify virtio boot code to
> make use of it for running channel programs.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/virtio.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index aa9da72..5fb49e2 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -92,30 +92,13 @@ int drain_irqs(SubChannelId schid)
>  static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
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
> -    }
> -    return r;
> +    enable_subchannel(vdev->schid);

Preexisting, but I'm wondering why we enable the subchannel here and
not just once?

> +    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);
>  }
>  
>  static void vring_init(VRing *vr, VqInfo *info)
