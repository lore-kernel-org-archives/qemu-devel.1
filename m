Received: from eggs.gnu.org ([2001:4830:134:3::10]:50267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxt-00083F-OS
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxq-000679-Hf
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52324 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxq-00066B-Ap
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:35:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA3015BCDD
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 855192026D76
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:24 +0200
Message-Id: <20180703213556.20619-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 00/32] Monitor patches for 2018-07-03
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit e8c858944ea61923ca563bb5905bf04624d05f=
16:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-07-02 19:07:19 +0100)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-07-03-v2

for you to fetch changes up to 153d73f320f422ecb5807ac3a93547b9f819599b:

  qapi: Polish command flags documentation in qapi-code-gen.txt (2018-07-=
03 23:18:56 +0200)

----------------------------------------------------------------
Monitor patches for 2018-07-03

----------------------------------------------------------------
Markus Armbruster (32):
      qmp: Say "out-of-band" instead of "Out-Of-Band"
      monitor: Spell "I/O thread" consistently in comments
      docs/interop/qmp: Improve OOB documentation
      qmp: Document COMMAND_DROPPED design flaw
      qmp: Get rid of x-oob-test command
      tests/qmp-test: Test in-band command doesn't overtake
      qmp: Make "id" optional again even in "oob" monitors
      tests/test-qga: Demonstrate the guest-agent ignores "id"
      qmp qemu-ga: Revert change that accidentally made qemu-ga accept "i=
d"
      tests/test-qga: Demonstrate the guest-agent ignores "control"
      qmp qemu-ga: Fix qemu-ga not to accept "control"
      qmp: Redo how the client requests out-of-band execution
      qmp: Revert change to handle_qmp_command tracepoint
      qmp: Always free QMPRequest with qmp_request_free()
      qmp: Simplify code around monitor_qmp_dispatch_one()
      tests/qmp-test: Demonstrate QMP errors jumping the queue
      qmp: Don't let malformed in-band commands jump the queue
      qmp: Don't let JSON errors jump the queue
      monitor: Rename use_io_thr to use_io_thread
      monitor: Peel off @mon_global wrapper
      qobject: New qdict_from_jsonf_nofail()
      qmp: De-duplicate error response building
      qmp: Use QDict * instead of QObject * for response objects
      qmp: Replace monitor_json_emitter{,raw}() by qmp_{queue,send}_respo=
nse()
      qmp: Replace get_qmp_greeting() by qmp_greeting()
      qmp: Simplify monitor_qmp_respond()
      qmp: Add some comments around null responses
      qmp: Switch timestamp_put() to qdict_from_jsonf_nofail()
      qobject: Let qobject_from_jsonf() fail instead of abort
      qmp: Clean up capability negotiation after commit 02130314d8c
      monitor: Improve some comments
      qapi: Polish command flags documentation in qapi-code-gen.txt

 docs/devel/qapi-code-gen.txt            |  63 ++--
 docs/interop/qmp-intro.txt              |  13 +-
 docs/interop/qmp-spec.txt               |  85 ++++--
 include/qapi/qmp/dispatch.h             |   6 +-
 include/qapi/qmp/qjson.h                |   2 +
 monitor.c                               | 507 +++++++++++++-------------=
------
 qapi/misc.json                          |  23 +-
 qapi/qmp-dispatch.c                     |  97 +++---
 qapi/qmp-event.c                        |  10 +-
 qga/main.c                              |  18 +-
 qmp.c                                   |  16 -
 qobject/qjson.c                         |  23 +-
 tests/qapi-schema/qapi-schema-test.json |   2 +-
 tests/qmp-test.c                        | 105 +++++--
 tests/test-qga.c                        |  34 +++
 tests/test-qmp-cmds.c                   |  23 +-
 16 files changed, 505 insertions(+), 522 deletions(-)

--=20
2.17.1
