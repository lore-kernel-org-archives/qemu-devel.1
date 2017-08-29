Received: from eggs.gnu.org ([2001:4830:134:3::10]:37943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dma0N-0007d5-4v
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dma0I-0002Xk-VV
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:28:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dma0I-0002X2-LK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 02:28:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<87fucc3q78.fsf@dusky.pond.sub.org>
	<CAJ+F1CK-srFaVCEA1iQurSayDc2u9QVSU9RYnV_uxK_iYTDE-A@mail.gmail.com>
	<87k21ny82k.fsf@dusky.pond.sub.org>
	<CAJ+F1C+Tc=s0PiRqcb9hrRxa6xPrKOXkiX=R5S_YSr2wLrH_cQ@mail.gmail.com>
Date: Tue, 29 Aug 2017 08:27:53 +0200
In-Reply-To: <CAJ+F1C+Tc=s0PiRqcb9hrRxa6xPrKOXkiX=R5S_YSr2wLrH_cQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 28 Aug 2017
	17:24:17 +0000")
Message-ID: <878ti2riqe.fsf@dusky.pond.sub.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, mdroth@linux.vnet.ibm.com, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Aug 28, 2017 at 6:24 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>> > Hi
>> >
>> > On Mon, Aug 28, 2017 at 1:08 PM Markus Armbruster <armbru@redhat.com>
>> wrote:
>> >
>> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>> >>
>> >> > On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <
>> >> dgilbert@redhat.com>
>> >> > wrote:
>> >> >
>> >> >> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
>> [...]
>> >> >> > Could the BQL be pushed down to the monitor commands level
>> instead? That
>> >> >> > way we wouldn't need a seperate thread to solve the hang on
>> commands that
>> >> >> > do not need BQL.
>> >> >>
>> >> >> If the main thread is stuck though I don't see how that helps you;
>> you
>> >> >> have to be able to run these commands on another thread.
>> >> >>
>> >> >
>> >> > Why would the main thread be stuck? In (1) If the vcpu thread takes
>> the BQL
>> >> > and the command doesn't need it, it would work.  In (2),  info cpus
>> >> > shouldn't keep the BQL (my qapi-async series would probably help he=
re)
>> >>
>> >> This has been discussed several times[*], but of course not with
>> >> everybody, so I'll summarize once more: asynchronous commands are not=
 a
>> >> actually *required* for anything.  They are *one* way to package the
>> >> "kick off task, receive an asynchronous message when it's done" patte=
rn.
>> >> Another way is synchronous command for the kick off, event for the
>> >> "done".
>> >>
>> >
>> > But you would have to break or duplicate the QMP APIs. My proposal
>> doesn't
>> > need that, a command can reenter the main loop, and keep current QMP A=
PI.
>>
>> Changing an existing command from synchronous to asynchronous is
>> definitely an API change, as discussed before.
>>
>
> We are getting of topic, but I really feel there is a misunderstanding and
> a wrong evaluation of my -async proposal.
>
> The command is in no way asynchronous from an external point of view, as
> long as the QMP user doesn't declare async capability.
>
> There is no external API change. The "internal API" change is made option=
al
> too.

Recapitulating another bit of previous discussion...

Making the change from synchronous to asynchronous opt-in is indeed
compatible evolution.

Another compatible evolution is an opt-in change from synchronous to
synchronous kick off + notify.

Once again, same thing, different packaging.

>> >> For better or worse, synchronous command + event is what we have toda=
y.
>> >> Whether adding another way to package the the same thing improves the
>> >> QMP interface is doubtful.
>> >>
>> >
>> > I would argue my series is mostly about internal refactoring for the
>> > benefit mentionned above. The fact that you can do (optionnaly)
>> concurrent
>> > QMP commands is a nice bonus. Furthermore, it simplifies the API compa=
red
>> > to CMD / dummy reply + EVENT. And it gives a meaning to the exisiting
>> > command "id"..
>>
>> Call a change "mostly internal" when it fundamentally extends the QMP
>> protocol makes as much sense to me as "mostly not pregnant".
>
>
>> The non-dummy nature of the command reply has also been discussed
>> several times.  So has been the relative complexity of "synchronous
>> commands + events" vs. "asynchronous commands" vs. "both".  In
>> considerable detail, in fact:
>>
>>     Message-ID: <87mvaszbsu.fsf@dusky.pond.sub.org>
>>     http://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01090.html
>>
>> Let me quote its last few lines:
>>
>>     Bottom line:
>>
>>     1. I still don't want to merge this.
>>
>>     2. I want us to tackle jobs sooner rather than later.
>>
>>     3. Once we got at least a jobs prototype, I'm willing to reconsider
>>        asynchronous commands implemented as special case of jobs.
>>
>
> This is not being fair tbh, my proposal is RFC for 2y, and has been ready
> for a while. I have no clear clue what the "jobs" API would look like, or
> what are the requirements, so I can't work on it or defend my work. But it
> will almost certainly benefit from my low-level -async work.

"Jobs" are even readier: it's what we use today.  The trouble is they
aren't instances of a generic jobs API.  We have a few that are
instances of a block jobs API, and a few more that are ad hoc, such as
migration, PCI hotplug with ACPI, dump-guest-memory with detach=3Dtrue.
Item 2. above is rectifying that.  John Snow (cc'ed) has played with it
some.  I asked you to talk it over with him.  Have you done that?
Results?  If not, perhaps talking it over in person at the KVM Forum
would work better.

Note that both block jobs and migration provide more than just "kick
off" and "notify when done": they also let you examine and control the
job.  These features are needed for all but the simplest of cases.

>>     One of the most important maintainer duties is saying "no".  It's al=
so
>>     one of the least fun duties.
>>
>>
>> I'm happy to reconsider this conclusion when presented with new
>> evidence.
>>
>
>  I am still convince my proposal has many merits, so I will keep proposing
> it when I see conflicts with what I have, even if you said "no" to an
> earlier merge request.

Want me to prepare a canned reply I can paste quickly?  You could do the
same for your counter-point, and we all save lots of time.

>> Asynchronous commands vs. synchronous commands + events are different
>> packaging of the same thing: neither can do anything the other could not
>> do.  If we want to make progress on the monitor hang problem (this
>> thread's topic), we should focus on the *concepts*, not how to best
>> package them for QMP.
>>
>
> Right, please ignore  the optional QMP protocol -async capability and look
> at it: one way is to make long-lived/blocking QMP commands -async
> internally, so other work can happen. This is 90% of my -async proposal.

Certain activities that are now synchronous commands should become "kick
off task, receive an asynchronous message when it's done".

The interesting question for *this* thread is inhowfar such a change
could help with avoiding monitor hangs.  Would changing the "right"
commands and making clients use them correctly suffice?  If not, what
other work is needed?

>> >> [*] Try this one:
>> >> Message-ID: <87o9yv890z.fsf@dusky.pond.sub.org>
>> >> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05483.html
