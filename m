Received: from eggs.gnu.org ([2001:4830:134:3::10]:41527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDt7-0007Z7-Ls
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1euDt5-0007k9-Fq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:00:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49262 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1euDt5-0007jy-2R
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 04:00:27 -0500
From: Peter Xu <peterx@redhat.com>
Date: Fri,  9 Mar 2018 16:59:43 +0800
Message-Id: <20180309090006.10018-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 00/23] QMP: out-of-band (OOB) execution
 support
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

Based-on: <20180306053320.15401-1-peterx@redhat.com>

The series is based on the following series:

  [PATCH v2 0/9] chardev: qio related non-default context support
  (actually patch 9 is based on version 2.1, Dan's version)

This version only contains some trivial changes, most of the work is
posted separately in either the QIO or CHARDEV series.

Four days until soft freeze.  Hmm...

Please review.  Thanks,

v8:
- fix up doc patch as suggested [Eric]
- rename functions in form of X_get_Y() or X_bh() [Stefan]
- English fixes [Stefan]
- make sure to kick iothread after suspend count update [Stefan]
- remove the hack to remove fd in monitor_init(), since now we have
  the QIO/CHARDEV series to solve the root problem.

v7:
- add some r-bs, and remove some.
- remove the chardev fix since already queued by Paolo
- use local var in qemu_chr_fe_add_watch [Stefan]
- move doc patch to front, mention it in some patches [Eric]
- Quite a few of English fixes [Eric]
- fix unlock missing in handle_qmp_command [Stefan]
- squash some patches according to the review comments
- don't break gdbserver usage on HMP non-interactive mode by fixing up
  the suspend/resume logic [Fam, Stefan]
- move the qemu_chr_fe_set_handlers() call in monitor_init() into a
  bottom half to avoid race between the call itself and
  iothread. [Stefan]
- spent quite a lot of time debugging another assertion failure in
  io_watch_poll_finalize() after above change is made (ouch! I really
  hoped we always have the latest glib): when QEMU inits chardevs in
  chardev_init_func() it's possible that QEMU registers the chardev
  handlers there, even before CharBackend is connected to that chardev
  in monitor_init().  Then, when we reach monitor_init() we must make
  sure we unregister that old one first, or there can have one orphan
  GSource still in default gcontext (note that this can really happen
  when we start to use QEMUBH to setup chardev frontends, which is
  above change).

v6:
- add r-bs
- s/negociate/negotiate/ [Dave]
- let mon_global be anonymous struct [Stefan]
- in monitor_init(): call qemu_chr_fe_set_handlers() later than init
  parser, then it's safe [Stefan]
- drop patch "qjson: add "opaque" field to JSONMessageParser",
  re-write the following one to use container_of(). [Stefan]
- keep get_qmp_greeting() the old way, add cap list [Stefan, Fam]
- fix the iothread_stop() comment since that's not really related to
  the glib bug [Stefan]
- when do qmp greeting, don't expose oob capability if iothread not
  used [Stefan, Fam]
- squash "qmp: introduce some capability helpers" into patch "monitor:
  separate QMP parser and dispatcher" [Fam]
- tune comments for monitor_qmp_respond(). [Stefan]
- use atomic_mb_{read|set}() where proper instead of no-mb ones
  [Stefan]
- add patch to let monitor suspend/resume really support QMP.  Notify
  iothread when needed, in both suspend/resume. [Stefan]
- add comment for qmp_queue_lock on lock taking ordering. [Stefan]
- refactor monitor_qmp_bh_dispatcher() to not loop, instead queue
  itself after each request. [Stefan]
- rename "request" into "command" in the new qmp event [Stefan]
- in handle_qmp_command() protect the queue length fetch with
  qmp_queue_lock [Stefan]
- one more s/2.11/2.12/.  [Fam]
- when isolating response queue, not only flush the queue, but also
  flush the monitor out buffer [Stefan]
- document rewrite [Stefan]
- some other touch-ups that I forgot to mention and some tiny new
  patches... anyway, rbs will be gone if any of the patch is touched
  up.  Please have a look!

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

Peter Xu (23):
  docs: update QMP documents for OOB commands
  qobject: introduce qstring_get_try_str()
  qobject: introduce qobject_get_try_str()
  qobject: let object_property_get_str() use new API
  monitor: move skip_flush into monitor_data_init
  monitor: move the cur_mon hack deeper for QMP
  monitor: unify global init
  monitor: let mon_list be tail queue
  monitor: allow using IO thread for parsing
  qmp: introduce QMPCapability
  monitor: introduce monitor_qmp_respond()
  monitor: let suspend_cnt be thread safe
  monitor: let suspend/resume work even with QMPs
  monitor: separate QMP parser and dispatcher
  qmp: add new event "command-dropped"
  monitor: send event when command queue full
  qapi: introduce new cmd option "allow-oob"
  qmp: support out-of-band (oob) execution
  qmp: isolate responses into io thread
  monitor: enable IO thread for (qmp & !mux) typed
  qmp: add command "x-oob-test"
  tests: qmp-test: verify command batching
  tests: qmp-test: add oob test

 docs/devel/qapi-code-gen.txt   |  65 +++-
 docs/interop/qmp-spec.txt      |  30 +-
 include/monitor/monitor.h      |   2 +-
 include/qapi/qmp/dispatch.h    |   7 +-
 include/qapi/qmp/qstring.h     |   2 +
 monitor.c                      | 695 ++++++++++++++++++++++++++++++++++++-----
 qapi/introspect.json           |   6 +-
 qapi/misc.json                 |  87 +++++-
 qapi/qmp-dispatch.c            |  33 +-
 qmp.c                          |  16 +
 qobject/qstring.c              |  21 ++
 qom/object.c                   |   9 +-
 scripts/qapi/commands.py       |  18 +-
 scripts/qapi/common.py         |  15 +-
 scripts/qapi/doc.py            |   2 +-
 scripts/qapi/introspect.py     |  10 +-
 tests/qapi-schema/test-qapi.py |   2 +-
 tests/qmp-test.c               |  97 +++++-
 trace-events                   |   3 +
 vl.c                           |   7 +-
 20 files changed, 1010 insertions(+), 117 deletions(-)

-- 
2.14.3
