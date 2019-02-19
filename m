Received: from eggs.gnu.org ([209.51.188.92]:57155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gw3Ee-0003pD-6i
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gw3EV-00080R-WB
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 06:06:45 -0500
Date: Tue, 19 Feb 2019 12:06:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190219120630.5a2f3042.cohuck@redhat.com>
In-Reply-To: <2da327e8-d6cd-2350-31e1-d99edb0f2980@linux.ibm.com>
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190130132212.7376-5-cohuck@redhat.com>
	<2da327e8-d6cd-2350-31e1-d99edb0f2980@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/6] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 15 Feb 2019 10:46:08 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/30/2019 08:22 AM, Cornelia Huck wrote:
> > Allow to extend the regions used by vfio-ccw. The first user will be
> > handling of halt and clear subchannel.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   drivers/s390/cio/vfio_ccw_ops.c     | 181 ++++++++++++++++++++++++----
> >   drivers/s390/cio/vfio_ccw_private.h |  38 ++++++
> >   include/uapi/linux/vfio.h           |   2 +
> >   3 files changed, 195 insertions(+), 26 deletions(-)

(...)

> > @@ -237,9 +301,51 @@ static int vfio_ccw_mdev_get_region_info(struct vfio_region_info *info,
> >   		info->flags = VFIO_REGION_INFO_FLAG_READ
> >   			      | VFIO_REGION_INFO_FLAG_WRITE;
> >   		return 0;
> > -	default:
> > -		return -EINVAL;
> > +	default: /* all other regions are handled via capability chain */
> > +	{
> > +		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> > +		struct vfio_region_info_cap_type cap_type = {
> > +			.header.id = VFIO_REGION_INFO_CAP_TYPE,
> > +			.header.version = 1 };
> > +		int ret;
> > +
> > +		if (info->index >=
> > +		    VFIO_CCW_NUM_REGIONS + private->num_regions)
> > +			return -EINVAL;  
> 
> I notice the similarity of this hunk to drivers/vfio/pci/vfio_pci.c ... 
> While I was trying to discern the likelihood/possibility/usefulness of 
> combining the two, I noticed that there is one difference at this point 
> in the other file, which was added by commit 0e714d27786c ("vfio/pci: 
> Fix potential Spectre v1")
> 
> This got me off on a tangent of setting up smatch in my environment, and 
> sure enough it flags this point [1] as being problematic:
> 
> drivers/s390/cio/vfio_ccw_ops.c:328 vfio_ccw_mdev_get_region_info() 
> warn: potential spectre issue 'private->region' [r]

This makes sense, added.

> 
> Might need to consider the same?  (And lends credence to my concern 
> about the capability chain code being duplicated.)

Yeah, there's definitely duplication there. I initially tried to make
this use some common infrastructure, but I remember that it was harder
than it looked and that I stopped trying (don't remember the details,
sorry).

> 
> > +
> > +		i = info->index - VFIO_CCW_NUM_REGIONS;
> > +
> > +		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
> > +		info->size = private->region[i].size;  
> 
> [1] smatch actually points to this line, though the referenced commit 
> inserts a line up there.
> 
> > +		info->flags = private->region[i].flags;
> > +
> > +		cap_type.type = private->region[i].type;
> > +		cap_type.subtype = private->region[i].subtype;
> > +
> > +		ret = vfio_info_add_capability(&caps, &cap_type.header,
> > +					       sizeof(cap_type));
> > +		if (ret)
> > +			return ret;
> > +
> > +		info->flags |= VFIO_REGION_INFO_FLAG_CAPS;
> > +		if (info->argsz < sizeof(*info) + caps.size) {
> > +			info->argsz = sizeof(*info) + caps.size;
> > +			info->cap_offset = 0;
> > +		} else {
> > +			vfio_info_cap_shift(&caps, sizeof(*info));
> > +			if (copy_to_user((void __user *)arg + sizeof(*info),
> > +					 caps.buf, caps.size)) {
> > +				kfree(caps.buf);
> > +				return -EFAULT;
> > +			}
> > +			info->cap_offset = sizeof(*info);
> > +		}
> > +
> > +		kfree(caps.buf);
> > +
> > +	}
> >   	}
> > +	return 0;
> >   }

(...)

> > @@ -19,6 +21,38 @@
> >   #include "css.h"
> >   #include "vfio_ccw_cp.h"
> >   
> > +#define VFIO_CCW_OFFSET_SHIFT   40
> > +#define VFIO_CCW_OFFSET_TO_INDEX(off)	(off >> VFIO_CCW_OFFSET_SHIFT)
> > +#define VFIO_CCW_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_CCW_OFFSET_SHIFT)
> > +#define VFIO_CCW_OFFSET_MASK	(((u64)(1) << VFIO_CCW_OFFSET_SHIFT) - 1)  
> 
> I know Farhan asked this back in v1, but I'd still love a better answer 
> than "vfio-pci did this" to what this is.  There's a lot more regions 
> prior to the capability chain in vfio-pci than here (9 versus 1), so I'd 
> like to be certain it's not related to that.

If we assume that we'll only add new regions via the capability chain
(and I think we can assume that), we can probably change that value. I
tried with a value of 10 (should be enough) and things still seem to
work, so that might be a nice, round value.

(...)

> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 02bb7ad6e986..56e2413d3e00 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -353,6 +353,8 @@ struct vfio_region_gfx_edid {
> >   #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
> >   };
> >   
> > +#define VFIO_REGION_TYPE_CCW			(2)
> > +  
> 
> I'm not sure if this should be here to keep it in its own area (esp. for 
> when patch 6 comes along), or with VFIO_REGION_TYPE_GFX to make it 
> noticeable where we are in the list without grepping for 
> VFIO_REGION_TYPE.  I guess it's just what it is, even if I'm not 
> thrilled about it.

I'm not really sure where it makes the most sense to put it, TBH. Maybe
it should be moved below the recently added nvlink stuff? My idea was
to keep the subtype (added in patch 6) close to the type; but they can
easily move to a different place in the file.

> 
> >   /*
> >    * 10de vendor sub-type
> >    *
> >   
> 
> This generally looks sane to me, even though I can't get past the idea 
> that there's opportunities for improvement between the two.  Maybe 
> that's refactoring for a day when someone is bored.  ;-)

Yeah, if someone has time, they could try to refactor :) I'm not sure
what made it complicated when I first tried it, maybe I should try
again ;)

Thanks for looking!
