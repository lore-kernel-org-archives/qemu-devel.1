Received: from eggs.gnu.org ([2001:4830:134:3::10]:39074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCF9-0007yt-2v
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYCF5-0007qG-TV
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:39 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYCF5-0007q4-Ky
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 08:43:35 -0500
Received: by mail-wm0-x241.google.com with SMTP id v77so16261443wmv.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 05:43:35 -0800 (PST)
Date: Mon, 30 Jan 2017 13:43:32 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170130134332.GB2118@stefanha-x1.localdomain>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
	<10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
	<20170124114302.GB17221@stefanha-x1.localdomain>
	<1305616133.813189.1485283397962.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <1305616133.813189.1485283397962.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/25] qmp: add async command type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <mlureau@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com, armbru@redhat.com, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 01:43:17PM -0500, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
> > On Mon, Jan 23, 2017 at 06:27:29AM -0500, Marc-Andr=E9 Lureau wrote:
> > > ----- Original Message -----
> > > > On Wed, Jan 18, 2017 at 08:03:07PM +0400, Marc-Andr=E9 Lureau wrote:
> > > > > Hi,
> > > >=20
> > > > CCing Jeff Cody and John Snow, who have been working on generalizing
> > > > Block Job APIs to generic background jobs.  There is some overlap
> > > > between async commands and background jobs.
> > >=20
> > > If you say so :) Did I miss a proposal or a discussion for async qmp
> > > commands?
> >=20
> > There is no recent mailing list thread, so it's probably best to discuss
> > here:
> >=20
> > The goal of jobs is to support long-running operations that can be
> > managed via QMP.  Jobs can have a more elaborate lifecycle than just
> > start -> finish/cancel (e.g. they can be paused/resumed and may have
> > multiple phases of execution that the client controls).  There are QMP
> > APIs to query their state (Are they running?  How much "progress" has
> > been made?).
>=20
> Indeed, I mention that in my cover. Such use cases require something more=
 complete than simple async qmp commands. I don't see why it would be incom=
patible with the usage of async qmp commands.
>=20
> > A client reconnecting to QEMU can query running jobs.  This way a client
> > can resume with a running QEMU process.  For commands like saving a
> > screenshot is mostly does not matter, but for commands that modify state
> > it's critical that clients are aware of running commands after reconnect
> > to prevent corruption/interference.  This behavior is what I asked about
> > in my previous mail.
>=20
> That's what I mention in the cover, some commands are global (and broadca=
sted events are appropriate) and some are local to the client context. Some=
 could be discarded when the client disconnects etc. It's a case by case.
>=20
> > Jobs are currently only used by the block layer and called "block jobs",
> > but the idea is to generalize this.  They use synchronous QMP + events.
>=20
> That pattern will have the flaws I mentioned (empty return, broadcast eve=
nts, id conflict, qapi semantic & documentation etc). Something new can be =
invented, but it will likely make the protocol more complicated compared to=
 the solution I proposed (which is optional btw, and gracefully fallbacks t=
o sync processing for clients that do not support the async qmp capability)=
=2E However, I believe the job interface could be built on top of what I pr=
opose.
>=20
> > Jobs are more heavy-weight than async QMP commands, but pause/resume,
> > rate-limiting, progress reporting, robust reconnect, etc are important
> > features.  Users want to be aware of long-running operations and have
> > the ability to control them.
>=20
> You can't generalize such job interface to all async commands. Some may n=
ot implement the ability to report progress, to cancel, to pause etc, etc. =
In the end, it will be complicated and unneeded in many cases (what's the u=
se case to pause or to get the progress of a screendump?). What I propose i=
s simpler and compatible with job/task interfaces appropriate for various d=
omains.
>=20
> > I suspect that if we transition synchronous QMP commands to async we'll
> > soon have requirements for progress reporting, pause/resume, etc.  So is
> > there a set of commands that should be async and others that should be
> > jobs or should everything just be a job?
>=20
> Hard to say without a concrete proposal of what "job" is. Likely, everyth=
ing is not going to be a "job".
>=20
> But hopefully qmp-async and jobs can co-exist and benefit from each other.

My concern with this series is that background operations must be
observable and there must be a way to cancel them.  Otherwise management
tools cannot do their job and it's hard to troubleshoot a misbehaving
system because you can't answer the question "what's going on?".  Once
you add that then a large chunk of block jobs is duplicated.

So then you look at block jobs and realize that no QMP wire protocol
changes are necessary.  Despite the limitations you've listed, block
jobs have been working successfully for years and don't require QMP
clients to change.

I agree that not all background operations need to support the same set
of management primitives to rate-limit, report progress, cancel,
pause/resume, etc.

It would be nice for this series to evolve to a generic QMP jobs series
so that all background operations are visible to the client and a useful
subset of management primitives can be implemented on a per-command
basis.  Both live migration and existing block jobs could use this code
so that we don't have multiple copies of the same infrastructure.

Stefan

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYj0MDAAoJEJykq7OBq3PIA9IIALA4Sq7ek/NC9xN6+RSXfJ0w
PvqphVvHqsvPiE5QCYk3ayWXIDUeuxKtXfwLTTu0MDhhC8mJQVmMrGEZQu9thd0T
CpW/XHg+ZS6SKHEVMxSt0dt8Ylq9+zbIfc1IDgsGkPPUirpvZRzrl1MsAz6fxwiV
TFaYyIwVKS7R+zOIEwyjxW8TVfFoczPIXodlpPiBSssYHk2El4Nj6FlqVbcnRKjm
4JprqKIl2bha7Sz86Cxc6twxhUgKRD74jWuGIjRNtMnHKEEDMF8cD46+jq7/Uvum
K0khg6N6nw6xrpJSuU3XVluAvBxXwLGwhXZ2qdllwvmZbKkkvZm8fxuF+wM5eA8=
=v1wE
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
