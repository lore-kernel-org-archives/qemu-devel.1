Received: from eggs.gnu.org ([2001:4830:134:3::10]:43148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dytZA-0006m5-QD
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 01:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dytZ5-0006vA-V6
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 01:46:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dytZ5-0006uN-NM
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 01:46:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-6-eblake@redhat.com>
	<87k22dw4r2.fsf@dusky.pond.sub.org>
	<c9564021-896a-2c29-8f74-0921e94d292a@redhat.com>
Date: Mon, 02 Oct 2017 07:46:47 +0200
In-Reply-To: <c9564021-896a-2c29-8f74-0921e94d292a@redhat.com> (Eric Blake's
	message of "Wed, 9 Aug 2017 08:14:09 -0500")
Message-ID: <87lgkurtiw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
List-ID: <qemu-devel.nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 08/09/2017 02:59 AM, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>> 
>>> qobject_from_jsonv() was unusual in that it took a va_list*, instead
>>> of the more typical va_list; this was so that callers could pass
>>> NULL to avoid % interpolation.  While this works under the hood, it
>>> is awkward for callers, so move the magic into qjson.c rather than
>>> in the public interface, and finally improve the documentation of
>>> qobject_from_jsonf().
>>>
>
>>> -    /* Going through qobject ensures we escape strings properly.
>>> -     * This seemingly unnecessary copy is required in case va_list
>>> -     * is an array type.
>>> -     */
>>> -    va_copy(ap_copy, ap);
>>> -    qobj = qobject_from_jsonv(fmt, &ap_copy, &error_abort);
>>> -    va_end(ap_copy);
>>> +    /* Going through qobject ensures we escape strings properly. */
>>> +    qobj = qobject_from_jsonv(fmt, ap);
>>>      qstr = qobject_to_json(qobj);
>>>
>>>      /*
>> 
>> Wait!  Oh, the va_copy() moves iinto qobject_from_jsonv().  Okay, I
>> guess.
[...]
>>> +
>>> +    /*
>>> +     * This seemingly unnecessary copy is required in case va_list
>>> +     * is an array type.
>>> +     */
>> 
>> --verbose?
>>
>>> +    va_copy(ap_copy, ap);
>>> +    obj = qobject_from_json_internal(string, &ap_copy, &error_abort);
>>> +    va_end(ap_copy);
>
> Code motion. But if the comment needs to be more verbose in the
> destination than it was on the source, the rationale is that C99/POSIX
> allows 'typedef something va_list[]' (that is, where va_list is an array
> of some other type), although I don't know of any modern OS that
> actually defines it like that.  Based on C pointer-decay rules, '&ap'
> has a different type based on whether va_list was a struct/pointer or an
> array type, when 'va_list ap' was passed as a parameter; so we can't
> portably use qobject_from_json_internal(string, &ap, &error_abort).  The
> va_copy() is what lets us guarantee that &ap_list is a pointer to a
> va_list regardless of the type of va_list (because va_copy was declared
> locally, rather than in a parameter list, and is therefore not subject
> to pointer decay), and NOT an accidental pointer to first element of the
> va_list array on platforms where va_list is an array.

I'm dense this Monday morning --- I still can't see where exactly
passing &ap directly goes wrong.

Two cases:

1. va_list is a typedef name for a non-array type T.

2. va_list is a typedef name for an array type E[].

What are the types of actual argument &ap and formal parameter va_list
*ap in either case?

How exactly does case 2 break?
