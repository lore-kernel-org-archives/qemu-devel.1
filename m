Received: from eggs.gnu.org ([2001:4830:134:3::10]:41691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtrYu-0001cM-1J
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:37:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dtrYq-0005BP-KP
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dtrYq-00050B-9E
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 04:37:48 -0400
Date: Mon, 18 Sep 2017 16:37:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170918083737.GD3617@pxdev.xzpeter.org>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
	<20170914185314.GA3280@work-vm>
	<20170915044622.GO3617@pxdev.xzpeter.org>
	<CAJ+F1CKGsYbK5M6WKGSCioFCFY79WjFCtEQGqudiuA-QZTfOCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKGsYbK5M6WKGSCioFCFY79WjFCtEQGqudiuA-QZTfOCA@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Sep 15, 2017 at 01:14:47PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Sep 14, 2017 at 9:46 PM, Peter Xu <peterx@redhat.com> wrote:
> > On Thu, Sep 14, 2017 at 07:53:15PM +0100, Dr. David Alan Gilbert wrot=
e:
> >> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> >> > Hi
> >> >
> >> > On Thu, Sep 14, 2017 at 9:50 AM, Peter Xu <peterx@redhat.com> wrot=
e:
> >> > > This series was born from this one:
> >> > >
> >> > >   https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg04310=
.html
> >> > >
> >> > > The design comes from Markus, and also the whole-bunch-of discus=
sions
> >> > > in previous thread.  My heartful thanks to Markus, Daniel, Dave,
> >> > > Stefan, etc. on discussing the topic (...again!), providing shin=
y
> >> > > ideas and suggestions.  Finally we got such a solution that seem=
s to
> >> > > satisfy everyone.
> >> > >
> >> > > I re-started the versioning since this series is totally differe=
nt
> >> > > from previous one.  Now it's version 1.
> >> > >
> >> > > In case new reviewers come along the way without reading previou=
s
> >> > > discussions, I will try to do a summary on what this is all abou=
t.
> >> > >
> >> > > What is OOB execution?
> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > >
> >> > > It's the shortcut of Out-Of-Band execution, its name is given by
> >> > > Markus.  It's a way to quickly execute a QMP request.  Say, orig=
inally
> >> > > QMP is going throw these steps:
> >> > >
> >> > >       JSON Parser --> QMP Dispatcher --> Respond
> >> > >           /|\    (2)                (3)     |
> >> > >        (1) |                               \|/ (4)
> >> > >            +---------  main thread  --------+
> >> > >
> >> > > The requests are executed by the so-called QMP-dispatcher after =
the
> >> > > JSON is parsed.  If OOB is on, we run the command directly in th=
e
> >> > > parser and quickly returns.
> >> >
> >> > All commands should have the "id" field mandatory in this case, el=
se
> >> > the client will not distinguish the replies coming from the last/o=
ob
> >> > and the previous commands.
> >> >
> >> > This should probably be enforced upfront by client capability chec=
ks,
> >> > more below.
> >
> > Hmm yes since the oob commands are actually running in async way,
> > request ID should be needed here.  However I'm not sure whether
> > enabling the whole "request ID" thing is too big for this "try to be
> > small" oob change... And IMHO it suites better to be part of the whol=
e
> > async work (no matter which implementation we'll use).
> >
> > How about this: we make "id" mandatory for "run-oob" requests only.
> > For oob commands, they will always have ID then no ordering issue, an=
d
> > we can do it async; for the rest of non-oob commands, we still allow
> > them to go without ID, and since they are not oob, they'll always be
> > done in order as well.  Would this work?
>=20
> This mixed-mode is imho more complicated to deal with than having the
> protocol enforced one way or the other, but that should work.
>=20
> >
> >> >
> >> > > Yeah I know in current code the parser calls dispatcher directly
> >> > > (please see handle_qmp_command()).  However it's not true again =
after
> >> > > this series (parser will has its own IO thread, and dispatcher w=
ill
> >> > > still be run in main thread).  So this OOB does brings something
> >> > > different.
> >> > >
> >> > > There are more details on why OOB and the difference/relationshi=
p
> >> > > between OOB, async QMP, block/general jobs, etc.. but IMHO that'=
s
> >> > > slightly out of topic (and believe me, it's not easy for me to
> >> > > summarize that).  For more information, please refers to [1].
> >> > >
> >> > > Summary ends here.
> >> > >
> >> > > Some Implementation Details
> >> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> > >
> >> > > Again, I mentioned that the old QMP workflow is this:
> >> > >
> >> > >       JSON Parser --> QMP Dispatcher --> Respond
> >> > >           /|\    (2)                (3)     |
> >> > >        (1) |                               \|/ (4)
> >> > >            +---------  main thread  --------+
> >> > >
> >> > > What this series does is, firstly:
> >> > >
> >> > >       JSON Parser     QMP Dispatcher --> Respond
> >> > >           /|\ |           /|\       (4)     |
> >> > >            |  | (2)        | (3)            |  (5)
> >> > >        (1) |  +----->      |               \|/
> >> > >            +---------  main thread  <-------+
> >> > >
> >> > > And further:
> >> > >
> >> > >                queue/kick
> >> > >      JSON Parser =3D=3D=3D=3D=3D=3D> QMP Dispatcher --> Respond
> >> > >          /|\ |     (3)       /|\        (4)    |
> >> > >       (1) |  | (2)            |                |  (5)
> >> > >           | \|/               |               \|/
> >> > >         IO thread         main thread  <-------+
> >> >
> >> > Is the queue per monitor or per client?
> >
> > The queue is currently global. I think yes maybe at least we can do i=
t
> > per monitor, but I am not sure whether that is urgent or can be
> > postponed.  After all now QMPRequest (please refer to patch 11) is
> > defined as (mon, id, req) tuple, so at least "id" namespace is
> > per-monitor.
> >
> >> > And is the dispatching going
> >> > to be processed even if the client is disconnected, and are new
> >> > clients going to receive the replies from previous clients
> >> > commands?
> >
> > [1]
> >
> > (will discuss together below)
> >
> >> > I
> >> > believe there should be a per-client context, so there won't be "i=
d"
> >> > request conflicts.
> >
> > I'd say I am not familiar with this "client" idea, since after all
> > IMHO one monitor is currently designed to mostly work with a single
> > client. Say, unix sockets, telnet, all these backends are only single
> > channeled, and one monitor instance can only work with one client at =
a
> > time.  Then do we really need to add this client layer upon it?  IMHO
> > the user can just provide more monitors if they wants more clients
> > (and at least these clients should know the existance of the others o=
r
> > there might be problem, otherwise user2 will fail a migration, finall=
y
> > noticed that user1 has already triggered one), and the user should
> > manage them well.
>=20
> qemu should support a management layer / libvirt restart/reconnect.
> Afaik, it mostly work today. There might be a cases where libvirt can
> be confused if it receives a reply from a previous connection command,
> but due to the sync processing of the chardev, I am not sure you can
> get in this situation.  By adding "oob" commands and queuing, the
> client will have to remember which was the last "id" used, or it will
> create more conflict after a reconnect.
>=20
> Imho we should introduce the client/connection concept to avoid this
> confusion (unexpected reply & per client id space).

Hmm I agree that the reconnect feature would be nice, but if so IMHO
instead of throwing responses away when client disconnect, we should
really keep them, and when the client reconnects, we queue the
responses again.

I think we have other quite simple ways to solve the "unexpected
reply" and "per-client-id duplication" issues you have mentioned.

Firstly, when client gets unexpected replies ("id" field not in its
own request queue), the client should just ignore that reply, which
seems natural to me.

Then, if client disconnected and reconnected, it should not have the
problem to generate duplicated id for request, since it should know
what requests it has sent already.  A simplest case I can think of is,
the ID should contains the following tuple:

  (client name, client unique ID, request ID)

Here "client name" can be something like "libvirt", which is the name
of client application;

"client unique ID" can be anything generated when client starts, it
identifies a single client session, maybe a UUID.

"request ID" can be a unsigned integer starts from zero, and increases
each time the client sends one request.

I believe current libvirt is using "client name" + "request ID".  It's
something similar (after all I think we don't normally have >1 libvirt
to manage single QEMU, so I think it should be good enough).

Then even if client disconnect and reconnect, request ID won't lose,
and no duplication would happen IMHO.

>=20
> >
> >> >
> >> > >
> >> > > Then it introduced the "allow-oob" parameter in QAPI schema to d=
efine
> >> > > commands, and "run-oob" flag to let oob-allowed command to run i=
n the
> >> > > parser.
> >> >
> >> > From a protocol point of view, I find that "run-oob" distinction p=
er
> >> > command a bit pointless. It helps with legacy client that wouldn't
> >> > expect out-of-order replies if qemu were to run oob commands oob b=
y
> >> > default though.
> >
> > After all oob somehow breaks existing rules or sync execution.  I
> > thought the more important goal was at least to keep the legacy
> > behaviors when adding new things, no?
>=20
> Of course we have to keep compatibily. What do you mean by "oob
> somehow breaks existing rules or sync execution"? oob means queuing
> and unordered reply support, so clearly this is breaking the current
> "mostly ordered" behaviour (mostly because events may still come any
> time..., and the reconnect issue discussed above).

Yes.  That's what I mean, it breaks the synchronous scemantic.  But
I should definitely not call it a "break" though since old clients
will work perfectly fine with it.  Sorry for the bad wording.

>=20
> >> > Clients shouldn't care about how/where a command is
> >> > being queued or not. If they send a command, they want it processe=
d as
> >> > quickly as possible. However, it can be interesting to know if the
> >> > implementation of the command will be able to deliver oob, so that
> >> > data in the introspection could be useful.
> >> >
> >> > I would rather propose a client/server capability in qmp_capabilit=
ies,
> >> > call it "oob":
> >> >
> >> > This capability indicates oob commands support.
> >>
> >> The problem is indicating which commands support oob as opposed to
> >> indicating whether oob is present at all.  Future versions will
> >> probably make more commands oob-able and a client will want to know
> >> whether it can rely on a particular command being non-blocking.
> >
> > Yes.
> >
> > And IMHO we don't urgently need that "whether the server globally
> > supports oob" thing.  Client can just know that from query-qmp-schema
> > already - there will always be the "allow-oob" new field for command
> > typed entries.  IMHO that's a solid hint.
> >
> > But I don't object to return it as well in qmp_capabilities.
>=20
> Does it feel right that the client can specify how the command are
> processed / queued ? Isn't it preferable to leave that to the server
> to decide? Why would a client specify that? And should the server be
> expected to behave differently? What the client needs to be able is to
> match the unordered replies, and that can be stated during cap
> negotiation / qmp_capabilties. The server is expected to do a best
> effort to handle commands and their priorities. If the client needs
> several command queue, it is simpler to open several connection rather
> than trying to fit that weird priority logic in the protocol imho.

Sorry I may have missed the point here.  We were discussing about a
global hint for "oob" support, am I right?  Then, could I ask what's
the "weird priority logic" you mentioned?

>=20
> >
> >>
> >> > An oob command is a regular client message request with the "id"
> >> > member mandatory, but the reply may be delivered
> >> > out of order by the server if the client supports
> >> > it too.
> >> >
> >> > If both the server and the client have the "oob" capability, the
> >> > server can handle new client requests while previous requests are =
being
> >> > processed.
> >> >
> >> > If the client doesn't have the "oob" capability, it may still call
> >> > an oob command, and make multiple outstanding calls. In this case,
> >> > the commands are processed in order, so the replies will also be i=
n
> >> > order. The "id" member isn't mandatory in this case.
> >> >
> >> > The client should match the replies with the "id" member associate=
d
> >> > with the requests.
> >> >
> >> > When a client is disconnected, the pending commands are not
> >> > necessarily cancelled. But the future clients will not get replies=
 from
> >> > commands they didn't make (they might, however, receive side-effec=
ts
> >> > events).
> >>
> >> What's the behaviour on the current monitor?
> >
> > Yeah I want to ask the same question, along with questioning about
> > above [1].
> >
> > IMHO this series will not change the behaviors of these, so IMHO the
> > behaviors will be the same before/after this series. E.g., when clien=
t
> > dropped right after the command is executed, I think we will still
> > execute the command, though we should encounter something odd in
> > monitor_json_emitter() somewhere when we want to respond.  And it wil=
l
> > happen the same after this series.
>=20
> I think it can get worse after your series, because you queue the
> commands, so clearly a new client can get replies from an old client
> commands. As said above, I am not convinced you can get in that
> situation with current code.

Hmm, seems so.  But would this a big problem?

I really think the new client should just throw that response away if
it does not really know that response (from peeking at "id" field),
just like my opinion above.

Thanks,

--=20
Peter Xu
