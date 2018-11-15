Received: from eggs.gnu.org ([2001:4830:134:3::10]:44665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNERR-000523-Fc
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:00:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNERJ-00063x-Sa
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:00:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNERH-000606-Tn
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 04:59:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181109110221.10553-1-david@redhat.com>
	<20181109110221.10553-6-david@redhat.com>
	<87h8gjocj9.fsf@dusky.pond.sub.org>
	<24876f15-3f6e-3daf-fc63-da3ab1d4d0f5@redhat.com>
Date: Thu, 15 Nov 2018 10:59:50 +0100
In-Reply-To: <24876f15-3f6e-3daf-fc63-da3ab1d4d0f5@redhat.com> (David
	Hildenbrand's message of "Wed, 14 Nov 2018 21:03:08 +0100")
Message-ID: <87ftw2iru1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC 5/6] test-string-input-visitor: split
 off uint64 list tests
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

> On 14.11.18 17:21, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> Basically copy all int64 list tests but adapt them to work on uint64
>>> instead.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  tests/test-string-input-visitor.c | 71 +++++++++++++++++++++++++++++--
>>>  1 file changed, 67 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
>>> index 2f6360e9ca..731094f789 100644
>>> --- a/tests/test-string-input-visitor.c
>>> +++ b/tests/test-string-input-visitor.c
>>> @@ -111,7 +111,6 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>>>                            6, 7, 8 };
>>>      int64_t expect2[] = { 32767, -32768, -32767 };
>>>      int64_t expect3[] = { INT64_MIN, INT64_MAX };
>>> -    uint64_t expect4[] = { UINT64_MAX };
>>>      Error *err = NULL;
>>>      int64List *res = NULL;
>>>      Visitor *v;
>>> @@ -129,9 +128,6 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>>>                                  "-9223372036854775808,9223372036854775807");
>>>      check_ilist(v, expect3, ARRAY_SIZE(expect3));
>>>  
>>> -    v = visitor_input_test_init(data, "18446744073709551615");
>>> -    check_ulist(v, expect4, ARRAY_SIZE(expect4));
>>> -
>> 
>> Hmm.  Testing behavior for this input is still worthwhile, isn't it?
>> 
>> The use of check_ulist() here is admittedly unclean.
>
> This check has been moved to the other function where we test ulists.

You're right, you didn't reduce test coverage.  I got confused.

But there's an opportunity to extend coverage: test
visit_type_int64List() for this input.  Separate patch.  If you put it
before PATCH 3, it'll ensure PATCH 3 doesn't change behavior for this
case.  Suggestion, not demand.  Use your judgement.

> Or do you want this check here to test again ilist and see that an error
> gets reported as the value is too big? Will add such range checks.

Be careful with new range checks, they can easily break backward
compatibility.  Deciding whether the break is acceptable then requires
analysis.

>> 
>>>      /* Empty list */
>>>  
>>>      v = visitor_input_test_init(data, "");
>>> @@ -174,6 +170,71 @@ static void test_visitor_in_intList(TestInputVisitorData *data,
>>>      visit_end_list(v, NULL);
>>>  }
>>>  
>>> +static void test_visitor_in_uintList(TestInputVisitorData *data,
>>> +                                     const void *unused)
>>> +{
>>> +    uint64_t expect1[] = { 1, 2, 0, 2, 3, 4, 20, 5, 6, 7, 8, 9, 1, 2, 3, 4, 5,
>> 
>> Please wrap this line a bit earlier.
>
> Yes.
>
>> 
>>> +                           6, 7, 8 };
>>> +    uint64_t expect2[] = { 32767, -32768, -32767 };
>>> +    uint64_t expect3[] = { UINT64_MAX };
>>> +    Error *err = NULL;
>>> +    uint64List *res = NULL;
>>> +    Visitor *v;
>>> +    uint64_t val;
>>> +
>>> +    /* Valid lists */
>>> +
>>> +    v = visitor_input_test_init(data, "1,2,0,2-4,20,5-9,1-8");
>>> +    check_ulist(v, expect1, ARRAY_SIZE(expect1));
>>> +
>>> +    v = visitor_input_test_init(data, "32767,-32768--32767");
>>> +    check_ulist(v, expect2, ARRAY_SIZE(expect2));
>>> +
>>> +    v = visitor_input_test_init(data, "18446744073709551615");
>>> +    check_ulist(v, expect3, ARRAY_SIZE(expect3));
>> 
>> Test behavior for large negative numbers?
>
> Yes, will add.

Again, a separate patch before PATCH 3 might be best.
