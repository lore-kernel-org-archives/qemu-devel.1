Received: from eggs.gnu.org ([2001:4830:134:3::10]:56665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmNm3-0007vN-BA
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmNm1-0007u8-6x
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:24:31 -0400
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:33384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dmNm1-0007ty-0g
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 13:24:29 -0400
Received: by mail-vk0-x22e.google.com with SMTP id j7so3273245vke.0
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 10:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<87fucc3q78.fsf@dusky.pond.sub.org>
	<CAJ+F1CK-srFaVCEA1iQurSayDc2u9QVSU9RYnV_uxK_iYTDE-A@mail.gmail.com>
	<87k21ny82k.fsf@dusky.pond.sub.org>
In-Reply-To: <87k21ny82k.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Aug 2017 17:24:17 +0000
Message-ID: <CAJ+F1C+Tc=s0PiRqcb9hrRxa6xPrKOXkiX=R5S_YSr2wLrH_cQ@mail.gmail.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Mon, Aug 28, 2017 at 6:24 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> >
> > On Mon, Aug 28, 2017 at 1:08 PM Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >>
> >> > On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <
> >> dgilbert@redhat.com>
> >> > wrote:
> >> >
> >> >> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
> [...]
> >> >> > Could the BQL be pushed down to the monitor commands level
> instead? That
> >> >> > way we wouldn't need a seperate thread to solve the hang on
> commands that
> >> >> > do not need BQL.
> >> >>
> >> >> If the main thread is stuck though I don't see how that helps you;
> you
> >> >> have to be able to run these commands on another thread.
> >> >>
> >> >
> >> > Why would the main thread be stuck? In (1) If the vcpu thread takes
> the BQL
> >> > and the command doesn't need it, it would work.  In (2),  info cpus
> >> > shouldn't keep the BQL (my qapi-async series would probably help her=
e)
> >>
> >> This has been discussed several times[*], but of course not with
> >> everybody, so I'll summarize once more: asynchronous commands are not =
a
> >> actually *required* for anything.  They are *one* way to package the
> >> "kick off task, receive an asynchronous message when it's done" patter=
n.
> >> Another way is synchronous command for the kick off, event for the
> >> "done".
> >>
> >
> > But you would have to break or duplicate the QMP APIs. My proposal
> doesn't
> > need that, a command can reenter the main loop, and keep current QMP AP=
I.
>
> Changing an existing command from synchronous to asynchronous is
> definitely an API change, as discussed before.
>

We are getting of topic, but I really feel there is a misunderstanding and
a wrong evaluation of my -async proposal.

The command is in no way asynchronous from an external point of view, as
long as the QMP user doesn't declare async capability.

There is no external API change. The "internal API" change is made optional
too.


> >> For better or worse, synchronous command + event is what we have today=
.
> >> Whether adding another way to package the the same thing improves the
> >> QMP interface is doubtful.
> >>
> >
> > I would argue my series is mostly about internal refactoring for the
> > benefit mentionned above. The fact that you can do (optionnaly)
> concurrent
> > QMP commands is a nice bonus. Furthermore, it simplifies the API compar=
ed
> > to CMD / dummy reply + EVENT. And it gives a meaning to the exisiting
> > command "id"..
>
> Call a change "mostly internal" when it fundamentally extends the QMP
> protocol makes as much sense to me as "mostly not pregnant".


> The non-dummy nature of the command reply has also been discussed
> several times.  So has been the relative complexity of "synchronous
> commands + events" vs. "asynchronous commands" vs. "both".  In
> considerable detail, in fact:
>
>     Message-ID: <87mvaszbsu.fsf@dusky.pond.sub.org>
>     http://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01090.html
>
> Let me quote its last few lines:
>
>     Bottom line:
>
>     1. I still don't want to merge this.
>

>     2. I want us to tackle jobs sooner rather than later.
>
>     3. Once we got at least a jobs prototype, I'm willing to reconsider
>        asynchronous commands implemented as special case of jobs.
>

This is not being fair tbh, my proposal is RFC for 2y, and has been ready
for a while. I have no clear clue what the "jobs" API would look like, or
what are the requirements, so I can't work on it or defend my work. But it
will almost certainly benefit from my low-level -async work.


>     One of the most important maintainer duties is saying "no".  It's als=
o
>     one of the least fun duties.
>
>
I'm happy to reconsider this conclusion when presented with new
> evidence.
>

 I am still convince my proposal has many merits, so I will keep proposing
it when I see conflicts with what I have, even if you said "no" to an
earlier merge request.


> Asynchronous commands vs. synchronous commands + events are different
> packaging of the same thing: neither can do anything the other could not
> do.  If we want to make progress on the monitor hang problem (this
> thread's topic), we should focus on the *concepts*, not how to best
> package them for QMP.
>

Right, please ignore  the optional QMP protocol -async capability and look
at it: one way is to make long-lived/blocking QMP commands -async
internally, so other work can happen. This is 90% of my -async proposal.


> >> [*] Try this one:
> >> Message-ID: <87o9yv890z.fsf@dusky.pond.sub.org>
> >> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05483.html
>
--=20
Marc-Andr=C3=A9 Lureau
