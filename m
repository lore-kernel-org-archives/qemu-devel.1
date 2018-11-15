Received: from eggs.gnu.org ([2001:4830:134:3::10]:44049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNJ5H-0006Jb-2Z
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:57:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNJ5C-0001W5-UJ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:57:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNJ5C-0001Vn-NT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:57:26 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-4-david@redhat.com>
	<874lcjmue4.fsf@dusky.pond.sub.org>
	<2ba6fbb2-d2cb-a4b3-61f5-385b08f822bd@redhat.com>
	<87tvkiisdi.fsf@dusky.pond.sub.org>
	<ef7b64f3-d7f3-6892-e0f3-f4e605604225@redhat.com>
Date: Thu, 15 Nov 2018 15:57:24 +0100
In-Reply-To: <ef7b64f3-d7f3-6892-e0f3-f4e605604225@redhat.com> (David
	Hildenbrand's message of "Thu, 15 Nov 2018 11:16:48 +0100")
Message-ID: <87ftw2e6cr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 3/6] qapi: rewrite string-input-visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> On 15.11.18 10:48, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 14.11.18 18:38, Markus Armbruster wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> The input visitor has some problems right now, especially
>>>>> - unsigned type "Range" is used to process signed ranges, resulting in
>>>>>   inconsistent behavior and ugly/magical code
>>>>> - uint64_t are parsed like int64_t, so big uint64_t values are not
>>>>>   supported and error messages are misleading
>>>>> - lists/ranges of int64_t are accepted although no list is parsed and
>>>>>   we should rather report an error
>>>>> - lists/ranges are preparsed using int64_t, making it hard to
>>>>>   implement uint64_t values or uint64_t lists
>>>>> - types that don't support lists don't bail out
>>>>
>>>> Known weirdness: empty list is invalid (test-string-input-visitor.c
>>>> demonstates).  Your patch doesn't change that (or else it would update
>>>> the test).  Should it be changed?
>>>>
>>>
>>> I don't change the test, so the old behavior still works.
>>> (empty string -> error)
>> 
>> Understand.  Design question: should it remain an error?  Feel free to
>> declare the question out of scope for this patch.
>
> I think I was confused, let me retry to explain.
>
> Empty lists actually don't result in an error. Calling start_list() on
> an empty string works just fine.
>
> However
> - check_list() will result in "Fewer list elements expected"
> - visit_type_.*int64() will result in "Fewer list elements expected"
> - next_list() will result in NULL
>
> I guess that is the intended behavior. E.g. the test does
>
> v = visitor_input_test_init(data, "");
> visit_type_uint64List(v, NULL, &res, &error_abort);
> g_assert(!res);
>
> So there won't be any error as the first "visit_next_list()" will
> properly indicate "NULL".

You know, I was confused, too :)  I looked at commit 3d089cea0d3, which
added the test case:

+    /* Empty list is invalid (weird) */
+
+    v = visitor_input_test_init(data, "");
+    visit_type_int64List(v, NULL, &res, &err);
+    error_free_or_abort(&err);

I missed regression fix commit d2788227c61:

-    /* Empty list is invalid (weird) */
+    /* Empty list */
 
     v = visitor_input_test_init(data, "");
-    visit_type_int64List(v, NULL, &res, &err);
-    error_free_or_abort(&err);
+    visit_type_int64List(v, NULL, &res, &error_abort);
+    g_assert(!res);

So the test actually demonstrates empty lists work fine before and after
your patch.

>>> Added "Only flat lists of integers (int64/uint64) are supported."
>> 
>> Hmm, do lists of narrower integer types also work?  I guess they do: the
>> narrower visit_type_*int*() call v->type_*int64() via
>> visit_type_*intN().
>> 
>> Lists of type size are expressly excluded, in parse_type_size() below.
>> That's okay, we can lift the restriction when it gets in the way.
>
> Right, we can make that clearer
>
> "Only flat lists of integers (except type "size") are supported." ?
> [...]

Sold!

[...]
