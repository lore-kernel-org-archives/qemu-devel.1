Received: from eggs.gnu.org ([2001:4830:134:3::10]:58300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gKk5Y-0006L9-NT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gKk0I-00067A-Dm
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:05:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gKk0I-0005n4-3o
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:05:46 -0500
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
	<8736scq7y9.fsf@dusky.pond.sub.org>
	<bfebc5b0-cebd-8a83-3106-effba5332094@redhat.com>
	<878t24ort1.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <50328c72-ec11-6158-bd44-018f7454de18@redhat.com>
Date: Thu, 8 Nov 2018 14:05:29 +0100
MIME-Version: 1.0
In-Reply-To: <878t24ort1.fsf@dusky.pond.sub.org>
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

On 08.11.18 10:13, Markus Armbruster wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>>>> Would it be valid to do something like this (skipping elements without a
>>>> proper visit_type_int)
>>>>
>>>> visit_start_list();
>>>> visit_next_list();  more input, returns "there's more"
>>>> visit_next_list();  parses "1-3,", buffers 2-3, skips over 1
>>>> visit_type_int();   returns 2
>>>> ...
>>>
>>> Excellent question!
>>>
>>> Here's the relevant part of visit_start_list()'s contract in visitor.h:
>>>
>>>  * After visit_start_list() succeeds, the caller may visit its members
>>>  * one after the other.  A real visit (where @obj is non-NULL) uses
>>>  * visit_next_list() for traversing the linked list, while a virtual
>>>  * visit (where @obj is NULL) uses other means.  For each list
>>>  * element, call the appropriate visit_type_FOO() with name set to
>>>  * NULL and obj set to the address of the value member of the list
>>>  * element.  Finally, visit_end_list() needs to be called with the
>>>  * same @list to clean up, even if intermediate visits fail.  See the
>>>  * examples above.
>>>
>>> So, you *may* visit members, and you *must* call visit_end_list().
>>>
>>> But what are "real" and "virtual" visits?  Again, the contract:
>>>
>>>  * @list must be non-NULL for a real walk, in which case @size
>>>  * determines how much memory an input or clone visitor will allocate
>>>  * into *@list (at least sizeof(GenericList)).  Some visitors also
>>>  * allow @list to be NULL for a virtual walk, in which case @size is
>>>  * ignored.
>>>
>>> I'm not sure whether I just decreased or increased global confusion ;)
>>
>> I was reading over these comments and got slightly confused :)
>>
>>>
>>> The file comment explains:
>>>
>>>  * The QAPI schema defines both a set of C data types, and a QMP wire
>>>  * format.  QAPI objects can contain references to other QAPI objects,
>>>  * resulting in a directed acyclic graph.  QAPI also generates visitor
>>>  * functions to walk these graphs.  This file represents the interface
>>>  * for doing work at each node of a QAPI graph; it can also be used
>>>  * for a virtual walk, where there is no actual QAPI C struct.
>>>
>>> A real walk with an output visitor works like this (error handling
>>> omitted for now):
>>>
>>>     Error *err = NULL;
>>>     intList *tail;
>>>     size_t size = sizeof(**obj);
>>>
>>>     // fetch list's head into *obj, start the list in output
>>>     visit_start_list(v, name, (GenericList **)obj, size, &err);
>>>
>>>     // iterate over list's tails
>>>     // below the hood, visit_next_list() iterates over the GenericList
>>>     for (tail = *obj; tail;
>>>          tail = (intList *)visit_next_list(v, (GenericList *)tail, size)) {
>>>         // visit current tail's first member, add it to output
>>>         visit_type_int(v, NULL, &tail->value, &err);
>>>     }
>>>
>>>     // end the list in output
>>>     visit_end_list(v, (void **)obj);
>>>
>>> The exact same code works for a real walk with an input visitor, where
>>> visit_next_list() iterates over the *input* and builds up the
>>> GenericList.  Compare qobject_input_next_list() and
>>> qobject_output_next_list().
>>>
>>> The code above is a straight copy of generated visit_type_intList() with
>>> error handling cut and comments added.
>>>
>>> A real walk works on a QAPI-generated C type.  QAPI generates a real
>>> walk for each such type.  Open-coding a real walk would senselessly
>>> duplicate the generated one, so we don't.  Thus, a real walk always
>>> visits each member.
>>>
>>> Okay, I lied: it visits each member until it runs into an error and
>>> bails out.  See generated visit_type_intList() in
>>> qapi/qapi-builtin-visit.c.
>>>
>>> A virtual walk doesn't work with a GenericList *.  Calling
>>> visit_next_list() makes no sense then.  visitor.h gives this example of
>>> a virtual walk:
>>
>> Alright, so we must not support virtual walks. But supporting it would
>> not harm :)
> 
> Hmm, let me check something... aha!  Both string-input-visitor.h and
> string-output-visitor.h have this comment:
> 
>  * The string input visitor does not implement support for visiting
>  * QAPI structs, alternates, null, or arbitrary QTypes.  It also
>  * requires a non-null list argument to visit_start_list().
> 
> The last sentence means virtual walks are not supported.  We owe thanks
> to Eric Blake for his commit d9f62dde130 :)
> 
>>>
>>>  * Thus, a virtual walk corresponding to '{ "list": [1, 2] }' looks
>>>  * like:
>>>  *
>>>  * <example>
>>>  *  Visitor *v;
>>>  *  Error *err = NULL;
>>>  *  int value;
>>>  *
>>>  *  v = FOO_visitor_new(...);
>>>  *  visit_start_struct(v, NULL, NULL, 0, &err);
>>>  *  if (err) {
>>>  *      goto out;
>>>  *  }
>>>  *  visit_start_list(v, "list", NULL, 0, &err);
>>>  *  if (err) {
>>>  *      goto outobj;
>>>  *  }
>>>  *  value = 1;
>>>  *  visit_type_int(v, NULL, &value, &err);
>>>  *  if (err) {
>>>  *      goto outlist;
>>>  *  }
>>>  *  value = 2;
>>>  *  visit_type_int(v, NULL, &value, &err);
>>>  *  if (err) {
>>>  *      goto outlist;
>>>  *  }
>>>  * outlist:
>>>  *  visit_end_list(v, NULL);
>>>  *  if (!err) {
>>>  *      visit_check_struct(v, &err);
>>>  *  }
>>>  * outobj:
>>>  *  visit_end_struct(v, NULL);
>>>  * out:
>>>  *  error_propagate(errp, err);
>>>  *  visit_free(v);
>>>
>>> Why could this be useful?
>>>
>>> 1. With the QObject input visitor, it's an alternative way to
>>>    destructure a QObject into a bunch of C variables.  The "obvious" way
>>>    would be calling the QObject accessors.  By using the visitors you
>>>    get much the error checking code for free.  YMMV.
>>>
>>> 2. With the QObject output visitor, it's an alternative way to build up
>>>    a QObject.  The "obvious" way would be calling the constructors
>>>    directly.
>>>
>>> 3. With the string input / output visitors, it's a way to parse / format
>>>    string visitor syntax without having to construct the C type first.
>>>
>>> Right now, we have no virtual list walks outside tests.  We do have
>>> virtual struct walks outside tests.
>>>
>>>> Or mixing types
>>>>
>>>> visit_start_list();
>>>> visit_next_list();
>>>> visit_type_int64();
>>>> visit_next_list();
>>>> visit_type_uint64();
>>>
>>> Another excellent question.
>>>
>>> QAPI can only express homogeneous lists, i.e. lists of some type T.
>>>
>>> The generated visit_type_TList call the same visit_type_T() for all list
>>> members.
>>
>> Okay, my point would be: Somebody coding its own visit code should not
>> assume this to work.
>>
>>>
>>> QAPI type 'any' is the top type, but visit_type_anyList() still calls
>>> visit_type_any() for all list members.
>>>
>>> Virtual walks could of course do anything.  Since they don't exist
>>> outside tests, we can outlaw doing things that cause us trouble.
>>>
>>> The virtual walks we currently have in tests/ seem to walk only
>>> homogeneous lists, i.e. always call the same visit_type_T().
>>
>> Okay, so bailing out if types are switched (e.g. just about to report a
>> range of uin64_t and somebody asks for a int64_t) is valid.
> 
> I think that would be okay.
> 
>>>
>>>> IOW, can I assume that after every visit_next_list(), visit_type_X is
>>>> called, and that X remains the same for one pass over the list?
>>>
>>> As far as I can tell, existing code is just fine with that assumption.
>>> We'd have to write it into the contract, though.
>>>
>>>> Also, I assume it is supposed to work like this
>>>>
>>>> visit_start_list();
>>>> visit_next_list();  more input, returns "there's more"
>>>> visit_type_int();   returns 1 (parses 1-3, buffers 1-3)
>>>> visit_type_int();   returns 1
>>>> visit_type_int();   returns 1
>>>> visit_next_list();  more input, unbuffers 1
>>>> visit_type_int();   returns 2
>>>>
>>>> So unbuffering actually happens on visit_next_list()?
>>>
>>> I believe this violates the contract.
>>>
>>> If it's a real walk, the contract wants you to call visit_next_list()
>>> between subsequent visit_type_int().
>>>
>>> If it's a virtual walk, calling visit_next_list() makes no sense.
>>>
>>> More questions?
>>>
>>
>> Thanks for the excessive answer! I think that should be enough to come
>> up with a RFC of a *rewrite* of the string input visitor :)
> 
> You're welcome!  I love great questions, they make me *think*.
> 
> Besides, if something's worth doing, it's probably worth overdoing ;)
> 

I found some more ugliness, looking at the tests. I am not sure the test
is correct here.

test_visitor_in_intList():

v = visitor_input_test_init(data, "1,2,0,2-4,20,5-9,1-8");

-> we expect { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 20 }, implying that the
visitor actually does sorting + duplicate elimination. Now I consider
this is wrong. We are parsing a list of integers, not an ordered set.

What's your take on this?

-- 

Thanks,

David / dhildenb
