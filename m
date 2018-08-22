Received: from eggs.gnu.org ([2001:4830:134:3::10]:38816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRp3-0006e8-00
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRoq-00089H-K1
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRoq-00086b-7b
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ED2CB804BAAD
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 12:00:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:30 +0200
Message-Id: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/20] Migration pull requset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-request' into staging (2018-08-21 15:57:56 +0100)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180822-1

for you to fetch changes up to ae526e32bd36cfb84045c8d2fd34e0b9e39a52f8:

  migration: hold the lock only if it is really needed (2018-08-22 12:36:18 +0200)

----------------------------------------------------------------
migration/next for 20180822

All pending patches that are reviewed:
- doc for pr_load (dave)
- postcopy + rdma is nearer (lidong chen)
- compression fixes (xiao)
- silent warning for pcc tests (Thomas)
- fix subsection without .needed function (pmaydell)

Please apply, Juan.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      docs/migration: Clarify pre_load in subsections

Li Qiang (1):
      migrate/cpu-throttle: Add max-cpu-throttle migration parameter

Lidong Chen (9):
      migration: disable RDMA WRITE after postcopy started
      migration: create a dedicated connection for rdma return path
      migration: implement bi-directional RDMA QIOChannel
      migration: Stop rdma yielding during incoming postcopy
      migration: implement io_set_aio_fd_handler function for RDMA QIOChannel
      migration: invoke qio_channel_yield only when qemu_in_coroutine()
      migration: poll the cm event while wait RDMA work request completion
      migration: implement the shutdown for RDMA QIOChannel
      migration: poll the cm event for destination qemu

Peter Maydell (1):
      migration: Correctly handle subsections with no 'needed' function

Thomas Huth (1):
      tests/migration-test: Silence the kvm_hv message by default

Xiao Guangrong (6):
      migration: do not wait for free thread
      migration: fix counting normal page for compression
      migration: introduce save_zero_page_to_file
      migration: drop the return value of do_compress_ram_page
      migration: move handle of zero page to the thread
      migration: hold the lock only if it is really needed

jialina01 (1):
      qapi/migration.json: fix the description for "query-migrate" output

 docs/devel/migration.rst      |  15 +-
 hmp.c                         |  16 ++
 include/qemu/queue.h          |   1 +
 migration/colo.c              |   2 +
 migration/migration.c         |  49 ++++-
 migration/migration.h         |   2 +
 migration/postcopy-ram.c      |   2 +
 migration/qemu-file-channel.c |  12 +-
 migration/qemu-file.c         |   8 +-
 migration/ram.c               | 204 +++++++++++++-------
 migration/rdma.c              | 423 ++++++++++++++++++++++++++++++++++++++----
 migration/savevm.c            |   3 +
 migration/vmstate.c           |   6 +-
 qapi/migration.json           |  64 +++++--
 tests/migration-test.c        |  20 +-
 15 files changed, 691 insertions(+), 136 deletions(-)
