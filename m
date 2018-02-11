Received: from eggs.gnu.org ([2001:4830:134:3::10]:44163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ekhXA-0003dz-FD
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 21:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ekhX6-0000Gu-Ne
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 21:38:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ekhX6-0000Fk-Ih
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 21:38:24 -0500
Date: Sun, 11 Feb 2018 10:38:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180211023812.GG2783@xz-mi>
References: <20180207001615.1156.10547.stgit@gimli.home>
	<20180207002646.1156.37051.stgit@gimli.home>
	<20180209071145.GE2783@xz-mi> <20180209150933.658881ed@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180209150933.658881ed@w520.home>
Subject: Re: [Qemu-devel] [RFC PATCH 5/5] vfio/quirks: Enable ioeventfd
 quirks to be handled by vfio directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Fri, Feb 09, 2018 at 03:09:33PM -0700, Alex Williamson wrote:
> On Fri, 9 Feb 2018 15:11:45 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, Feb 06, 2018 at 05:26:46PM -0700, Alex Williamson wrote:
> > > With vfio ioeventfd support, we can program vfio-pci to perform a
> > > specified BAR write when an eventfd is triggered.  This allows the
> > > KVM ioeventfd to be wired directly to vfio-pci, entirely avoiding
> > > userspace handling for these events.  On the same micro-benchmark
> > > where the ioeventfd got us to almost 90% of performance versus
> > > disabling the GeForce quirks, this gets us to within 95%.
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > >  hw/vfio/pci-quirks.c |   42 ++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 36 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > > index e739efe601b1..35a4d5197e2d 100644
> > > --- a/hw/vfio/pci-quirks.c
> > > +++ b/hw/vfio/pci-quirks.c
> > > @@ -16,6 +16,7 @@
> > >  #include "qemu/range.h"
> > >  #include "qapi/error.h"
> > >  #include "qapi/visitor.h"
> > > +#include <sys/ioctl.h>
> > >  #include "hw/nvram/fw_cfg.h"
> > >  #include "pci.h"
> > >  #include "trace.h"
> > > @@ -287,13 +288,27 @@ static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
> > >      return quirk;
> > >  }
> > >  
> > > -static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
> > > +static void vfio_ioeventfd_exit(VFIOPCIDevice *vdev, VFIOIOEventFD *ioeventfd)
> > >  {
> > > +    struct vfio_device_ioeventfd vfio_ioeventfd;
> > > +
> > >      QLIST_REMOVE(ioeventfd, next);
> > > +
> > >      memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
> > >                                ioeventfd->match_data, ioeventfd->data,
> > >                                &ioeventfd->e);
> > > +
> > >      qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e), NULL, NULL, NULL);
> > > +
> > > +    vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
> > > +    vfio_ioeventfd.flags = ioeventfd->size;
> > > +    vfio_ioeventfd.data = ioeventfd->data;
> > > +    vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
> > > +                            ioeventfd->region_addr;
> > > +    vfio_ioeventfd.fd = -1;
> > > +
> > > +    ioctl(vdev->vbasedev.fd, VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);
> > > +
> > >      event_notifier_cleanup(&ioeventfd->e);
> > >      g_free(ioeventfd);
> > >  }
> > > @@ -315,6 +330,8 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
> > >                                            hwaddr region_addr)
> > >  {
> > >      VFIOIOEventFD *ioeventfd = g_malloc0(sizeof(*ioeventfd));
> > > +    struct vfio_device_ioeventfd vfio_ioeventfd;
> > > +    char vfio_enabled = '+';
> > >  
> > >      if (event_notifier_init(&ioeventfd->e, 0)) {
> > >          g_free(ioeventfd);
> > > @@ -329,15 +346,28 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
> > >      ioeventfd->region = region;
> > >      ioeventfd->region_addr = region_addr;
> > >  
> > > -    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
> > > -                        vfio_ioeventfd_handler, NULL, ioeventfd);
> > > +    vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
> > > +    vfio_ioeventfd.flags = ioeventfd->size;
> > > +    vfio_ioeventfd.data = ioeventfd->data;
> > > +    vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
> > > +                            ioeventfd->region_addr;
> > > +    vfio_ioeventfd.fd = event_notifier_get_fd(&ioeventfd->e);
> > > +
> > > +    if (ioctl(vdev->vbasedev.fd,
> > > +              VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd) != 0) {
> > > +        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
> > > +                            vfio_ioeventfd_handler, NULL, ioeventfd);
> > > +        vfio_enabled = '-';  
> > 
> > Would the performance be even slower if a new QEMU runs on a old
> > kernel due to these ioeventfds (MMIO -> eventfd -> same MMIO again)?
> > If so, shall we only enable this ioeventfd enhancement only if we
> > detected that the kernel supports this new feature (assuming this
> > feature bit won't change after VM starts)?
> 
> No, it's actually still a significant improvement to enable the KVM
> ioeventfd even if we can't enable vfio.  My testing shows that the KVM
> ioeventfd alone accounts for slightly more than half of the total
> improvement, so I don't see any reason to restrict this to depending on
> both ends being available.  Thanks,

The numbers (83%->90%->95%) were mentioned in different patches but I
didn't really catch all of them.  Sorry.

And obviously the userspace code path is different, which I missed
too.  And it makes sense that ioeventfd should always be faster.

Thanks,

-- 
Peter Xu
