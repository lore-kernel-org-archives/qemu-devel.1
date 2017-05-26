Received: from eggs.gnu.org ([2001:4830:134:3::10]:54055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3N-00041f-2y
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dEA3J-00063N-4q
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:52:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dEA3I-000634-Rf
	for qemu-devel@nongnu.org; Fri, 26 May 2017 03:52:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 May 2017 15:52:24 +0800
Message-Id: <20170526075246.20265-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>

The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b=
60:

  Merge remote-tracking branch 'jasowang/tags/net-pull-request' into stag=
ing (2017-05-23 15:01:31 +0100)

are available in the git repository at:

  git://github.com/famz/qemu.git tags/docker-and-block-pull-request

for you to fetch changes up to 77269bba94ef97de99ae61fdc98629a8704ae2ed:

  block: make accounting thread-safe (2017-05-26 09:25:30 +0800)

----------------------------------------------------------------

For Paolo's block layer thread safety part I and my docker testing
enhancements.

----------------------------------------------------------------

Fam Zheng (4):
  docker: Run tests with current user
  docker: Add bzip2 and hostname to fedora image
  docker: Add libaio to fedora image
  docker: Add flex and bison to centos6 image

Paolo Bonzini (18):
  block: access copy_on_read with atomic ops
  block: access quiesce_counter with atomic ops
  block: access io_limits_disabled with atomic ops
  block: access serialising_in_flight with atomic ops
  block: access wakeup with atomic ops
  block: access io_plugged with atomic ops
  throttle-groups: only start one coroutine from drained_begin
  throttle-groups: do not use qemu_co_enter_next
  throttle-groups: protect throttled requests with a CoMutex
  util: add stats64 module
  block: use Stat64 for wr_highest_offset
  block: access write_gen with atomics
  block: protect tracked_requests and flush_queue with reqs_lock
  block: introduce dirty_bitmap_mutex
  migration/block: reset dirty bitmap before reading
  block: protect modification of dirty bitmaps with a mutex
  block: introduce block_account_one_io
  block: make accounting thread-safe

 block.c                                 |   9 +-
 block/accounting.c                      |  65 ++++++-----
 block/block-backend.c                   |   5 +-
 block/dirty-bitmap.c                    | 114 +++++++++++++++++--
 block/io.c                              |  51 +++++----
 block/mirror.c                          |  14 ++-
 block/nfs.c                             |   4 +-
 block/qapi.c                            |   2 +-
 block/sheepdog.c                        |   3 +-
 block/throttle-groups.c                 |  91 +++++++++++----
 blockdev.c                              |  46 ++------
 include/block/accounting.h              |   8 +-
 include/block/block.h                   |   5 +-
 include/block/block_int.h               |  65 +++++++----
 include/block/dirty-bitmap.h            |  25 +++--
 include/qemu/stats64.h                  | 193 ++++++++++++++++++++++++++=
++++++
 include/sysemu/block-backend.h          |  10 +-
 migration/block.c                       |  17 ++-
 tests/docker/Makefile.include           |   2 +-
 tests/docker/dockerfiles/centos6.docker |   2 +-
 tests/docker/dockerfiles/fedora.docker  |   4 +-
 util/Makefile.objs                      |   1 +
 util/stats64.c                          | 136 ++++++++++++++++++++++
 23 files changed, 687 insertions(+), 185 deletions(-)
 create mode 100644 include/qemu/stats64.h
 create mode 100644 util/stats64.c

--=20
2.9.4
