Received: from eggs.gnu.org ([2001:4830:134:3::10]:37634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsiC-0002hi-1k
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cTsi7-0007Ly-7q
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cTsi6-0007LK-VQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:03:43 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACD7877E44
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:03:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 18 Jan 2017 20:03:07 +0400
Message-Id: <20170118160332.13390-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kraxel@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

One of initial design goals of QMP was to have "asynchronous command
completion" (http://wiki.qemu.org/Features/QAPI). Unfortunately, that
goal was not fully achieved, and some broken bits left were removed
progressively until commit 65207c59d that removed async command
support.

Note that qmp events are asynchronous messages, and must be handled
appropriately by the client: dispatch both reply and events after a
command is sent for example.

The benefits of async commands that can be trade-off depending on the
requirements are:

1) allow the command handler to re-enter the main loop if the command
cannot be handled synchronously, or if it is long-lasting. This is
currently not possible and make some bugs such as rhbz#1230527 tricky
(see below) to solve.  Furthermore, many QMP commands do IO and could
be considered 'slow' and blocking today.

2) allow concurrent commands and events. This mainly implies hanlding
concurrency in qemu and out-of-order replies for the client. As noted
earlier, a good qmp client already has to handle dispatching of
received messages (reply and events).

The traditional approach to solving the above in qemu is the following
scheme:
-> { "execute": "do-foo" }
<- { "return": {} }
<- { "event": "FOO_DONE" }

It has several flaws:
- FOO_DONE event has no semantic link with do-foo in the qapi
  schema. It is not simple to generalize that pattern when writing
  qmp clients. It makes documentation and usage harder.
- the FOO_DONE event has no clear association with the command that
  triggered it: commands/events have to come up with additional
  specific association schemes (ids, path etc)
- FOO_DONE is broadcasted to all clients, but they may have no way to
  interprete it or interest in it, or worse it may conflict with their
  own commands.
- the arguably useless empty reply return

For some cases, it makes sense to use that scheme, or a more complete
one: to have an "handler" associated with an on-going operation, that
can be queried, modified, cancelled etc (block jobs etc). Also, some
operations have a global side-effect, in which case that cmd+event
scheme is right, as all clients are listening for global events.

However, for the simple case where a client want to perform a "local
context" operation (dump, query etc), QAPI can easily do better
without resorting to this pattern: it can send the reply when the
operation is done. That would make QAPI schema, usage and
documentation more obvious.

The following series implements an async solution, by introducing a
context associated with a command, it can:
- defer the return
- return only to the caller (no broadcasted event)
- return with the 'id' associated with the call (as originally intended)
- optionnally allow cancellation when the client is gone
- track on-going qapi command(s) per client

1) existing qemu commands can be gradually replaced by async:true
variants when needed, and by carefully reviewing the concurrency
aspects. The async:true commands marshaller helpers are splitted in
half, the calling and return functions. The command is called with a
QmpReturn context, that can return immediately or later, using the
generated return helper.

2) allow concurrent commands when 'async' is negotiated. If the client
doesn't support 'async', then the monitor is suspended during command
execution (events are still sent). Effectively, async commands behave
like normal commands from client POV in this case, giving full
backward compatibility.

The screendump command is converted to an async:true version to solve
rhbz#1230527. The command shows basic cancellation (this could be
extended if needed). HMP remains sync, but it would be worth to make
it possible to call async:true qapi commands.

The last patch cleans up qmp_dispatch usage to have consistant checks
between qga & qemu, and simplify QmpClient/parser_feed usage.

v2:
- documentation fixes and improvements
- fix calling async commands sync without id
- fix bad hmp monitor assert
- add a few extra asserts
- add async with no-id failure and screendump test

Marc-Andr=C3=A9 Lureau (25):
  tests: start generic qemu-qmp tests
  tests: change /0.15/* tests to /qmp/*
  qmp: teach qmp_dispatch() to take a pre-filled QDict
  qmp: use a return callback for the command reply
  qmp: add QmpClient
  qmp: add qmp_return_is_cancelled()
  qmp: introduce async command type
  qapi: ignore top-level 'id' field
  qmp: take 'id' from request
  qmp: check that async command have an 'id'
  scripts: learn 'async' qapi commands
  tests: add dispatch async tests
  monitor: add 'async' capability
  monitor: add !qmp pre-conditions
  monitor: suspend when running async and client has no async
  qmp: update qmp-spec about async capability
  qtest: add qtest-timeout
  qtest: add qtest_init_qmp_caps()
  tests: add tests for async and non-async clients
  qapi: improve 'screendump' documentation
  console: graphic_hw_update return true if async
  console: add graphic_hw_update_done()
  console: make screendump async
  qtest: add /qemu-qmp/screendump test
  qmp: move json-message-parser and check to QmpClient

 qapi-schema.json                        |  45 +++++-
 qapi/introspect.json                    |   2 +-
 scripts/qapi.py                         |  14 +-
 scripts/qapi-commands.py                | 139 ++++++++++++++---
 scripts/qapi-introspect.py              |   7 +-
 hw/display/qxl.h                        |   2 +-
 include/qapi/qmp/dispatch.h             |  66 +++++++-
 include/ui/console.h                    |   5 +-
 tests/libqtest.h                        |   9 ++
 hmp.c                                   |   2 +-
 hw/display/qxl-render.c                 |  14 +-
 hw/display/qxl.c                        |   8 +-
 monitor.c                               | 213 +++++++++++++-------------
 qapi/qmp-dispatch.c                     | 260 ++++++++++++++++++++++++++=
+++---
 qapi/qmp-registry.c                     |  25 ++-
 qga/main.c                              |  73 ++-------
 qobject/json-lexer.c                    |   4 +-
 qtest.c                                 |  48 ++++++
 tests/libqtest.c                        |  13 +-
 tests/qmp-test.c                        | 191 +++++++++++++++++++++++
 tests/test-qmp-commands.c               | 211 ++++++++++++++++++++++----
 ui/console.c                            |  86 ++++++++++-
 MAINTAINERS                             |   1 +
 docs/qmp-spec.txt                       |  48 +++++-
 tests/Makefile.include                  |   3 +
 tests/qapi-schema/async.err             |   0
 tests/qapi-schema/async.exit            |   1 +
 tests/qapi-schema/async.json            |   6 +
 tests/qapi-schema/async.out             |  10 ++
 tests/qapi-schema/qapi-schema-test.json |   6 +
 tests/qapi-schema/qapi-schema-test.out  |   6 +
 tests/qapi-schema/test-qapi.py          |   7 +-
 32 files changed, 1236 insertions(+), 289 deletions(-)
 create mode 100644 tests/qmp-test.c
 create mode 100644 tests/qapi-schema/async.err
 create mode 100644 tests/qapi-schema/async.exit
 create mode 100644 tests/qapi-schema/async.json
 create mode 100644 tests/qapi-schema/async.out

--=20
2.11.0.295.gd7dffce1c
