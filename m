Received: from eggs.gnu.org ([2001:4830:134:3::10]:47981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cIv4z-0003Zc-QI
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cIv4u-0005yh-Sy
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:22:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cIv4u-0005y4-KO
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 05:21:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481567461-2341-1-git-send-email-ehabkost@redhat.com>
	<87zijyfyq5.fsf@dusky.pond.sub.org>
	<20161214134841.GG3808@thinpad.lan.raisama.net>
	<b5cf13d0-d03f-d477-20ce-211948b315ee@redhat.com>
	<87oa0e8kt5.fsf@dusky.pond.sub.org>
	<66ac2973-03c3-a04a-bead-981314e63bbd@redhat.com>
Date: Mon, 19 Dec 2016 11:21:52 +0100
In-Reply-To: <66ac2973-03c3-a04a-bead-981314e63bbd@redhat.com> (Paolo
	Bonzini's message of "Thu, 15 Dec 2016 14:45:34 +0100")
Message-ID: <87lgvcte0v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] qom: Make all interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Lin Ma <lma@suse.com>, qemu-devel@nongnu.org, Andreas =?utf-8?Q?F?= =?utf-8?Q?=C3=A4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 14/12/2016 18:47, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 14/12/2016 14:48, Eduardo Habkost wrote:
>>>>> How do you find all abstract TypeInfo in the source?  The uninitiated
>>>>> might grep for .abstract = true, and be misled.  The initiated will be
>>>>> annoyed instead, because grepping for *absence* of .instance_size = is
>>>>> bothersome.
>>>>>
>>>>> I suspect life could be easier going forward if we instead required
>>>>> .abstract = true for interfaces, and enforced it with
>>>>> assert(ti->instance_size || ti->abstract) here.
>>>> I was doing that before deciding to change type_initialize(). I
>>>> think I still have the commit in my git reflog, I will recover it
>>>> and submit it as v3.
>>>
>>> I think it's worse.
>>>
>>> Interfaces are abstract by definition.  Requiring ".abstract = true"
>>> makes things less intuitive.  v2 seems good.
>> 
>> What makes a TypeInfo declaration an interface?  Whatever it is, it
>> better be *locally* obvious.
>
> The fact that the superclass is an interface:
>
> 1) most interface names are (or should be) "interfacey".  Compare
> device, memory backend, console (all classes) with user-creatable, fw
> path provider, hotplug handler.  A few others simply end with "_IF".  Of
> course naming is the hardest problem in computer science so there are
> some interfaces whose name might apply just as well to a class (stream
> slave, ISA DMA).  However...
>
> 2) ... currently we don't have a single case of an interface that
> doesn't inherit from TYPE_INTERFACE, so all interfaces are declared with
> ".parent = TYPE_INTERFACE".  That does make a TypeInfo obviously an
> interface.
>
> If we ever have a case of interface inheritance, the supertype had
> better have a good name.

I see.

The choice is between a complex default for .abstract that permits us to
elide .abstract = true for interface types, and a simple default that
requires us to spell it out explicitly.

Given that we have the grand total of thirteen interface types, I prefer
simple & explicit.  Thirteen obvious .abstract = true are less of a
mental burden than a complex default.  Even 25 would be for me.
