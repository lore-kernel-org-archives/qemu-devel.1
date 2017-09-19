Received: from eggs.gnu.org ([2001:4830:134:3::10]:51057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duEk1-0006Yz-5t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:22:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duEjw-000338-5s
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:22:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duEjv-00032l-Ss
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 05:22:48 -0400
Date: Tue, 19 Sep 2017 17:22:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170919092232.GM3617@pxdev.xzpeter.org>
References: <20170915120643.GN2170@work-vm> <20170915121433.GI13610@redhat.com>
	<20170915121956.GO2170@work-vm> <20170915122913.GJ13610@redhat.com>
	<20170915145632.GD18767@stefanha-x1.localdomain>
	<20170915151706.GQ2170@work-vm>
	<20170918092625.GE3617@pxdev.xzpeter.org>
	<20170918104039.GC2581@work-vm>
	<20170919022312.GG3617@pxdev.xzpeter.org>
	<20170919091352.GC2107@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919091352.GC2107@work-vm>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Sep 19, 2017 at 10:13:52AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Mon, Sep 18, 2017 at 11:40:40AM +0100, Dr. David Alan Gilbert wrot=
e:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > On Fri, Sep 15, 2017 at 04:17:07PM +0100, Dr. David Alan Gilbert =
wrote:
> > > > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > > > On Fri, Sep 15, 2017 at 01:29:13PM +0100, Daniel P. Berrange =
wrote:
> > > > > > > On Fri, Sep 15, 2017 at 01:19:56PM +0100, Dr. David Alan Gi=
lbert wrote:
> > > > > > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > > > > > On Fri, Sep 15, 2017 at 01:06:44PM +0100, Dr. David Ala=
n Gilbert wrote:
> > > > > > > > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > > > > > > > On Fri, Sep 15, 2017 at 11:49:26AM +0100, Stefan Ha=
jnoczi wrote:
> > > > > > > > > > > > On Fri, Sep 15, 2017 at 11:50:57AM +0800, Peter X=
u wrote:
> > > > > > > > > > > > > On Thu, Sep 14, 2017 at 04:19:11PM +0100, Stefa=
n Hajnoczi wrote:
> > > > > > > > > > > > > > On Thu, Sep 14, 2017 at 01:15:09PM +0200, Mar=
c-Andr=C3=A9 Lureau wrote:
> > > > > > > > > > > > > > > There should be a limit in the number of re=
quests the thread can
> > > > > > > > > > > > > > > queue. Before the patch, the limit was enfo=
rced by system socket
> > > > > > > > > > > > > > > buffering I think. Now, should oob commands=
 still be processed even if
> > > > > > > > > > > > > > > the queue is full? If so, the thread can't =
be suspended.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I agree.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Memory usage must be bounded.  The number of =
requests is less important
> > > > > > > > > > > > > > than the amount of memory consumed by them.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Existing QMP clients that send multiple QMP c=
ommands without waiting for
> > > > > > > > > > > > > > replies need to rethink their strategy becaus=
e OOB commands cannot be
> > > > > > > > > > > > > > processed if queued non-OOB commands consume =
too much memory.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Thanks for pointing out this.  Yes the memory u=
sage problem is valid,
> > > > > > > > > > > > > as Markus pointed out as well in previous discu=
ssions (in "Flow
> > > > > > > > > > > > > Control" section of that long reply).  Hopefull=
y this series basically
> > > > > > > > > > > > > can work from design prospective, then I'll add=
 this flow control in
> > > > > > > > > > > > > next version.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Regarding to what we should do if the limit is =
reached: Markus
> > > > > > > > > > > > > provided a few options, but the one I prefer mo=
st is that we don't
> > > > > > > > > > > > > respond, but send an event showing that a comma=
nd is dropped.
> > > > > > > > > > > > > However, I would like it not queued, but a dire=
ct reply (after all,
> > > > > > > > > > > > > it's an event, and we should not need to care m=
uch on ordering of it).
> > > > > > > > > > > > > Then we can get rid of the babysitting of those=
 "to be failed"
> > > > > > > > > > > > > requests asap, meanwhile we don't lose anything=
 IMHO.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I think I also missed at least a unit test for =
this new interface.
> > > > > > > > > > > > > Again, I'll add it after the whole idea is prov=
ed solid.  Thanks,
> > > > > > > > > > > >=20
> > > > > > > > > > > > Another solution: the server reports available re=
ceive buffer space to
> > > > > > > > > > > > the client.  The server only guarantees immediate=
 OOB processing when
> > > > > > > > > > > > the client stays within the receive buffer size.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Clients wishing to take advantage of OOB must que=
ry the receive buffer
> > > > > > > > > > > > size and make sure to leave enough room.
> > > > > > > > > > >=20
> > > > > > > > > > > I don't think having to query it ahead of time is p=
articularly nice,
> > > > > > > > > > > and of course it is inherantly racy.
> > > > > > > > > > >=20
> > > > > > > > > > > I would just have QEMU emit an event when it pausin=
g processing of the
> > > > > > > > > > > incoming commands due to a full queue.  If the even=
t includes the ID
> > > > > > > > > > > of the last queued command, the client will know wh=
ich (if any) of
> > > > > > > > > > > its outstanding commands are delayed. Another even =
can be sent when
> > > > > > > > > > > it restarts reading.
> > > > > > > > > >=20
> > > > > > > > > > Hmm and now we're implementing flow control!
> > > > > > > > > >=20
> > > > > > > > > > a) What exactly is the current semantics/buffer sizes=
?
> > > > > > > > > > b) When do clients send multiple QMP commands on one =
channel without
> > > > > > > > > > waiting for the response to the previous command?
> > > > > > > > > > c) Would one queue entry for each class of commands/c=
hannel work
> > > > > > > > > >   (Where a class of commands is currently 'normal' an=
d 'oob')
> > > > > > > > >=20
> > > > > > > > > I do wonder if we need to worry about request limiting =
at all from the
> > > > > > > > > client side.  For non-OOB commands clients will wait fo=
r a reply before
> > > > > > > > > sending a 2nd non-OOB command, so you'll never get a de=
ep queue for.
> > > > > > > > >=20
> > > > > > > > > OOB commands are supposed to be things which can be han=
dled quickly
> > > > > > > > > without blocking, so even if a client sent several comm=
ands at once
> > > > > > > > > without waiting for replies, they're going to be proces=
sed quickly,
> > > > > > > > > so whether we temporarily block reading off the wire is=
 a minor
> > > > > > > > > detail.
> > > > > > > >=20
> > > > > > > > Lets just define it so that it can't - you send an OOB co=
mmand and wait
> > > > > > > > for it's response before sending another on that channel.
> > > > > > > >=20
> > > > > > > > > IOW, I think we could just have a fixed 10 command queu=
e and apps just
> > > > > > > > > pretend that there's an infinite queue and nothing bad =
would happen from
> > > > > > > > > the app's POV.
> > > > > > > >=20
> > > > > > > > Can you justify 10 as opposed to 1?
> > > > > > >=20
> > > > > > > Semantically I don't think it makes a difference if the OOB=
 commands are
> > > > > > > being processed sequentially by their thread. A >1 length q=
ueue would only
> > > > > > > matter for non-OOB commands if an app was filling the pipel=
ine with non-OOB
> > > > > > > requests, as then that could block reading of OOB commands.=
=20
> > > > > >=20
> > > > > > To summarize:
> > > > > >=20
> > > > > > The QMP server has a lookahead of 1 command so it can dispatc=
h
> > > > > > out-of-band commands.  If 2 or more non-OOB commands are queu=
ed at the
> > > > > > same time then OOB processing will not occur.
> > > > > >=20
> > > > > > Is that right?
> > > > >=20
> > > > > I think my view is slightly more complex;
> > > > >   a) There's a pair of queues for each channel
> > > > >   b) There's a central pair of queues on the QMP server
> > > > >     one for OOB commands and one for normal commands.
> > > > >   c) Each queue is only really guaranteed to be one deep.
> > > > >=20
> > > > >   That means that each one of the channels can send a non-OOB
> > > > > command without getting in the way of a channel that wants
> > > > > to send one.
> > > >=20
> > > > But current version should not be that complex:
> > > >=20
> > > > Firstly, parser thread will only be enabled for QMP+NO_MIXED moni=
tors.
> > > >=20
> > > > Then, we only have a single global queue for QMP non-oob commands=
, and
> > > > we don't have response queue yet.  We do respond just like before=
 in a
> > > > synchronous way (I explained why - for OOB we don't need that
> > > > complexity IMHO).
> > >=20
> > > I think  the discussion started because of two related comments:
> > >   Marc-Andr=C3=A9 said :
> > >      'There should be a limit in the number of requests the thread =
can
> > > queue'
> > > and Stefan said :
> > >      'Memory usage must be bounded.'
> > >=20
> > > actually neither of those cases really worried me (because they onl=
y
> > > happen if the client keeps pumping commands, and that seems it's fa=
ult).
> > >=20
> > > However, once you start adding a limit, you've got to be careful - =
if
> > > you just added a limit to the central queue, then what happens if t=
hat
> > > queue is filled by non-OOB commands?
> >=20
> > Ah!  So I misunderstood "a pair of queues for each channel".  I
> > thought it means the input and output of a single monitor, while I
> > think it actually means "OOB channel" and "non-OOB channel".
> >=20
> > My plan (or say, this version) starts from only one global queue for
> > non-OOB commands.  There is no queue for OOB commands at all.  As
> > discussed below [1], if we receive one OOB command, we execute it
> > directly and reply to client.  And here the "request queue" will only
> > queue non-OOB commands.  Maybe the name "request queue" sounds
> > confusing here.
> >=20
> > If so, we should not have above problem, right?  Since even if the
> > queue is full (of course there will only be non-OOB commands in the
> > queue), the parsing is still working, and we will still be able to
> > handle OOB ones:
> >=20
> >   req =3D parse(stream);
> >=20
> >   if (is_oob(req)) {
> >     execute(req);
> >     return;
> >   }
> >=20
> >   if (queue_full(req_queue)) {
> >     emit_full_event(req);
> >     return;
> >   }
> >=20
> >   enqueue(req_queue, req);
> >=20
> > So again, this version is a simplified version from previous
> > discussion (no oob-queue but only non-oob-queue, no respond queue but
> > only request queue, etc...), but hope it can work.
>=20
> That might work.  You have to be really careful about allowing
> OOB commands to be parsed, even if the non-OOB queue is full.
>=20
> One problem is that one client could fill up that shared queue,
> then another client would be surprised to find the queue is full
> when it tries to send just one command - hence why I thought a separate
> queue per client would solve that.

Ah yes.  Let me switch to one queue per monitor in my next post.  Thanks,

--=20
Peter Xu
