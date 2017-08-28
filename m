Received: from eggs.gnu.org ([2001:4830:134:3::10]:54744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmHu9-0001ve-Gd
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmHu5-0002es-F9
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:08:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dmHu5-0002eX-5r
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:08:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
Date: Mon, 28 Aug 2017 13:08:11 +0200
In-Reply-To: <CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 25 Aug 2017
	16:07:34 +0000")
Message-ID: <87fucc3q78.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, mdroth@linux.vnet.ibm.com, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <dgilbert@redhat.c=
om>
> wrote:
>
>> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
>> > Hi
>> >
>> > On Wed, Aug 23, 2017 at 8:52 AM Peter Xu <peterx@redhat.com> wrote:
>> >
>> > > Firstly, introduce Monitor.use_thread, and set it for monitors that =
are
>> > > using non-mux typed backend chardev.  We only do this for monitors, =
so
>> > > mux-typed chardevs are not suitable (when it connects to, e.g., seri=
als
>> > > and the monitor together).
>> > >
>> > > When use_thread is set, we create standalone thread to poll the moni=
tor
>> > > events, isolated from the main loop thread.  Here we still need to t=
ake
>> > > the BQL before dispatching the tasks since some of the monitor comma=
nds
>> > > are not allowed to execute without the protection of BQL.  Then this
>> > > gives us the chance to avoid taking the BQL for some monitor command=
s in
>> > > the future.
>> > >
>> > > * Why this change?
>> > >
>> > > We need these per-monitor threads to make sure we can have at least =
one
>> > > monitor that will never stuck (that can receive further monitor
>> > > commands).
>> > >
>> > > * So when will monitors stuck?  And, how do they stuck?
>> > >
>> > > After we have postcopy and remote page faults, it's simple to achiev=
e a
>> > > stuck in the monitor (which is also a stuck in main loop thread):
>> > >
>> > > (1) Monitor deadlock on BQL
>> > >
>> > > As we may know, when postcopy is running on destination VM, the vcpu
>> > > threads can stuck merely any time as long as it tries to access an
>> > > uncopied guest page.  Meanwhile, when the stuck happens, it is possi=
ble
>> > > that the vcpu thread is holding the BQL.  If the page fault is not
>> > > handled quickly, you'll find that monitors stop working, which is tr=
ying
>> > > to take the BQL.
>> > >
>> > > If the page fault cannot be handled correctly (one case is a paused
>> > > postcopy, when network is temporarily down), monitors will hang
>> > > forever.  Without current patch, that means the main loop hanged. We=
'll
>> > > never find a way to talk to VM again.
>> > >
>> >
>> > Could the BQL be pushed down to the monitor commands level instead? Th=
at
>> > way we wouldn't need a seperate thread to solve the hang on commands t=
hat
>> > do not need BQL.
>>
>> If the main thread is stuck though I don't see how that helps you; you
>> have to be able to run these commands on another thread.
>>
>
> Why would the main thread be stuck? In (1) If the vcpu thread takes the B=
QL
> and the command doesn't need it, it would work.  In (2),  info cpus
> shouldn't keep the BQL (my qapi-async series would probably help here)

This has been discussed several times[*], but of course not with
everybody, so I'll summarize once more: asynchronous commands are not a
actually *required* for anything.  They are *one* way to package the
"kick off task, receive an asynchronous message when it's done" pattern.
Another way is synchronous command for the kick off, event for the
"done".

For better or worse, synchronous command + event is what we have today.
Whether adding another way to package the the same thing improves the
QMP interface is doubtful.


[*] Try this one:
Message-ID: <87o9yv890z.fsf@dusky.pond.sub.org>
https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05483.html
