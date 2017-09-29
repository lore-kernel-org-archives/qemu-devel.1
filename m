Received: from eggs.gnu.org ([2001:4830:134:3::10]:35759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm8g-00057h-4n
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm8c-000697-Tb
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:38:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm8c-00068h-KQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:38:54 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:22 +0800
Message-Id: <20170929033844.26935-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 00/22] QMP: out-of-band (OOB) execution support
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is RFC version 2 of monitor OOB series.  It is based on following
series:

  [PATCH v4 0/5] iothread: allow to create internal iothreads
  (queued in Stefan's tree, pre-requisite for iothread usage)
  [PATCH v2 0/4] chardev: support non-default gcontext
  (queued in Paolo's tree, fix chardev reconnect issue)

Big changes from version 1:

* Use IOThread for monitor IO thread.

* Request queue switched from global queue to per-monitor queue, with
  basic flow control (currently 8 outstanding requests per monitor).

* Moved all documents into a single patch.

* Start to use "capabilities" field in QMP greeting message, to
  declare OOB support on server side.

* Added per-monitor response queue, so finally it looks like this:

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

TODO:
- qmp qtest for oob

Please review.  Thanks,

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D below is original RFC cover letter =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This series was born from this one:

  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.html

The design comes from Markus, and also the whole-bunch-of discussions
in previous thread.  My heartful thanks to Markus, Daniel, Dave,
Stefan, etc. on discussing the topic (...again!), providing shiny
ideas and suggestions.  Finally we got such a solution that seems to
satisfy everyone.

I re-started the versioning since this series is totally different
from previous one.  Now it's version 1.

In case new reviewers come along the way without reading previous
discussions, I will try to do a summary on what this is all about.

What is OOB execution?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

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

Yeah I know in current code the parser calls dispatcher directly
(please see handle_qmp_command()).  However it's not true again after
this series (parser will has its own IO thread, and dispatcher will
still be run in main thread).  So this OOB does brings something
different.

There are more details on why OOB and the difference/relationship
between OOB, async QMP, block/general jobs, etc.. but IMHO that's
slightly out of topic (and believe me, it's not easy for me to
summarize that).  For more information, please refers to [1].

Summary ends here.

Some Implementation Details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

Again, I mentioned that the old QMP workflow is this:

      JSON Parser --> QMP Dispatcher --> Respond
          /|\    (2)                (3)     |
       (1) |                               \|/ (4)
           +---------  main thread  --------+

What this series does is, firstly:

      JSON Parser     QMP Dispatcher --> Respond
          /|\ |           /|\       (4)     |
           |  | (2)        | (3)            |  (5)
       (1) |  +----->      |               \|/
           +---------  main thread  <-------+

And further:

               queue/kick
     JSON Parser =3D=3D=3D=3D=3D=3D> QMP Dispatcher --> Respond
         /|\ |     (3)       /|\        (4)    |
      (1) |  | (2)            |                |  (5)
          | \|/               |               \|/
        IO thread         main thread  <-------+

Then it introduced the "allow-oob" parameter in QAPI schema to define
commands, and "run-oob" flag to let oob-allowed command to run in the
parser.

The last patch enables this for "migrate-incoming" command.

Please review.  Thanks.

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.html

Peter Xu (22):
  char-io: fix possible race on IOWatchPoll
  qobject: introduce qstring_get_try_str()
  qobject: introduce qobject_get_try_str()
  qobject: let object_property_get_str() use new API
  monitor: move skip_flush into monitor_data_init
  qjson: add "opaque" field to JSONMessageParser
  monitor: move the cur_mon hack deeper for QMP
  monitor: unify global init
  monitor: create monitor dedicate iothread
  monitor: allow to use IO thread for parsing
  monitor: introduce monitor_qmp_respond()
  monitor: let mon_list be tail queue
  monitor: separate QMP parser and dispatcher
  qmp: add new event "request-dropped"
  monitor: send event when request queue full
  monitor: enable IO thread for (qmp & !mux) typed
  qapi: introduce new cmd option "allow-oob"
  qmp: support out-of-band (oob) execution
  qmp: let migrate-incoming allow out-of-band
  qmp: isolate responses into io thread
  qmp: introduce QMPCapability
  docs: update QMP documents for OOB commands

 chardev/char-io.c                |  16 +-
 docs/devel/qapi-code-gen.txt     |  51 ++++-
 docs/interop/qmp-spec.txt        |  24 ++-
 include/monitor/monitor.h        |   2 +-
 include/qapi/qmp/dispatch.h      |   2 +
 include/qapi/qmp/json-streamer.h |  10 +-
 include/qapi/qmp/qstring.h       |   2 +
 monitor.c                        | 441 ++++++++++++++++++++++++++++++++-=
------
 qapi-schema.json                 |  48 +++++
 qapi/introspect.json             |   6 +-
 qapi/migration.json              |   3 +-
 qapi/qmp-dispatch.c              |  34 +++
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
 tests/qmp-test.c                 |   2 +-
 trace-events                     |   2 +
 vl.c                             |   3 +-
 26 files changed, 630 insertions(+), 115 deletions(-)

--=20
2.13.5
