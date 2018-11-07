Received: from eggs.gnu.org ([2001:4830:134:3::10]:37335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKPmQ-000831-Ee
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKPmJ-0002AK-7F
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:30:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gKPmI-00029o-Uk
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 10:29:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-2-david@redhat.com>
	<87pnvqdvsj.fsf@dusky.pond.sub.org>
	<e8fe86a1-d075-2ea8-d1f4-e08e5dceee07@redhat.com>
	<875zxingqn.fsf@dusky.pond.sub.org>
	<440eb166-73d1-77b6-5dd9-66a0abd7d665@redhat.com>
	<87muqn5ydc.fsf@dusky.pond.sub.org>
	<1ec41fe2-d4b4-fce2-9381-818ee3356409@redhat.com>
	<87tvkv2r2b.fsf@dusky.pond.sub.org>
	<64720ade-c69d-40a4-5359-2132711c01cd@redhat.com>
Date: Wed, 07 Nov 2018 16:29:51 +0100
In-Reply-To: <64720ade-c69d-40a4-5359-2132711c01cd@redhat.com> (David
	Hildenbrand's message of "Tue, 6 Nov 2018 10:19:52 +0100")
Message-ID: <87d0rgvrbk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: David Hildenbrand <david@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

David Hildenbrand <david@redhat.com> writes:

> On 05.11.18 21:43, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 05.11.18 16:37, Markus Armbruster wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> On 31.10.18 18:55, Markus Armbruster wrote:
>>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>>
>>>>>>> On 31.10.18 15:40, Markus Armbruster wrote:
>>>>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>>>>
>>>>>>>>> The qemu api claims to be easier to use, and the resulting code seems to
>>>>>>>>> agree.
>>>>>> [...]
>>>>>>>>> @@ -60,9 +61,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>>>>>>>>      }
>>>>>>>>>  
>>>>>>>>>      do {
>>>>>>>>> -        errno = 0;
>>>>>>>>> -        start = strtoll(str, &endptr, 0);
>>>>>>>>> -        if (errno == 0 && endptr > str) {
>>>>>>>>> +        if (!qemu_strtoi64(str, &endptr, 0, &start)) {
>>>>>>>>>              if (*endptr == '\0') {
>>>>>>>>>                  cur = g_malloc0(sizeof(*cur));
>>>>>>>>>                  range_set_bounds(cur, start, start);
>>>>>>>>> @@ -71,11 +70,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>>>>>>>>                  str = NULL;
>>>>>>>>>              } else if (*endptr == '-') {
>>>>>>>>>                  str = endptr + 1;
>>>>>>>>> -                errno = 0;
>>>>>>>>> -                end = strtoll(str, &endptr, 0);
>>>>>>>>> -                if (errno == 0 && endptr > str && start <= end &&
>>>>>>>>> -                    (start > INT64_MAX - 65536 ||
>>>>>>>>> -                     end < start + 65536)) {
>>>>>>>>> +                if (!qemu_strtoi64(str, &endptr, 0, &end) && start < end) {
>>>>>>>>
>>>>>>>> You deleted (start > INT64_MAX - 65536 || end < start + 65536).  Can you
>>>>>>>> explain that to me?  I'm feeling particularly dense today...
>>>>>>>
>>>>>>> qemu_strtoi64 performs all different kinds of error handling completely
>>>>>>> internally. This old code here was an attempt to filter out -EWHATEVER
>>>>>>> from the response. No longer needed as errors and the actual value are
>>>>>>> reported via different ways.
>>>>>>
>>>>>> I understand why errno == 0 && endptr > str go away.  They also do in
>>>>>> the previous hunk.
>>>>>>
>>>>>> The deletion of (start > INT64_MAX - 65536 || end < start + 65536) is
>>>>>> unobvious.  What does it do before the patch?
>>>>>>
>>>>>> The condition goes back to commit 659268ffbff, which predates my watch
>>>>>> as maintainer.  Its commit message is of no particular help.  Its code
>>>>>> is... allright, the less I say about that, the better.
>>>>>>
>>>>>> We're parsing a range here.  We already parsed its lower bound into
>>>>>> @start (and guarded against errors), and its upper bound into @end (and
>>>>>> guarded against errors).
>>>>>>
>>>>>> If the condition you delete is false, we goto error.  So the condition
>>>>>> is about range validity.  I figure it's an attempt to require valid
>>>>>> ranges to be no "wider" than 65535.  The second part end < start + 65536
>>>>>> checks exactly that, except shit happens when start + 65536 overflows.
>>>>>> The first part attempts to guard against that, but
>>>>>>
>>>>>> (1) INT64_MAX is *wrong*, because we compute in long long, and
>>>>>>
>>>>>> (2) it rejects even small ranges like INT64_MAX - 2 .. INT64_MAX - 1.
>>>>>>
>>>>>> WTF?!?
>>>>>>
>>>>>> Unless I'm mistaken, the condition is not about handling any of the
>>>>>> errors that qemu_strtoi64() handles for us.
>>>>>>
>>>>>> The easiest way for you out of this morass is probably to keep the
>>>>>> condition exactly as it was, then use the "my patch doesn't make things
>>>>>> any worse" get-out-of-jail-free card.
>>>>>>
>>>>>
>>>>> Looking at the code in qapi/string-output-visitor.c related to range and
>>>>> list handling I feel like using the get-out-of-jail-free card to get out
>>>>> of qapi code now :) Too much magic in that code and too little time for
>>>>> me to understand it all.
>>>>>
>>>>> Thanks for your time and review anyway. My time is better invested in
>>>>> other parts of QEMU. I will drop both patches from this series.
>>>>
>>>> Understand.
>>>>
>>>> When I first looked at the ranges stuff in the string input visitor, I
>>>> felt the urge to clean it up, then sat on my hands until it passed.
>>>>
>>>> The rest is reasonable once you understand how it works.  The learning
>>>> curve is less than pleasant, though.
>>>>
>>>
>>> Maybe I'll pick this up again when I have more time to invest.
>>>
>>> The general concept
>>>
>>> 1. of having an input visitor that is able to parse different types
>>> (expected by e.g. a property) sounds sane to me.
>>>
>>> 2. of having a list of *something*, assuming it is int64_t, and assuming
>>> it is to be parsed into a list of ranges sounds completely broken to me.
>> 
>> Starting point: the string visitors can only do scalars.  We have a need
>> for lists of integers (see below).  The general solution would be
>> generalizing these visitors to lists (and maybe objects while we're at
>> it).  YAGNI.  So we put in a quick hack that can do just lists of
>> integers.
>> 
>> Except applying YAGNI to stable interfaces is *bonkers*.
>> 
>>> I was not even able to find an example QEMU comand line for 2. Is this
>>> maybe some very old code that nobody actually uses anymore? (who uses
>>> list of ranges?)
>> 
>> The one I remember offhand is -numa node,cpus=..., but that one's
>> actually parsed with the options visitor.  Which is even hairier, but at
>> least competently coded.
>> 
>> To find uses, we need to follow the uses of the string visitors.
>> 
>> Of the callers of string_input_visitor_new(),
>> object_property_get_uint16List() is the only one that deals with lists.
>> It's used by query_memdev() for property host-nodes.
>> 
>> The callers of string_output_visitor_new() lead to MigrationInfo member
>> postcopy-vcpu-blocktime, and Memdev member host-nodes again.
>> 
>> Searching the QAPI schema for lists of integers coughs up a few more
>> candidates: NumaNodeOptions member cpus (covered above), RxFilterInfo
>> member vlan-table (unrelated, as far as I can tell), RockerOfDpaGroup
>> (likewise), block latency histogram stuff (likewise).
>> 
>
> As Eric pointed out, tests/test-string-input-visitor.c actually tests
> for range support in test_visitor_in_intList.
>
> I might be completely wrong, but actually the string input visitor
> should not pre-parse stuff into a list of ranges, but instead parse on
> request (parse_type_...) and advance in the logical list on "next_list".
> And we should parse ranges *only* if we are expecting a list. Because a
> range is simply a short variant of a list. A straight parse_type_uint64
> should bail out if we haven't started a list.

Yes, parse_type_int64() & friends should simply parse the appropriate
integer, *except* when we're working on a list.  Then they should return
the next integer, which may or may not require parsing.

Say, input is "1-3,5", and the visitor is called like

    visit_start_list()
    visit_next_list()   more input, returns "there's more"
    visit_type_int()    parses "1-3,", buffers 2-3, returns 1
    visit_next_list()   buffer not empty, returns "there's more"
    visit_type_int()    unbuffers and returns 2
    visit_next_list()   buffer not empty, returns "there's more"
    visit_type_int()    unbuffers and returns 3 
    visit_next_list()   more input, returns "there's more"
    visit_type_int()    parses "5", returns 5
    visit_next_list()   buffer empty and no more input, returns "done"
    visit_end_list()   

Alternatively, parse and buffer the whole list at once.

> I guess I am starting to understand how this magic is supposed to work.
> Always parsing and processing one list token at a time
> ("size"/"uint64_t" or "range of such") should be the way to go. And if
> nobody requested to parse a list (start_list()), also ranges should not
> be allowed. This pre-parsing of the whole list and unconditional use of
> ranges should go.
>
> Ranges are still ugly but needed as far as I can understand (as a
> shortcut for lengthy lists).
>
> Am I on the right track?

I believe you are.

The overall problem is to convert between text and (QAPI-generated) C
data structures.

We have a "low magic" solution for JSON text: we split the problem like

    JSON text --> QObject --> C data --> QObject --> JSON text
               |           |          |           |
           JSON parser     |          |     JSON formatter
                QObject input visitor |
                            QObject output visitor

The JSON parser is slightly magical around numbers.  Everything else is
straightforward.

We have a "moderate magic" solution for key-value text (used for option
arguments):

    key-value text --> QObject --> C data
                    |           |
              keyval_parse()    |
                      QObject input visitor
                         keyval variant

Key-value text is less expressive than JSON: it can't distinguish the
scalar types (everthing's a string), and it can't do empty arrays or
empty non-root objects.  The visitor magically converts strings to
whatever type is expected.

We have a "bad magic" solution for "strings":

    string --> C data --> string
            |          |
  string input visitor |
              string output visitor

Initially, this visitor was simple: only scalars.  Adding ranges was a
misguided idea.  The way they were coded should never have passed
review.

We have a "more bad magic" solution for certain option arguments:

    key-value text --> QemuOpts --> C data
                    |            |
             qemu_opts_parse()   |
                            opts visitor

Predates the other key-value solution.  Less general (by design), and
nevertheless more complex.  I hope the other one can replace it one day.
