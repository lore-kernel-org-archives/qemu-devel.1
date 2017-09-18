Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dttU0-0004Tl-SE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dttTw-0005zg-T6
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:40:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dttTw-0005zT-Hw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:40:52 -0400
Date: Mon, 18 Sep 2017 11:40:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170918104039.GC2581@work-vm>
References: <20170915035057.GM3617@pxdev.xzpeter.org>
	<20170915104926.GA14994@stefanha-x1.localdomain>
	<20170915113428.GF13610@redhat.com> <20170915120643.GN2170@work-vm>
	<20170915121433.GI13610@redhat.com> <20170915121956.GO2170@work-vm>
	<20170915122913.GJ13610@redhat.com>
	<20170915145632.GD18767@stefanha-x1.localdomain>
	<20170915151706.GQ2170@work-vm>
	<20170918092625.GE3617@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170918092625.GE3617@pxdev.xzpeter.org>
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
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Sep 15, 2017 at 04:17:07PM +0100, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > On Fri, Sep 15, 2017 at 01:29:13PM +0100, Daniel P. Berrange wrote:
> > > > On Fri, Sep 15, 2017 at 01:19:56PM +0100, Dr. David Alan Gilbert =
wrote:
> > > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > > On Fri, Sep 15, 2017 at 01:06:44PM +0100, Dr. David Alan Gilb=
ert wrote:
> > > > > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > > > > On Fri, Sep 15, 2017 at 11:49:26AM +0100, Stefan Hajnoczi=
 wrote:
> > > > > > > > > On Fri, Sep 15, 2017 at 11:50:57AM +0800, Peter Xu wrot=
e:
> > > > > > > > > > On Thu, Sep 14, 2017 at 04:19:11PM +0100, Stefan Hajn=
oczi wrote:
> > > > > > > > > > > On Thu, Sep 14, 2017 at 01:15:09PM +0200, Marc-Andr=
=E9 Lureau wrote:
> > > > > > > > > > > > There should be a limit in the number of requests=
 the thread can
> > > > > > > > > > > > queue. Before the patch, the limit was enforced b=
y system socket
> > > > > > > > > > > > buffering I think. Now, should oob commands still=
 be processed even if
> > > > > > > > > > > > the queue is full? If so, the thread can't be sus=
pended.
> > > > > > > > > > >=20
> > > > > > > > > > > I agree.
> > > > > > > > > > >=20
> > > > > > > > > > > Memory usage must be bounded.  The number of reques=
ts is less important
> > > > > > > > > > > than the amount of memory consumed by them.
> > > > > > > > > > >=20
> > > > > > > > > > > Existing QMP clients that send multiple QMP command=
s without waiting for
> > > > > > > > > > > replies need to rethink their strategy because OOB =
commands cannot be
> > > > > > > > > > > processed if queued non-OOB commands consume too mu=
ch memory.
> > > > > > > > > >=20
> > > > > > > > > > Thanks for pointing out this.  Yes the memory usage p=
roblem is valid,
> > > > > > > > > > as Markus pointed out as well in previous discussions=
 (in "Flow
> > > > > > > > > > Control" section of that long reply).  Hopefully this=
 series basically
> > > > > > > > > > can work from design prospective, then I'll add this =
flow control in
> > > > > > > > > > next version.
> > > > > > > > > >=20
> > > > > > > > > > Regarding to what we should do if the limit is reache=
d: Markus
> > > > > > > > > > provided a few options, but the one I prefer most is =
that we don't
> > > > > > > > > > respond, but send an event showing that a command is =
dropped.
> > > > > > > > > > However, I would like it not queued, but a direct rep=
ly (after all,
> > > > > > > > > > it's an event, and we should not need to care much on=
 ordering of it).
> > > > > > > > > > Then we can get rid of the babysitting of those "to b=
e failed"
> > > > > > > > > > requests asap, meanwhile we don't lose anything IMHO.
> > > > > > > > > >=20
> > > > > > > > > > I think I also missed at least a unit test for this n=
ew interface.
> > > > > > > > > > Again, I'll add it after the whole idea is proved sol=
id.  Thanks,
> > > > > > > > >=20
> > > > > > > > > Another solution: the server reports available receive =
buffer space to
> > > > > > > > > the client.  The server only guarantees immediate OOB p=
rocessing when
> > > > > > > > > the client stays within the receive buffer size.
> > > > > > > > >=20
> > > > > > > > > Clients wishing to take advantage of OOB must query the=
 receive buffer
> > > > > > > > > size and make sure to leave enough room.
> > > > > > > >=20
> > > > > > > > I don't think having to query it ahead of time is particu=
larly nice,
> > > > > > > > and of course it is inherantly racy.
> > > > > > > >=20
> > > > > > > > I would just have QEMU emit an event when it pausing proc=
essing of the
> > > > > > > > incoming commands due to a full queue.  If the event incl=
udes the ID
> > > > > > > > of the last queued command, the client will know which (i=
f any) of
> > > > > > > > its outstanding commands are delayed. Another even can be=
 sent when
> > > > > > > > it restarts reading.
> > > > > > >=20
> > > > > > > Hmm and now we're implementing flow control!
> > > > > > >=20
> > > > > > > a) What exactly is the current semantics/buffer sizes?
> > > > > > > b) When do clients send multiple QMP commands on one channe=
l without
> > > > > > > waiting for the response to the previous command?
> > > > > > > c) Would one queue entry for each class of commands/channel=
 work
> > > > > > >   (Where a class of commands is currently 'normal' and 'oob=
')
> > > > > >=20
> > > > > > I do wonder if we need to worry about request limiting at all=
 from the
> > > > > > client side.  For non-OOB commands clients will wait for a re=
ply before
> > > > > > sending a 2nd non-OOB command, so you'll never get a deep que=
ue for.
> > > > > >=20
> > > > > > OOB commands are supposed to be things which can be handled q=
uickly
> > > > > > without blocking, so even if a client sent several commands a=
t once
> > > > > > without waiting for replies, they're going to be processed qu=
ickly,
> > > > > > so whether we temporarily block reading off the wire is a min=
or
> > > > > > detail.
> > > > >=20
> > > > > Lets just define it so that it can't - you send an OOB command =
and wait
> > > > > for it's response before sending another on that channel.
> > > > >=20
> > > > > > IOW, I think we could just have a fixed 10 command queue and =
apps just
> > > > > > pretend that there's an infinite queue and nothing bad would =
happen from
> > > > > > the app's POV.
> > > > >=20
> > > > > Can you justify 10 as opposed to 1?
> > > >=20
> > > > Semantically I don't think it makes a difference if the OOB comma=
nds are
> > > > being processed sequentially by their thread. A >1 length queue w=
ould only
> > > > matter for non-OOB commands if an app was filling the pipeline wi=
th non-OOB
> > > > requests, as then that could block reading of OOB commands.=20
> > >=20
> > > To summarize:
> > >=20
> > > The QMP server has a lookahead of 1 command so it can dispatch
> > > out-of-band commands.  If 2 or more non-OOB commands are queued at =
the
> > > same time then OOB processing will not occur.
> > >=20
> > > Is that right?
> >=20
> > I think my view is slightly more complex;
> >   a) There's a pair of queues for each channel
> >   b) There's a central pair of queues on the QMP server
> >     one for OOB commands and one for normal commands.
> >   c) Each queue is only really guaranteed to be one deep.
> >=20
> >   That means that each one of the channels can send a non-OOB
> > command without getting in the way of a channel that wants
> > to send one.
>=20
> But current version should not be that complex:
>=20
> Firstly, parser thread will only be enabled for QMP+NO_MIXED monitors.
>=20
> Then, we only have a single global queue for QMP non-oob commands, and
> we don't have response queue yet.  We do respond just like before in a
> synchronous way (I explained why - for OOB we don't need that
> complexity IMHO).

I think  the discussion started because of two related comments:
  Marc-Andr=E9 said :
     'There should be a limit in the number of requests the thread can
queue'
and Stefan said :
     'Memory usage must be bounded.'

actually neither of those cases really worried me (because they only
happen if the client keeps pumping commands, and that seems it's fault).

However, once you start adding a limit, you've got to be careful - if
you just added a limit to the central queue, then what happens if that
queue is filled by non-OOB commands?

Dave

> When we parse commands, we execute it directly if OOB, otherwise we
> put it onto request queue.  Request queue handling is done by a main
> thread QEMUBH.  That's all.
>=20
> Would this "simple version" suffice to implement this whole OOB idea?
>=20
> (Again, I really don't think we need to specify queue length to 1,
>  though we can make it small)
>=20
> --=20
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
