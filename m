Received: from eggs.gnu.org ([2001:4830:134:3::10]:50401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fkTmM-00043E-DA
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fkTmI-0004B0-DU
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:29:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fkTmI-0004AS-6e
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 08:29:26 -0400
Date: Tue, 31 Jul 2018 15:29:17 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180731152716-mutt-send-email-mst@kernel.org>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153299204130.14411.11438396195753743913.stgit@gimli.home>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Balloon inhibit enhancements,
 vfio restriction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, cohuck@redhat.com, david@redhat.com

On Mon, Jul 30, 2018 at 05:13:26PM -0600, Alex Williamson wrote:
> v2:
>  - Use atomic ops for balloon inhibit counter (Peter)
>  - Allow endpoint driver opt-in for ballooning, vfio-ccw opt-in by
>    default, vfio-pci opt-in by device option, only allowed for mdev
>    devices, no support added for platform as there are no platform
>    mdev devices.
> 
> See patch 3/4 for detailed explanation why ballooning and device
> assignment typically don't mix.  If this eventually changes, flags
> on the iommu info struct or perhaps device info struct can inform
> us for automatic opt-in.  Thanks,
> 
> Alex

So this patch seems to block ballooning when vfio is added.
But what if balloon is added and inflated first?

I'd suggest making qemu_balloon_inhibit fail in that case,
and then vfio realize will fail as well.


> ---
> 
> Alex Williamson (4):
>       balloon: Allow nested inhibits
>       kvm: Use inhibit to prevent ballooning without synchronous mmu
>       vfio: Inhibit ballooning based on group attachment to a container
>       vfio/ccw/pci: Allow devices to opt-in for ballooning
> 
> 
>  accel/kvm/kvm-all.c           |    4 ++++
>  balloon.c                     |   13 ++++++++++---
>  hw/vfio/ccw.c                 |    9 +++++++++
>  hw/vfio/common.c              |   26 ++++++++++++++++++++++++++
>  hw/vfio/pci.c                 |   26 +++++++++++++++++++++++++-
>  hw/vfio/trace-events          |    1 +
>  hw/virtio/virtio-balloon.c    |    4 +---
>  include/hw/vfio/vfio-common.h |    2 ++
>  8 files changed, 78 insertions(+), 7 deletions(-)
