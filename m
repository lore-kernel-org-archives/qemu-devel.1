Received: from eggs.gnu.org ([2001:4830:134:3::10]:41544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHu-0008K2-GB
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dHrHr-0005jr-Db
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dHrHr-0005iD-7a
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:39:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EE6080C18
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:39:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  5 Jun 2017 14:38:49 +0200
Message-Id: <20170605123908.18777-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/19] Block layer thread safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

v3->v4: rebased and included fixes in Fam's v2 pull request
        new patch 18, fixing testsuite failures on OS X

Paolo Bonzini (19):
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
  block: split BlockAcctStats creation and setup
  block: make accounting thread-safe

 block.c                        |   9 +-
 block/accounting.c             |  78 ++++++++++-------
 block/block-backend.c          |   6 +-
 block/dirty-bitmap.c           | 112 ++++++++++++++++++++++--
 block/io.c                     |  51 ++++++-----
 block/mirror.c                 |  14 ++-
 block/nfs.c                    |   4 +-
 block/qapi.c                   |   2 +-
 block/sheepdog.c               |   3 +-
 block/throttle-groups.c        |  91 ++++++++++++++-----
 blockdev.c                     |  48 ++--------
 include/block/accounting.h     |  11 ++-
 include/block/block.h          |   5 +-
 include/block/block_int.h      |  61 ++++++++-----
 include/block/dirty-bitmap.h   |  25 ++++--
 include/qemu/stats64.h         | 193 +++++++++++++++++++++++++++++++++++++++++
 include/sysemu/block-backend.h |  10 +--
 migration/block.c              |  17 ++--
 util/Makefile.objs             |   1 +
 util/stats64.c                 | 137 +++++++++++++++++++++++++++++
 20 files changed, 693 insertions(+), 185 deletions(-)
 create mode 100644 include/qemu/stats64.h
 create mode 100644 util/stats64.c

-- 
2.13.0
