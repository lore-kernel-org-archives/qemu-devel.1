Received: from eggs.gnu.org ([209.51.188.92]:34748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldO-0006GJ-Sm
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gvldL-0002Nk-Jd
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:19:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Feb 2019 17:18:10 +0100
Message-Id: <20190218161822.3573-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/12] block: bdrv_set_aio_context() related
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, stefanha@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

Background for this series is the following bug report, which is about a
crash with virtio-blk + iothread and request resubmission for werror/rerr=
or:

https://bugzilla.redhat.com/show_bug.cgi?id=3D1671173

The reason is that bdrv_set_aio_context() didn't correctly quiesce
everything. Instead, it had a local hack to call aio_poll() for the
source AioContext, which covered some, but not all cases, and is wrong
because you can only call aio_poll() from the home thread.

So this series tries to make bdrv_drain() actually drain the known cases
(fixes virtio-blk and the NBD client) and use the regular drain
functions in bdrv_set_aio_context() instead of open-coding something
similar.

Kevin Wolf (12):
  block-backend: Make blk_inc/dec_in_flight public
  virtio-blk: Increase in_flight for request restart BH
  nbd: Restrict connection_co reentrance
  io: Make qio_channel_yield() interruptible
  nbd: Move nbd_read_eof() to nbd/client.c
  nbd: Use low-level QIOChannel API in nbd_read_eof()
  nbd: Increase bs->in_flight during AioContext switch
  block: Don't poll in bdrv_set_aio_context()
  block: Fix AioContext switch for drained node
  test-bdrv-drain: AioContext switch in drained section
  block: Use normal drain for bdrv_set_aio_context()
  aio-posix: Assert that aio_poll() is always called in home thread

 block/nbd-client.h             |  2 ++
 include/block/nbd.h            |  4 ++-
 include/io/channel.h           |  9 +++--
 include/sysemu/block-backend.h |  2 ++
 nbd/nbd-internal.h             | 19 ----------
 block.c                        | 25 +++++++-------
 block/block-backend.c          |  4 +--
 block/nbd-client.c             | 27 ++++++++++++++-
 hw/block/virtio-blk.c          |  4 +++
 io/channel.c                   | 10 ++++++
 nbd/client.c                   | 63 ++++++++++++++++++++++++++++++++--
 tests/test-bdrv-drain.c        | 32 +++++++++++++++++
 util/aio-posix.c               |  3 +-
 13 files changed, 162 insertions(+), 42 deletions(-)

--=20
2.20.1
