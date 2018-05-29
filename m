Received: from eggs.gnu.org ([2001:4830:134:3::10]:56726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNiF1-0003QC-L9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNiF0-0005Uw-A3
	for qemu-devel@nongnu.org; Tue, 29 May 2018 13:16:59 -0400
Date: Tue, 29 May 2018 18:16:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180529171643.GD2575@work-vm>
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518184151.GA2479@work-vm>
	<20180522110114.GC6233@localhost.localdomain>
	<CAMxuvaxnRF4RJhjr3ZgM=w6EB=1vx_ZyE6BUdNnw=uUAu3bK7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAMxuvaxnRF4RJhjr3ZgM=w6EB=1vx_ZyE6BUdNnw=uUAu3bK7g@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/40] Generic background jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, "Armbruster, Markus" <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@redhat.com) wrote:
> Hi
>=20
> On Tue, May 22, 2018 at 1:01 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 18.05.2018 um 20:41 hat Dr. David Alan Gilbert geschrieben:
> >> * Kevin Wolf (kwolf@redhat.com) wrote:
> >> > Before we can make x-blockdev-create a background job, we need to
> >> > generalise the job infrastructure so that it can be used without a=
ny
> >> > associated block node.
> >>
> >> Is there any relationship between what this does, and what
> >> Marc-Andr=E9's 'monitor: add asynchronous command type' tries to do?
> >> (See 20180326150916.9602-1-marcandre.lureau@redhat.com 26th March)
> >
> > Depends on who you ask. :-)
> >
> > In a way, yes. Marc-Andr=E9's async commands are for long-running
> > operations and jobs are for long-running operations. However, they ar=
e
> > for a different kind of "long-running".
> >
> > Basically, Marc-Andr=E9's work is for commands that are generally qui=
ck,
> > but perform some blocking operation. Usually commands that are curren=
tly
> > implemented synchronously, but always bothered us because they block =
the
> > VM for a while. They take maybe a few seconds at most, but you really
> > don't want them to block the guest even for short time.
> >
> > The important part here is you don't want to modify the operations wh=
ile
> > they're running, they just send their return value when they are done=
.
> > (In the latest version, Marc-Andr=E9 even made sure not to modify the=
 wire
> > protocol, so IIUC the commands aren't really async any more in the se=
nse
> > that you can have multiple commands running, but they are just
> > non-blocking in the sense that the guest can keep running while they =
are
> > doing their work.)
> >
> > In comparison, jobs are typically really long running, like several
> > minutes (like copying a whole disk image). Some of them can even run
> > indefinitely (like mirroring) until you explicitly tell them to stop.
> > You want to continue using the monitor while they are running, and to=
 be
> > able to manage them at runtime (pause/resume/set speed/cancel/...).
> >
> > So I think both address different problems.
>=20
> I agree with Kevin that both address different needs and complement
> each other. Right now, QMP commands are handled synchronous, so they
> block the main thread (or the "OOB" thread). I needed a simple way to
> handle them asynchronously, *without* breaking or changing an existing
> QMP command API. Job, on the other hand, provides a lot of facilities
> that are unnecessary for most short living commands, while adding
> complexity, at the protocol level (for instance, by using an extra
> "job-id" space and not being tied to the qmp session). Depending on
> the facilities Job provide, and the guarantee that must hold when
> using it, it may make sense or help to transform an existing command
> to an asynchronous version, but I doubt many of the existing commands
> will need it. However, if there is a need to introduce job-like
> facilities to QMP async (such as running concurrent commands, listing
> running commands, being able to cancel them, being notified on
> progression etc), then I think we should be careful to use Job. For
> now, this is unneeded, as QMP async is internal to qemu, the client
> can't run anything  to manage an ongoing async command, so I think
> both are improvements and will coexist harmoniously.

OK; it seems we are carving stuff up into a whole bunch of different
categories based on their longevity and blockableness.
(Normal, OOB, Async, Job)

I do worry a bit that pretty much anything that's not 'instant' means
it's waiting for something somewhere, and because you're waiting
for something that means you've got to be able to fail or cancel
it in case that thing never happens.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
