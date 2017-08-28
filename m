Received: from eggs.gnu.org ([2001:4830:134:3::10]:40440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmMpw-0006h9-Pe
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 12:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmMpt-0005t3-KE
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 12:24:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dmMpt-0005ox-BL
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 12:24:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<87fucc3q78.fsf@dusky.pond.sub.org>
	<CAJ+F1CK-srFaVCEA1iQurSayDc2u9QVSU9RYnV_uxK_iYTDE-A@mail.gmail.com>
Date: Mon, 28 Aug 2017 18:24:03 +0200
In-Reply-To: <CAJ+F1CK-srFaVCEA1iQurSayDc2u9QVSU9RYnV_uxK_iYTDE-A@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 28 Aug 2017
	12:28:45 +0000")
Message-ID: <87k21ny82k.fsf@dusky.pond.sub.org>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Aug 28, 2017 at 1:08 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>> > On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <
>> dgilbert@redhat.com>
>> > wrote:
>> >
>> >> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@gmail.com) wrote:
[...]
>> >> > Could the BQL be pushed down to the monitor commands level instead?=
 That
>> >> > way we wouldn't need a seperate thread to solve the hang on command=
s that
>> >> > do not need BQL.
>> >>
>> >> If the main thread is stuck though I don't see how that helps you; you
>> >> have to be able to run these commands on another thread.
>> >>
>> >
>> > Why would the main thread be stuck? In (1) If the vcpu thread takes th=
e BQL
>> > and the command doesn't need it, it would work.  In (2),  info cpus
>> > shouldn't keep the BQL (my qapi-async series would probably help here)
>>
>> This has been discussed several times[*], but of course not with
>> everybody, so I'll summarize once more: asynchronous commands are not a
>> actually *required* for anything.  They are *one* way to package the
>> "kick off task, receive an asynchronous message when it's done" pattern.
>> Another way is synchronous command for the kick off, event for the
>> "done".
>>
>
> But you would have to break or duplicate the QMP APIs. My proposal doesn't
> need that, a command can reenter the main loop, and keep current QMP API.

Changing an existing command from synchronous to asynchronous is
definitely an API change, as discussed before.

>> For better or worse, synchronous command + event is what we have today.
>> Whether adding another way to package the the same thing improves the
>> QMP interface is doubtful.
>>
>
> I would argue my series is mostly about internal refactoring for the
> benefit mentionned above. The fact that you can do (optionnaly) concurrent
> QMP commands is a nice bonus. Furthermore, it simplifies the API compared
> to CMD / dummy reply + EVENT. And it gives a meaning to the exisiting
> command "id"..

Call a change "mostly internal" when it fundamentally extends the QMP
protocol makes as much sense to me as "mostly not pregnant".

The non-dummy nature of the command reply has also been discussed
several times.  So has been the relative complexity of "synchronous
commands + events" vs. "asynchronous commands" vs. "both".  In
considerable detail, in fact:

    Message-ID: <87mvaszbsu.fsf@dusky.pond.sub.org>
    http://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01090.html

Let me quote its last few lines:

    Bottom line:

    1. I still don't want to merge this.

    2. I want us to tackle jobs sooner rather than later.

    3. Once we got at least a jobs prototype, I'm willing to reconsider
       asynchronous commands implemented as special case of jobs.

    One of the most important maintainer duties is saying "no".  It's also
    one of the least fun duties.

I'm happy to reconsider this conclusion when presented with new
evidence.

Asynchronous commands vs. synchronous commands + events are different
packaging of the same thing: neither can do anything the other could not
do.  If we want to make progress on the monitor hang problem (this
thread's topic), we should focus on the *concepts*, not how to best
package them for QMP.

>> [*] Try this one:
>> Message-ID: <87o9yv890z.fsf@dusky.pond.sub.org>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05483.html
