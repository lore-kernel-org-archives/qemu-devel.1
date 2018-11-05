Received: from eggs.gnu.org ([2001:4830:134:3::10]:60125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJhCH-0006vE-JD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gJhCC-0004Tc-H7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:53:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gJhC5-00048t-H2
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:53:40 -0500
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
	<87pnvqdvsj.fsf@dusky.pond.sub.org>
	<e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com>
	<875zxingqn.fsf@dusky.pond.sub.org>
	<440eb166-73d1-77b6-5dd9-66a0abd7d665@redhat.com>
	<87muqn5ydc.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1ec41fe2-d4b4-fce2-9381-818ee3356409@redhat.com>
Date: Mon, 5 Nov 2018 16:53:22 +0100
MIME-Version: 1.0
In-Reply-To: <87muqn5ydc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] qapi: use qemu_strtoi64() in
 parse_str
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 05.11.18 16:37, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 31.10.18 18:55, Markus Armbruster wrote:
>>> David Hildenbrand <david@redhat.com> writes:
>>>
>>>> On 31.10.18 15:40, Markus Armbruster wrote:
>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>
>>>>>> The qemu api claims to be easier to use, and the resulting code seems to
>>>>>> agree.
>>> [...]
>>>>>> @@ -60,9 +61,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>>>>>      }
>>>>>>  
>>>>>>      do {
>>>>>> -        errno = 0;
>>>>>> -        start = strtoll(str, &endptr, 0);
>>>>>> -        if (errno == 0 && endptr > str) {
>>>>>> +        if (!qemu_strtoi64(str, &endptr, 0, &start)) {
>>>>>>              if (*endptr == '\0') {
>>>>>>                  cur = g_malloc0(sizeof(*cur));
>>>>>>                  range_set_bounds(cur, start, start);
>>>>>> @@ -71,11 +70,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>>>>>                  str = NULL;
>>>>>>              } else if (*endptr == '-') {
>>>>>>                  str = endptr + 1;
>>>>>> -                errno = 0;
>>>>>> -                end = strtoll(str, &endptr, 0);
>>>>>> -                if (errno == 0 && endptr > str && start <= end &&
>>>>>> -                    (start > INT64_MAX - 65536 ||
>>>>>> -                     end < start + 65536)) {
>>>>>> +                if (!qemu_strtoi64(str, &endptr, 0, &end) && start < end) {
>>>>>
>>>>> You deleted (start > INT64_MAX - 65536 || end < start + 65536).  Can you
>>>>> explain that to me?  I'm feeling particularly dense today...
>>>>
>>>> qemu_strtoi64 performs all different kinds of error handling completely
>>>> internally. This old code here was an attempt to filter out -EWHATEVER
>>>> from the response. No longer needed as errors and the actual value are
>>>> reported via different ways.
>>>
>>> I understand why errno == 0 && endptr > str go away.  They also do in
>>> the previous hunk.
>>>
>>> The deletion of (start > INT64_MAX - 65536 || end < start + 65536) is
>>> unobvious.  What does it do before the patch?
>>>
>>> The condition goes back to commit 659268ffbff, which predates my watch
>>> as maintainer.  Its commit message is of no particular help.  Its code
>>> is... allright, the less I say about that, the better.
>>>
>>> We're parsing a range here.  We already parsed its lower bound into
>>> @start (and guarded against errors), and its upper bound into @end (and
>>> guarded against errors).
>>>
>>> If the condition you delete is false, we goto error.  So the condition
>>> is about range validity.  I figure it's an attempt to require valid
>>> ranges to be no "wider" than 65535.  The second part end < start + 65536
>>> checks exactly that, except shit happens when start + 65536 overflows.
>>> The first part attempts to guard against that, but
>>>
>>> (1) INT64_MAX is *wrong*, because we compute in long long, and
>>>
>>> (2) it rejects even small ranges like INT64_MAX - 2 .. INT64_MAX - 1.
>>>
>>> WTF?!?
>>>
>>> Unless I'm mistaken, the condition is not about handling any of the
>>> errors that qemu_strtoi64() handles for us.
>>>
>>> The easiest way for you out of this morass is probably to keep the
>>> condition exactly as it was, then use the "my patch doesn't make things
>>> any worse" get-out-of-jail-free card.
>>>
>>
>> Looking at the code in qapi/string-output-visitor.c related to range and
>> list handling I feel like using the get-out-of-jail-free card to get out
>> of qapi code now :) Too much magic in that code and too little time for
>> me to understand it all.
>>
>> Thanks for your time and review anyway. My time is better invested in
>> other parts of QEMU. I will drop both patches from this series.
> 
> Understand.
> 
> When I first looked at the ranges stuff in the string input visitor, I
> felt the urge to clean it up, then sat on my hands until it passed.
> 
> The rest is reasonable once you understand how it works.  The learning
> curve is less than pleasant, though.
> 

Maybe I'll pick this up again when I have more time to invest.

The general concept

1. of having an input visitor that is able to parse different types
(expected by e.g. a property) sounds sane to me.

2. of having a list of *something*, assuming it is int64_t, and assuming
it is to be parsed into a list of ranges sounds completely broken to me.

I was not even able to find an example QEMU comand line for 2. Is this
maybe some very old code that nobody actually uses anymore? (who uses
list of ranges?)

-- 

Thanks,

David / dhildenb
