Received: from eggs.gnu.org ([2001:4830:134:3::10]:40997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmJA2-0002u6-N8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmJA0-0004Nh-Tw
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:28:58 -0400
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:36627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dmJA0-0004NR-Na
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:28:56 -0400
Received: by mail-vk0-x232.google.com with SMTP id d124so866850vkf.3
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 05:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<87fucc3q78.fsf@dusky.pond.sub.org>
In-Reply-To: <87fucc3q78.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Aug 2017 12:28:45 +0000
Message-ID: <CAJ+F1CK-srFaVCEA1iQurSayDc2u9QVSU9RYnV_uxK_iYTDE-A@mail.gmail.com>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, mdroth@linux.vnet.ibm.com, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Mon, Aug 28, 2017 at 1:08 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <
> dgilbert@redhat.com>
> > wrote:
> >
> >> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> >> > Hi
> >> >
> >> > On Wed, Aug 23, 2017 at 8:52 AM Peter Xu <peterx@redhat.com> wrote:
> >> >
> >> > > Firstly, introduce Monitor.use_thread, and set it for monitors tha=
t
> are
> >> > > using non-mux typed backend chardev.  We only do this for monitors=
,
> so
> >> > > mux-typed chardevs are not suitable (when it connects to, e.g.,
> serials
> >> > > and the monitor together).
> >> > >
> >> > > When use_thread is set, we create standalone thread to poll the
> monitor
> >> > > events, isolated from the main loop thread.  Here we still need to
> take
> >> > > the BQL before dispatching the tasks since some of the monitor
> commands
> >> > > are not allowed to execute without the protection of BQL.  Then th=
is
> >> > > gives us the chance to avoid taking the BQL for some monitor
> commands in
> >> > > the future.
> >> > >
> >> > > * Why this change?
> >> > >
> >> > > We need these per-monitor threads to make sure we can have at leas=
t
> one
> >> > > monitor that will never stuck (that can receive further monitor
> >> > > commands).
> >> > >
> >> > > * So when will monitors stuck?  And, how do they stuck?
> >> > >
> >> > > After we have postcopy and remote page faults, it's simple to
> achieve a
> >> > > stuck in the monitor (which is also a stuck in main loop thread):
> >> > >
> >> > > (1) Monitor deadlock on BQL
> >> > >
> >> > > As we may know, when postcopy is running on destination VM, the vc=
pu
> >> > > threads can stuck merely any time as long as it tries to access an
> >> > > uncopied guest page.  Meanwhile, when the stuck happens, it is
> possible
> >> > > that the vcpu thread is holding the BQL.  If the page fault is not
> >> > > handled quickly, you'll find that monitors stop working, which is
> trying
> >> > > to take the BQL.
> >> > >
> >> > > If the page fault cannot be handled correctly (one case is a pause=
d
> >> > > postcopy, when network is temporarily down), monitors will hang
> >> > > forever.  Without current patch, that means the main loop hanged.
> We'll
> >> > > never find a way to talk to VM again.
> >> > >
> >> >
> >> > Could the BQL be pushed down to the monitor commands level instead?
> That
> >> > way we wouldn't need a seperate thread to solve the hang on commands
> that
> >> > do not need BQL.
> >>
> >> If the main thread is stuck though I don't see how that helps you; you
> >> have to be able to run these commands on another thread.
> >>
> >
> > Why would the main thread be stuck? In (1) If the vcpu thread takes the
> BQL
> > and the command doesn't need it, it would work.  In (2),  info cpus
> > shouldn't keep the BQL (my qapi-async series would probably help here)
>
> This has been discussed several times[*], but of course not with
> everybody, so I'll summarize once more: asynchronous commands are not a
> actually *required* for anything.  They are *one* way to package the
> "kick off task, receive an asynchronous message when it's done" pattern.
> Another way is synchronous command for the kick off, event for the
> "done".
>

But you would have to break or duplicate the QMP APIs. My proposal doesn't
need that, a command can reenter the main loop, and keep current QMP API.


> For better or worse, synchronous command + event is what we have today.
> Whether adding another way to package the the same thing improves the
> QMP interface is doubtful.
>

I would argue my series is mostly about internal refactoring for the
benefit mentionned above. The fact that you can do (optionnaly) concurrent
QMP commands is a nice bonus. Furthermore, it simplifies the API compared
to CMD / dummy reply + EVENT. And it gives a meaning to the exisiting
command "id"..


>
> [*] Try this one:
> Message-ID: <87o9yv890z.fsf@dusky.pond.sub.org>
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05483.html
>
--=20
Marc-Andr=C3=A9 Lureau
