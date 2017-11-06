Received: from eggs.gnu.org ([2001:4830:134:3::10]:47468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBdzm-0003d4-5R
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:47:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBdzi-0003VQ-3F
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:47:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBdzh-0003Ub-QC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:47:02 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon,  6 Nov 2017 17:46:16 +0800
Message-Id: <20171106094643.14881-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 00/27] QMP: out-of-band (OOB) execution support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is RFC v3 of Monitor Out-Of-Band series.  It's getting longer and
changes happens between versions, so I decided to re-write the cover
letter.

This series was born from this one:

  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.html

The idea comes from Markus Armbruster and the discussion we had in the
thread.  It's not a super ideal solution (I believe Markus had been
thinking hard to keep everything in order meanwhile trying to satisfy
the migration requirement), but AFAIU it's currently the best.

What is OOB?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It's the shortcut of Out-Of-Band execution, its name is given by
Markus.  It's a way to quickly execute a QMP request.  Say, originally
QMP is going throw these steps:

      JSON Parser --> QMP Dispatcher --> Respond
          /|\    (2)                (3)     |
       (1) |                               \|/ (4)
           +---------  main thread  --------+

The requests are executed by the so-called QMP-dispatcher after the
JSON is parsed.  If OOB is on, we run the command directly in the
parser and quickly returns.

This series changed the QMP handling logic by moving the command
parsing and responding phases into IOThreads, so to be more accurate,
after the series the above graph would change into this:

               queue/kick              queue/kick
     JSON Parser =3D=3D=3D=3D=3D=3D> QMP Dispatcher =3D=3D=3D=3D=3D> Resp=
onder
         /|\ |     (3)       /|\  |      (4)      | /|\
      (1) |  | (2)            |   |               |  |
          |  |                |  \|/           (6)|  |(5)
          |  |            main thread             |  |
          |  |                                    |  |
          |  +--------> monitor IO thread <-------+  |
          +-----------/                   \----------+

New Interfaces
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

QMP Introspection Changes
-------------------------

When do query-qmp-schema, we were getting something like:

  {"name": "migrate-incoming", "ret-type": "17",
   "meta-type": "command", "arg-type": "89"}

Now we will get a new key named "allow-oob":

  {"name": "migrate-incoming", "ret-type": "17", "allow-oob": true,
   "meta-type": "command", "arg-type": "89"}

Which shows whether a command supports OOB.

QMP Negociation Changes
-----------------------

We were running "qmp_capabilities" always without parameters like:

  {"execute": "qmp_capabilities"}

Now we can enable capabilities (we don't have any capability before
this series) like OOB using:

  {"execute": "qmp_capabilities", "arguments": {"enable": ["oob"]}}

Only after we explicitly enable OOB capability can we send requests in
OOB manner.  Otherwise we'll have exactly the same QMP session as
before, just like when OOB is not there.

When OOB is enabled, it's possible that OOB reply reaches faster than
previous command, so clients should be prepared.

Trigger OOB execution
---------------------

Let's take migrate-incoming as example.  The old command looks like:

  {"execute": "migrate-incoming", "arguments" : {"uri": "xxxxxx"}}

To execute a command with OOB execution, we need to specify it in the
QMP request in the extra "control" key:

  {"execute": "migrate-incoming", "arguments" : {"uri": "xxxxxx"},
   "control" { "run-oob": true } }

Then the command will be run in parser, and it can preempt other
commands.

Others
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The last patch of OOB test may need some attention.  I used
dump-guest-memory as a time-consuming command to test whether OOB is
working, and the only command I can test now is "migrate-incoming".  I
hope that is a "okay" solution for unit tests.  Any other suggestions
on that would be welcomed.

v3 changelog:
- inline monitor_io_thread_destroy(). [Stefan]
- rename usage of "*io_thread*" into "*iothread*" [Stefan]
- fixed quite a few English errors [Stefan]
- add the missing "return" (oops!) in handle_qmp_command(). [Stefan]
- rename QMP_ASYNC_QUEUE_LEN_MAX to QMP_REQ_QUEUE_LEN_MAX. [Stefan]
- add OOB cap negociationg phase, conditionally enable OOB.  Make sure
  that old QMP client requests will never be dropped by using
  monitor_suspend() when OOB not enabled. [Stefan]
- add new lock Monitor.qmp.qmp_queue_lock, then take it when queuing
  for requests/responses. [Stefan]
- move Monitor fields "qmp_requests" & "qmp_responses" into MonitorQMP
  struct for cleaness.
- write more tests for oob, and some smoke test with libvirt, hoping
  that it won't break too many things

v2 changelog:
- use 10-char hash for git commit ID [Eric]
- instead of changing qstring_get_str(), add new
  qstring_get_try_str(), and rename qobject_get_str() to
  qobject_get_try_str() to follow the naming rule [Eric]
- add one more patch to let object_property_get_str() leverage the new
  qobject_get_try_str(). [Eric]
- introduce JSONMessageEmitFunc in the JSON parser patch [Eric]
- use per-monitor request queue, rather than a global queue
- add queue flow control, when full (current queue depth: 8), send
  event to notify client (two new patches added for this)
- stop monitor thread first before destroying monitor objects [Dan]
- document that client should drop responses with unknown IDs.
- move all the documents into a single standalone patch.
- use iothread for the monitor io thread.
- respond in IO thread, rather than the dispatcher
- new patch: in QMP greeting message, add 'oob' field in
  'capabilities', so that client can explicitly know whether server
  supports oob

Please review.  Thanks.

Peter Xu (27):
  char-io: fix possible race on IOWatchPoll
  qobject: introduce qstring_get_try_str()
  qobject: introduce qobject_get_try_str()
  qobject: let object_property_get_str() use new API
  monitor: move skip_flush into monitor_data_init
  qjson: add "opaque" field to JSONMessageParser
  monitor: move the cur_mon hack deeper for QMP
  monitor: unify global init
  monitor: let mon_list be tail queue
  monitor: create monitor dedicate iothread
  monitor: allow to use IO thread for parsing
  qmp: introduce QMPCapability
  qmp: negociate QMP capabilities
  qmp: introduce some capability helpers
  monitor: introduce monitor_qmp_respond()
  monitor: let monitor_{suspend|resume} thread safe
  monitor: separate QMP parser and dispatcher
  qmp: add new event "request-dropped"
  monitor: send event when request queue full
  qapi: introduce new cmd option "allow-oob"
  qmp: support out-of-band (oob) execution
  qmp: let migrate-incoming allow out-of-band
  qmp: isolate responses into io thread
  monitor: enable IO thread for (qmp & !mux) typed
  docs: update QMP documents for OOB commands
  tests: qmp-test: verify command batching
  tests: qmp-test: add oob test

 chardev/char-io.c                |  16 +-
 docs/devel/qapi-code-gen.txt     |  51 +++-
 docs/interop/qmp-spec.txt        |  32 ++-
 include/monitor/monitor.h        |   2 +-
 include/qapi/qmp/dispatch.h      |   2 +
 include/qapi/qmp/json-streamer.h |  10 +-
 include/qapi/qmp/qstring.h       |   2 +
 monitor.c                        | 546 +++++++++++++++++++++++++++++++++=
------
 qapi-schema.json                 |  63 ++++-
 qapi/introspect.json             |   6 +-
 qapi/migration.json              |   3 +-
 qapi/qmp-dispatch.c              |  39 +++
 qga/main.c                       |   5 +-
 qobject/json-streamer.c          |   6 +-
 qobject/qjson.c                  |   5 +-
 qobject/qstring.c                |  21 ++
 qom/object.c                     |   9 +-
 scripts/qapi-commands.py         |  19 +-
 scripts/qapi-introspect.py       |  10 +-
 scripts/qapi.py                  |  15 +-
 scripts/qapi2texi.py             |   2 +-
 tests/libqtest.c                 |   5 +-
 tests/qapi-schema/test-qapi.py   |   2 +-
 tests/qmp-test.c                 | 122 ++++++++-
 trace-events                     |   2 +
 vl.c                             |   3 +-
 26 files changed, 876 insertions(+), 122 deletions(-)

--=20
2.13.5
