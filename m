Received: from eggs.gnu.org ([2001:4830:134:3::10]:47589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlHN2-0002vd-Rt
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlHN1-00032H-5H
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:22:08 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:34023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dlHN0-00031H-Vb
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:22:07 -0400
Received: by mail-ua0-x243.google.com with SMTP id t47so121683uah.1
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 09:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<20170825161221.GM2090@work-vm>
In-Reply-To: <20170825161221.GM2090@work-vm>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 25 Aug 2017 16:21:56 +0000
Message-ID: <CAJ+F1CLURZ8JqRKzCHX+xgq6XW5GL=Th4m3CH2j6OYgupiRGbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Fri, Aug 25, 2017 at 6:12 PM Dr. David Alan Gilbert <dgilbert@redhat.com=
>
wrote:

> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <
> dgilbert@redhat.com>
> > wrote:
> >
> > > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > > Hi
> > > >
> > > > On Wed, Aug 23, 2017 at 8:52 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > > Firstly, introduce Monitor.use_thread, and set it for monitors
> that are
> > > > > using non-mux typed backend chardev.  We only do this for
> monitors, so
> > > > > mux-typed chardevs are not suitable (when it connects to, e.g.,
> serials
> > > > > and the monitor together).
> > > > >
> > > > > When use_thread is set, we create standalone thread to poll the
> monitor
> > > > > events, isolated from the main loop thread.  Here we still need t=
o
> take
> > > > > the BQL before dispatching the tasks since some of the monitor
> commands
> > > > > are not allowed to execute without the protection of BQL.  Then
> this
> > > > > gives us the chance to avoid taking the BQL for some monitor
> commands
> > > in
> > > > > the future.
> > > > >
> > > > > * Why this change?
> > > > >
> > > > > We need these per-monitor threads to make sure we can have at
> least one
> > > > > monitor that will never stuck (that can receive further monitor
> > > > > commands).
> > > > >
> > > > > * So when will monitors stuck?  And, how do they stuck?
> > > > >
> > > > > After we have postcopy and remote page faults, it's simple to
> achieve a
> > > > > stuck in the monitor (which is also a stuck in main loop thread):
> > > > >
> > > > > (1) Monitor deadlock on BQL
> > > > >
> > > > > As we may know, when postcopy is running on destination VM, the
> vcpu
> > > > > threads can stuck merely any time as long as it tries to access a=
n
> > > > > uncopied guest page.  Meanwhile, when the stuck happens, it is
> possible
> > > > > that the vcpu thread is holding the BQL.  If the page fault is no=
t
> > > > > handled quickly, you'll find that monitors stop working, which is
> > > trying
> > > > > to take the BQL.
> > > > >
> > > > > If the page fault cannot be handled correctly (one case is a paus=
ed
> > > > > postcopy, when network is temporarily down), monitors will hang
> > > > > forever.  Without current patch, that means the main loop hanged.
> > > We'll
> > > > > never find a way to talk to VM again.
> > > > >
> > > >
> > > > Could the BQL be pushed down to the monitor commands level instead?
> That
> > > > way we wouldn't need a seperate thread to solve the hang on command=
s
> that
> > > > do not need BQL.
> > >
> > > If the main thread is stuck though I don't see how that helps you; yo=
u
> > > have to be able to run these commands on another thread.
> > >
> >
> > Why would the main thread be stuck? In (1) If the vcpu thread takes the
> BQL
> > and the command doesn't need it, it would work.
>
> True; assuming nothing else in the main loop is blocked;  which is a big
> if - making sure no bh's etc could block on guest memory or the bql.
>
>
> In (2),  info cpus
> > shouldn't keep the BQL (my qapi-async series would probably help here)
>
> How does that work?
>
>
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03626.html

With the series, a command can be broken up in receive/start &
finish/reply. This allows to reenter the loop, potentially freeing the BQL,
and process other events. This allowed me to fix a screendump glitch bug (
http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03650.html). This
also open the door to concurrent QMP commands (if the client turns on the
capability option).

--=20
Marc-Andr=C3=A9 Lureau
