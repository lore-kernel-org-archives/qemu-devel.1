Received: from eggs.gnu.org ([2001:4830:134:3::10]:37172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxRE2-0006Vw-Pz
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxRE0-0006w6-VM
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxRE0-0006gz-E2
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:23:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD18A40216E6
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 06:23:27 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Sep 2018 14:23:07 +0800
Message-Id: <20180905062313.4059-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 0/6] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Based-on: <20180828191048.29806-1-armbru@redhat.com>
Based-on: <20180901111716.1675-1-armbru@redhat.com>

(this series is based on Markus's monitor-next tree)

v8:
- remove patch 1 & 2 since already in the QAPI pull
- squash patch 3 & 4, use Markus's version of commit message (with
  some of my additions), make sure popping and reading queue length is
  in the same critical section [Markus]
- add one patch to cover test for queue full [Markus]
- add one patch to resume the monitor earlier when queue not full [Markus]

v7:
- use Markus's commit message for patch "qapi: Drop
  qapi_event_send_FOO()'s Error ** argument" [Markus]
- update commit message for "qapi: remove COMMAND_DROPPED event" since
  QEMU 3.0 is released [Eric/Dave]
- rebase to Markus's monitor-next tree:
  http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/monitor-next
  the patch "monitor: suspend monitor instead of send CMD_DROP"
  re-written since people prefer to drop need_resume flag so now I
  hand-made it.  Dropped a few patches since not appliable any more.

Please review.  Thanks,

Peter Xu (6):
  monitor: Suspend monitor instead dropping commands
  monitor: resume the monitor earlier if needed
  monitor: remove "x-oob", turn oob on by default
  Revert "tests: Add parameter to qtest_init_without_qmp_handshake"
  tests: add oob functional test for test-qmp-cmds
  tests: qmp-test: add queue full test

 docs/interop/qmp-spec.txt |  5 ++-
 include/monitor/monitor.h |  3 +-
 monitor.c                 | 80 +++++++++++++++------------------------
 qapi/misc.json            | 40 --------------------
 tests/libqtest.c          | 10 ++---
 tests/libqtest.h          |  4 +-
 tests/qmp-test.c          | 32 ++++++++++++++--
 tests/test-qmp-cmds.c     | 16 ++++++++
 vl.c                      |  5 ---
 9 files changed, 86 insertions(+), 109 deletions(-)

-- 
2.17.1
