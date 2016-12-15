Received: from eggs.gnu.org ([2001:4830:134:3::10]:40458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHWMr-0006K1-8D
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHWMn-00029V-BU
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:46:41 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cHWMn-000294-3h
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 08:46:37 -0500
Received: by mail-wj0-f193.google.com with SMTP id j10so9860799wjb.3
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 05:46:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1481567461-2341-1-git-send-email-ehabkost@redhat.com>
	<87zijyfyq5.fsf@dusky.pond.sub.org>
	<20161214134841.GG3808@thinpad.lan.raisama.net>
	<b5cf13d0-d03f-d477-20ce-211948b315ee@redhat.com>
	<87oa0e8kt5.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66ac2973-03c3-a04a-bead-981314e63bbd@redhat.com>
Date: Thu, 15 Dec 2016 14:45:34 +0100
MIME-Version: 1.0
In-Reply-To: <87oa0e8kt5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Lin Ma <lma@suse.com>



On 14/12/2016 18:47, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 14/12/2016 14:48, Eduardo Habkost wrote:
>>>> How do you find all abstract TypeInfo in the source?  The uninitiated
>>>> might grep for .abstract = true, and be misled.  The initiated will be
>>>> annoyed instead, because grepping for *absence* of .instance_size = is
>>>> bothersome.
>>>>
>>>> I suspect life could be easier going forward if we instead required
>>>> .abstract = true for interfaces, and enforced it with
>>>> assert(ti->instance_size || ti->abstract) here.
>>> I was doing that before deciding to change type_initialize(). I
>>> think I still have the commit in my git reflog, I will recover it
>>> and submit it as v3.
>>
>> I think it's worse.
>>
>> Interfaces are abstract by definition.  Requiring ".abstract = true"
>> makes things less intuitive.  v2 seems good.
> 
> What makes a TypeInfo declaration an interface?  Whatever it is, it
> better be *locally* obvious.

The fact that the superclass is an interface:

1) most interface names are (or should be) "interfacey".  Compare
device, memory backend, console (all classes) with user-creatable, fw
path provider, hotplug handler.  A few others simply end with "_IF".  Of
course naming is the hardest problem in computer science so there are
some interfaces whose name might apply just as well to a class (stream
slave, ISA DMA).  However...

2) ... currently we don't have a single case of an interface that
doesn't inherit from TYPE_INTERFACE, so all interfaces are declared with
".parent = TYPE_INTERFACE".  That does make a TypeInfo obviously an
interface.

If we ever have a case of interface inheritance, the supertype had
better have a good name.

Paolo
