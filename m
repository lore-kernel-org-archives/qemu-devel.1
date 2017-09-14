Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsZGa-0004EM-Pn
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsZGX-0001e7-JW
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:53:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsZGX-0001dA-99
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:53:33 -0400
Date: Thu, 14 Sep 2017 19:53:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170914185314.GA3280@work-vm>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 00/15] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Sep 14, 2017 at 9:50 AM, Peter Xu <peterx@redhat.com> wrote:
> > This series was born from this one:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.html
> >
> > The design comes from Markus, and also the whole-bunch-of discussions
> > in previous thread.  My heartful thanks to Markus, Daniel, Dave,
> > Stefan, etc. on discussing the topic (...again!), providing shiny
> > ideas and suggestions.  Finally we got such a solution that seems to
> > satisfy everyone.
> >
> > I re-started the versioning since this series is totally different
> > from previous one.  Now it's version 1.
> >
> > In case new reviewers come along the way without reading previous
> > discussions, I will try to do a summary on what this is all about.
> >
> > What is OOB execution?
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > It's the shortcut of Out-Of-Band execution, its name is given by
> > Markus.  It's a way to quickly execute a QMP request.  Say, originall=
y
> > QMP is going throw these steps:
> >
> >       JSON Parser --> QMP Dispatcher --> Respond
> >           /|\    (2)                (3)     |
> >        (1) |                               \|/ (4)
> >            +---------  main thread  --------+
> >
> > The requests are executed by the so-called QMP-dispatcher after the
> > JSON is parsed.  If OOB is on, we run the command directly in the
> > parser and quickly returns.
>=20
> All commands should have the "id" field mandatory in this case, else
> the client will not distinguish the replies coming from the last/oob
> and the previous commands.
>=20
> This should probably be enforced upfront by client capability checks,
> more below.
>=20
> > Yeah I know in current code the parser calls dispatcher directly
> > (please see handle_qmp_command()).  However it's not true again after
> > this series (parser will has its own IO thread, and dispatcher will
> > still be run in main thread).  So this OOB does brings something
> > different.
> >
> > There are more details on why OOB and the difference/relationship
> > between OOB, async QMP, block/general jobs, etc.. but IMHO that's
> > slightly out of topic (and believe me, it's not easy for me to
> > summarize that).  For more information, please refers to [1].
> >
> > Summary ends here.
> >
> > Some Implementation Details
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> >
> > Again, I mentioned that the old QMP workflow is this:
> >
> >       JSON Parser --> QMP Dispatcher --> Respond
> >           /|\    (2)                (3)     |
> >        (1) |                               \|/ (4)
> >            +---------  main thread  --------+
> >
> > What this series does is, firstly:
> >
> >       JSON Parser     QMP Dispatcher --> Respond
> >           /|\ |           /|\       (4)     |
> >            |  | (2)        | (3)            |  (5)
> >        (1) |  +----->      |               \|/
> >            +---------  main thread  <-------+
> >
> > And further:
> >
> >                queue/kick
> >      JSON Parser =3D=3D=3D=3D=3D=3D> QMP Dispatcher --> Respond
> >          /|\ |     (3)       /|\        (4)    |
> >       (1) |  | (2)            |                |  (5)
> >           | \|/               |               \|/
> >         IO thread         main thread  <-------+
>=20
> Is the queue per monitor or per client? And is the dispatching going
> to be processed even if the client is disconnected, and are new
> clients going to receive the replies from previous clients commands? I
> believe there should be a per-client context, so there won't be "id"
> request conflicts.
>=20
> >
> > Then it introduced the "allow-oob" parameter in QAPI schema to define
> > commands, and "run-oob" flag to let oob-allowed command to run in the
> > parser.
>=20
> From a protocol point of view, I find that "run-oob" distinction per
> command a bit pointless. It helps with legacy client that wouldn't
> expect out-of-order replies if qemu were to run oob commands oob by
> default though. Clients shouldn't care about how/where a command is
> being queued or not. If they send a command, they want it processed as
> quickly as possible. However, it can be interesting to know if the
> implementation of the command will be able to deliver oob, so that
> data in the introspection could be useful.
>=20
> I would rather propose a client/server capability in qmp_capabilities,
> call it "oob":
>=20
> This capability indicates oob commands support.

The problem is indicating which commands support oob as opposed to
indicating whether oob is present at all.  Future versions will
probably make more commands oob-able and a client will want to know
whether it can rely on a particular command being non-blocking.

> An oob command is a regular client message request with the "id"
> member mandatory, but the reply may be delivered
> out of order by the server if the client supports
> it too.
>=20
> If both the server and the client have the "oob" capability, the
> server can handle new client requests while previous requests are being
> processed.
>=20
> If the client doesn't have the "oob" capability, it may still call
> an oob command, and make multiple outstanding calls. In this case,
> the commands are processed in order, so the replies will also be in
> order. The "id" member isn't mandatory in this case.
>=20
> The client should match the replies with the "id" member associated
> with the requests.
>=20
> When a client is disconnected, the pending commands are not
> necessarily cancelled. But the future clients will not get replies from
> commands they didn't make (they might, however, receive side-effects
> events).

What's the behaviour on the current monitor?


> Note that without "oob" support, a client may still receive
>  messages (or events) from the server between the time a
> request is handled by the server and the reply is received. It must
> thus be prepared to handle dispatching both events and reply after
> sending a request.
>=20
>=20
> (see also https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg0364=
1.html)
>=20
>=20
> > The last patch enables this for "migrate-incoming" command.
> >
> > Please review.  Thanks.
> >
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.ht=
ml
> >
> > Peter Xu (15):
> >   char-io: fix possible race on IOWatchPoll
> >   qobject: allow NULL for qstring_get_str()
> >   qobject: introduce qobject_to_str()
> >   monitor: move skip_flush into monitor_data_init
> >   qjson: add "opaque" field to JSONMessageParser
> >   monitor: move the cur_mon hack deeper for QMP
> >   monitor: unify global init
> >   monitor: create IO thread
> >   monitor: allow to use IO thread for parsing
> >   monitor: introduce monitor_qmp_respond()
> >   monitor: separate QMP parser and dispatcher
>=20
> There should be a limit in the number of requests the thread can
> queue. Before the patch, the limit was enforced by system socket
> buffering I think. Now, should oob commands still be processed even if
> the queue is full? If so, the thread can't be suspended.

I think the previous discussion was expecting a pair of queues
per client and perhaps a pair of central queues; each pair being
for normal command and oob commands.
(I'm not expecting these queues to be deep; IMHO '1' is the
right size for this type of queue in both cases).

Dave

> >   monitor: enable IO thread for (qmp & !mux) typed
> >   qapi: introduce new cmd option "allow-oob"
> >   qmp: support out-of-band (oob) execution
> >   qmp: let migrate-incoming allow out-of-band
> >
> >  chardev/char-io.c                |  15 ++-
> >  docs/devel/qapi-code-gen.txt     |  51 ++++++-
> >  include/monitor/monitor.h        |   2 +-
> >  include/qapi/qmp/dispatch.h      |   2 +
> >  include/qapi/qmp/json-streamer.h |   8 +-
> >  include/qapi/qmp/qstring.h       |   1 +
> >  monitor.c                        | 283 +++++++++++++++++++++++++++++=
++--------
> >  qapi/introspect.json             |   6 +-
> >  qapi/migration.json              |   3 +-
> >  qapi/qmp-dispatch.c              |  34 +++++
> >  qga/main.c                       |   5 +-
> >  qobject/json-streamer.c          |   7 +-
> >  qobject/qjson.c                  |   5 +-
> >  qobject/qstring.c                |  13 +-
> >  scripts/qapi-commands.py         |  19 ++-
> >  scripts/qapi-introspect.py       |  10 +-
> >  scripts/qapi.py                  |  15 ++-
> >  scripts/qapi2texi.py             |   2 +-
> >  tests/libqtest.c                 |   5 +-
> >  tests/qapi-schema/test-qapi.py   |   2 +-
> >  trace-events                     |   2 +
> >  vl.c                             |   3 +-
> >  22 files changed, 398 insertions(+), 95 deletions(-)
> >
> > --
> > 2.7.4
> >
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
