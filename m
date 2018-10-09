Received: from eggs.gnu.org ([2001:4830:134:3::10]:34831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9lUY-0000At-Ox
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9lUV-0006RB-Kx
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9lUV-0006Q4-Em
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:27:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8ECB601B
	for <qemu-devel@nongnu.org>; Tue,  9 Oct 2018 06:27:33 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  9 Oct 2018 14:27:12 +0800
Message-Id: <20181009062718.1914-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v9 0/6] monitor: enable OOB by default
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

v9:
- add r-bs
- release the qmp queue lock before resume [Marc-Andre]

v8:
- remove patch 1 & 2 since already in the QAPI pull
- squash patch 3 & 4, use Markus's version of commit message (with
  some of my additions), make sure popping and reading queue length is
  in the same critical section [Markus]
- add one patch to cover test for queue full [Markus]
- add one patch to resume the monitor earlier when queue not full [Markus=
]

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
 monitor.c                 | 82 ++++++++++++++++-----------------------
 qapi/misc.json            | 40 -------------------
 tests/libqtest.c          | 10 ++---
 tests/libqtest.h          |  4 +-
 tests/qmp-test.c          | 32 +++++++++++++--
 tests/test-qmp-cmds.c     | 16 ++++++++
 vl.c                      |  5 ---
 9 files changed, 89 insertions(+), 108 deletions(-)

--=20
2.17.1
