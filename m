Received: from eggs.gnu.org ([2001:4830:134:3::10]:50878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRDfL-0005Ff-7l
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRDfJ-0001PS-TF
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:58:55 -0500
Date: Mon, 26 Nov 2018 10:58:43 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181126105843.2efa2d06.cohuck@redhat.com>
In-Reply-To: <8fbbe0b6-6924-ad61-1d94-26517765f346@linux.ibm.com>
References: <20181122165457.4517-1-cohuck@redhat.com>
	<20181122165457.4517-3-cohuck@redhat.com>
	<8fbbe0b6-6924-ad61-1d94-26517765f346@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio-ccw: support async command
 subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 23 Nov 2018 15:13:12 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 22/11/2018 17:54, Cornelia Huck wrote:
> > A vfio-ccw device may provide an async command subregion for
> > issuing halt/clear subchannel requests. If it is present, use
> > it for sending halt/clear request to the device; if not, fall
> > back to emulation (as done today).
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   hw/s390x/css.c              |  27 +++++++--
> >   hw/vfio/ccw.c               | 109 +++++++++++++++++++++++++++++++++++-
> >   include/hw/s390x/s390-ccw.h |   3 +
> >   3 files changed, 133 insertions(+), 6 deletions(-)
> > 

> > @@ -114,6 +120,87 @@ again:
> >       }
> >   }
> >   
> > +int vfio_ccw_handle_clear(SubchDev *sch)
> > +{
> > +    S390CCWDevice *cdev = sch->driver_data;
> > +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> > +    struct ccw_cmd_region *region = vcdev->async_cmd_region;
> > +    int ret;
> > +
> > +    if (!vcdev->async_cmd_region) {
> > +        /* Async command region not available, fall back to emulation */
> > +        return -ENOSYS;
> > +    }
> > +
> > +    memset(region, 0, sizeof(*region));
> > +    region->command = VFIO_CCW_ASYNC_CMD_CSCH;
> > +
> > +again:
> > +    ret = pwrite(vcdev->vdev.fd, region,
> > +                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_offset);
> > +    if (ret != vcdev->async_cmd_region_size) {
> > +        if (errno == EAGAIN) {  
> 
> 
> Where do the EAGAIN come from?

It might be set by pwrite.

> 
> 
> > +            goto again;
> > +        }
> > +        error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);

I should also fix up this message here and for hsch as well :)

> > +        ret = -errno;
> > +    } else {
> > +        ret = region->ret_code;
> > +    }
> > +    switch (ret) {
> > +    case 0:
> > +    case -ENODEV:
> > +    case -EACCES:  
> 
> should never happen?

It should not happen; but it can nevertheless be returned, so...

> 
> > +        return 0;
> > +    case -EFAULT:
> > +    default:
> > +        sch_gen_unit_exception(sch);
> > +        css_inject_io_interrupt(sch);
> > +        return 0;
> > +    }
> > +}
> > +  
> 
> otherwise LGTM

Thanks!
