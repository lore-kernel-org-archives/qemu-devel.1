Received: from eggs.gnu.org ([2001:4830:134:3::10]:53806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6hy-0005Of-No
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6hu-0002QE-Ql
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6hu-0002Q9-Kj
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:30 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 984FE75EDE
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:30 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:18 +0100
Message-Id: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 00/10] Preparation for block job mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com

These are a bunch of cleanups and patches extracted from the AioContext
lock removal series.  They are independent and can be applied/reviewed
separately.  The flip side is that several of the changes seem to be a
bit gratuitous without the big change from AioContext lock to a specific
block job mutex for all block job data structures.

While the patch set seems very large, a lot of it just moving the code
around to avoid forward references; this is so that close functions will
have similar locking rules.

Paolo

Paolo Bonzini (10):
  blockjob: remove unnecessary check
  blockjob: remove iostatus_reset callback
  blockjob: introduce block_job_fail
  blockjob: introduce block_job_pause/resume_all
  blockjob: separate monitor and blockjob APIs
  blockjob: move iostatus reset inside block_job_user_resume
  blockjob: strengthen a bit test-blockjob-txn
  blockjob: introduce block_job_cancel_async
  blockjob: reorganize block_job_completed_txn_abort
  blockjob: use deferred_to_main_loop to indicate the coroutine has
    ended

 block/backup.c               |   2 +-
 block/commit.c               |   2 +-
 block/io.c                   |  18 +-
 block/mirror.c               |   2 +-
 blockdev.c                   |   1 -
 blockjob.c                   | 559 ++++++++++++++++++++++++-------------------
 include/block/blockjob.h     |  14 +-
 include/block/blockjob_int.h |  21 +-
 tests/test-blockjob-txn.c    |   7 +-
 tests/test-blockjob.c        |  10 +-
 10 files changed, 334 insertions(+), 302 deletions(-)

-- 
2.9.3
