Received: from eggs.gnu.org ([2001:4830:134:3::10]:34178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoP-0004Xn-Jb
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoK-0001RU-HP
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoK-0001QS-Ba
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:24 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57F523DBCC
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:08 +0200
Message-Id: <20170419144219.20371-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for 2.10 00/11] Preparation for block job mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, jcody@redhat.com, stefanha@redhat.com

These are a bunch of cleanups and patches extracted from the AioContext
lock removal series.  As a general theme, the patches reorganize
blockjob.c to follow the blockjob.h/blockjob_int.h separation more
closely.  For this reason, a lot of the patches are just moving functions
around.

The blockjob.h/blockjob_int.h split later will correspond to different
locking rules, but the patches are independent from this change, and
can be applied/reviewed separately.

The main change from v1 to v2 is that John helped me realize the match
between the future locking rules and the blockjob.h/blockjob_int.h split;
therefore I have adjusted code comments and commit messages to mention it=
.

Thanks,

Paolo

Paolo Bonzini (11):
  blockjob: remove unnecessary check
  blockjob: remove iostatus_reset callback
  blockjob: introduce block_job_early_fail
  blockjob: introduce block_job_pause/resume_all
  blockjob: separate monitor and blockjob APIs
  blockjob: move iostatus reset inside block_job_user_resume
  blockjob: introduce block_job_cancel_async, check iostatus invariants
  blockjob: group BlockJob transaction functions together
  blockjob: strengthen a bit test-blockjob-txn
  blockjob: reorganize block_job_completed_txn_abort
  blockjob: use deferred_to_main_loop to indicate the coroutine has
    ended

 block/backup.c               |   2 +-
 block/commit.c               |   2 +-
 block/io.c                   |  19 +-
 block/mirror.c               |   2 +-
 blockdev.c                   |   1 -
 blockjob.c                   | 900 +++++++++++++++++++++++--------------=
------
 include/block/blockjob.h     |  16 -
 include/block/blockjob_int.h |  27 +-
 tests/test-blockjob-txn.c    |   7 +-
 tests/test-blockjob.c        |  10 +-
 10 files changed, 522 insertions(+), 464 deletions(-)

--=20
2.9.3
