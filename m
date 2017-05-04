Received: from eggs.gnu.org ([2001:4830:134:3::10]:51776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6H29-0001Vc-SD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6H26-0001Xh-Pp
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:43:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6H26-0001Xd-Fu
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:43:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170502203115.22233-1-ehabkost@redhat.com>
	<20170502203115.22233-3-ehabkost@redhat.com>
	<87y3udsz3k.fsf@dusky.pond.sub.org>
	<20170503183037.GV3482@thinpad.lan.raisama.net>
	<87vaphm4fs.fsf@dusky.pond.sub.org>
	<0778f9a5-d974-9beb-ae94-b8e46de7b75d@redhat.com>
Date: Thu, 04 May 2017 15:42:59 +0200
In-Reply-To: <0778f9a5-d974-9beb-ae94-b8e46de7b75d@redhat.com> (Eric Blake's
	message of "Thu, 4 May 2017 08:23:33 -0500")
Message-ID: <871ss4d9gc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] string-input-visitor: Support
 alternate types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Eric Blake <eblake@redhat.com> writes:

> On 05/04/2017 03:06 AM, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>>> On Wed, May 03, 2017 at 06:07:43PM +0200, Markus Armbruster wrote:
>>>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>>>
>>>>> When parsing alternates from a string, there are some limitations in
>>>>> what we can do, but it is a valid use case in some situations. We can
>>>>> support booleans, integer types, and enums.
>> 
>> By the way, the same restrictions apply to the "keyval" variant of the
>> QObject input visitor.  It's a known problem stated here:
>> 
>>     Message-ID: <8737exuz6u.fsf@dusky.pond.sub.org>
>>     https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00046.html
>> 
>> However, I failed to document it properly in the source.
>> 
>
>>>> Begs the question what happens when you violate these restrictions.
>>>
>>> Right now, we don't detect those cases and behavior is undefined.
>>> I think it will be a good idea to give start_alternate() enough
>>> information to detect those cases (by adding a 'const char *const
>>> enum_table[]' parameter).
>> 
>> Alternate types that won't work with the string input visitor can be
>> detected at compile time (by qapi.py), but not their actual use.  Pity.
>> 
>> Do we actually use alternates that violate the restrictions?  If not, we
>> could simply restrict alternates so they work with *all* visitors.  If
>> we ever run into an actual need for alternates that don't, we'll be no
>> worse off than now.
>> 
>> Let's review existing alternates outside tests:
>> 
>> * Qcow2OverlapChecks: struct + enum
>> * BlockdevRef: struct + str
>> * GuestFileWhence: int + enum (all enum members start with a letter)
>> 
>> Restricting alternates looks practical to me.  Eric, what do you think?
>
> As in: we forbid the combination of a scalar (whether 'int', 'number',
> 'bool', and perhaps 'null') with a plain 'str' (since there's no way to
> tell whether '1' should parse as an integer or the string "1"); and
> combining a scalar with an 'enum' requires that all enum members be
> distinct from what could otherwise be parsed as a scalar?

Exactly.

>                                                            I can live
> with such a restriction.

Then let's do it.

Eduardo, are you comfortable implementing this, or would you like me to
do it?
