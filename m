Received: from eggs.gnu.org ([2001:4830:134:3::10]:55866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewWWX-0004wH-CG
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ewWWW-0005PQ-AG
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 13:18:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 15 Mar 2018 18:18:28 +0100
Message-Id: <20180315171828.5214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/44] Block layer patches
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

The following changes since commit 56e8698ffa8aba9f762f980bc21b5340b006f2=
4b:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-=
130318-1' into staging (2018-03-15 14:48:09 +0000)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to d3137181e5e1e5e6b651b58484fc8f705a48ee36:

  iscsi: fix iSER compilation (2018-03-15 17:58:26 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Fam Zheng (4):
      block: Fix flags in reopen queue
      iotests: Add regression test for commit base locking
      vvfat: Fix inherit_options flags
      block: Fix leak of ignore_children in error path

John Snow (21):
      blockjobs: fix set-speed kick
      blockjobs: model single jobs as transactions
      Blockjobs: documentation touchup
      blockjobs: add status enum
      blockjobs: add state transition table
      iotests: add pause_wait
      blockjobs: add block_job_verb permission table
      blockjobs: add ABORTING state
      blockjobs: add CONCLUDED state
      blockjobs: add NULL state
      blockjobs: add block_job_dismiss
      blockjobs: ensure abort is called for cancelled jobs
      blockjobs: add commit, abort, clean helpers
      blockjobs: add block_job_txn_apply function
      blockjobs: add prepare callback
      blockjobs: add waiting status
      blockjobs: add PENDING status and event
      blockjobs: add block-job-finalize
      blockjobs: Expose manual property
      iotests: test manual job dismissal
      tests/test-blockjob: test cancellations

Kevin Wolf (14):
      luks: Separate image file creation from formatting
      luks: Create block_crypto_co_create_generic()
      luks: Support .bdrv_co_create
      luks: Turn invalid assertion into check
      luks: Catch integer overflow for huge sizes
      qemu-iotests: Test luks QMP image creation
      parallels: Support .bdrv_co_create
      qemu-iotests: Enable write tests for parallels
      qcow: Support .bdrv_co_create
      qed: Support .bdrv_co_create
      vdi: Make comments consistent with other drivers
      vhdx: Support .bdrv_co_create
      vpc: Support .bdrv_co_create
      vpc: Require aligned size in .bdrv_co_create

Liang Li (1):
      block/mirror: change the semantic of 'force' of block-job-cancel

Max Reitz (3):
      vdi: Pull option parsing from vdi_co_create
      vdi: Move file creation to vdi_co_create_opts
      vdi: Implement .bdrv_co_create

Paolo Bonzini (1):
      iscsi: fix iSER compilation

 qapi/block-core.json          | 363 ++++++++++++++++++++++++++++++++++++=
++++--
 include/block/blockjob.h      |  71 ++++++++-
 include/block/blockjob_int.h  |  17 +-
 block.c                       |  10 +-
 block/backup.c                |   5 +-
 block/commit.c                |   2 +-
 block/crypto.c                | 150 ++++++++++++-----
 block/iscsi.c                 |   2 +-
 block/mirror.c                |  12 +-
 block/parallels.c             | 199 +++++++++++++++++------
 block/qcow.c                  | 196 +++++++++++++++--------
 block/qed.c                   | 204 ++++++++++++++++--------
 block/stream.c                |   2 +-
 block/vdi.c                   | 147 +++++++++++++----
 block/vhdx.c                  | 216 +++++++++++++++++++------
 block/vpc.c                   | 241 +++++++++++++++++++++-------
 block/vvfat.c                 |   2 +-
 blockdev.c                    |  71 +++++++--
 blockjob.c                    | 358 +++++++++++++++++++++++++++++++++++-=
-----
 tests/test-bdrv-drain.c       |   5 +-
 tests/test-blockjob-txn.c     |  27 ++--
 tests/test-blockjob.c         | 233 ++++++++++++++++++++++++++-
 block/trace-events            |   7 +
 hmp-commands.hx               |   3 +-
 tests/qemu-iotests/030        |   6 +-
 tests/qemu-iotests/055        |  17 +-
 tests/qemu-iotests/056        | 187 ++++++++++++++++++++++
 tests/qemu-iotests/056.out    |   4 +-
 tests/qemu-iotests/109.out    |  24 +--
 tests/qemu-iotests/153        |  12 ++
 tests/qemu-iotests/153.out    |   5 +
 tests/qemu-iotests/181        |   2 +-
 tests/qemu-iotests/209        | 210 ++++++++++++++++++++++++
 tests/qemu-iotests/209.out    | 136 ++++++++++++++++
 tests/qemu-iotests/check      |   1 -
 tests/qemu-iotests/common.rc  |   2 +-
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |  12 +-
 38 files changed, 2645 insertions(+), 517 deletions(-)
 create mode 100755 tests/qemu-iotests/209
 create mode 100644 tests/qemu-iotests/209.out
