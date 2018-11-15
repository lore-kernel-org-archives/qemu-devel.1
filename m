Received: from eggs.gnu.org ([2001:4830:134:3::10]:60709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNLv8-0005Df-Li
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNLv5-0005UY-76
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:59:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNLv4-0005O2-VY
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:59:11 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-3-david@redhat.com>
	<40ed700b-d0b1-2a03-eba9-4afa595de556@redhat.com>
	<87in0yb8f6.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d96fce9d-7499-fe62-f8be-5ad624238788@redhat.com>
Date: Thu, 15 Nov 2018 18:59:06 +0100
MIME-Version: 1.0
In-Reply-To: <87in0yb8f6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/9] cutils: use qemu_strtod_finite() in
 do_strtosz()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 15.11.18 17:41, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> On 11/15/18 8:04 AM, David Hildenbrand wrote:
>>> Let's use the new function. In order to do so, we have to convert all
>>> users of qemu_strtosz*() to pass a "const char **end" ptr.
> 
> We shouldn't have qemu_strtol() "improve" on strtol() by splicing in
> another const.  Since we did, we havr to do the same for qemu_strtod().
> 
>>>
>>> We will now also reject "inf" properly.
>>>
> 
> Ah, so this is a bug fix!  The commit message's title should tell.
> Suggest something like:
> 
>     cutils: Fix qemu_strtosz() & friends to reject non-finite sizes
> 
>     qemu_strtosz() & friends reject NaNs, but happily accept inifities.
>     They shouldn't.  Fix that.
> 
>     The fix makes use of qemu_strtod_finite().  To avoid ugly casts,
>     change the @end parameter of qemu_strtosz() & friends from char **
>     to const char **.
> 
> I'd split the patch into just the fix (with the ugly cast) and the
> parameter type change (getting rid of the ugly cast), but I'm a
> compulsive patch splitter.  Up to you.

I'll leave it in one patch for now. (and will also add two test cases
for "inf" and "NaN"). If this patch grows even bigger, it makes sense to
split.

Commit message updated.

> 
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   include/qemu/cutils.h |  6 +++---
>>>   monitor.c             |  2 +-
>>>   tests/test-cutils.c   | 14 +++++++-------
>>>   util/cutils.c         | 14 ++++++--------
>>>   4 files changed, 17 insertions(+), 19 deletions(-)
>>>
>>
>>> +++ b/tests/test-cutils.c
>>> @@ -1950,7 +1950,7 @@ static void test_qemu_strtou64_full_max(void)
>>>   static void test_qemu_strtosz_simple(void)
>>>   {
>>>       const char *str;
>>> -    char *endptr = NULL;
>>> +    const char *endptr = NULL;
>> ...
>>> diff --git a/util/cutils.c b/util/cutils.c
>>
>> Conversion of call sites is good (in fact, you could drop the ' =
>> NULL' initialization, since do_strtosz() guarantees it is set to
>> something sane even on error).
> 
> Yes.
> 

Dropped.

>>                                 But where's the added test coverage of
>> rejecting "inf" as a size?
> 
> Let's stick it into test_qemu_strtosz_invalid().

Done.

@@ -2096,12 +2096,22 @@ static void test_qemu_strtosz_invalid(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert(endptr == str);
+
+    str = "inf";
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
+
+    str = "NaN";
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert(endptr == str);
 }


> 
>>
>>> index 7868a683e8..dd61fb4558 100644
>>> --- a/util/cutils.c
>>> +++ b/util/cutils.c
>>> @@ -206,19 +206,17 @@ static int64_t suffix_mul(char suffix, int64_t unit)
>>>    * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
>>>    * other error.
>>>    */
>>> -static int do_strtosz(const char *nptr, char **end,
>>> +static int do_strtosz(const char *nptr, const char **end,
>>>                         const char default_suffix, int64_t unit,
>>>                         uint64_t *result)
>>>   {
>>>       int retval;
>>> -    char *endptr;
>>> +    const char *endptr;
>>>       unsigned char c;
>>>       int mul_required = 0;
>>>       double val, mul, integral, fraction;
>>>   -    errno = 0;
>>> -    val = strtod(nptr, &endptr);
>>> -    if (isnan(val) || endptr == nptr || errno != 0) {
>>> +    if (qemu_strtod_finite(nptr, &endptr, &val)) {
>>>           retval = -EINVAL;
>>
>> This slams -ERANGE failure into -EINVAL.  Do we care?  Or would it
>> have been better to just do:
>>
>> retval = qemu_strtod_finite(...);
>> if (retval) {
>>     goto out;
> 
> If distinguishing between ERANGE and EINVAL makes sense for
> qemu_strtod_finite(), it probably makes sense for qemu_strtod(), too.

Yes, will do it like that.

> 
>>>           goto out;
>>>       }
>>> @@ -259,17 +257,17 @@ out:
>>
>> More context:
>>
>> out:
>>     if (end) {
>>         *end = endptr;
>>     } else if (*endptr) {
>>         retval = -EINVAL;
>>     }
>>
>>>       return retval;
>>>   }
>>
>> Everything else looks okay.
>>
>> Hmm - while touching this, is it worth making mul_required be a bool,
>> to match its use?
> 
> Touches no line containing mul_required, so I wouldn't.
> 

Alright, thanks to the both of you.

-- 

Thanks,

David / dhildenb
