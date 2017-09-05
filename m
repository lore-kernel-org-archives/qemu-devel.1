Received: from eggs.gnu.org ([2001:4830:134:3::10]:54372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpJ4F-0005ou-G5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpJ4A-00063N-Fd
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:59:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpJ4A-00062t-5p
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 14:59:18 -0400
Date: Tue, 5 Sep 2017 19:58:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170905185856.GI2112@work-vm>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<20170828030538.GI14174@pxdev.xzpeter.org>
	<CAJ+F1CJ34uwxrbZ6zmp0Z+7baWh-uSxYJNvj2QJE1ryyUpOi3Q@mail.gmail.com>
	<20170828124834.GR14174@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170828124834.GR14174@pxdev.xzpeter.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 2/8] monitor: allow monitor to create
 thread to poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Mon, Aug 28, 2017 at 12:11:38PM +0200, Marc-Andr=E9 Lureau wrote:
> > Hi
> >=20
> > On Mon, Aug 28, 2017 at 5:05 AM, Peter Xu <peterx@redhat.com> wrote:
> > > On Fri, Aug 25, 2017 at 04:07:34PM +0000, Marc-Andr=E9 Lureau wrote=
:
> > >> On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <dgilbert@r=
edhat.com>
> > >> wrote:
> > >>
> > >> > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > >> > > Hi
> > >> > >
> > >> > > On Wed, Aug 23, 2017 at 8:52 AM Peter Xu <peterx@redhat.com> w=
rote:
> > >> > >
> > >> > > > Firstly, introduce Monitor.use_thread, and set it for monito=
rs that are
> > >> > > > using non-mux typed backend chardev.  We only do this for mo=
nitors, so
> > >> > > > mux-typed chardevs are not suitable (when it connects to, e.=
g., serials
> > >> > > > and the monitor together).
> > >> > > >
> > >> > > > When use_thread is set, we create standalone thread to poll =
the monitor
> > >> > > > events, isolated from the main loop thread.  Here we still n=
eed to take
> > >> > > > the BQL before dispatching the tasks since some of the monit=
or commands
> > >> > > > are not allowed to execute without the protection of BQL.  T=
hen this
> > >> > > > gives us the chance to avoid taking the BQL for some monitor=
 commands
> > >> > in
> > >> > > > the future.
> > >> > > >
> > >> > > > * Why this change?
> > >> > > >
> > >> > > > We need these per-monitor threads to make sure we can have a=
t least one
> > >> > > > monitor that will never stuck (that can receive further moni=
tor
> > >> > > > commands).
> > >> > > >
> > >> > > > * So when will monitors stuck?  And, how do they stuck?
> > >> > > >
> > >> > > > After we have postcopy and remote page faults, it's simple t=
o achieve a
> > >> > > > stuck in the monitor (which is also a stuck in main loop thr=
ead):
> > >> > > >
> > >> > > > (1) Monitor deadlock on BQL
> > >> > > >
> > >> > > > As we may know, when postcopy is running on destination VM, =
the vcpu
> > >> > > > threads can stuck merely any time as long as it tries to acc=
ess an
> > >> > > > uncopied guest page.  Meanwhile, when the stuck happens, it =
is possible
> > >> > > > that the vcpu thread is holding the BQL.  If the page fault =
is not
> > >> > > > handled quickly, you'll find that monitors stop working, whi=
ch is
> > >> > trying
> > >> > > > to take the BQL.
> > >> > > >
> > >> > > > If the page fault cannot be handled correctly (one case is a=
 paused
> > >> > > > postcopy, when network is temporarily down), monitors will h=
ang
> > >> > > > forever.  Without current patch, that means the main loop ha=
nged.
> > >> > We'll
> > >> > > > never find a way to talk to VM again.
> > >> > > >
> > >> > >
> > >> > > Could the BQL be pushed down to the monitor commands level ins=
tead? That
> > >> > > way we wouldn't need a seperate thread to solve the hang on co=
mmands that
> > >> > > do not need BQL.
> > >> >
> > >> > If the main thread is stuck though I don't see how that helps yo=
u; you
> > >> > have to be able to run these commands on another thread.
> > >> >
> > >>
> > >> Why would the main thread be stuck? In (1) If the vcpu thread take=
s the BQL
> > >> and the command doesn't need it, it would work.  In (2),  info cpu=
s
> > >> shouldn't keep the BQL (my qapi-async series would probably help h=
ere)
> > >
> > > (Thanks for joining the discussion)
> > >
> > > AFAIK the main thread can be stuck for many reasons.  I have seen o=
ne
> > > stack when the VGA code (IIUC) was trying to writting to guest grap=
hic
> > > memory in main loop thread but luckily that guest page is still not
> > > copied yet from source.  As long as the main thread is stuck for an=
y
> > > reason, no chance for monitor commands, even if the commands suppor=
t
> > > async operations.
> >=20
> > If that command becomes async (it probably should, any command doing
> > IO probaly should), then the main loop can keep running.
>=20
> The problem is that, it's not blocked at "a command", but a task
> running on the main thread.  The task can access guest memory, and
> when the guest page is not there, the main thread hangs.  Then it
> hangs every monitors, and all other tasks that are bounded to main
> thread.

This is my main reason for believing we need this approach; I don't
see how the async-command solution solves it.

(I don't have anything against the async command stuff, I just don't
think it solves this problem)

Dave

> >=20
> > >
> > > So IMHO the only solution is doing these things in separate threads=
,
> > > rather than all in a single one.
> >=20
> > I wouldn't say it's the only solution. I think the monitor can touch
> > many areas that haven't been written with multi-threading in mind. My
> > proposal is probably safer, although I don't know how hard it would b=
e
> > to push the BQL down to QMP commands, and make async existing IO
> > commands. The benefits of this work are quite interesting imho,
> > because a stuck mainloop is basically a stuck qemu, and an additional
> > thread will not solve it...
> >=20
> > --=20
> > Marc-Andr=E9 Lureau
>=20
> --=20
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
