Received: from eggs.gnu.org ([2001:4830:134:3::10]:52532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkmmT-0002GX-UU
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkmmS-0005dV-TQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:42:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
	<da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
	<c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
	<5d84655b-d82a-956a-f434-023961b23552@redhat.com>
	<2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
	<bddc04d6-686e-ca5c-ef30-6df7bdb9c3bf@redhat.com>
Date: Thu, 24 Aug 2017 09:42:06 +0200
In-Reply-To: <bddc04d6-686e-ca5c-ef30-6df7bdb9c3bf@redhat.com> (Paolo
	Bonzini's message of "Wed, 23 Aug 2017 23:50:28 +0200")
Message-ID: <87h8wxqunl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 08/13] tests: Rely more on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, "open list:Floppy" <qemu-block@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/08/2017 23:30, Eric Blake wrote:
>>> Well, whatever is assigning to global_qtest should be using the long form.
>> Question - what about going the other way, and switching ALL callers to
>> always use the explicit form?  I'd really like to maintain only one
>> form, but if we think maintaining the explicit form is better, then I'd
>> rather see:
>> 
>> s = qtest_init(...);
>> qmp(s, "{'execute':'foo'}");
>
> I think the short form is not problematic per se, but when e.g.
> migration is involved, then the tests are abusing it...

The long forms avoid global state.  Global state exits through the front
door; designer congratulates himself for this virtous deed.

Trouble is the long forms are, well, long, so designer creates short
ones.  Global state jumps right back through the open window.  Almost
everything uses the short forms, and with good reason.

Ritual avoidance of global state without really avoiding it has a
name in German programming jargon: "Muesli".

While undisciplined use of global state is the root of many problems, I
fail to see a problem here.  For me,

    do this with QTestState A
    do that with QTestState A

    do something with QTestState B

    do more with QTestState A

is no better than

    with QTestState A
        do this
        do that

    with QTestState B
        do something

    with QTestState A
        do more

In a language less primitive than C, I'd write it exactly that way, and
nobody would complain.  In old, primitive C, I have to write

    global_qtest = A;
    do this
    do that

    global_qtest = B;
    do something

    global_qtest = A;
    do more

Why's that so horrible to justify busywork on wrappers?

Creating and updating the short form wrappers has grown on me.  If I
enjoyed busywork, I would've become Vice President of Nothing in
Particular or something.

Pretty-please?  ;)
