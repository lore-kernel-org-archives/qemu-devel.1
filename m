Received: from eggs.gnu.org ([2001:4830:134:3::10]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejsbk-000820-LX
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ejsbh-0004mt-8r
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:15:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53994 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ejsbh-0004gL-2n
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:15:45 -0500
Date: Thu, 8 Feb 2018 20:15:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180208201523.GE2326@work-vm>
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
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> This is the deivce part implementation to add a new feature,
> VIRTIO_BALLOON_F_FREE_PAGE_HINT to the virtio-balloon device. The device
> receives the guest free page hints from the driver and clears the
> corresponding bits in the dirty bitmap, so that those free pages are
> not transferred by the migration thread to the destination.
> 
> Please see the driver patch link for test results:
> https://lkml.org/lkml/2018/2/4/60

Hi Wei,
   I'll look at the code a bit more - but first some more basic
questions on that lkml post:

    a) The idle guest time thing is a nice result; can you just state
       what the host was, speed of connection, and what other options
       you were using?

    b) The workload test, the one with the kernel compile; you list
       the kernel compile time but don't mention any changes in the
       migration times of the ping-pong; can you give those times as
       well?

    c) What's your real workload that this is aimed at?
       Is it really for people migrating idle VMs - or do you have some
       NFV application in mind, if so why not include a figure for
       those?

Thanks,

Dave

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
> 
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
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
