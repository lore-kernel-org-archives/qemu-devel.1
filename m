Received: from eggs.gnu.org ([2001:4830:134:3::10]:45504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPCgT-00083K-Gp
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPCgN-00082o-3e
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:31:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPCgM-0007uO-Ip
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:31:38 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-3-david@redhat.com>
	<7d8d4e4f-bb70-5047-4e37-ed3672c89e02@redhat.com>
Date: Tue, 20 Nov 2018 21:31:29 +0100
In-Reply-To: <7d8d4e4f-bb70-5047-4e37-ed3672c89e02@redhat.com> (Eric Blake's
	message of "Tue, 20 Nov 2018 10:29:39 -0600")
Message-ID: <87va4r7aou.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/9] cutils: Fix qemu_strtosz() &
 friends to reject non-finite sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 11/20/18 3:25 AM, David Hildenbrand wrote:
>> qemu_strtosz() & friends reject NaNs, but happily accept inifities.
>
> s/inifities/infinities/
>
>> They shouldn't. Fix that.
>>
>> The fix makes use of qemu_strtod_finite(). To avoid ugly casts,
>> change the @end parameter of qemu_strtosz() & friends from char **
>> to const char **.
>>
>> Also, add two test cases, testing that "inf" and "NaN" are properly
>> rejected.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/qemu/cutils.h |  6 +++---
>>   monitor.c             |  2 +-
>>   tests/test-cutils.c   | 24 +++++++++++++++++-------
>>   util/cutils.c         | 16 +++++++---------
>>   4 files changed, 28 insertions(+), 20 deletions(-)
>>
>
>> +++ b/util/cutils.c
>> @@ -206,20 +206,18 @@ static int64_t suffix_mul(char suffix, int64_t unit)
>>    * in *end, if not NULL. Return -ERANGE on overflow, Return -EINVAL on
>
> Pre-existing, but since you're touching this area: the second 'Return'
> is unusual capitalization for being mid-sentence.  You could even
> s/Return/of/

"of"?

>
>>    * other error.
>>    */
>> -static int do_strtosz(const char *nptr, char **end,
>> +static int do_strtosz(const char *nptr, const char **end,
>>                         const char default_suffix, int64_t unit,
>>                         uint64_t *result)
>>   {
>>       int retval;
>> -    char *endptr;
>> +    const char *endptr;
>>       unsigned char c;
>>       int mul_required = 0;
>>       double val, mul, integral, fraction;
>>   -    errno = 0;
>> -    val = strtod(nptr, &endptr);
>> -    if (isnan(val) || endptr == nptr || errno != 0) {
>> -        retval = -EINVAL;
>> +    retval = qemu_strtod_finite(nptr, &endptr, &val);
>> +    if (retval) {
>>           goto out;
>
> Here, retval can be -EINVAL (for failure to parse, or encountering
> "inf" or "NaN") or -ERANGE (overflow, underflow)...
>
>>       }
>>       fraction = modf(val, &integral);
>> @@ -259,17 +257,17 @@ out:
>
> out:
>     if (end) {
>         *end = endptr;
>     } else if (*endptr) {
>         retval = -EINVAL;
>     }
>
>>       return retval;
>
> ...if the failure was -EINVAL due to trailing garbage or empty string,
> nothing changes. If the failure was -EINVAL due to "inf", and the user
> passed in 'end', then 'end' now points to the beginning of "inf"
> instead of the end (probably okay). If the failure was -EINVAL due to
> "inf" and the user gave NULL for 'end', then we slam retval back to
> -EINVAL (no change).  If the failure was -ERANGE, then there is no
> trailing garbage, so *endptr had better be NULL, and we still fail
> with -ERANGE.  Any other way to reach the out label is unchanged from
> earlier logic.
>
> It's some hairy code to think about, but I can't find anything wrong
> with it.  Typo fixes are minor, so
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks for your analysis, Eric.

With the typo fixes:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
