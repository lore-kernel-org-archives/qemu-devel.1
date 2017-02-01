Received: from eggs.gnu.org ([2001:4830:134:3::10]:57883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxic-0000iB-QV
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:25:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cYxiX-0003E1-Ou
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:25:14 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cYxiX-0003DP-Fo
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 11:25:09 -0500
Received: by mail-wm0-x242.google.com with SMTP id v77so6675796wmv.0
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 08:25:09 -0800 (PST)
Date: Wed, 1 Feb 2017 16:25:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170201162505.GB12283@stefanha-x1.localdomain>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
	<10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
	<20170124114302.GB17221@stefanha-x1.localdomain>
	<1305616133.813189.1485283397962.JavaMail.zimbra@redhat.com>
	<20170130134332.GB2118@stefanha-x1.localdomain>
	<1327323310.207981.1485800296146.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <1327323310.207981.1485800296146.JavaMail.zimbra@redhat.com>
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


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 30, 2017 at 01:18:16PM -0500, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> ----- Original Message -----
> > On Tue, Jan 24, 2017 at 01:43:17PM -0500, Marc-Andr=E9 Lureau wrote:
> > > Hi
> > >=20
> > > ----- Original Message -----
> > > > On Mon, Jan 23, 2017 at 06:27:29AM -0500, Marc-Andr=E9 Lureau wrote:
> > > > > ----- Original Message -----
> > > > > > On Wed, Jan 18, 2017 at 08:03:07PM +0400, Marc-Andr=E9 Lureau w=
rote:
> > > > > > > Hi,
> > > > > >=20
> > > > > > CCing Jeff Cody and John Snow, who have been working on general=
izing
> > > > > > Block Job APIs to generic background jobs.  There is some overl=
ap
> > > > > > between async commands and background jobs.
> > > > >=20
> > > > > If you say so :) Did I miss a proposal or a discussion for async =
qmp
> > > > > commands?
> > > >=20
> > > > There is no recent mailing list thread, so it's probably best to di=
scuss
> > > > here:
> > > >=20
> > > > The goal of jobs is to support long-running operations that can be
> > > > managed via QMP.  Jobs can have a more elaborate lifecycle than just
> > > > start -> finish/cancel (e.g. they can be paused/resumed and may have
> > > > multiple phases of execution that the client controls).  There are =
QMP
> > > > APIs to query their state (Are they running?  How much "progress" h=
as
> > > > been made?).
> > >=20
> > > Indeed, I mention that in my cover. Such use cases require something =
more
> > > complete than simple async qmp commands. I don't see why it would be
> > > incompatible with the usage of async qmp commands.
> > >=20
> > > > A client reconnecting to QEMU can query running jobs.  This way a c=
lient
> > > > can resume with a running QEMU process.  For commands like saving a
> > > > screenshot is mostly does not matter, but for commands that modify =
state
> > > > it's critical that clients are aware of running commands after reco=
nnect
> > > > to prevent corruption/interference.  This behavior is what I asked =
about
> > > > in my previous mail.
> > >=20
> > > That's what I mention in the cover, some commands are global (and
> > > broadcasted events are appropriate) and some are local to the client
> > > context. Some could be discarded when the client disconnects etc. It'=
s a
> > > case by case.
> > >=20
> > > > Jobs are currently only used by the block layer and called "block j=
obs",
> > > > but the idea is to generalize this.  They use synchronous QMP + eve=
nts.
> > >=20
> > > That pattern will have the flaws I mentioned (empty return, broadcast
> > > events, id conflict, qapi semantic & documentation etc). Something ne=
w can
> > > be invented, but it will likely make the protocol more complicated
> > > compared to the solution I proposed (which is optional btw, and grace=
fully
> > > fallbacks to sync processing for clients that do not support the asyn=
c qmp
> > > capability). However, I believe the job interface could be built on t=
op of
> > > what I propose.
> > >=20
> > > > Jobs are more heavy-weight than async QMP commands, but pause/resum=
e,
> > > > rate-limiting, progress reporting, robust reconnect, etc are import=
ant
> > > > features.  Users want to be aware of long-running operations and ha=
ve
> > > > the ability to control them.
> > >=20
> > > You can't generalize such job interface to all async commands. Some m=
ay not
> > > implement the ability to report progress, to cancel, to pause etc, et=
c. In
> > > the end, it will be complicated and unneeded in many cases (what's th=
e use
> > > case to pause or to get the progress of a screendump?). What I propos=
e is
> > > simpler and compatible with job/task interfaces appropriate for vario=
us
> > > domains.
> > >=20
> > > > I suspect that if we transition synchronous QMP commands to async w=
e'll
> > > > soon have requirements for progress reporting, pause/resume, etc.  =
So is
> > > > there a set of commands that should be async and others that should=
 be
> > > > jobs or should everything just be a job?
> > >=20
> > > Hard to say without a concrete proposal of what "job" is. Likely,
> > > everything is not going to be a "job".
> > >=20
> > > But hopefully qmp-async and jobs can co-exist and benefit from each o=
ther.
> >=20
> > My concern with this series is that background operations must be
> > observable and there must be a way to cancel them.  Otherwise management
> > tools cannot do their job and it's hard to troubleshoot a misbehaving
> > system because you can't answer the question "what's going on?".  Once
> > you add that then a large chunk of block jobs is duplicated.
>=20
> Tracking ongoing operations can also be done at management layer. If need=
ed, we could add qmp-commands to list on-going commands (their ids etc), an=
d add commands to cancel them. But then again, not all operations will be c=
ancellable, and I am not sure having requirements to list or cancel or modi=
fy all on-going operation is needed (I would say no, just like today you ca=
n't do anything while a command is running)

It cannot be done by robustly by the client.  If the client crashes then
there's no way of knowing what pending commands are running.  Requiring
the client to keep a journal would force every client that wants to be
robust and easy to troubleshoot to duplicate this and IMO isn't a
solution.

QEMU knows which commands are in-flight, it should be able to report
this info.  It's important for troubleshooting.

I agree that it's not important today since only one command runs at a
time (except block jobs and migration, which do have commands to query
their status).  But the nature of async commands means that they can run
in the background for a long time, so it will be necessary.

Stefan

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkgvhAAoJEJykq7OBq3PIqegH/2fgN1wzE16eBQAiBY8QD+EK
3KPV1iBW4/OOvo0VRfSQaA/K7G0+47QDo5ENg7tIn1xM5PsQaPeSlUDj0aL8GXFz
EfnCGv+CjWIQmt0tYYYZmyZPs/emelECG1X/V4GVqn++TOe57x1r53sCf8lcGTml
QhxbMbxD3UoUUbzU/IR8XYdpld2rmvuRRBVl96nfJCrfp/+6nMnvTBdnVTfNYoRL
Gow15pmKc91skoN3dR60HHkyqgTW5SQoFRJ69gace7ZGcFvhB1SNau4u0qJgtA43
AbNyjO0nenalqh1yUrJAjh89aHfdkDrFduhJEfYgQjccltTB54zkgzupK5XoUgk=
=wGKf
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
