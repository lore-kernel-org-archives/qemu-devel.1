Received: from eggs.gnu.org ([2001:4830:134:3::10]:50366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmAN5-0004Im-HX
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmAN2-00023l-B9
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmAN2-00022c-1r
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 23:05:48 -0400
Date: Mon, 28 Aug 2017 11:05:38 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170828030538.GI14174@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Aug 25, 2017 at 04:07:34PM +0000, Marc-Andr=C3=A9 Lureau wrote:
> On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <dgilbert@redhat=
.com>
> wrote:
>=20
> > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > Hi
> > >
> > > On Wed, Aug 23, 2017 at 8:52 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > > Firstly, introduce Monitor.use_thread, and set it for monitors th=
at are
> > > > using non-mux typed backend chardev.  We only do this for monitor=
s, so
> > > > mux-typed chardevs are not suitable (when it connects to, e.g., s=
erials
> > > > and the monitor together).
> > > >
> > > > When use_thread is set, we create standalone thread to poll the m=
onitor
> > > > events, isolated from the main loop thread.  Here we still need t=
o take
> > > > the BQL before dispatching the tasks since some of the monitor co=
mmands
> > > > are not allowed to execute without the protection of BQL.  Then t=
his
> > > > gives us the chance to avoid taking the BQL for some monitor comm=
ands
> > in
> > > > the future.
> > > >
> > > > * Why this change?
> > > >
> > > > We need these per-monitor threads to make sure we can have at lea=
st one
> > > > monitor that will never stuck (that can receive further monitor
> > > > commands).
> > > >
> > > > * So when will monitors stuck?  And, how do they stuck?
> > > >
> > > > After we have postcopy and remote page faults, it's simple to ach=
ieve a
> > > > stuck in the monitor (which is also a stuck in main loop thread):
> > > >
> > > > (1) Monitor deadlock on BQL
> > > >
> > > > As we may know, when postcopy is running on destination VM, the v=
cpu
> > > > threads can stuck merely any time as long as it tries to access a=
n
> > > > uncopied guest page.  Meanwhile, when the stuck happens, it is po=
ssible
> > > > that the vcpu thread is holding the BQL.  If the page fault is no=
t
> > > > handled quickly, you'll find that monitors stop working, which is
> > trying
> > > > to take the BQL.
> > > >
> > > > If the page fault cannot be handled correctly (one case is a paus=
ed
> > > > postcopy, when network is temporarily down), monitors will hang
> > > > forever.  Without current patch, that means the main loop hanged.
> > We'll
> > > > never find a way to talk to VM again.
> > > >
> > >
> > > Could the BQL be pushed down to the monitor commands level instead?=
 That
> > > way we wouldn't need a seperate thread to solve the hang on command=
s that
> > > do not need BQL.
> >
> > If the main thread is stuck though I don't see how that helps you; yo=
u
> > have to be able to run these commands on another thread.
> >
>=20
> Why would the main thread be stuck? In (1) If the vcpu thread takes the=
 BQL
> and the command doesn't need it, it would work.  In (2),  info cpus
> shouldn't keep the BQL (my qapi-async series would probably help here)

(Thanks for joining the discussion)

AFAIK the main thread can be stuck for many reasons.  I have seen one
stack when the VGA code (IIUC) was trying to writting to guest graphic
memory in main loop thread but luckily that guest page is still not
copied yet from source.  As long as the main thread is stuck for any
reason, no chance for monitor commands, even if the commands support
async operations.

So IMHO the only solution is doing these things in separate threads,
rather than all in a single one.

--=20
Peter Xu
