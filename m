Received: from eggs.gnu.org ([2001:4830:134:3::10]:58471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gChWL-00028i-9P
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gChWG-0004RB-B2
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:49:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gChWF-0004Co-V7
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:49:32 -0400
Date: Wed, 17 Oct 2018 10:49:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181017104909.15ba95ff.cohuck@redhat.com>
In-Reply-To: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
References: <1539713558-2453-1-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/4] Add migration support for VFIO
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: alex.williamson@redhat.com, cjia@nvidia.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org

On Tue, 16 Oct 2018 23:42:34 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> Add migration support for VFIO device

I'd love to take a deeper look at this; but sadly, I'm currently low on
spare time, and therefore will only add some general remarks.

> 
> This Patch set include patches as below:
> - Define KABI for VFIO device for migration support.
> - Generic migration functionality for VFIO device.
>   * This patch set adds functionality only for PCI devices, but can be
>     extended to other VFIO devices.

I've been thinking about how best to add migration to vfio-ccw; it
might be quite different from what we do for vfio-pci, but I hope that
we can still use some common infrastructure.

Basically, we probably need something like the following:

- Wait until outstanding channel programs are finished, and don't allow
  new ones. Don't report back to userspace (or maybe do; we just don't
  want to fence of too many new requests.)
- Collect subchannel and related state, copy it over. That probably
  fits in with the interface you're proposing.
- Re-setup on the other side and get going again. The problem here
  might be state that the vfio-ccw driver can't be aware of (like
  replaying storage server configurations). Maybe we can send CRWs
  (notifications) to the guest and leverage the existing suspend/resume
  driver code for channel devices.

For vfio-ap, I frankly have no idea how migration will work, given the
setup with the matrix device and the interesting information in the SIE
control blocks (but maybe it just can replay from the info in the
matrix device?) Keys etc. are likely to be the bigger problem here.

Cc:ing some s390 folks for awareness.

>   * Added all the basic functions required for pre-copy, stop-and-copy and
>     resume phases of migration.
>   * Added state change notifier and from that notifier function, VFIO
>     device's state changed is conveyed to VFIO vendor driver.

I assume that this will, in general, be transparent for the guest; but
maybe there'll be need for some interaction for special cases?

>   * During save setup phase and resume/load setup phase, migration region
>     is queried from vendor driver and is mmaped by QEMU. This region is
>     used to read/write data from and to vendor driver.
>   * .save_live_pending, .save_live_iterate and .is_active_iterate are
>     implemented to use QEMU's functionality of iteration during pre-copy
>     phase.
>   * In .save_live_complete_precopy, that is in stop-and-copy phase,
>     iteration to read data from vendor driver is implemented till pending
>     bytes returned by vendor driver are not zero.
>   * .save_cleanup and .load_cleanup are implemented to unmap migration
>     region that was setup duing setup phase.
>   * Added function to get dirty pages bitmap from vendor driver.
> - Add vfio_listerner_log_sync to mark dirty pages.
> - Make VFIO PCI device migration capable.
> 
> Thanks,
> Kirti
> 
> Kirti Wankhede (4):
>   VFIO KABI for migration interface
>   Add migration functions for VFIO devices
>   Add vfio_listerner_log_sync to mark dirty pages
>   Make vfio-pci device migration capable.
> 
>  hw/vfio/Makefile.objs         |   2 +-
>  hw/vfio/common.c              |  32 ++
>  hw/vfio/migration.c           | 716 ++++++++++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c                 |  13 +-
>  include/hw/vfio/vfio-common.h |  23 ++
>  linux-headers/linux/vfio.h    |  91 ++++++
>  6 files changed, 869 insertions(+), 8 deletions(-)
>  create mode 100644 hw/vfio/migration.c
> 
