Received: from eggs.gnu.org ([2001:4830:134:3::10]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6E-0003co-Nl
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6D-0003Ty-Ak
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:10 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:30 +0200
Message-Id: <20180629140959.6690-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/29] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

The following changes since commit 609ef9f451759151d0bfe7c3843410ab94d68f=
18:

  Merge remote-tracking branch 'remotes/berrange/tags/qio-next-pull-reque=
st' into staging (2018-06-28 17:53:31 +0100)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 583c99d39368526dfb57a715b04a6ceea27dbe1e:

  block: Remove unused sector-based vectored I/O (2018-06-29 14:20:56 +02=
00)

----------------------------------------------------------------
Block layer patches:

- Make truncate operations asynchronous (so that preallocation in
  blockdev-create doesn't block the main loop any more)
- usb-storage: Add rerror/werror properties
- nvme: Add num_queues property
- qemu-img convert: Copy offloading fixes (including data corruption fix)
- qcow2: Fix cluster leak on temporary write error
- Use byte-based functions instead of bdrv_co_readv/writev()
- Various small fixes and cleanups

----------------------------------------------------------------
Eric Blake (8):
      parallels: Switch to byte-based calls
      qcow: Switch get_cluster_offset to be byte-based
      qcow: Switch qcow_co_readv to byte-based calls
      qcow: Switch qcow_co_writev to byte-based calls
      qcow: Switch to a byte-based driver
      replication: Switch to byte-based calls
      vhdx: Switch to byte-based calls
      block: Remove unused sector-based vectored I/O

Fam Zheng (5):
      qcow2: Remove dead check on !ret
      block: Move request tracking to children in copy offloading
      qcow2: Fix src_offset in copy offloading
      iscsi: Don't blindly use designator length in response for memcpy
      file-posix: Fix EINTR handling

Kevin Wolf (12):
      qapi/job: The next release will be 3.0
      usb-storage: Add rerror/werror properties
      qcow2: Fix qcow2_truncate() error return value
      block: Convert .bdrv_truncate callback to coroutine_fn
      qcow2: Remove coroutine trampoline for preallocate_co()
      block: Move bdrv_truncate() implementation to io.c
      block: Use tracked request for truncate
      file-posix: Make .bdrv_co_truncate asynchronous
      qemu-iotests: Update 026.out.nocache reference output
      qcow2: Free allocated clusters on write error
      qemu-iotests: Test qcow2 not leaking clusters on write error
      file-posix: Implement co versions of discard/flush

Markus Armbruster (3):
      block-qdict: Pacify Coverity after commit f1b34a248e9
      block/crypto: Pacify Coverity after commit f853465aacb
      block/crypto: Simplify block_crypto_{open,create}_opts_init()

Weiping Zhang (1):
      hw/block/nvme: add optional parameter num_queues for nvme device

 qapi/job.json                      |  18 +-
 block/crypto.h                     |   8 +-
 block/qcow2.h                      |   1 +
 include/block/block.h              |   8 +-
 include/block/block_int.h          |   7 +-
 include/block/raw-aio.h            |   4 +-
 include/hw/scsi/scsi.h             |   2 +
 block.c                            |  64 +------
 block/copy-on-read.c               |   8 +-
 block/crypto.c                     | 112 +++--------
 block/file-posix.c                 | 367 +++++++++++++++++++------------=
------
 block/file-win32.c                 |   6 +-
 block/gluster.c                    |  14 +-
 block/io.c                         | 219 +++++++++++++++-------
 block/iscsi.c                      |  10 +-
 block/nfs.c                        |   7 +-
 block/parallels.c                  |  16 +-
 block/qcow.c                       | 135 +++++++-------
 block/qcow2-cluster.c              |  11 ++
 block/qcow2.c                      | 140 ++++++--------
 block/qed.c                        |   8 +-
 block/raw-format.c                 |   8 +-
 block/rbd.c                        |   8 +-
 block/replication.c                |  14 +-
 block/sheepdog.c                   |  12 +-
 block/ssh.c                        |   6 +-
 block/vhdx.c                       |  12 +-
 hw/block/nvme.c                    |   5 +-
 hw/scsi/scsi-bus.c                 |  11 +-
 hw/usb/dev-storage.c               |   2 +
 qobject/block-qdict.c              |  16 +-
 tests/qemu-iotests/026             |  17 ++
 tests/qemu-iotests/026.out         |   8 +
 tests/qemu-iotests/026.out.nocache |  14 +-
 tests/qemu-iotests/063             |   9 +
 tests/qemu-iotests/063.out         |  12 ++
 36 files changed, 685 insertions(+), 634 deletions(-)
