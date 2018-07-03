Received: from eggs.gnu.org ([2001:4830:134:3::10]:53154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4b-0001VR-K1
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4X-0007HR-IF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4X-0007G3-Ap
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:26 +0200
Message-Id: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 00/32] ] qmp: Fixes and cleanups around OOB
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
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

We're trying to get the out-of-band execution feature ready.  This
series fixes a number of issues, and marks a design flaw FIXME.  More
work is needed.

I pushed the series to my public repository for your convenience:
http://repo.or.cz/qemu/armbru.git/shortlog/refs/heads/oob-fixes

v2:
* Rebased (no conflicts)
* PATCH 03
  - Spelling fixes [Eric]
  - Use the greeting we expect for the release in examples [Eric]
* PATCH 05
  - Commit message improvement [Eric]
  - Avoid side effect in g_assert() [Eric]
  - Clarify in source that migrate-pause is expected to fail [Eric]
* PATCH 07
  - Add advice on the need to use "id" with out-of-band commands to
    documentation [Eric]
  - Tweak commit message
* PATCH 08
  - Comment tweak [Eric]

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
 docs/interop/qmp-spec.txt               |  85 ++--
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
 tests/qmp-test.c                        | 106 +++--
 tests/test-qga.c                        |  34 ++
 tests/test-qmp-cmds.c                   |  23 +-
 16 files changed, 506 insertions(+), 522 deletions(-)

-- 
2.17.1
