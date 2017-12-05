Received: from eggs.gnu.org ([2001:4830:134:3::10]:33144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM69S-0002Vi-AD
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eM69P-0000nR-N9
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:52:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eM69P-0000me-ET
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 00:52:15 -0500
From: Peter Xu <peterx@redhat.com>
Date: Tue,  5 Dec 2017 13:51:34 +0800
Message-Id: <20171205055200.16305-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v5 00/26] QMP: out-of-band (OOB) execution support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This version is mostly document update, and dropped the single patch
that is migration related (will be put into postcopy recovery
series).

v5
- rename "monitor_iothread" to "mon_iothread" [Dave]
- add comment in monitor_cleanup(), note that when the hacks can be
  removed. [Dan]
- add a note section in qmp-spec.txt, mentioning about how to migrate
  existing QMP command to oob-capable command. [Dave]
- drop patch "qmp: let migrate-incoming allow out-of-band".  All
  migration related changes will all be put into postcopy-recovery
  series.

v4:
- drop first patch to fix IOWatchPool [Stefan, Dan]
- add s-o-b where missing, and newly got r-bs
- fix English error in commit msg [Fam]
- some tunes on request-dropped event:  [Stefan]
  - firstly let 'id' be any type, meanwhile make sure "id" is there as
    long as OOB is enabled for the monitor.
  - some comments fix
- add new command "x-oob-test" for testing oob commands [Stefan]
- simplify the test codes to use new x-oob-test
- flush response queue before cleanup monitors

This series was born from this one:

  https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.html

The idea comes from Markus Armbruster and the discussion we had in the
thread.  It's not a super ideal solution (I believe Markus had been
thinking hard to keep everything in order meanwhile trying to satisfy
the migration requirement), but AFAIU it's currently the best.

What is OOB?
============

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
     JSON Parser ======> QMP Dispatcher =====> Responder
         /|\ |     (3)       /|\  |      (4)      | /|\
      (1) |  | (2)            |   |               |  |
          |  |                |  \|/           (6)|  |(5)
          |  |            main thread             |  |
          |  |                                    |  |
          |  +--------> monitor IO thread <-------+  |
          +-----------/                   \----------+

New Interfaces
==============

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
=================

The last patch of OOB test may need some attention.  I used
dump-guest-memory as a time-consuming command to test whether OOB is
working, and the only command I can test now is "migrate-incoming".  I
hope that is a "okay" solution for unit tests.  Any other suggestions
on that would be welcomed.

Please review.  Thanks.

Peter Xu (26):
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
  monitor: let suspend_cnt be thread safe
  monitor: separate QMP parser and dispatcher
  qmp: add new event "request-dropped"
  monitor: send event when request queue full
  qapi: introduce new cmd option "allow-oob"
  qmp: support out-of-band (oob) execution
  qmp: isolate responses into io thread
  monitor: enable IO thread for (qmp & !mux) typed
  qmp: add command "x-oob-test"
  docs: update QMP documents for OOB commands
  tests: qmp-test: verify command batching
  tests: qmp-test: add oob test

 docs/devel/qapi-code-gen.txt     |  51 +++-
 docs/interop/qmp-spec.txt        |  49 +++-
 include/monitor/monitor.h        |   2 +-
 include/qapi/qmp/dispatch.h      |   2 +
 include/qapi/qmp/json-streamer.h |  10 +-
 include/qapi/qmp/qstring.h       |   2 +
 monitor.c                        | 566 +++++++++++++++++++++++++++++++++------
 qapi-schema.json                 |  80 +++++-
 qapi/introspect.json             |   6 +-
 qapi/qmp-dispatch.c              |  39 +++
 qga/main.c                       |   5 +-
 qmp.c                            |  16 ++
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
 tests/qmp-test.c                 |  90 ++++++-
 trace-events                     |   2 +
 vl.c                             |   3 +-
 25 files changed, 892 insertions(+), 125 deletions(-)

-- 
2.14.3
