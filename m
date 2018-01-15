Received: from eggs.gnu.org ([2001:4830:134:3::10]:59194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eb3oW-0006iO-5d
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:24:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eb3oS-0006IN-6Z
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:24:32 -0500
Date: Mon, 15 Jan 2018 13:24:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180115132422.6a1a805d.cohuck@redhat.com>
In-Reply-To: <82e00fe3-22be-c4df-60c9-8348906d8c45@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<20180111030421.31418-2-bjsdjshi@linux.vnet.ibm.com>
	<82e00fe3-22be-c4df-60c9-8348906d8c45@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/3] vfio: ccw: introduce schib region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com

On Mon, 15 Jan 2018 10:50:00 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 11/01/2018 04:04, Dong Jia Shi wrote:
> > This introduces a new region for vfio-ccw to provide subchannel
> > information for user space.
> >
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_fsm.c     | 21 ++++++++++
> >   drivers/s390/cio/vfio_ccw_ops.c     | 79 +++++++++++++++++++++++++++----------
> >   drivers/s390/cio/vfio_ccw_private.h |  3 ++
> >   include/uapi/linux/vfio.h           |  1 +
> >   include/uapi/linux/vfio_ccw.h       |  6 +++
> >   5 files changed, 90 insertions(+), 20 deletions(-)
> >

> > diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> > index 78a66d96756b..460c8b90d834 100644
> > --- a/drivers/s390/cio/vfio_ccw_private.h
> > +++ b/drivers/s390/cio/vfio_ccw_private.h
> > @@ -28,6 +28,7 @@
> >    * @mdev: pointer to the mediated device
> >    * @nb: notifier for vfio events
> >    * @io_region: MMIO region to input/output I/O arguments/results
> > + * @schib_region: MMIO region of subchannel information
> >    * @cp: channel program for the current I/O operation
> >    * @irb: irb info received from interrupt
> >    * @scsw: scsw info
> > @@ -42,6 +43,7 @@ struct vfio_ccw_private {
> >   	struct mdev_device	*mdev;
> >   	struct notifier_block	nb;
> >   	struct ccw_io_region	io_region;
> > +	struct ccw_schib_region	schib_region;
> >
> >   	struct channel_program	cp;
> >   	struct irb		irb;  
> 
> Hi,
> 
> I have a problem with these patches: you have 3 definitions for the 
> subchannel status word:
> 1: direct in the scsw entry of the vfio_ccw_private structure
> 2: indirect in the IRB structure irb
> 3: now in the scsw of the schib_region
> 
> How do you keep them all in sync?
> 
> The direct scsw in io region seems to only serve as a trigger used by 
> userland, while
> the IRB in the io region and the SCHIB in the schib region are updated 
> asynchronously,
> from hardware, one by polling (scsw in schib region), one by IRQ (scsw 
> in irb in io region).
> 
> I find this at least a source for obfuscation.

I agree that this wants some more documentation.

However, some of this structure duplication is a consequence of the
hardware design, because the scsw is present in both the schib (updated
by stsch) and the irb (updated by tsch). There are cases where the irb
is simply not enough (it does not contain a pmcw, and you can only do
tsch on an enabled subchannel). So I think that we really need two
structures for those two distinct operations (and everything
interfacing with this needs to keep synced on the scsw, as current
users of stsch/tsch already need to do now).

The direct scsw entry is used for initiating the different functions
(only start right now), I don't really see a good alternative for that
(and I also don't really see any problem with needed syncing.)
