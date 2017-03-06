Received: from eggs.gnu.org ([2001:4830:134:3::10]:59184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cknbb-0001LK-E9
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:02:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cknbY-0005J6-BH
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:02:55 -0500
Received: from [59.151.112.132] (port=31528 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cknbW-0005HK-3k
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:02:52 -0500
References: <1488011202-32121-1-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58BD1982.30509@cn.fujitsu.com>
Date: Mon, 6 Mar 2017 16:10:42 +0800
MIME-Version: 1.0
In-Reply-To: <1488011202-32121-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 0/8] the reset of msix_init series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Hannes Reinecke <hare@suse.de>, Dmitry Fleytman <dmitry@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Michael,
Is this series ok for 2.9?

-- 
Sincerely,
Cao jin

On 02/25/2017 04:26 PM, Cao jin wrote:
> v10 changelog:
> 1. drop the unliked patch, introduce a new patch 1 according to mst's comments.
> 2. base on the new patch, remove the following statements
> 
>         /* Any error other than -ENOTSUP(board's MSI support is broken)
>          * is a programming error */
>         assert(!ret || ret == -ENOTSUP);
> 
>    for the affected device: megasas, hcd-xhci. This is trivial changes,
>    so I left the R-bs where it was.
> 
> Test:
> 1. Detailed test via command line as v9
> 2. make check hangs at: GTESTER check-qtest-x86_64. After ctrl-C, it says:
> 
>     make: *** [check-qtest-x86_64] Interrupt
>     qemu-system-x86_64: Failed to read msg header. Read -1 instead of 12. Original request 11.
>     qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Input/output error (5)
>     qemu-system-x86_64: Failed to set msg fds.
>     qemu-system-x86_64: vhost VQ 0 ring restore failed: -1: Invalid argument (22)
> 
>     qemu-system-x86_64: Failed to set msg fds.
>     qemu-system-x86_64: vhost VQ 1 ring restore failed: -1: Invalid argument (22)
> 
>    Is it a regresstion or I missed something?
> 
> CC: Jason Wang <jasowang@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>
> CC: Dmitry Fleytman <dmitry@daynix.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Hannes Reinecke <hare@suse.de>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Alex Williamson <alex.williamson@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Marcel Apfelbaum <marcel@redhat.com>
> 
> Cao jin (8):
>   msix: Rename and create a wrapper
>   megasas: change behaviour of msix switch
>   hcd-xhci: change behaviour of msix switch
>   megasas: undo the overwrites of msi user configuration
>   vmxnet3: fix reference leak issue
>   vmxnet3: remove unnecessary internal msix flag
>   msi_init: convert assert to return -errno
>   megasas: remove unnecessary megasas_use_msix()
> 
>  hw/net/vmxnet3.c      | 40 +++++++++++++++-------------------------
>  hw/pci/msi.c          |  9 ++++++---
>  hw/pci/msix.c         | 30 +++++++++++++++++++++---------
>  hw/scsi/megasas.c     | 48 +++++++++++++++++++++++++-----------------------
>  hw/usb/hcd-xhci.c     | 29 +++++++++++++++++++++--------
>  hw/vfio/pci.c         | 12 ++++++------
>  include/hw/pci/msix.h |  5 +++++
>  7 files changed, 99 insertions(+), 74 deletions(-)
> 
