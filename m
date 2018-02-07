Received: from eggs.gnu.org ([2001:4830:134:3::10]:50848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejDCN-0004Pq-MK
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejDCK-0003jR-Kb
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:02:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ejDCK-0003iF-Ge
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 19:02:48 -0500
Date: Wed, 7 Feb 2018 02:02:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180207015803-mutt-send-email-mst@kernel.org>
References: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517915299-15349-1-git-send-email-wei.w.wang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] virtio-balloon: free page hint
 reporting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

On Tue, Feb 06, 2018 at 07:08:16PM +0800, Wei Wang wrote:
> This is the deivce part implementation to add a new feature,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
> receives the guest free page hints from the driver and clears the
> corresponding bits in the dirty bitmap, so that those free pages are
> not transferred by the migration thread to the destination.
> 
> Please see the driver patch link for test results:
> https://lkml.org/lkml/2018/2/4/60
> 
> ChangeLog:
> v1->v2: 
>     1) virtio-balloon
>         - use subsections to save free_page_report_cmd_id;
>         - poll the free page vq after sending a cmd id to the driver;
>         - change the free page vq size to VIRTQUEUE_MAX_SIZE;
>         - virtio_balloon_poll_free_page_hints: handle the corner case
>           that the free page block reported from the driver may cross
>           the RAMBlock boundary.
>     2) migration/ram.c
>         - use balloon_free_page_poll to start the optimization
> 
> Wei Wang (3):
>   virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>   migration: use the free page reporting feature from balloon
>   virtio-balloon: add a timer to limit the free page report waiting time

This feature needs in-tree documentation about possible ways to use it,
tradeoffs involved etc.


>  balloon.c                                       |  39 ++--
>  hw/virtio/virtio-balloon.c                      | 227 ++++++++++++++++++++++--
>  hw/virtio/virtio-pci.c                          |   3 +
>  include/hw/virtio/virtio-balloon.h              |  15 +-
>  include/migration/misc.h                        |   3 +
>  include/standard-headers/linux/virtio_balloon.h |   7 +
>  include/sysemu/balloon.h                        |  12 +-
>  migration/ram.c                                 |  34 +++-
>  8 files changed, 307 insertions(+), 33 deletions(-)
> 
> -- 
> 1.8.3.1
