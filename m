Received: from eggs.gnu.org ([2001:4830:134:3::10]:46807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d5TCu-0007Se-C3
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d5TCt-0000X2-9V
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d5TCt-0000Vu-1k
	for qemu-devel@nongnu.org; Tue, 02 May 2017 04:30:51 -0400
Message-ID: <1493713843.8581.69.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 02 May 2017 10:30:43 +0200
In-Reply-To: <20170428191321.GF4714@noname.redhat.com>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<87o9yv890z.fsf@dusky.pond.sub.org> <87lgqpei5d.fsf@dusky.pond.sub.org>
	<20170425102258.GA4615@noname.redhat.com>
	<CAJ+F1CKYUbMo-3TrkNfc+H3tzLUaN00c6sGTxdnPn5qapfA_bA@mail.gmail.com>
	<20170428191321.GF4714@noname.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

  Hi,

> > As explained in the cover letter, an async command may cancel the
> > ongoing operation on disconnect.
>=20
> But that's not what you generally want. You don't want to abort your
> backup just because libvirt lost its monitor connection, but qemu should
> continue to copy the data, and when libvirt reconnects it should be able
> to get back control of this background operation and bring it to
> successful completion.

Sure.  We can't move the existing block jobs to async commands, block
jobs need more features.

> I think we need a clear understanding of what the potential use cases
> are that could make good use a new infrastructure. We don't generally
> add infrastructure if we don't have a concrete idea what its users could
> be. I only ruled out that the current users of block jobs are a good fit
> for it, but there may be other use cases for which it works great.

One case at hand is the screendump command, driving this discussion
since years.

Today it writes out a dump to a file, synchronously.  I wouldn't be
surprised if this is measurable as latency spike.  Also specifically
with qxl we have the problem that spice-server renders locally only on
demand (because it can skip rendering altogether in many cases), so it
would be very nice if we can ask spice-server thread to render the
screen for us before writing the screen dump.

With async qmp commands we could actually do that.  Kick spice-server
(if needed), write out the screen dump in a separate thread so we don't
block the main loop while writing it.

There is no need to query status / progress.  Usually it'll finish in
fractions of a second (if not we probably have bigger problems like a
hanging nfs server ...).  Can be canceled without loosing important
data, for example in case the monitor connection goes down, client can
just ask for a new screen dump after reconnect.  Nobody but the client
which submitted the command is interested in the reply.

> > I agree a fully-featured job infrastructure is way over the top, and I
> > believe I propose a minimal change to make optionnally some QMP
> > commands async.
>=20
> So are commands like 'query-block' (which are typically _not_ considered
> long-running) what you're aiming for with your proposal?

I think pretty much everything in the query-* category which doesn't
just dump out internal qemu state but has to go gather information
before returning a reply could profit from async command support.

Not sure whenever that is the case for query-block.  If it is just a
list of block devices then no.  If it possibly does I/O to get and
return some image statistics then yes.

> The point here is rather that even async commands degenerate into sync
> commands if the management tool doesn't send multiple commands in
> parallel.

Allowing to submit multiple commands is one (externally visible)
benefit.  The other is internal to qemu:  We don't have to block
main-loop while running the command.

> >     -> { "execute": "do-foo",  "id": 42 }
> >     <- { "return": {}, "id": 42 }   (this is a dummy useless return)

> I know you like to insist on its uselessness, but no, it's not useless.
> It tells the management tool that the background job has successfully
> been started and block job management commands can be used with it now.

See above, block jobs are a different story.

> The question is whether enough users (command implementations and
> clients) need the change to justify maintaining another type of commands
> long term. Just not breaking existing users doesn't justify a new
> feature, it's only the most basic requirement for it to even be
> considered.

I think the question is which route we want go long-term.  I basically
see three options:

  (1) continue to abuse events as async reply.

  (2) implement async commands, roughly as suggested by Marc.

  (3) move jobs out of the block corner so they can be used everywhere
      in qemu (which is in discussion for a while too, don't know what
      the current state is though).  Then implement async commands using
      that infrastructure, as some kind of "simple job".

Disclaimer: I'm not very familiar with the block jobs code base.

cheers,
  Gerd
