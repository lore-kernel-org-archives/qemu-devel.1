Received: from eggs.gnu.org ([209.51.188.92]:49725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ebw-0000vF-C1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1Ebv-0001eG-3P
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1Ebu-0001ab-ME
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:14 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:15:41 +0000
Message-Id: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/21] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a=
2d:

  Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' i=
nto staging (2019-03-05 09:33:20 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20190305a

for you to fetch changes up to 3feabbb5fc5e3d5504c735a77ebd1d7fc1eabb9b:

  qapi/migration.json: Remove a variable that doesn't exist in example (2=
019-03-05 18:04:05 +0000)

----------------------------------------------------------------
Migration pull 2019-03-05

   a) 3 small fixes including the cancel problem
     that caused the ahci migration test to fail
     intermittently
   b) Yury's ignore-shared feature
   c) Juan's extra tests
   d) Wei Wang's free page hinting
   e) Some Colo fixes from Zhang Chen

----------------------------------------------------------------
Dr. David Alan Gilbert (2):
      migration: Fix cancel state
      migration/rdma: Fix qemu_rdma_cleanup null check

Juan Quintela (3):
      tests: Add migration xbzrle test
      migration: Create socket-address parameter
      tests: Add basic migration precopy tcp test

Marcel Apfelbaum (1):
      migration/rdma: clang compilation fix

Wei Wang (7):
      bitmap: fix bitmap_count_one
      bitmap: bitmap_count_one_with_offset
      migration: use bitmap_mutex in migration_bitmap_clear_dirty
      migration: API to clear bits of guest free pages from the dirty bit=
map
      migration/ram.c: add a notifier chain for precopy
      migration/ram.c: add the free page optimization enable flag
      virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT

Yury Kotov (5):
      exec: Change RAMBlockIterFunc definition
      migration: Introduce ignore-shared capability
      migration: Add an ability to ignore shared RAM blocks
      tests/migration-test: Add a test for ignore-shared capability
      migration: Add capabilities validation

Zhang Chen (3):
      Migration/colo.c: Fix double close bug when occur COLO failover
      Migration/colo.c: Make COLO node running after failover
      qapi/migration.json: Remove a variable that doesn't exist in exampl=
e

 exec.c                             |  38 ++---
 hmp.c                              |  33 ++++
 hw/virtio/virtio-balloon.c         | 263 +++++++++++++++++++++++++++++++
 include/exec/cpu-common.h          |   7 +-
 include/hw/virtio/virtio-balloon.h |  28 +++-
 include/migration/misc.h           |  22 +++
 include/qemu/bitmap.h              |  17 ++
 migration/colo.c                   |   2 +-
 migration/migration.c              |  52 ++++++-
 migration/migration.h              |   9 +-
 migration/postcopy-ram.c           |  48 +++---
 migration/ram.c                    | 231 ++++++++++++++++++++++++----
 migration/rdma.c                   |  18 ++-
 migration/savevm.c                 | 152 ++++++++++++++++++
 migration/socket.c                 |  11 ++
 qapi/migration.json                |  13 +-
 qapi/sockets.json                  |  18 +++
 stubs/ram-block.c                  |  15 ++
 tests/migration-test.c             | 308 +++++++++++++++++++++++++++++++=
++----
 util/vfio-helpers.c                |   6 +-
 vl.c                               |   1 +
 21 files changed, 1169 insertions(+), 123 deletions(-)
