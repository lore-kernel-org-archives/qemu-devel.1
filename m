Received: from eggs.gnu.org ([2001:4830:134:3::10]:55369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cZ1T2-00034P-UZ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cZ1T0-0001Xc-Jv
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:25:24 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:36168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cZ1T0-0001XU-DL
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:25:22 -0500
Received: by mail-yw0-x242.google.com with SMTP id q71so26950609ywg.3
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 12:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20170118160332.13390-1-marcandre.lureau@redhat.com>
	<20170123105502.GH29186@stefanha-x1.localdomain>
	<10505721.4200193.1485170849535.JavaMail.zimbra@redhat.com>
	<20170124114302.GB17221@stefanha-x1.localdomain>
	<1305616133.813189.1485283397962.JavaMail.zimbra@redhat.com>
	<20170130134332.GB2118@stefanha-x1.localdomain>
	<1327323310.207981.1485800296146.JavaMail.zimbra@redhat.com>
	<20170201162505.GB12283@stefanha-x1.localdomain>
In-Reply-To: <20170201162505.GB12283@stefanha-x1.localdomain>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 01 Feb 2017 20:25:10 +0000
Message-ID: <CAJ+F1CJxkOoM1qPx0BL8KkabY=EX00jJCwTmHqZp5iahmLf3FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, kraxel@redhat.com, John Snow <jsnow@redhat.com>

Hi

On Wed, Feb 1, 2017 at 8:26 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, Jan 30, 2017 at 01:18:16PM -0500, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > ----- Original Message -----
> > > On Tue, Jan 24, 2017 at 01:43:17PM -0500, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > ----- Original Message -----
> > > > > On Mon, Jan 23, 2017 at 06:27:29AM -0500, Marc-Andr=C3=A9 Lureau =
wrote:
> > > > > > ----- Original Message -----
> > > > > > > On Wed, Jan 18, 2017 at 08:03:07PM +0400, Marc-Andr=C3=A9 Lur=
eau
> wrote:
> > > > > > > > Hi,
> > > > > > >
> > > > > > > CCing Jeff Cody and John Snow, who have been working on
> generalizing
> > > > > > > Block Job APIs to generic background jobs.  There is some
> overlap
> > > > > > > between async commands and background jobs.
> > > > > >
> > > > > > If you say so :) Did I miss a proposal or a discussion for asyn=
c
> qmp
> > > > > > commands?
> > > > >
> > > > > There is no recent mailing list thread, so it's probably best to
> discuss
> > > > > here:
> > > > >
> > > > > The goal of jobs is to support long-running operations that can b=
e
> > > > > managed via QMP.  Jobs can have a more elaborate lifecycle than
> just
> > > > > start -> finish/cancel (e.g. they can be paused/resumed and may
> have
> > > > > multiple phases of execution that the client controls).  There ar=
e
> QMP
> > > > > APIs to query their state (Are they running?  How much "progress"
> has
> > > > > been made?).
> > > >
> > > > Indeed, I mention that in my cover. Such use cases require somethin=
g
> more
> > > > complete than simple async qmp commands. I don't see why it would b=
e
> > > > incompatible with the usage of async qmp commands.
> > > >
> > > > > A client reconnecting to QEMU can query running jobs.  This way a
> client
> > > > > can resume with a running QEMU process.  For commands like saving=
 a
> > > > > screenshot is mostly does not matter, but for commands that modif=
y
> state
> > > > > it's critical that clients are aware of running commands after
> reconnect
> > > > > to prevent corruption/interference.  This behavior is what I aske=
d
> about
> > > > > in my previous mail.
> > > >
> > > > That's what I mention in the cover, some commands are global (and
> > > > broadcasted events are appropriate) and some are local to the clien=
t
> > > > context. Some could be discarded when the client disconnects etc.
> It's a
> > > > case by case.
> > > >
> > > > > Jobs are currently only used by the block layer and called "block
> jobs",
> > > > > but the idea is to generalize this.  They use synchronous QMP +
> events.
> > > >
> > > > That pattern will have the flaws I mentioned (empty return, broadca=
st
> > > > events, id conflict, qapi semantic & documentation etc). Something
> new can
> > > > be invented, but it will likely make the protocol more complicated
> > > > compared to the solution I proposed (which is optional btw, and
> gracefully
> > > > fallbacks to sync processing for clients that do not support the
> async qmp
> > > > capability). However, I believe the job interface could be built on
> top of
> > > > what I propose.
> > > >
> > > > > Jobs are more heavy-weight than async QMP commands, but
> pause/resume,
> > > > > rate-limiting, progress reporting, robust reconnect, etc are
> important
> > > > > features.  Users want to be aware of long-running operations and
> have
> > > > > the ability to control them.
> > > >
> > > > You can't generalize such job interface to all async commands. Some
> may not
> > > > implement the ability to report progress, to cancel, to pause etc,
> etc. In
> > > > the end, it will be complicated and unneeded in many cases (what's
> the use
> > > > case to pause or to get the progress of a screendump?). What I
> propose is
> > > > simpler and compatible with job/task interfaces appropriate for
> various
> > > > domains.
> > > >
> > > > > I suspect that if we transition synchronous QMP commands to async
> we'll
> > > > > soon have requirements for progress reporting, pause/resume, etc.
> So is
> > > > > there a set of commands that should be async and others that
> should be
> > > > > jobs or should everything just be a job?
> > > >
> > > > Hard to say without a concrete proposal of what "job" is. Likely,
> > > > everything is not going to be a "job".
> > > >
> > > > But hopefully qmp-async and jobs can co-exist and benefit from each
> other.
> > >
> > > My concern with this series is that background operations must be
> > > observable and there must be a way to cancel them.  Otherwise
> management
> > > tools cannot do their job and it's hard to troubleshoot a misbehaving
> > > system because you can't answer the question "what's going on?".  Onc=
e
> > > you add that then a large chunk of block jobs is duplicated.
> >
> > Tracking ongoing operations can also be done at management layer. If
> needed, we could add qmp-commands to list on-going commands (their ids
> etc), and add commands to cancel them. But then again, not all operations
> will be cancellable, and I am not sure having requirements to list or
> cancel or modify all on-going operation is needed (I would say no, just
> like today you can't do anything while a command is running)
>
> It cannot be done by robustly by the client.  If the client crashes then
> there's no way of knowing what pending commands are running.  Requiring
> the client to keep a journal would force every client that wants to be
> robust and easy to troubleshoot to duplicate this and IMO isn't a
> solution.
>
>
My proposal allows for commands to be cancelled when the client is gone.
And we can quite easily provide a qmp command to list on-going commands, I
can add a patch for that.

There is no per-client context as of today, so recovering from on-going job
would conflict with other clients (there is no per client id or job-id
namespace neither). I don't know if there is a way to enforce only a single
qmp client today, I would have to check.

QEMU knows which commands are in-flight, it should be able to report
> this info.  It's important for troubleshooting.
>
> I agree that it's not important today since only one command runs at a
> time (except block jobs and migration, which do have commands to query
> their status).  But the nature of async commands means that they can run
> in the background for a long time, so it will be necessary.
>
>
If needed, it can be added with this proposal. I will add a
proof-of-concept patch in the next iteration.

thanks
--=20
Marc-Andr=C3=A9 Lureau
