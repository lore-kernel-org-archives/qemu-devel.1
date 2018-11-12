Received: from eggs.gnu.org ([2001:4830:134:3::10]:59673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfD-0000FI-7E
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfC-0006lN-2d
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:49 +0100
Message-Id: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Block layer patches
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

The following changes since commit 5704c36d25ee84e7129722cb0db53df9faefe9=
43:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181112-pul=
l-request' into staging (2018-11-12 15:55:40 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 1a42e5d8298d1b0f90d2254e7d559391dd3a45ca:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2018-11-12' into q=
ueue-block (2018-11-12 17:57:32 +0100)

----------------------------------------------------------------
Block layer patches:

- file-posix: Don't waste a file descriptor for locking, don't lock the
  same bit multiple times
- nvme: Fix double free and memory leak
- Misc error handling fixes
- Added NULL checks found by static analysis
- Allow more block drivers to not be included in the qemu build

----------------------------------------------------------------
Fam Zheng (4):
      file-posix: Use error API properly
      file-posix: Skip effectiveless OFD lock operations
      file-posix: Drop s->lock_fd
      tests: Add unit tests for image locking

Jeff Cody (1):
      block: Make more block drivers compile-time configurable

Kevin Wolf (1):
      Merge remote-tracking branch 'mreitz/tags/pull-block-2018-11-12' in=
to queue-block

Li Qiang (2):
      nvme: don't unref ctrl_mem when device unrealized
      nvme: free cmbuf in nvme_exit

Liam Merwick (5):
      job: Fix off-by-one assert checks for JobSTT and JobVerbTable
      block: Null pointer dereference in blk_root_get_parent_desc()
      qemu-img: assert block_job_get() does not return NULL in img_commit=
()
      block: Fix potential Null pointer dereferences in vvfat.c
      qcow2: Read outside array bounds in qcow2_pre_write_overlap_check()

Peter Maydell (1):
      blockdev: Consistently use snapshot_node_name in external_snapshot_=
prepare()

zhenwei pi (1):
      blockdev: handle error on block latency histogram set error

 configure                  |  91 ++++++++++++++++++++++++++
 block/block-backend.c      |   3 +-
 block/file-posix.c         | 122 ++++++++++++++++++++---------------
 block/qcow2-refcount.c     |  18 +++---
 block/vvfat.c              |  46 ++++++++-----
 blockdev.c                 |  21 ++++--
 hw/block/nvme.c            |   6 +-
 job.c                      |   4 +-
 qemu-img.c                 |   1 +
 tests/test-image-locking.c | 157 +++++++++++++++++++++++++++++++++++++++=
++++++
 block/Makefile.objs        |  22 +++++--
 tests/Makefile.include     |   2 +
 12 files changed, 400 insertions(+), 93 deletions(-)
 create mode 100644 tests/test-image-locking.c
