Received: from eggs.gnu.org ([2001:4830:134:3::10]:51467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cYGX2-0003ll-59
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cYGWy-0002aw-3e
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:18:24 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:53846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cYGWx-0002aW-RK
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:18:20 -0500
Date: Mon, 30 Jan 2017 13:18:16 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1327323310.207981.1485800296146.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170130134332.GB2118@stefanha-x1.localdomain>
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
	<10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
	<20170124114302.GB17221@stefanha-x1.localdomain>
	<1305616133.813189.1485283397962.JavaMail.zimbra@redhat.com>
	<20170130134332.GB2118@stefanha-x1.localdomain>
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
> On Tue, Jan 24, 2017 at 01:43:17PM -0500, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >=20
> > ----- Original Message -----
> > > On Mon, Jan 23, 2017 at 06:27:29AM -0500, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > ----- Original Message -----
> > > > > On Wed, Jan 18, 2017 at 08:03:07PM +0400, Marc-Andr=C3=A9 Lureau =
wrote:
> > > > > > Hi,
> > > > >=20
> > > > > CCing Jeff Cody and John Snow, who have been working on generaliz=
ing
> > > > > Block Job APIs to generic background jobs.  There is some overlap
> > > > > between async commands and background jobs.
> > > >=20
> > > > If you say so :) Did I miss a proposal or a discussion for async qm=
p
> > > > commands?
> > >=20
> > > There is no recent mailing list thread, so it's probably best to disc=
uss
> > > here:
> > >=20
> > > The goal of jobs is to support long-running operations that can be
> > > managed via QMP.  Jobs can have a more elaborate lifecycle than just
> > > start -> finish/cancel (e.g. they can be paused/resumed and may have
> > > multiple phases of execution that the client controls).  There are QM=
P
> > > APIs to query their state (Are they running?  How much "progress" has
> > > been made?).
> >=20
> > Indeed, I mention that in my cover. Such use cases require something mo=
re
> > complete than simple async qmp commands. I don't see why it would be
> > incompatible with the usage of async qmp commands.
> >=20
> > > A client reconnecting to QEMU can query running jobs.  This way a cli=
ent
> > > can resume with a running QEMU process.  For commands like saving a
> > > screenshot is mostly does not matter, but for commands that modify st=
ate
> > > it's critical that clients are aware of running commands after reconn=
ect
> > > to prevent corruption/interference.  This behavior is what I asked ab=
out
> > > in my previous mail.
> >=20
> > That's what I mention in the cover, some commands are global (and
> > broadcasted events are appropriate) and some are local to the client
> > context. Some could be discarded when the client disconnects etc. It's =
a
> > case by case.
> >=20
> > > Jobs are currently only used by the block layer and called "block job=
s",
> > > but the idea is to generalize this.  They use synchronous QMP + event=
s.
> >=20
> > That pattern will have the flaws I mentioned (empty return, broadcast
> > events, id conflict, qapi semantic & documentation etc). Something new =
can
> > be invented, but it will likely make the protocol more complicated
> > compared to the solution I proposed (which is optional btw, and gracefu=
lly
> > fallbacks to sync processing for clients that do not support the async =
qmp
> > capability). However, I believe the job interface could be built on top=
 of
> > what I propose.
> >=20
> > > Jobs are more heavy-weight than async QMP commands, but pause/resume,
> > > rate-limiting, progress reporting, robust reconnect, etc are importan=
t
> > > features.  Users want to be aware of long-running operations and have
> > > the ability to control them.
> >=20
> > You can't generalize such job interface to all async commands. Some may=
 not
> > implement the ability to report progress, to cancel, to pause etc, etc.=
 In
> > the end, it will be complicated and unneeded in many cases (what's the =
use
> > case to pause or to get the progress of a screendump?). What I propose =
is
> > simpler and compatible with job/task interfaces appropriate for various
> > domains.
> >=20
> > > I suspect that if we transition synchronous QMP commands to async we'=
ll
> > > soon have requirements for progress reporting, pause/resume, etc.  So=
 is
> > > there a set of commands that should be async and others that should b=
e
> > > jobs or should everything just be a job?
> >=20
> > Hard to say without a concrete proposal of what "job" is. Likely,
> > everything is not going to be a "job".
> >=20
> > But hopefully qmp-async and jobs can co-exist and benefit from each oth=
er.
>=20
> My concern with this series is that background operations must be
> observable and there must be a way to cancel them.  Otherwise management
> tools cannot do their job and it's hard to troubleshoot a misbehaving
> system because you can't answer the question "what's going on?".  Once
> you add that then a large chunk of block jobs is duplicated.

Tracking ongoing operations can also be done at management layer. If needed=
, we could add qmp-commands to list on-going commands (their ids etc), and =
add commands to cancel them. But then again, not all operations will be can=
cellable, and I am not sure having requirements to list or cancel or modify=
 all on-going operation is needed (I would say no, just like today you can'=
t do anything while a command is running)

>=20
> So then you look at block jobs and realize that no QMP wire protocol
> changes are necessary.  Despite the limitations you've listed, block
> jobs have been working successfully for years and don't require QMP
> clients to change.

Right, but we have existing bugs with functions that need to be async, at l=
east at the qemu level. My proposal fixes this and optionally also allows c=
ommands to be async at the qmp level to solve the limitations and issues I =
listed.

>=20
> I agree that not all background operations need to support the same set
> of management primitives to rate-limit, report progress, cancel,
> pause/resume, etc.
>=20
> It would be nice for this series to evolve to a generic QMP jobs series
> so that all background operations are visible to the client and a useful
> subset of management primitives can be implemented on a per-command
> basis.  Both live migration and existing block jobs could use this code
> so that we don't have multiple copies of the same infrastructure.

Indeed, but I would need to know what proposal or requirements the block la=
yer have here, and I would appreciate if they took time to review mine.=20
