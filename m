Received: from eggs.gnu.org ([2001:4830:134:3::10]:41493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZIVI-0008BH-2r
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZIVD-0000Ld-Qv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 11:45:56 -0500
Date: Tue, 18 Dec 2018 17:45:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181218174521.331bf7bc.cohuck@redhat.com>
In-Reply-To: <ca97f673-621d-77c8-ed54-da2cebcf4a7c@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<ca97f673-621d-77c8-ed54-da2cebcf4a7c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 17 Dec 2018 16:54:31 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> > Add a region to the vfio-ccw device that can be used to submit
> > asynchronous I/O instructions. ssch continues to be handled by the
> > existing I/O region; the new region handles hsch and csch.
> > 
> > Interrupt status continues to be reported through the same channels
> > as for ssch.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/Makefile           |   3 +-
> >   drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
> >   drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
> >   drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
> >   drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
> >   drivers/s390/cio/vfio_ccw_private.h |   6 ++
> >   include/uapi/linux/vfio.h           |   4 +
> >   include/uapi/linux/vfio_ccw.h       |  12 +++
> >   8 files changed, 313 insertions(+), 19 deletions(-)
> >   create mode 100644 drivers/s390/cio/vfio_ccw_async.c

> > diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> > new file mode 100644
> > index 000000000000..8c7f51d17d70
> > --- /dev/null
> > +++ b/drivers/s390/cio/vfio_ccw_async.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Async I/O region for vfio_ccw
> > + *
> > + * Copyright Red Hat, Inc. 2018
> > + *
> > + * Author(s): Cornelia Huck <cohuck@redhat.com>
> > + */
> > +
> > +#include <linux/vfio.h>
> > +#include <linux/mdev.h>
> > +
> > +#include "vfio_ccw_private.h"
> > +
> > +static size_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,  
> 
> I think this should return ssize_t ?  (same for _write, below)

Yes, ssize_t makes more sense. Changed.

(vfio_pci_regops also has size_t; should probably be changed as well.)

> 
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
> > +
> > +	switch (region->command) {
> > +	case VFIO_CCW_ASYNC_CMD_HSCH:
> > +		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_HALT_REQ);
> > +		break;
> > +	case VFIO_CCW_ASYNC_CMD_CSCH:
> > +		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLEAR_REQ);
> > +		break;  
> 
> I find myself wondering why we add separate VFIO_CCW_EVENT_x_REQ entries 
> for HALT and CLEAR, rather than a single VFIO_CCW_EVENT_ASYNC_REQ and a 
> switch on cmd_region->command within it to go to fsm_do_halt, 
> fsm_do_clear, or whatever.

In the end, it probably does not matter much where we do the switch.
When I started writing this, I thought I would want to allow clear in
more states than halt; but that does not make much sense (best to let
the hardware sort it out; see also the other discussions around
concurrency.)

> 
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return region->ret_code ? region->ret_code : count;
> > +}

(...)

> > diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
> > index f94aa01f9c36..0caf77e8f377 100644
> > --- a/drivers/s390/cio/vfio_ccw_fsm.c
> > +++ b/drivers/s390/cio/vfio_ccw_fsm.c

> > @@ -102,6 +179,20 @@ static void fsm_io_busy(struct vfio_ccw_private *private,
> >   	private->io_region->ret_code = -EBUSY;
> >   }
> >   
> > +static void fsm_async_error(struct vfio_ccw_private *private,
> > +			    enum vfio_ccw_event event)
> > +{
> > +	pr_err("vfio-ccw: FSM: halt/clear request from state:%d\n",
> > +	       private->state);  
> 
> Worth stating whether it's a Halt or Clear here, rather than leaving it 
> ambiguous?

Not sure. Also not sure if we want to fold the events, as you suggested
above :)

This also reminds me that I need to rebase this: some details in the
handling will need to be different without the BOXED state.
