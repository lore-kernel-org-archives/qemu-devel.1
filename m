Received: from eggs.gnu.org ([2001:4830:134:3::10]:54274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cW63y-0006ge-NE
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cW63v-0005SR-FU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:43:26 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:60416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cW63v-0005R8-7O
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:43:23 -0500
Date: Tue, 24 Jan 2017 13:43:17 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1305616133.813189.1485283397962.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170124114302.GB17221@stefanha-x1.localdomain>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
	<10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
	<20170124114302.GB17221@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

Hi

----- Original Message -----
> On Mon, Jan 23, 2017 at 06:27:29AM -0500, Marc-Andr=C3=A9 Lureau wrote:
> > ----- Original Message -----
> > > On Wed, Jan 18, 2017 at 08:03:07PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi,
> > >=20
> > > CCing Jeff Cody and John Snow, who have been working on generalizing
> > > Block Job APIs to generic background jobs.  There is some overlap
> > > between async commands and background jobs.
> >=20
> > If you say so :) Did I miss a proposal or a discussion for async qmp
> > commands?
>=20
> There is no recent mailing list thread, so it's probably best to discuss
> here:
>=20
> The goal of jobs is to support long-running operations that can be
> managed via QMP.  Jobs can have a more elaborate lifecycle than just
> start -> finish/cancel (e.g. they can be paused/resumed and may have
> multiple phases of execution that the client controls).  There are QMP
> APIs to query their state (Are they running?  How much "progress" has
> been made?).

Indeed, I mention that in my cover. Such use cases require something more c=
omplete than simple async qmp commands. I don't see why it would be incompa=
tible with the usage of async qmp commands.

> A client reconnecting to QEMU can query running jobs.  This way a client
> can resume with a running QEMU process.  For commands like saving a
> screenshot is mostly does not matter, but for commands that modify state
> it's critical that clients are aware of running commands after reconnect
> to prevent corruption/interference.  This behavior is what I asked about
> in my previous mail.

That's what I mention in the cover, some commands are global (and broadcast=
ed events are appropriate) and some are local to the client context. Some c=
ould be discarded when the client disconnects etc. It's a case by case.

> Jobs are currently only used by the block layer and called "block jobs",
> but the idea is to generalize this.  They use synchronous QMP + events.

That pattern will have the flaws I mentioned (empty return, broadcast event=
s, id conflict, qapi semantic & documentation etc). Something new can be in=
vented, but it will likely make the protocol more complicated compared to t=
he solution I proposed (which is optional btw, and gracefully fallbacks to =
sync processing for clients that do not support the async qmp capability). =
However, I believe the job interface could be built on top of what I propos=
e.

> Jobs are more heavy-weight than async QMP commands, but pause/resume,
> rate-limiting, progress reporting, robust reconnect, etc are important
> features.  Users want to be aware of long-running operations and have
> the ability to control them.

You can't generalize such job interface to all async commands. Some may not=
 implement the ability to report progress, to cancel, to pause etc, etc. In=
 the end, it will be complicated and unneeded in many cases (what's the use=
 case to pause or to get the progress of a screendump?). What I propose is =
simpler and compatible with job/task interfaces appropriate for various dom=
ains.

> I suspect that if we transition synchronous QMP commands to async we'll
> soon have requirements for progress reporting, pause/resume, etc.  So is
> there a set of commands that should be async and others that should be
> jobs or should everything just be a job?

Hard to say without a concrete proposal of what "job" is. Likely, everythin=
g is not going to be a "job".

But hopefully qmp-async and jobs can co-exist and benefit from each other.
