Received: from eggs.gnu.org ([2001:4830:134:3::10]:51582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOvI-00061q-Ea
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsOvF-0006Lo-8Z
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:50:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsOvE-0006Kf-Vb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:50:53 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 14 Sep 2017 15:50:21 +0800
Message-Id: <1505375436-28439-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 00/15] QMP: out-of-band (OOB) execution support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

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

Peter Xu (15):
  char-io: fix possible race on IOWatchPoll
  qobject: allow NULL for qstring_get_str()
  qobject: introduce qobject_to_str()
  monitor: move skip_flush into monitor_data_init
  qjson: add "opaque" field to JSONMessageParser
  monitor: move the cur_mon hack deeper for QMP
  monitor: unify global init
  monitor: create IO thread
  monitor: allow to use IO thread for parsing
  monitor: introduce monitor_qmp_respond()
  monitor: separate QMP parser and dispatcher
  monitor: enable IO thread for (qmp & !mux) typed
  qapi: introduce new cmd option "allow-oob"
  qmp: support out-of-band (oob) execution
  qmp: let migrate-incoming allow out-of-band

 chardev/char-io.c                |  15 ++-
 docs/devel/qapi-code-gen.txt     |  51 ++++++-
 include/monitor/monitor.h        |   2 +-
 include/qapi/qmp/dispatch.h      |   2 +
 include/qapi/qmp/json-streamer.h |   8 +-
 include/qapi/qmp/qstring.h       |   1 +
 monitor.c                        | 283 +++++++++++++++++++++++++++++++--=
------
 qapi/introspect.json             |   6 +-
 qapi/migration.json              |   3 +-
 qapi/qmp-dispatch.c              |  34 +++++
 qga/main.c                       |   5 +-
 qobject/json-streamer.c          |   7 +-
 qobject/qjson.c                  |   5 +-
 qobject/qstring.c                |  13 +-
 scripts/qapi-commands.py         |  19 ++-
 scripts/qapi-introspect.py       |  10 +-
 scripts/qapi.py                  |  15 ++-
 scripts/qapi2texi.py             |   2 +-
 tests/libqtest.c                 |   5 +-
 tests/qapi-schema/test-qapi.py   |   2 +-
 trace-events                     |   2 +
 vl.c                             |   3 +-
 22 files changed, 398 insertions(+), 95 deletions(-)

--=20
2.7.4
