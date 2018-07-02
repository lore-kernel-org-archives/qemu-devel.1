Received: from eggs.gnu.org ([2001:4830:134:3::10]:42426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1aq-0004Qv-5b
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1an-0006aU-12
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40446 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1am-0006a6-Qz
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 048CD805A530
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:21:46 +0200
Message-Id: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 00/32] qmp: Fixes and cleanups around OOB
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

We're trying to get the out-of-band execution feature ready.  This
series fixes a number of issues, and marks a design flaw FIXME.  More
work is needed.

Markus Armbruster (32):
  qmp: Say "out-of-band" instead of "Out-Of-Band"
  monitor: Spell "I/O thread" consistently in comments
  docs/interop/qmp: Improve OOB documentation
  qmp: Document COMMAND_DROPPED design flaw
  qmp: Get rid of x-oob-test command
  tests/qmp-test: Test in-band command doesn't overtake
  qmp: Make "id" optional again even in "oob" monitors
  tests/test-qga: Demonstrate the guest-agent ignores "id"
  qmp qemu-ga: Revert change that accidentally made qemu-ga accept "id"
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
  qmp: Replace monitor_json_emitter{,raw}() by
    qmp_{queue,send}_response()
  qmp: Replace get_qmp_greeting() by qmp_greeting()
  qmp: Simplify monitor_qmp_respond()
  qmp: Add some comments around null responses
  qmp: Switch timestamp_put() to qdict_from_jsonf_nofail()
  qobject: Let qobject_from_jsonf() fail instead of abort
  qmp: Clean up capability negotiation after commit 02130314d8c
  monitor: Improve some comments
  qapi: Polish command flags documentation in qapi-code-gen.txt

 docs/devel/qapi-code-gen.txt            |  63 ++-
 docs/interop/qmp-intro.txt              |  13 +-
 docs/interop/qmp-spec.txt               |  81 ++--
 include/qapi/qmp/dispatch.h             |   6 +-
 include/qapi/qmp/qjson.h                |   2 +
 monitor.c                               | 507 ++++++++++--------------
 qapi/misc.json                          |  23 +-
 qapi/qmp-dispatch.c                     |  97 ++---
 qapi/qmp-event.c                        |  10 +-
 qga/main.c                              |  18 +-
 qmp.c                                   |  16 -
 qobject/qjson.c                         |  23 +-
 tests/qapi-schema/qapi-schema-test.json |   2 +-
 tests/qmp-test.c                        | 103 +++--
 tests/test-qga.c                        |  34 ++
 tests/test-qmp-cmds.c                   |  23 +-
 16 files changed, 499 insertions(+), 522 deletions(-)

-- 
2.17.1
