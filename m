Received: from eggs.gnu.org ([2001:4830:134:3::10]:49006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1Ue-0000u0-Mk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX1UZ-0003Jv-Nv
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gX1UZ-0003JL-HC
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:11:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDB2030014CD
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-56.ams2.redhat.com
	[10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B3D019743
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 12 Dec 2018 11:11:34 +0100
Message-Id: <20181212101145.3496-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/11] Monitor patches for 2018-12-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af4220=
86:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-r=
equest' into staging (2018-12-11 19:18:58 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-12-12

for you to fetch changes up to c55f070b7195cee4e06998c10f57f13c7df98dbd:

  tests: add oob functional test for test-qmp-cmds (2018-12-12 10:28:27 +=
0100)

----------------------------------------------------------------
Monitor patches for 2018-12-12

* Fixes related to running the monitor in an I/O thread
* Change how OOB-enabled QMP monitors handle flow control: suspend
  monitor instead dropping commands
* Offer QMP capability "oob" unconditionally, remove "x-oob"

----------------------------------------------------------------
Marc-Andr=C3=A9 Lureau (7):
      monitor: inline ambiguous helper functions
      monitor: accept chardev input from iothread
      char: add a QEMU_CHAR_FEATURE_GCONTEXT flag
      monitor: check if chardev can switch gcontext for OOB
      colo: check chardev can switch context
      monitor: prevent inserting new monitors after cleanup
      monitor: avoid potential dead-lock when cleaning up

Peter Xu (4):
      monitor: Suspend monitor instead dropping commands
      monitor: Remove "x-oob", offer capability "oob" unconditionally
      Revert "tests: Add parameter to qtest_init_without_qmp_handshake"
      tests: add oob functional test for test-qmp-cmds

 chardev/char.c            |  11 ++++
 docs/interop/qmp-spec.txt |   5 +-
 include/chardev/char.h    |   3 +
 include/monitor/monitor.h |   3 +-
 monitor.c                 | 139 +++++++++++++++++++++++-----------------=
------
 net/colo-compare.c        |   6 ++
 qapi/misc.json            |  40 -------------
 tests/libqtest.c          |   9 ++-
 tests/libqtest.h          |   4 +-
 tests/qmp-test.c          |   6 +-
 tests/test-qmp-cmds.c     |  16 ++++++
 vl.c                      |   5 --
 12 files changed, 118 insertions(+), 129 deletions(-)

--=20
2.17.2
