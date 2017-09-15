Received: from eggs.gnu.org ([2001:4830:134:3::10]:38755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsiWT-00022c-Ht
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 00:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsiWQ-0002F3-Ap
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 00:46:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsiWQ-0002E9-0f
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 00:46:34 -0400
Date: Fri, 15 Sep 2017 12:46:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170915044622.GO3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
	<20170914185314.GA3280@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170914185314.GA3280@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Sep 14, 2017 at 07:53:15PM +0100, Dr. David Alan Gilbert wrote:
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > Hi
> >=20
> > On Thu, Sep 14, 2017 at 9:50 AM, Peter Xu <peterx@redhat.com> wrote:
> > > This series was born from this one:
> > >
> > >   https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.ht=
ml
> > >
> > > The design comes from Markus, and also the whole-bunch-of discussio=
ns
> > > in previous thread.  My heartful thanks to Markus, Daniel, Dave,
> > > Stefan, etc. on discussing the topic (...again!), providing shiny
> > > ideas and suggestions.  Finally we got such a solution that seems t=
o
> > > satisfy everyone.
> > >
> > > I re-started the versioning since this series is totally different
> > > from previous one.  Now it's version 1.
> > >
> > > In case new reviewers come along the way without reading previous
> > > discussions, I will try to do a summary on what this is all about.
> > >
> > > What is OOB execution?
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > > It's the shortcut of Out-Of-Band execution, its name is given by
> > > Markus.  It's a way to quickly execute a QMP request.  Say, origina=
lly
> > > QMP is going throw these steps:
> > >
> > >       JSON Parser --> QMP Dispatcher --> Respond
> > >           /|\    (2)                (3)     |
> > >        (1) |                               \|/ (4)
> > >            +---------  main thread  --------+
> > >
> > > The requests are executed by the so-called QMP-dispatcher after the
> > > JSON is parsed.  If OOB is on, we run the command directly in the
> > > parser and quickly returns.
> >=20
> > All commands should have the "id" field mandatory in this case, else
> > the client will not distinguish the replies coming from the last/oob
> > and the previous commands.
> >=20
> > This should probably be enforced upfront by client capability checks,
> > more below.

Hmm yes since the oob commands are actually running in async way,
request ID should be needed here.  However I'm not sure whether
enabling the whole "request ID" thing is too big for this "try to be
small" oob change... And IMHO it suites better to be part of the whole
async work (no matter which implementation we'll use).

How about this: we make "id" mandatory for "run-oob" requests only.
For oob commands, they will always have ID then no ordering issue, and
we can do it async; for the rest of non-oob commands, we still allow
them to go without ID, and since they are not oob, they'll always be
done in order as well.  Would this work?

> >=20
> > > Yeah I know in current code the parser calls dispatcher directly
> > > (please see handle_qmp_command()).  However it's not true again aft=
er
> > > this series (parser will has its own IO thread, and dispatcher will
> > > still be run in main thread).  So this OOB does brings something
> > > different.
> > >
> > > There are more details on why OOB and the difference/relationship
> > > between OOB, async QMP, block/general jobs, etc.. but IMHO that's
> > > slightly out of topic (and believe me, it's not easy for me to
> > > summarize that).  For more information, please refers to [1].
> > >
> > > Summary ends here.
> > >
> > > Some Implementation Details
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >
> > > Again, I mentioned that the old QMP workflow is this:
> > >
> > >       JSON Parser --> QMP Dispatcher --> Respond
> > >           /|\    (2)                (3)     |
> > >        (1) |                               \|/ (4)
> > >            +---------  main thread  --------+
> > >
> > > What this series does is, firstly:
> > >
> > >       JSON Parser     QMP Dispatcher --> Respond
> > >           /|\ |           /|\       (4)     |
> > >            |  | (2)        | (3)            |  (5)
> > >        (1) |  +----->      |               \|/
> > >            +---------  main thread  <-------+
> > >
> > > And further:
> > >
> > >                queue/kick
> > >      JSON Parser =3D=3D=3D=3D=3D=3D> QMP Dispatcher --> Respond
> > >          /|\ |     (3)       /|\        (4)    |
> > >       (1) |  | (2)            |                |  (5)
> > >           | \|/               |               \|/
> > >         IO thread         main thread  <-------+
> >=20
> > Is the queue per monitor or per client?

The queue is currently global. I think yes maybe at least we can do it
per monitor, but I am not sure whether that is urgent or can be
postponed.  After all now QMPRequest (please refer to patch 11) is
defined as (mon, id, req) tuple, so at least "id" namespace is
per-monitor.

> > And is the dispatching going
> > to be processed even if the client is disconnected, and are new
> > clients going to receive the replies from previous clients
> > commands?

[1]

(will discuss together below)

> > I
> > believe there should be a per-client context, so there won't be "id"
> > request conflicts.

I'd say I am not familiar with this "client" idea, since after all
IMHO one monitor is currently designed to mostly work with a single
client. Say, unix sockets, telnet, all these backends are only single
channeled, and one monitor instance can only work with one client at a
time.  Then do we really need to add this client layer upon it?  IMHO
the user can just provide more monitors if they wants more clients
(and at least these clients should know the existance of the others or
there might be problem, otherwise user2 will fail a migration, finally
noticed that user1 has already triggered one), and the user should
manage them well.

> >=20
> > >
> > > Then it introduced the "allow-oob" parameter in QAPI schema to defi=
ne
> > > commands, and "run-oob" flag to let oob-allowed command to run in t=
he
> > > parser.
> >=20
> > From a protocol point of view, I find that "run-oob" distinction per
> > command a bit pointless. It helps with legacy client that wouldn't
> > expect out-of-order replies if qemu were to run oob commands oob by
> > default though.

After all oob somehow breaks existing rules or sync execution.  I
thought the more important goal was at least to keep the legacy
behaviors when adding new things, no?

> > Clients shouldn't care about how/where a command is
> > being queued or not. If they send a command, they want it processed a=
s
> > quickly as possible. However, it can be interesting to know if the
> > implementation of the command will be able to deliver oob, so that
> > data in the introspection could be useful.
> >=20
> > I would rather propose a client/server capability in qmp_capabilities=
,
> > call it "oob":
> >=20
> > This capability indicates oob commands support.
>=20
> The problem is indicating which commands support oob as opposed to
> indicating whether oob is present at all.  Future versions will
> probably make more commands oob-able and a client will want to know
> whether it can rely on a particular command being non-blocking.

Yes.

And IMHO we don't urgently need that "whether the server globally
supports oob" thing.  Client can just know that from query-qmp-schema
already - there will always be the "allow-oob" new field for command
typed entries.  IMHO that's a solid hint.

But I don't object to return it as well in qmp_capabilities.

>=20
> > An oob command is a regular client message request with the "id"
> > member mandatory, but the reply may be delivered
> > out of order by the server if the client supports
> > it too.
> >=20
> > If both the server and the client have the "oob" capability, the
> > server can handle new client requests while previous requests are bei=
ng
> > processed.
> >=20
> > If the client doesn't have the "oob" capability, it may still call
> > an oob command, and make multiple outstanding calls. In this case,
> > the commands are processed in order, so the replies will also be in
> > order. The "id" member isn't mandatory in this case.
> >=20
> > The client should match the replies with the "id" member associated
> > with the requests.
> >=20
> > When a client is disconnected, the pending commands are not
> > necessarily cancelled. But the future clients will not get replies fr=
om
> > commands they didn't make (they might, however, receive side-effects
> > events).
>=20
> What's the behaviour on the current monitor?

Yeah I want to ask the same question, along with questioning about
above [1].

IMHO this series will not change the behaviors of these, so IMHO the
behaviors will be the same before/after this series. E.g., when client
dropped right after the command is executed, I think we will still
execute the command, though we should encounter something odd in
monitor_json_emitter() somewhere when we want to respond.  And it will
happen the same after this series.

>=20
>=20
> > Note that without "oob" support, a client may still receive
> >  messages (or events) from the server between the time a
> > request is handled by the server and the reply is received. It must
> > thus be prepared to handle dispatching both events and reply after
> > sending a request.
> >=20
> >=20
> > (see also https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03=
641.html)
> >=20
> >=20
> > > The last patch enables this for "migrate-incoming" command.
> > >
> > > Please review.  Thanks.
> > >
> > > [1] https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310.=
html
> > >
> > > Peter Xu (15):
> > >   char-io: fix possible race on IOWatchPoll
> > >   qobject: allow NULL for qstring_get_str()
> > >   qobject: introduce qobject_to_str()
> > >   monitor: move skip_flush into monitor_data_init
> > >   qjson: add "opaque" field to JSONMessageParser
> > >   monitor: move the cur_mon hack deeper for QMP
> > >   monitor: unify global init
> > >   monitor: create IO thread
> > >   monitor: allow to use IO thread for parsing
> > >   monitor: introduce monitor_qmp_respond()
> > >   monitor: separate QMP parser and dispatcher
> >=20
> > There should be a limit in the number of requests the thread can
> > queue. Before the patch, the limit was enforced by system socket
> > buffering I think. Now, should oob commands still be processed even i=
f
> > the queue is full? If so, the thread can't be suspended.
>=20
> I think the previous discussion was expecting a pair of queues
> per client and perhaps a pair of central queues; each pair being
> for normal command and oob commands.
> (I'm not expecting these queues to be deep; IMHO '1' is the
> right size for this type of queue in both cases).

Yes.  One thing to mention is that, if we see the graph above, I
didn't really introduce two queues (input/output), but only one input
queue.  The response is still handled in dispatcher for now, since I
think that's quite enough at least for OOB, and I didn't see much
benefit now to split that 2nd queue.

So I am thinking whether we can just quickly respond an event when the
queue is full, as I proposed in the other reply.

Regarding to queue size: I am afraid max_size=3D1 may not suffice?
Otherwise a simple batch of:

{"execute": "query-status"} {"execute": "query-status"}

Will trigger the failure.  But I definitely agree it should not be
something very large.  The total memory will be this:

  json limit * queue length limit * monitor count limit
      (X)            (Y)                    (Z)

Now we have (X) already (in form of a few tunables for JSON token
counts, etc.), we don't have (Z), and we definitely need (Y).

How about we add limits on Y=3D16 and Z=3D8?

We can do some math if we want some more exact number though.

>=20
> Dave
>=20
> > >   monitor: enable IO thread for (qmp & !mux) typed
> > >   qapi: introduce new cmd option "allow-oob"
> > >   qmp: support out-of-band (oob) execution
> > >   qmp: let migrate-incoming allow out-of-band
> > >
> > >  chardev/char-io.c                |  15 ++-
> > >  docs/devel/qapi-code-gen.txt     |  51 ++++++-
> > >  include/monitor/monitor.h        |   2 +-
> > >  include/qapi/qmp/dispatch.h      |   2 +
> > >  include/qapi/qmp/json-streamer.h |   8 +-
> > >  include/qapi/qmp/qstring.h       |   1 +
> > >  monitor.c                        | 283 +++++++++++++++++++++++++++=
++++--------
> > >  qapi/introspect.json             |   6 +-
> > >  qapi/migration.json              |   3 +-
> > >  qapi/qmp-dispatch.c              |  34 +++++
> > >  qga/main.c                       |   5 +-
> > >  qobject/json-streamer.c          |   7 +-
> > >  qobject/qjson.c                  |   5 +-
> > >  qobject/qstring.c                |  13 +-
> > >  scripts/qapi-commands.py         |  19 ++-
> > >  scripts/qapi-introspect.py       |  10 +-
> > >  scripts/qapi.py                  |  15 ++-
> > >  scripts/qapi2texi.py             |   2 +-
> > >  tests/libqtest.c                 |   5 +-
> > >  tests/qapi-schema/test-qapi.py   |   2 +-
> > >  trace-events                     |   2 +
> > >  vl.c                             |   3 +-
> > >  22 files changed, 398 insertions(+), 95 deletions(-)
> > >
> > > --
> > > 2.7.4
> > >
> >=20
> >=20
> >=20
> > --=20
> > Marc-Andr=C3=A9 Lureau
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

--=20
Peter Xu
