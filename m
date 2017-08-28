Received: from eggs.gnu.org ([2001:4830:134:3::10]:54829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmH1E-0007VA-P2
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmH1B-000235-5R
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:11:44 -0400
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:36285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dmH1A-00020x-VS
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 06:11:41 -0400
Received: by mail-ua0-x22d.google.com with SMTP id 105so180557uad.3
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 03:11:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170828030538.GI14174@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<20170828030538.GI14174@pxdev.xzpeter.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Aug 2017 12:11:38 +0200
Message-ID: <CAJ+F1CJ34uwxrbZ6zmp0Z+7baWh-uSxYJNvj2QJE1ryyUpOi3Q@mail.gmail.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Mon, Aug 28, 2017 at 5:05 AM, Peter Xu <peterx@redhat.com> wrote:
> On Fri, Aug 25, 2017 at 04:07:34PM +0000, Marc-Andr=C3=A9 Lureau wrote:
>> On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <dgilbert@redhat.=
com>
>> wrote:
>>
>> > * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
>> > > Hi
>> > >
>> > > On Wed, Aug 23, 2017 at 8:52 AM Peter Xu <peterx@redhat.com> wrote:
>> > >
>> > > > Firstly, introduce Monitor.use_thread, and set it for monitors tha=
t are
>> > > > using non-mux typed backend chardev.  We only do this for monitors=
, so
>> > > > mux-typed chardevs are not suitable (when it connects to, e.g., se=
rials
>> > > > and the monitor together).
>> > > >
>> > > > When use_thread is set, we create standalone thread to poll the mo=
nitor
>> > > > events, isolated from the main loop thread.  Here we still need to=
 take
>> > > > the BQL before dispatching the tasks since some of the monitor com=
mands
>> > > > are not allowed to execute without the protection of BQL.  Then th=
is
>> > > > gives us the chance to avoid taking the BQL for some monitor comma=
nds
>> > in
>> > > > the future.
>> > > >
>> > > > * Why this change?
>> > > >
>> > > > We need these per-monitor threads to make sure we can have at leas=
t one
>> > > > monitor that will never stuck (that can receive further monitor
>> > > > commands).
>> > > >
>> > > > * So when will monitors stuck?  And, how do they stuck?
>> > > >
>> > > > After we have postcopy and remote page faults, it's simple to achi=
eve a
>> > > > stuck in the monitor (which is also a stuck in main loop thread):
>> > > >
>> > > > (1) Monitor deadlock on BQL
>> > > >
>> > > > As we may know, when postcopy is running on destination VM, the vc=
pu
>> > > > threads can stuck merely any time as long as it tries to access an
>> > > > uncopied guest page.  Meanwhile, when the stuck happens, it is pos=
sible
>> > > > that the vcpu thread is holding the BQL.  If the page fault is not
>> > > > handled quickly, you'll find that monitors stop working, which is
>> > trying
>> > > > to take the BQL.
>> > > >
>> > > > If the page fault cannot be handled correctly (one case is a pause=
d
>> > > > postcopy, when network is temporarily down), monitors will hang
>> > > > forever.  Without current patch, that means the main loop hanged.
>> > We'll
>> > > > never find a way to talk to VM again.
>> > > >
>> > >
>> > > Could the BQL be pushed down to the monitor commands level instead? =
That
>> > > way we wouldn't need a seperate thread to solve the hang on commands=
 that
>> > > do not need BQL.
>> >
>> > If the main thread is stuck though I don't see how that helps you; you
>> > have to be able to run these commands on another thread.
>> >
>>
>> Why would the main thread be stuck? In (1) If the vcpu thread takes the =
BQL
>> and the command doesn't need it, it would work.  In (2),  info cpus
>> shouldn't keep the BQL (my qapi-async series would probably help here)
>
> (Thanks for joining the discussion)
>
> AFAIK the main thread can be stuck for many reasons.  I have seen one
> stack when the VGA code (IIUC) was trying to writting to guest graphic
> memory in main loop thread but luckily that guest page is still not
> copied yet from source.  As long as the main thread is stuck for any
> reason, no chance for monitor commands, even if the commands support
> async operations.

If that command becomes async (it probably should, any command doing
IO probaly should), then the main loop can keep running.

>
> So IMHO the only solution is doing these things in separate threads,
> rather than all in a single one.

I wouldn't say it's the only solution. I think the monitor can touch
many areas that haven't been written with multi-threading in mind. My
proposal is probably safer, although I don't know how hard it would be
to push the BQL down to QMP commands, and make async existing IO
commands. The benefits of this work are quite interesting imho,
because a stuck mainloop is basically a stuck qemu, and an additional
thread will not solve it...

--=20
Marc-Andr=C3=A9 Lureau
