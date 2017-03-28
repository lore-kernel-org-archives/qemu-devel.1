Received: from eggs.gnu.org ([2001:4830:134:3::10]:38988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cssyD-000633-NG
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cssyC-0005tK-Cc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:23:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cssyC-0005sy-2k
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:23:40 -0400
Date: Tue, 28 Mar 2017 09:23:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170328092336.18c44c0d@t450s.home>
In-Reply-To: <ad83f499-cc12-688e-f455-50a28c1f2ea0@de.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170328102016.4926f21d.cornelia.huck@de.ibm.com>
	<ad83f499-cc12-688e-f455-50a28c1f2ea0@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 00/16] basic vfio-ccw infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 28 Mar 2017 10:39:40 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 03/28/2017 10:20 AM, Cornelia Huck wrote:
> > On Fri, 17 Mar 2017 04:17:27 +0100
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> >> Dong Jia Shi (16):
> >>   s390: cio: introduce cio_cancel_halt_clear
> >>   s390: cio: export more interfaces
> >>   vfio: ccw: define device_api strings
> >>   vfio: ccw: basic implementation for vfio_ccw driver
> >>   vfio: ccw: introduce channel program interfaces
> >>   vfio: ccw: register vfio_ccw to the mediated device framework
> >>   vfio: ccw: introduce ccw_io_region
> >>   vfio: ccw: handle ccw command request
> >>   vfio: ccw: realize VFIO_DEVICE_GET_REGION_INFO ioctl
> >>   vfio: ccw: realize VFIO_DEVICE_RESET ioctl
> >>   vfio: ccw: realize VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
> >>   vfio: ccw: return I/O results asynchronously
> >>   vfio: ccw: introduce a finite state machine
> >>   docs: add documentation for vfio-ccw
> >>   vfio: ccw: introduce support for ccw0
> >>   MAINTAINERS: Add vfio-ccw maintainers
> >>
> >>  Documentation/s390/00-INDEX         |   2 +
> >>  Documentation/s390/vfio-ccw.txt     | 303 +++++++++++++
> >>  MAINTAINERS                         |  10 +
> >>  arch/s390/Kconfig                   |  10 +
> >>  arch/s390/include/asm/cio.h         |  18 +
> >>  arch/s390/include/asm/isc.h         |   1 +
> >>  drivers/iommu/Kconfig               |   8 +
> >>  drivers/s390/cio/Makefile           |   3 +
> >>  drivers/s390/cio/cio.c              |  69 +++
> >>  drivers/s390/cio/cio.h              |   1 +
> >>  drivers/s390/cio/device_fsm.c       |  54 +--
> >>  drivers/s390/cio/vfio_ccw_cp.c      | 842 ++++++++++++++++++++++++++++++++++++
> >>  drivers/s390/cio/vfio_ccw_cp.h      |  42 ++
> >>  drivers/s390/cio/vfio_ccw_drv.c     | 308 +++++++++++++
> >>  drivers/s390/cio/vfio_ccw_fsm.c     | 207 +++++++++
> >>  drivers/s390/cio/vfio_ccw_ops.c     | 447 +++++++++++++++++++
> >>  drivers/s390/cio/vfio_ccw_private.h |  96 ++++
> >>  include/uapi/linux/vfio.h           |  18 +
> >>  include/uapi/linux/vfio_ccw.h       |  24 +
> >>  19 files changed, 2417 insertions(+), 46 deletions(-)
> >>  create mode 100644 Documentation/s390/vfio-ccw.txt
> >>  create mode 100644 drivers/s390/cio/vfio_ccw_cp.c
> >>  create mode 100644 drivers/s390/cio/vfio_ccw_cp.h
> >>  create mode 100644 drivers/s390/cio/vfio_ccw_drv.c
> >>  create mode 100644 drivers/s390/cio/vfio_ccw_fsm.c
> >>  create mode 100644 drivers/s390/cio/vfio_ccw_ops.c
> >>  create mode 100644 drivers/s390/cio/vfio_ccw_private.h
> >>  create mode 100644 include/uapi/linux/vfio_ccw.h
> >>  
> > 
> > Patch set looks good to me, and I think we should target it for the
> > next merge window (the interface looks fine, and we can iron out any
> > other things later.)
> > 
> > Question: Which tree should this go through? Vfio or kvm/s390?  
> 
> Reading todays MAINTAINERS file this would go via Martins tree, after the last
> patch it will be separate. I can certainly carry that via the kvms390 tree,
> but Alex is certainly the final maintainer. 
> So what about having a new repository under 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/
> e.g. vfio.git that will then queue the patches for Alex to take?

I would think this should be merged through s390 trees, I don't claim
any sort of maintainership for each individual mdev vendor driver
(perhaps with the exception of the mtty sample driver).  I think I've
acked all the (relatively minor) bits where this series updates the
vfio core code.  Thanks,

Alex
