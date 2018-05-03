Received: from eggs.gnu.org ([2001:4830:134:3::10]:37345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fEH83-0004ys-43
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fEH7z-0005YE-SN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:30:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fEH7z-0005Xo-NC
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:30:43 -0400
Date: Thu, 3 May 2018 10:30:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180503103034.50cdd58d@w520.home>
In-Reply-To: <53a51b7e-49df-f0f7-00d6-353823750ae8@redhat.com>
References: <20180501162901.28940.1075.stgit@gimli.home>
	<20180501164346.28940.93328.stgit@gimli.home>
	<53a51b7e-49df-f0f7-00d6-353823750ae8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] vfio/quirks: Enable ioeventfd
 quirks to be handled by vfio directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, kvm@vger.kernel.org

On Thu, 3 May 2018 17:20:18 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Alex,
> 
> On 05/01/2018 06:43 PM, Alex Williamson wrote:
> > With vfio ioeventfd support, we can program vfio-pci to perform a
> > specified BAR write when an eventfd is triggered.  This allows the
> > KVM ioeventfd to be wired directly to vfio-pci, entirely avoiding
> > userspace handling for these events.  On the same micro-benchmark
> > where the ioeventfd got us to almost 90% of performance versus
> > disabling the GeForce quirks, this gets us to within 95%.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  hw/vfio/pci-quirks.c |   50 +++++++++++++++++++++++++++++++++++++++++++-------
> >  hw/vfio/pci.c        |    2 ++
> >  hw/vfio/pci.h        |    2 ++
> >  hw/vfio/trace-events |    2 +-
> >  4 files changed, 48 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index 4cedc733bc0a..94be27dd0a3b 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -16,6 +16,7 @@
> >  #include "qemu/range.h"
> >  #include "qapi/error.h"
> >  #include "qapi/visitor.h"
> > +#include <sys/ioctl.h>
> >  #include "hw/nvram/fw_cfg.h"
> >  #include "pci.h"
> >  #include "trace.h"
> > @@ -287,13 +288,31 @@ static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
> >      return quirk;
> >  }
> >  
> > -static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
> > +static void vfio_ioeventfd_exit(VFIOPCIDevice *vdev, VFIOIOEventFD *ioeventfd)
> >  {
> >      QLIST_REMOVE(ioeventfd, next);
> > +  
> nit: unrelated new line

Fixed

> >      memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
> >                                ioeventfd->match_data, ioeventfd->data,
> >                                &ioeventfd->e);
> > -    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e), NULL, NULL, NULL);
> > +
> > +    if (ioeventfd->vfio) {
> > +        struct vfio_device_ioeventfd vfio_ioeventfd;
> > +
> > +        vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
> > +        vfio_ioeventfd.flags = ioeventfd->size;
> > +        vfio_ioeventfd.data = ioeventfd->data;
> > +        vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
> > +                                ioeventfd->region_addr;
> > +        vfio_ioeventfd.fd = -1;
> > +
> > +        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);
> > +
> > +    } else {
> > +        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
> > +                            NULL, NULL, NULL);
> > +    }
> > +
> >      event_notifier_cleanup(&ioeventfd->e);
> >      trace_vfio_ioeventfd_exit(memory_region_name(ioeventfd->mr),
> >                                (uint64_t)ioeventfd->addr, ioeventfd->size,
> > @@ -307,7 +326,7 @@ static void vfio_drop_dynamic_eventfds(VFIOPCIDevice *vdev, VFIOQuirk *quirk)
> >  
> >      QLIST_FOREACH_SAFE(ioeventfd, &quirk->ioeventfds, next, tmp) {
> >          if (ioeventfd->dynamic) {
> > -            vfio_ioeventfd_exit(ioeventfd);
> > +            vfio_ioeventfd_exit(vdev, ioeventfd);
> >          }
> >      }
> >  }
> > @@ -361,13 +380,30 @@ static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
> >      ioeventfd->region = region;
> >      ioeventfd->region_addr = region_addr;
> >  
> > -    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
> > -                        vfio_ioeventfd_handler, NULL, ioeventfd);
> > +    if (!vdev->no_vfio_ioeventfd) {
> > +        struct vfio_device_ioeventfd vfio_ioeventfd;
> > +
> > +        vfio_ioeventfd.argsz = sizeof(vfio_ioeventfd);
> > +        vfio_ioeventfd.flags = ioeventfd->size;
> > +        vfio_ioeventfd.data = ioeventfd->data;
> > +        vfio_ioeventfd.offset = ioeventfd->region->fd_offset +
> > +                                ioeventfd->region_addr;
> > +        vfio_ioeventfd.fd = event_notifier_get_fd(&ioeventfd->e);
> > +
> > +        ioeventfd->vfio = !ioctl(vdev->vbasedev.fd,
> > +                                 VFIO_DEVICE_IOEVENTFD, &vfio_ioeventfd);
> > +    }
> > +
> > +    if (!ioeventfd->vfio) {
> > +        qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
> > +                            vfio_ioeventfd_handler, NULL, ioeventfd);
> > +    }
> > +
> >      memory_region_add_eventfd(ioeventfd->mr, ioeventfd->addr,
> >                                ioeventfd->size, ioeventfd->match_data,
> >                                ioeventfd->data, &ioeventfd->e);
> >      trace_vfio_ioeventfd_init(memory_region_name(mr), (uint64_t)addr,
> > -                              size, data);
> > +                              size, data, ioeventfd->vfio);
> >  
> >      return ioeventfd;
> >  }
> > @@ -1835,7 +1871,7 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
> >  
> >      QLIST_FOREACH(quirk, &bar->quirks, next) {
> >          while (!QLIST_EMPTY(&quirk->ioeventfds)) {
> > -            vfio_ioeventfd_exit(QLIST_FIRST(&quirk->ioeventfds));
> > +            vfio_ioeventfd_exit(vdev, QLIST_FIRST(&quirk->ioeventfds));
> >          }
> >  
> >          for (i = 0; i < quirk->nr_mem; i++) {
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index ba1239551115..84e27c7bb2d1 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3177,6 +3177,8 @@ static Property vfio_pci_dev_properties[] = {
> >                       no_geforce_quirks, false),
> >      DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
> >                       false),
> > +    DEFINE_PROP_BOOL("x-no-vfio-ioeventfd", VFIOPCIDevice, no_vfio_ioeventfd,
> > +                     false),  
> I tend to agree with Peter about the 2 options. Only the KVM
> acceleration brings benefit here?

Consolidated response in reply to Peter.  Thanks,

Alex
