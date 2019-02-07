Received: from eggs.gnu.org ([209.51.188.92]:53553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1grpNs-0000Bw-4r
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1grpNr-0002Gu-5n
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 14:30:52 -0500
Date: Thu, 7 Feb 2019 14:30:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190207142945-mutt-send-email-mst@kernel.org>
References: <20190206112729.37761-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206112729.37761-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] virtio-blk: add DISCARD and
 WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Wed, Feb 06, 2019 at 12:27:23PM +0100, Stefano Garzarella wrote:
> This series adds the support of DISCARD and WRITE_ZEROES commands
> and extends the virtio-blk-test to test WRITE_ZEROES command when
> the feature is enabled.

pls note and fix patchew errors:

https://patchew.org/QEMU/20190206112729.37761-1-sgarzare@redhat.com/

> v3:
> - rebased on master (I removed Based-on tag since the new virtio headers from
>   linux v5.0-rc1 are merged)
> - added patch 2 to add host_features field (as in virtio-net) [Michael]
> - fixed patch 3 (previously 2/5) using the new host_features field
> - fixed patch 4 (previously 3/5) following the Stefan's comments:
>                 - fixed name of functions and fields
>                 - used vdev and s pointers
>                 - removed "wz-may-unmap" property
>                 - split "dwz-max-sectors" in two properties
> 
> v2:
> - added patch 1 to use virtio_blk_handle_rw_error() with discard operation
> - added patch 2 to make those new features machine-type dependent (thanks David)
> - fixed patch 3 (previously patch 1/2) adding more checks, block_acct_start()
>                 for WRITE_ZEROES requests, and configurable parameters to
>                 initialize the limits (max_sectors, wzeroes_may_unmap).
>                 (thanks Stefan)
>                 I moved in a new function the code to handle a single segment,
>                 in order to simplify the support of multiple segments in the
>                 future.
> - added patch 4 to change the assert on data_size following the discussion with
>                 Thomas, Changpeng, Michael, and Stefan (thanks all)
> - fixed patch 5 (previously patch 2/2) using local dwz_hdr variable instead of
>                 dynamic allocation (thanks Thomas)
> 
> Thanks,
> Stefano
> 
> Stefano Garzarella (6):
>   virtio-blk: add acct_failed param to virtio_blk_handle_rw_error()
>   virtio-blk: add host_features field in VirtIOBlock
>   virtio-blk: add "discard" and "write-zeroes" properties
>   virtio-blk: add DISCARD and WRITE_ZEROES features
>   tests/virtio-blk: change assert on data_size in virtio_blk_request()
>   tests/virtio-blk: add test for WRITE_ZEROES command
> 
>  hw/block/virtio-blk.c          | 213 +++++++++++++++++++++++++++++++--
>  hw/core/machine.c              |   2 +
>  include/hw/virtio/virtio-blk.h |   5 +-
>  tests/virtio-blk-test.c        |  75 +++++++++++-
>  4 files changed, 281 insertions(+), 14 deletions(-)
> 
> -- 
> 2.20.1
