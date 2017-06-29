Received: from eggs.gnu.org ([2001:4830:134:3::10]:43390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQixO-0007BV-W0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dQixO-0002n6-48
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 19:34:43 -0400
Date: Fri, 30 Jun 2017 02:34:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170630023423-mutt-send-email-mst@kernel.org>
References: <20170628184724.21378-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170628184724.21378-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] virtio: use ioeventfd in TCG and qtest
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Wed, Jun 28, 2017 at 07:47:18PM +0100, Stefan Hajnoczi wrote:
> This patch series fixes qemu-iotests 068.  Since commit
> ea4f3cebc4e0224605ab9dd9724aa4e7768fe372 ("qemu-iotests: 068: test iothread
> mode") the test case has attempted to use dataplane without -M accel=kvm.
> Although QEMU is capable of running TCG or qtest with emulated ioeventfd/irqfd
> we haven't enabled it yet.
> 
> Unfortunately the virtio test cases fail when ioeventfd is enabled in qtest
> mode.  This is because they make assumptions about virtqueue ISR signalling.
> They assume that a request is completed when ISR becomes 1.  However, the ISR
> can be set to 1 even though no new request has completed since commit
> 83d768b5640946b7da55ce8335509df297e2c7cd "virtio: set ISR on dataplane
> notifications".
> 
> This issue is solved by introducing a proper qvirtqueue_get_buf() API (similar
> to the Linux guest drivers) instead of making assumptions about the ISR.  Most
> of the patches update the test cases to use the new API.
> 
> Stefan Hajnoczi (6):
>   libqos: fix typo in virtio.h QVirtQueue->used comment
>   libqos: add virtio used ring support
>   tests: fix virtio-scsi-test ISR dependence
>   tests: fix virtio-blk-test ISR dependence
>   tests: fix virtio-net-test ISR dependence
>   virtio-pci: use ioeventfd even when KVM is disabled


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge.

>  tests/libqos/virtio.h    |  8 ++++++-
>  hw/virtio/virtio-pci.c   |  2 +-
>  tests/libqos/virtio.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/virtio-blk-test.c  | 27 ++++++++++++++--------
>  tests/virtio-net-test.c  |  6 ++---
>  tests/virtio-scsi-test.c |  2 +-
>  6 files changed, 89 insertions(+), 16 deletions(-)
> 
> -- 
> 2.9.4
