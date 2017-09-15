Received: from eggs.gnu.org ([2001:4830:134:3::10]:41167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dss2v-0006w6-LB
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dss2s-0006MO-Jr
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:56:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dss2s-0006Lu-Aw
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 10:56:42 -0400
Date: Fri, 15 Sep 2017 15:56:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170915145632.GD18767@stefanha-x1.localdomain>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<CAJ+F1CL1CekcYq2xnrkhsjyx17FDSgppP1C+YqL0iNgv8HbwYQ@mail.gmail.com>
	<20170914151911.GB7370@stefanha-x1.localdomain>
	<20170915035057.GM3617@pxdev.xzpeter.org>
	<20170915104926.GA14994@stefanha-x1.localdomain>
	<20170915113428.GF13610@redhat.com> <20170915120643.GN2170@work-vm>
	<20170915121433.GI13610@redhat.com> <20170915121956.GO2170@work-vm>
	<20170915122913.GJ13610@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170915122913.GJ13610@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Sep 15, 2017 at 01:29:13PM +0100, Daniel P. Berrange wrote:
> On Fri, Sep 15, 2017 at 01:19:56PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > On Fri, Sep 15, 2017 at 01:06:44PM +0100, Dr. David Alan Gilbert wr=
ote:
> > > > * Daniel P. Berrange (berrange@redhat.com) wrote:
> > > > > On Fri, Sep 15, 2017 at 11:49:26AM +0100, Stefan Hajnoczi wrote=
:
> > > > > > On Fri, Sep 15, 2017 at 11:50:57AM +0800, Peter Xu wrote:
> > > > > > > On Thu, Sep 14, 2017 at 04:19:11PM +0100, Stefan Hajnoczi w=
rote:
> > > > > > > > On Thu, Sep 14, 2017 at 01:15:09PM +0200, Marc-Andr=E9 Lu=
reau wrote:
> > > > > > > > > There should be a limit in the number of requests the t=
hread can
> > > > > > > > > queue. Before the patch, the limit was enforced by syst=
em socket
> > > > > > > > > buffering I think. Now, should oob commands still be pr=
ocessed even if
> > > > > > > > > the queue is full? If so, the thread can't be suspended=
.
> > > > > > > >=20
> > > > > > > > I agree.
> > > > > > > >=20
> > > > > > > > Memory usage must be bounded.  The number of requests is =
less important
> > > > > > > > than the amount of memory consumed by them.
> > > > > > > >=20
> > > > > > > > Existing QMP clients that send multiple QMP commands with=
out waiting for
> > > > > > > > replies need to rethink their strategy because OOB comman=
ds cannot be
> > > > > > > > processed if queued non-OOB commands consume too much mem=
ory.
> > > > > > >=20
> > > > > > > Thanks for pointing out this.  Yes the memory usage problem=
 is valid,
> > > > > > > as Markus pointed out as well in previous discussions (in "=
Flow
> > > > > > > Control" section of that long reply).  Hopefully this serie=
s basically
> > > > > > > can work from design prospective, then I'll add this flow c=
ontrol in
> > > > > > > next version.
> > > > > > >=20
> > > > > > > Regarding to what we should do if the limit is reached: Mar=
kus
> > > > > > > provided a few options, but the one I prefer most is that w=
e don't
> > > > > > > respond, but send an event showing that a command is droppe=
d.
> > > > > > > However, I would like it not queued, but a direct reply (af=
ter all,
> > > > > > > it's an event, and we should not need to care much on order=
ing of it).
> > > > > > > Then we can get rid of the babysitting of those "to be fail=
ed"
> > > > > > > requests asap, meanwhile we don't lose anything IMHO.
> > > > > > >=20
> > > > > > > I think I also missed at least a unit test for this new int=
erface.
> > > > > > > Again, I'll add it after the whole idea is proved solid.  T=
hanks,
> > > > > >=20
> > > > > > Another solution: the server reports available receive buffer=
 space to
> > > > > > the client.  The server only guarantees immediate OOB process=
ing when
> > > > > > the client stays within the receive buffer size.
> > > > > >=20
> > > > > > Clients wishing to take advantage of OOB must query the recei=
ve buffer
> > > > > > size and make sure to leave enough room.
> > > > >=20
> > > > > I don't think having to query it ahead of time is particularly =
nice,
> > > > > and of course it is inherantly racy.
> > > > >=20
> > > > > I would just have QEMU emit an event when it pausing processing=
 of the
> > > > > incoming commands due to a full queue.  If the event includes t=
he ID
> > > > > of the last queued command, the client will know which (if any)=
 of
> > > > > its outstanding commands are delayed. Another even can be sent =
when
> > > > > it restarts reading.
> > > >=20
> > > > Hmm and now we're implementing flow control!
> > > >=20
> > > > a) What exactly is the current semantics/buffer sizes?
> > > > b) When do clients send multiple QMP commands on one channel with=
out
> > > > waiting for the response to the previous command?
> > > > c) Would one queue entry for each class of commands/channel work
> > > >   (Where a class of commands is currently 'normal' and 'oob')
> > >=20
> > > I do wonder if we need to worry about request limiting at all from =
the
> > > client side.  For non-OOB commands clients will wait for a reply be=
fore
> > > sending a 2nd non-OOB command, so you'll never get a deep queue for=
.
> > >=20
> > > OOB commands are supposed to be things which can be handled quickly
> > > without blocking, so even if a client sent several commands at once
> > > without waiting for replies, they're going to be processed quickly,
> > > so whether we temporarily block reading off the wire is a minor
> > > detail.
> >=20
> > Lets just define it so that it can't - you send an OOB command and wa=
it
> > for it's response before sending another on that channel.
> >=20
> > > IOW, I think we could just have a fixed 10 command queue and apps j=
ust
> > > pretend that there's an infinite queue and nothing bad would happen=
 from
> > > the app's POV.
> >=20
> > Can you justify 10 as opposed to 1?
>=20
> Semantically I don't think it makes a difference if the OOB commands ar=
e
> being processed sequentially by their thread. A >1 length queue would o=
nly
> matter for non-OOB commands if an app was filling the pipeline with non=
-OOB
> requests, as then that could block reading of OOB commands.=20

To summarize:

The QMP server has a lookahead of 1 command so it can dispatch
out-of-band commands.  If 2 or more non-OOB commands are queued at the
same time then OOB processing will not occur.

Is that right?

Stefan
