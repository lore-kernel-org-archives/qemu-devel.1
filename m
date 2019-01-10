Received: from eggs.gnu.org ([209.51.188.92]:40165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghd2w-0003LV-Kk
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghd2v-0001nE-Ox
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 11:19:06 -0500
Date: Thu, 10 Jan 2019 17:19:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190110171901.44dc95ee.cohuck@redhat.com>
In-Reply-To: <39e59802-2ba9-e621-c339-6f870cd58754@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-13-git-send-email-jjherne@linux.ibm.com>
	<20181214140428.6c677a48.cohuck@redhat.com>
	<39e59802-2ba9-e621-c339-6f870cd58754@linux.ibm.com>
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com

On Thu, 10 Jan 2019 11:12:47 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 12/14/18 8:04 AM, Cornelia Huck wrote:
> > On Wed, 12 Dec 2018 09:11:15 -0500
> > "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >   
> >> Now that we have a Channel I/O library let's modify virtio boot code to
> >> make use of it for running channel programs.
> >>
> >> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >> ---
> >>   pc-bios/s390-ccw/virtio.c | 21 ++-------------------
> >>   1 file changed, 2 insertions(+), 19 deletions(-)
> >>
> >> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> >> index aa9da72..5fb49e2 100644
> >> --- a/pc-bios/s390-ccw/virtio.c
> >> +++ b/pc-bios/s390-ccw/virtio.c
> >> @@ -92,30 +92,13 @@ int drain_irqs(SubChannelId schid)
> >>   static int run_ccw(VDev *vdev, int cmd, void *ptr, int len)
> >>   {
> >>       Ccw1 ccw = {};
> >> -    CmdOrb orb = {};
> >> -    int r;
> >> -
> >> -    enable_subchannel(vdev->schid);
> >> -
> >> -    /* start subchannel command */
> >> -    orb.fmt = 1;
> >> -    orb.cpa = (u32)(long)&ccw;
> >> -    orb.lpm = 0x80;
> >>   
> >>       ccw.cmd_code = cmd;
> >>       ccw.cda = (long)ptr;
> >>       ccw.count = len;
> >>   
> >> -    r = ssch(vdev->schid, &orb);
> >> -    /*
> >> -     * XXX Wait until device is done processing the CCW. For now we can
> >> -     *     assume that a simple tsch will have finished the CCW processing,
> >> -     *     but the architecture allows for asynchronous operation
> >> -     */
> >> -    if (!r) {
> >> -        r = drain_irqs(vdev->schid);
> >> -    }
> >> -    return r;
> >> +    enable_subchannel(vdev->schid);  
> > 
> > Preexisting, but I'm wondering why we enable the subchannel here and
> > not just once?
> >   
> >> +    return do_cio(vdev->schid, ptr2u32(&ccw), CCW_FMT1);
> >>   }
> >>   
> >>   static void vring_init(VRing *vr, VqInfo *info)  
> > 
> >   
> 
> Good question. It seems to be needed for the net-boot path. Here is the chain:
> 
> netmain.c : main()
> netmain,c : net_init()
> virtio-net.c : virtio_net_init()
> virtio.c : virtio_setup_ccw()
> virtio.c : run_ccw()
> 
> In this case the subchannel would not already be enabled. I suppose I *could* change it, 
> but at this point I'm trying to limit how much more code I'm touching :). This patch set 
> already touches a bit more code than I anticipated. Let me know what your thoughts are.

As it doesn't really hurt, I think we can defer this to later. Let's
not make this patch set bigger than needed :)
