Received: from eggs.gnu.org ([2001:4830:134:3::10]:41958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fn2lk-0007Ng-0D
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fn2lg-0008Us-Fg
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:15:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36092 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fn2lg-0008Ud-6s
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:15:24 -0400
Date: Tue, 7 Aug 2018 16:15:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180807161513.300dea9d.cohuck@redhat.com>
In-Reply-To: <153299247733.14411.6837517320997223920.stgit@gimli.home>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
	<153299247733.14411.6837517320997223920.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] vfio/ccw/pci: Allow devices to
 opt-in for ballooning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, mst@redhat.com, david@redhat.com

On Mon, 30 Jul 2018 17:14:37 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> If a vfio assigned device makes use of a physical IOMMU, then memory
> ballooning is necessarily inhibited due to the page pinning, lack of
> page level granularity at the IOMMU, and sufficient notifiers to both
> remove the page on balloon inflation and add it back on deflation.
> However, not all devices are backed by a physical IOMMU.  In the case
> of mediated devices, if a vendor driver is well synchronized with the
> guest driver, such that only pages actively used by the guest driver
> are pinned by the host mdev vendor driver, then there should be no
> overlap between pages available for the balloon driver and pages
> actively in use by the device.  Under these conditions, ballooning
> should be safe.
> 
> vfio-ccw devices are always mediated devices and always operate under
> the constraints above.  Therefore we can consider all vfio-ccw devices
> as balloon compatible.

I agree, that should be the case.

For the upcoming vfio-ap devices? I'm not sure how much control there
is over the pages that are used.

> 
> The situation is far from straightforward with vfio-pci.  These
> devices can be physical devices with physical IOMMU backing or
> mediated devices where it is unknown whether a physical IOMMU is in
> use or whether the vendor driver is well synchronized to the working
> set of the guest driver.  The safest approach is therefore to assume
> all vfio-pci devices are incompatible with ballooning, but allow user
> opt-in should they have further insight into mediated devices.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/ccw.c                 |    9 +++++++++
>  hw/vfio/common.c              |   23 ++++++++++++++++++++++-
>  hw/vfio/pci.c                 |   26 +++++++++++++++++++++++++-
>  hw/vfio/trace-events          |    1 +
>  include/hw/vfio/vfio-common.h |    2 ++
>  5 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 351b305e1ae7..40e7b5623e69 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -349,6 +349,15 @@ static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
>          }
>      }
>  
> +    /*
> +     * All vfio-ccw devices are believed to operate compatibly with memory

Better "to operate in a way compatible with memory ballooning"?

> +     * ballooning, ie. pages pinned in the host are in the current working
> +     * set of the guest driver and therefore never overlap with pages
> +     * available to the guest balloon driver.  This needs to be set before
> +     * vfio_get_device() for vfio common to handle the balloon inhibitor.
> +     */
> +    vcdev->vdev.balloon_allowed = true;
> +
>      if (vfio_get_device(group, vcdev->cdev.mdevid, &vcdev->vdev, errp)) {
>          goto out_err;
>      }
