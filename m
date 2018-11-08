Received: from eggs.gnu.org ([2001:4830:134:3::10]:43116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKg2P-0007no-DM
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:51:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gKfqu-0003FR-Hy
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:39:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gKfqs-00033N-GZ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 03:39:46 -0500
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
	<87d0rgvrbk.fsf@dusky.pond.sub.org>
	<fcbd588d-f51c-4ab4-fa45-ad5360aff5b1@redhat.com>
Date: Thu, 08 Nov 2018 09:39:26 +0100
In-Reply-To: <fcbd588d-f51c-4ab4-fa45-ad5360aff5b1@redhat.com> (David
	Hildenbrand's message of "Wed, 7 Nov 2018 21:02:22 +0100")
Message-ID: <8736scq7y9.fsf@dusky.pond.sub.org>
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

> On 07.11.18 16:29, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 05.11.18 21:43, Markus Armbruster wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> On 05.11.18 16:37, Markus Armbruster wrote:
>>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>>
>>>>>>> On 31.10.18 18:55, Markus Armbruster wrote:
>>>>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>>>>
>>>>>>>>> On 31.10.18 15:40, Markus Armbruster wrote:
>>>>>>>>>> David Hildenbrand <david@redhat.com> writes:
>>>>>>>>>>
>>>>>>>>>>> The qemu api claims to be easier to use, and the resulting code seems to
>>>>>>>>>>> agree.
>>>>>>>> [...]
>>>>>>>>>>> @@ -60,9 +61,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>>>>>>>>>>      }
>>>>>>>>>>>  
>>>>>>>>>>>      do {
>>>>>>>>>>> -        errno = 0;
>>>>>>>>>>> -        start = strtoll(str, &endptr, 0);
>>>>>>>>>>> -        if (errno == 0 && endptr > str) {
>>>>>>>>>>> +        if (!qemu_strtoi64(str, &endptr, 0, &start)) {
>>>>>>>>>>>              if (*endptr == '\0') {
>>>>>>>>>>>                  cur = g_malloc0(sizeof(*cur));
>>>>>>>>>>>                  range_set_bounds(cur, start, start);
>>>>>>>>>>> @@ -71,11 +70,7 @@ static int parse_str(StringInputVisitor *siv, const char *name, Error **errp)
>>>>>>>>>>>                  str = NULL;
>>>>>>>>>>>              } else if (*endptr == '-') {
>>>>>>>>>>>                  str = endptr + 1;
>>>>>>>>>>> -                errno = 0;
>>>>>>>>>>> -                end = strtoll(str, &endptr, 0);
>>>>>>>>>>> -                if (errno == 0 && endptr > str && start <= end &&
>>>>>>>>>>> -                    (start > INT64_MAX - 65536 ||
>>>>>>>>>>> -                     end < start + 65536)) {
>>>>>>>>>>> +                if (!qemu_strtoi64(str, &endptr, 0, &end) && start < end) {
>>>>>>>>>>
>>>>>>>>>> You deleted (start > INT64_MAX - 65536 || end < start + 65536).  Can you
>>>>>>>>>> explain that to me?  I'm feeling particularly dense today...
>>>>>>>>>
>>>>>>>>> qemu_strtoi64 performs all different kinds of error handling completely
>>>>>>>>> internally. This old code here was an attempt to filter out -EWHATEVER
>>>>>>>>> from the response. No longer needed as errors and the actual value are
>>>>>>>>> reported via different ways.
>>>>>>>>
>>>>>>>> I understand why errno == 0 && endptr > str go away.  They also do in
>>>>>>>> the previous hunk.
>>>>>>>>
>>>>>>>> The deletion of (start > INT64_MAX - 65536 || end < start + 65536) is
>>>>>>>> unobvious.  What does it do before the patch?
>>>>>>>>
>>>>>>>> The condition goes back to commit 659268ffbff, which predates my watch
>>>>>>>> as maintainer.  Its commit message is of no particular help.  Its code
>>>>>>>> is... allright, the less I say about that, the better.
>>>>>>>>
>>>>>>>> We're parsing a range here.  We already parsed its lower bound into
>>>>>>>> @start (and guarded against errors), and its upper bound into @end (and
>>>>>>>> guarded against errors).
>>>>>>>>
>>>>>>>> If the condition you delete is false, we goto error.  So the condition
>>>>>>>> is about range validity.  I figure it's an attempt to require valid
>>>>>>>> ranges to be no "wider" than 65535.  The second part end < start + 65536
>>>>>>>> checks exactly that, except shit happens when start + 65536 overflows.
>>>>>>>> The first part attempts to guard against that, but
>>>>>>>>
>>>>>>>> (1) INT64_MAX is *wrong*, because we compute in long long, and
>>>>>>>>
>>>>>>>> (2) it rejects even small ranges like INT64_MAX - 2 .. INT64_MAX - 1.
>>>>>>>>
>>>>>>>> WTF?!?
>>>>>>>>
>>>>>>>> Unless I'm mistaken, the condition is not about handling any of the
>>>>>>>> errors that qemu_strtoi64() handles for us.
>>>>>>>>
>>>>>>>> The easiest way for you out of this morass is probably to keep the
>>>>>>>> condition exactly as it was, then use the "my patch doesn't make things
>>>>>>>> any worse" get-out-of-jail-free card.
>>>>>>>>
>>>>>>>
>>>>>>> Looking at the code in qapi/string-output-visitor.c related to range and
>>>>>>> list handling I feel like using the get-out-of-jail-free card to get out
>>>>>>> of qapi code now :) Too much magic in that code and too little time for
>>>>>>> me to understand it all.
>>>>>>>
>>>>>>> Thanks for your time and review anyway. My time is better invested in
>>>>>>> other parts of QEMU. I will drop both patches from this series.
>>>>>>
>>>>>> Understand.
>>>>>>
>>>>>> When I first looked at the ranges stuff in the string input visitor, I
>>>>>> felt the urge to clean it up, then sat on my hands until it passed.
>>>>>>
>>>>>> The rest is reasonable once you understand how it works.  The learning
>>>>>> curve is less than pleasant, though.
>>>>>>
>>>>>
>>>>> Maybe I'll pick this up again when I have more time to invest.
>>>>>
>>>>> The general concept
>>>>>
>>>>> 1. of having an input visitor that is able to parse different types
>>>>> (expected by e.g. a property) sounds sane to me.
>>>>>
>>>>> 2. of having a list of *something*, assuming it is int64_t, and assuming
>>>>> it is to be parsed into a list of ranges sounds completely broken to me.
>>>>
>>>> Starting point: the string visitors can only do scalars.  We have a need
>>>> for lists of integers (see below).  The general solution would be
>>>> generalizing these visitors to lists (and maybe objects while we're at
>>>> it).  YAGNI.  So we put in a quick hack that can do just lists of
>>>> integers.
>>>>
>>>> Except applying YAGNI to stable interfaces is *bonkers*.
>>>>
>>>>> I was not even able to find an example QEMU comand line for 2. Is this
>>>>> maybe some very old code that nobody actually uses anymore? (who uses
>>>>> list of ranges?)
>>>>
>>>> The one I remember offhand is -numa node,cpus=..., but that one's
>>>> actually parsed with the options visitor.  Which is even hairier, but at
>>>> least competently coded.
>>>>
>>>> To find uses, we need to follow the uses of the string visitors.
>>>>
>>>> Of the callers of string_input_visitor_new(),
>>>> object_property_get_uint16List() is the only one that deals with lists.
>>>> It's used by query_memdev() for property host-nodes.
>>>>
>>>> The callers of string_output_visitor_new() lead to MigrationInfo member
>>>> postcopy-vcpu-blocktime, and Memdev member host-nodes again.
>>>>
>>>> Searching the QAPI schema for lists of integers coughs up a few more
>>>> candidates: NumaNodeOptions member cpus (covered above), RxFilterInfo
>>>> member vlan-table (unrelated, as far as I can tell), RockerOfDpaGroup
>>>> (likewise), block latency histogram stuff (likewise).
>>>>
>>>
>>> As Eric pointed out, tests/test-string-input-visitor.c actually tests
>>> for range support in test_visitor_in_intList.
>>>
>>> I might be completely wrong, but actually the string input visitor
>>> should not pre-parse stuff into a list of ranges, but instead parse on
>>> request (parse_type_...) and advance in the logical list on "next_list".
>>> And we should parse ranges *only* if we are expecting a list. Because a
>>> range is simply a short variant of a list. A straight parse_type_uint64
>>> should bail out if we haven't started a list.
>> 
>> Yes, parse_type_int64() & friends should simply parse the appropriate
>> integer, *except* when we're working on a list.  Then they should return
>> the next integer, which may or may not require parsing.
>> 
>> Say, input is "1-3,5", and the visitor is called like
>> 
>>     visit_start_list()
>>     visit_next_list()   more input, returns "there's more"
>>     visit_type_int()    parses "1-3,", buffers 2-3, returns 1
>>     visit_next_list()   buffer not empty, returns "there's more"
>>     visit_type_int()    unbuffers and returns 2
>>     visit_next_list()   buffer not empty, returns "there's more"
>>     visit_type_int()    unbuffers and returns 3 
>>     visit_next_list()   more input, returns "there's more"
>>     visit_type_int()    parses "5", returns 5
>>     visit_next_list()   buffer empty and no more input, returns "done"
>>     visit_end_list()   
>> 
>
> Would it be valid to do something like this (skipping elements without a
> proper visit_type_int)
>
> visit_start_list();
> visit_next_list();  more input, returns "there's more"
> visit_next_list();  parses "1-3,", buffers 2-3, skips over 1
> visit_type_int();   returns 2
> ...

Excellent question!

Here's the relevant part of visit_start_list()'s contract in visitor.h:

 * After visit_start_list() succeeds, the caller may visit its members
 * one after the other.  A real visit (where @obj is non-NULL) uses
 * visit_next_list() for traversing the linked list, while a virtual
 * visit (where @obj is NULL) uses other means.  For each list
 * element, call the appropriate visit_type_FOO() with name set to
 * NULL and obj set to the address of the value member of the list
 * element.  Finally, visit_end_list() needs to be called with the
 * same @list to clean up, even if intermediate visits fail.  See the
 * examples above.

So, you *may* visit members, and you *must* call visit_end_list().

But what are "real" and "virtual" visits?  Again, the contract:

 * @list must be non-NULL for a real walk, in which case @size
 * determines how much memory an input or clone visitor will allocate
 * into *@list (at least sizeof(GenericList)).  Some visitors also
 * allow @list to be NULL for a virtual walk, in which case @size is
 * ignored.

I'm not sure whether I just decreased or increased global confusion ;)

The file comment explains:

 * The QAPI schema defines both a set of C data types, and a QMP wire
 * format.  QAPI objects can contain references to other QAPI objects,
 * resulting in a directed acyclic graph.  QAPI also generates visitor
 * functions to walk these graphs.  This file represents the interface
 * for doing work at each node of a QAPI graph; it can also be used
 * for a virtual walk, where there is no actual QAPI C struct.

A real walk with an output visitor works like this (error handling
omitted for now):

    Error *err = NULL;
    intList *tail;
    size_t size = sizeof(**obj);

    // fetch list's head into *obj, start the list in output
    visit_start_list(v, name, (GenericList **)obj, size, &err);

    // iterate over list's tails
    // below the hood, visit_next_list() iterates over the GenericList
    for (tail = *obj; tail;
         tail = (intList *)visit_next_list(v, (GenericList *)tail, size)) {
        // visit current tail's first member, add it to output
        visit_type_int(v, NULL, &tail->value, &err);
    }

    // end the list in output
    visit_end_list(v, (void **)obj);

The exact same code works for a real walk with an input visitor, where
visit_next_list() iterates over the *input* and builds up the
GenericList.  Compare qobject_input_next_list() and
qobject_output_next_list().

The code above is a straight copy of generated visit_type_intList() with
error handling cut and comments added.

A real walk works on a QAPI-generated C type.  QAPI generates a real
walk for each such type.  Open-coding a real walk would senselessly
duplicate the generated one, so we don't.  Thus, a real walk always
visits each member.

Okay, I lied: it visits each member until it runs into an error and
bails out.  See generated visit_type_intList() in
qapi/qapi-builtin-visit.c.

A virtual walk doesn't work with a GenericList *.  Calling
visit_next_list() makes no sense then.  visitor.h gives this example of
a virtual walk:

 * Thus, a virtual walk corresponding to '{ "list": [1, 2] }' looks
 * like:
 *
 * <example>
 *  Visitor *v;
 *  Error *err = NULL;
 *  int value;
 *
 *  v = FOO_visitor_new(...);
 *  visit_start_struct(v, NULL, NULL, 0, &err);
 *  if (err) {
 *      goto out;
 *  }
 *  visit_start_list(v, "list", NULL, 0, &err);
 *  if (err) {
 *      goto outobj;
 *  }
 *  value = 1;
 *  visit_type_int(v, NULL, &value, &err);
 *  if (err) {
 *      goto outlist;
 *  }
 *  value = 2;
 *  visit_type_int(v, NULL, &value, &err);
 *  if (err) {
 *      goto outlist;
 *  }
 * outlist:
 *  visit_end_list(v, NULL);
 *  if (!err) {
 *      visit_check_struct(v, &err);
 *  }
 * outobj:
 *  visit_end_struct(v, NULL);
 * out:
 *  error_propagate(errp, err);
 *  visit_free(v);

Why could this be useful?

1. With the QObject input visitor, it's an alternative way to
   destructure a QObject into a bunch of C variables.  The "obvious" way
   would be calling the QObject accessors.  By using the visitors you
   get much the error checking code for free.  YMMV.

2. With the QObject output visitor, it's an alternative way to build up
   a QObject.  The "obvious" way would be calling the constructors
   directly.

3. With the string input / output visitors, it's a way to parse / format
   string visitor syntax without having to construct the C type first.

Right now, we have no virtual list walks outside tests.  We do have
virtual struct walks outside tests.

> Or mixing types
>
> visit_start_list();
> visit_next_list();
> visit_type_int64();
> visit_next_list();
> visit_type_uint64();

Another excellent question.

QAPI can only express homogeneous lists, i.e. lists of some type T.

The generated visit_type_TList call the same visit_type_T() for all list
members.

QAPI type 'any' is the top type, but visit_type_anyList() still calls
visit_type_any() for all list members.

Virtual walks could of course do anything.  Since they don't exist
outside tests, we can outlaw doing things that cause us trouble.

The virtual walks we currently have in tests/ seem to walk only
homogeneous lists, i.e. always call the same visit_type_T().

> IOW, can I assume that after every visit_next_list(), visit_type_X is
> called, and that X remains the same for one pass over the list?

As far as I can tell, existing code is just fine with that assumption.
We'd have to write it into the contract, though.

> Also, I assume it is supposed to work like this
>
> visit_start_list();
> visit_next_list();  more input, returns "there's more"
> visit_type_int();   returns 1 (parses 1-3, buffers 1-3)
> visit_type_int();   returns 1
> visit_type_int();   returns 1
> visit_next_list();  more input, unbuffers 1
> visit_type_int();   returns 2
>
> So unbuffering actually happens on visit_next_list()?

I believe this violates the contract.

If it's a real walk, the contract wants you to call visit_next_list()
between subsequent visit_type_int().

If it's a virtual walk, calling visit_next_list() makes no sense.

More questions?
