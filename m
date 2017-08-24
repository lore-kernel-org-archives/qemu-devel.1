Received: from eggs.gnu.org ([2001:4830:134:3::10]:54436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkp4n-0004mE-Qq
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkp4m-0002oe-UP
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:09:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
	<da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
	<c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
	<5d84655b-d82a-956a-f434-023961b23552@redhat.com>
	<2ffb6aab-09a0-7136-946f-f68f7478c0f7@redhat.com>
	<bddc04d6-686e-ca5c-ef30-6df7bdb9c3bf@redhat.com>
	<87h8wxqunl.fsf@dusky.pond.sub.org>
	<e1c18d2a-ac5e-2892-3343-80b943345f3e@redhat.com>
Date: Thu, 24 Aug 2017 12:09:15 +0200
In-Reply-To: <e1c18d2a-ac5e-2892-3343-80b943345f3e@redhat.com> (Paolo
	Bonzini's message of "Thu, 24 Aug 2017 10:52:06 +0200")
Message-ID: <874lsxnupg.fsf@dusky.pond.sub.org>
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, "open list:Floppy" <qemu-block@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 24/08/2017 09:42, Markus Armbruster wrote:
>> 
>> In a language less primitive than C, I'd write it exactly that way, and
>> nobody would complain.  In old, primitive C, I have to write
>> 
>>     global_qtest = A;
>>     do this
>>     do that
>> 
>>     global_qtest = B;
>>     do something
>> 
>>     global_qtest = A;
>>     do more
>> 
>> Why's that so horrible to justify busywork on wrappers?
>
> Because cut-and-paste is a thing. :(

Cut-and-paste cuts both ways (pardon the pun):

    initialize with QTestState A
    frobnicate with QTestState A
    glomnify with QTestState A
    frobnicate with QTestState A
    initialize with QTestState B
    boingboing with QTestState B
    finalize with QTestState A
    finalize with QTestState A

Uh, forgot to frobnicate after boingboing, let me fix that real quick!

    initialize with QTestState A
    frobnicate with QTestState A
    glomnify with QTestState A
    frobnicate with QTestState A
    initialize with QTestState B
    boingboing with QTestState B
    frobnicate with QTestState A
    finalize with QTestState A
    finalize with QTestState A

Spot the pasto.

This hasty paste would simply work with global_qtest.  I'm not claiming
there are cases that are just the opposite.  I'm just challenging your
apparent claim that the long forms help with avoiding or catching
pastos.  Can you explain how they help more than they hurt?

A bit of global state isn't automatically bad.  *Shared* global state is
what gets us into trouble.  Can you point to examples where global_qtest
is shared in ways that aren't 100% trivial?
