Received: from eggs.gnu.org ([2001:4830:134:3::10]:41802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSPYX-0003Rv-2X
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSPYT-00069Z-2c
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:52:49 -0500
Date: Thu, 29 Nov 2018 17:52:34 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181129175234.5e8d9f7b.cohuck@redhat.com>
In-Reply-To: <20181128173604.24b301a3@oc2783563651>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<20181128173604.24b301a3@oc2783563651>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] vfio-ccw: add handling
 for asnyc channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Wed, 28 Nov 2018 17:36:04 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 22 Nov 2018 17:54:32 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Add a region to the vfio-ccw device that can be used to submit
> > asynchronous I/O instructions. ssch continues to be handled by the
> > existing I/O region; the new region handles hsch and csch.
> > 
> > Interrupt status continues to be reported through the same channels
> > as for ssch.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  drivers/s390/cio/Makefile           |   3 +-
> >  drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
> >  drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
> >  drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
> >  drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
> >  drivers/s390/cio/vfio_ccw_private.h |   6 ++
> >  include/uapi/linux/vfio.h           |   4 +
> >  include/uapi/linux/vfio_ccw.h       |  12 +++
> >  8 files changed, 313 insertions(+), 19 deletions(-)
> >  create mode 100644 drivers/s390/cio/vfio_ccw_async.c

> > +static size_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
> > +					 char __user *buf, size_t count,
> > +					 loff_t *ppos)
> > +{
> > +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> > +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> > +	struct ccw_cmd_region *region;
> > +
> > +	if (pos + count > sizeof(*region))
> > +		return -EINVAL;
> > +
> > +	region = private->region[i].data;
> > +	if (copy_to_user(buf, (void *)region + pos, count))
> > +		return -EFAULT;
> > +
> > +	return count;
> > +
> > +}
> > +
> > +static size_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
> > +					  const char __user *buf, size_t count,
> > +					  loff_t *ppos)
> > +{
> > +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> > +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> > +	struct ccw_cmd_region *region;
> > +
> > +	if (pos + count > sizeof(*region))
> > +		return -EINVAL;
> > +
> > +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> > +	    private->state == VFIO_CCW_STATE_STANDBY)
> > +		return -EACCES;
> > +
> > +	region = private->region[i].data;
> > +	if (copy_from_user((void *)region + pos, buf, count))
> > +		return -EFAULT;  
> 
> I guess vfio_ccw_async_region_write() is supposed to be reentrant in a
> sense that there may be more that one 'instances' of the function
> executing at the same time, or am I wrong?
> 
> If it is reenarant, I wonder what protects private->region[i].data from
> corruption or simply being changed 'while at it'?

Interesting question. AFAICS this same issue applies to the existing
I/O region as well.

There's nothing in common code enforcing any exclusivity. If I
understand the code correctly, the common vfio-pci code reads/writes in
1/2/4 byte chunks for most accesses. There's igd code that does not do
that, though.

> 
> Regards,
> Halil
> 
> > +
> > +	switch (region->command) {
> > +	case VFIO_CCW_ASYNC_CMD_HSCH:
> > +		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_HALT_REQ);
> > +		break;
> > +	case VFIO_CCW_ASYNC_CMD_CSCH:
> > +		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLEAR_REQ);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return region->ret_code ? region->ret_code : count;
> > +}
> > +  
> 
