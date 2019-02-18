Received: from eggs.gnu.org ([209.51.188.92]:59164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjW9-00083e-6C
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gvjW8-0003mR-4M
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:03:33 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 18 Feb 2019 15:02:51 +0100
Message-Id: <20190218140301.197408-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 00/10] virtio-blk: add DISCARD and
 WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>

This series adds the support of DISCARD and WRITE_ZEROES commands
and extends the virtio-blk-test to test these new commands.

v5:
- rebased on master
- handled the config size for DISCARD and WRITE_ZEROES features as in
  virtio-net (patches 4 and 5) [Michael, Stefan]
- fixed an endianness issues on the WRITE_ZEROES test (patches 8 and 9)
- added a test for DISCARD command to only test the status returned by th=
e
  request (patch 10)
- others patches are unchanged (patches 1, 2, 3, 6, 7)

v4:
- fixed error with mingw compiler in patch 4
  gcc and clang want %lu, but mingw wants %llu for BDRV_REQUEST_MAX_SECTO=
RS.
  Since is less than INT_MAX, I casted it to integer and I used %d in the
  format string of error_setg. (mingw now is happy)

v3:
- rebased on master (I removed Based-on tag since the new virtio headers =
from
  linux v5.0-rc1 are merged)
- added patch 2 to add host_features field (as in virtio-net) [Michael]
- fixed patch 3 (previously 2/5) using the new host_features field
- fixed patch 4 (previously 3/5) following the Stefan's comments:
                - fixed name of functions and fields
                - used vdev and s pointers
                - removed "wz-may-unmap" property
                - split "dwz-max-sectors" in two properties

v2:
- added patch 1 to use virtio_blk_handle_rw_error() with discard operatio=
n
- added patch 2 to make those new features machine-type dependent (thanks=
 David)
- fixed patch 3 (previously patch 1/2) adding more checks, block_acct_sta=
rt()
                for WRITE_ZEROES requests, and configurable parameters to
                initialize the limits (max_sectors, wzeroes_may_unmap).
                (thanks Stefan)
                I moved in a new function the code to handle a single seg=
ment,
                in order to simplify the support of multiple segments in =
the
                future.
- added patch 4 to change the assert on data_size following the discussio=
n with
                Thomas, Changpeng, Michael, and Stefan (thanks all)
- fixed patch 5 (previously patch 2/2) using local dwz_hdr variable inste=
ad of
                dynamic allocation (thanks Thomas)

Thanks,
Stefano

Stefano Garzarella (10):
  virtio-blk: add acct_failed param to virtio_blk_handle_rw_error()
  virtio-blk: add host_features field in VirtIOBlock
  virtio-blk: add "discard" and "write-zeroes" properties
  virtio-net: make VirtIOFeature usable for other virtio devices
  virtio-blk: set config size depending on the features enabled
  virtio-blk: add DISCARD and WRITE_ZEROES features
  tests/virtio-blk: change assert on data_size in virtio_blk_request()
  tests/virtio-blk: add virtio_blk_fix_dwz_hdr() function
  tests/virtio-blk: add test for WRITE_ZEROES command
  tests/virtio-blk: add test for DISCARD command

 hw/block/virtio-blk.c          | 245 ++++++++++++++++++++++++++++++---
 hw/core/machine.c              |   2 +
 hw/net/virtio-net.c            |  31 +----
 hw/virtio/virtio.c             |  15 ++
 include/hw/virtio/virtio-blk.h |   6 +-
 include/hw/virtio/virtio.h     |  15 ++
 tests/virtio-blk-test.c        | 127 ++++++++++++++++-
 7 files changed, 391 insertions(+), 50 deletions(-)

--=20
2.20.1
