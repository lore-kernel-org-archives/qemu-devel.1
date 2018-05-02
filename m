Received: from eggs.gnu.org ([2001:4830:134:3::10]:43219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDrra-0003V7-W7
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDrrX-0000EF-SJ
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:32:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49818 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fDrrX-0000E5-Hr
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:32:03 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87o9inxkd1.fsf@dusky.pond.sub.org>
	<20180430065235.577-1-aik@ozlabs.ru>
	<c23d1ec1-51d7-d967-28a2-0df0f59e7480@redhat.com>
	<d15dfc3e-b33b-f0a9-971a-0f40bbffcdf4@ozlabs.ru>
	<87muxi8t2b.fsf@dusky.pond.sub.org>
	<6c49e4ab-bb40-cf20-629a-2fc5c19d8585@redhat.com>
	<87o9hy5re9.fsf@dusky.pond.sub.org>
	<2fc4e700-9222-8785-efc3-f2749be298ab@redhat.com>
	<8760462q11.fsf@dusky.pond.sub.org>
	<30f96849-0422-7441-e03d-7f340dd14141@redhat.com>
Date: Wed, 02 May 2018 15:31:58 +0200
In-Reply-To: <30f96849-0422-7441-e03d-7f340dd14141@redhat.com> (Paolo
	Bonzini's message of "Wed, 2 May 2018 14:42:19 +0200")
Message-ID: <878t9218vl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH qemu] qom: Document
 qom/device-list-properties implementation specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/05/2018 14:36, Markus Armbruster wrote:
>>> The purpose of this command is to tell people/tools what they can pass
>>> to -device/-object/device_add/object_add, so the real question is
>>> whether there are cases where it falls short of that purpose.
>>>
>>> If not,
>>
>> Do we have to be certain?  Or would "we don't think so" be enough?
>
> I think it's enough.
>
>>>         maybe the wording for the .json file could be something like:
>>>
>>>   Objects can create properties at runtime, for example to describe
>>>   links between different devices and/or objects.  These properties
>>>   are not included in the output of this command.
>>
>> Not bad.
>
> Thanks. :)
>
>> In theory, objects can also create properties in response to non-default
>> configuration, and these would also not be included.  Objects could even
>> create a property with the same name, but different type or description.
>> Arguably capital-letter Bad Ideas, but nothing prevents such misuse.
>> 
>> Since I'm in a generous mood, I'd rate the thing at Rusty API level 4
>> "Follow common convention and you'll get it right."
>> 
>> https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
>> https://ozlabs.org/~rusty/index.cgi/tech/2008-04-01.html
>> 
>> If dynamic properties are really just for internal use
>
> I wouldn't say they are for internal use.  They are somewhat orthogonal
> to the _intended_ use case of this command though.

That makes me suspect that...

>                                                      Somebody is bound
> to be annoyed by them anyway, but that's sort of expected with dynamic
> stuff.
>
>> , as you seem to
>> suggest in Message-ID:
>> <c1d40d88-1c80-2bbd-c28c-613b7fe8d45e@redhat.com>, then we should've had
>> the common sense to unambiguously separate them from the user-facing
>> properties.  Can we still do that?
>
> We do have infrastructure for class properties, we just don't use it much.

... the sane thing to do would be to limit this command to class
properties, and use class properties for anything that doesn't *have* to
be dynamic.  The second half of the sane thing looks like a substantial
chunk of work, though.
