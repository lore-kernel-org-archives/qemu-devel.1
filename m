Received: from eggs.gnu.org ([2001:4830:134:3::10]:58604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPCJL-0006mk-Qk
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPCJD-0003hh-W0
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:07:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPCJD-0003ga-KO
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:07:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-2-david@redhat.com>
	<74608eca-34f8-f85f-39ab-ab98a206b0c1@redhat.com>
Date: Tue, 20 Nov 2018 21:07:40 +0100
In-Reply-To: <74608eca-34f8-f85f-39ab-ab98a206b0c1@redhat.com> (Eric Blake's
	message of "Tue, 20 Nov 2018 10:13:14 -0600")
Message-ID: <871s7f8qcz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/9] cutils: Add qemu_strtod() and
 qemu_strtod_finite()
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
>> Let's provide a wrapper for strtod().
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> This changed enough from v1 that I would have dropped R-b to ensure
> that reviewers notice the differences.
>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/qemu/cutils.h |  2 ++
>>   util/cutils.c         | 65 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 67 insertions(+)
>>
>
>> + * If the conversion overflows, store +/-HUGE_VAL in @result, depending
>> + * on the sign, and return -ERANGE.
>> + *
>> + * If the conversion underflows, store =C2=B10.0 in @result, depending =
on the
>> + * sign, and return -ERANGE.
>
> The use of UTF-8 =C2=B1 in one place but not both is odd.  I think we're =
at
> the point where UTF-8 comments are acceptable these days, rather than
> trying to keep our codebase ASCII-clean, so I don't care which way you
> resolve the inconsistency.

217 out of 6455 git-controlled files contain non-ASCII characters.  53
of them are binary, and don't count.  In most text files, it's for
spelling names of authors properly in comments.  Ample precedence for
UTF-8 in comments, I'd say.

That said, I second Eric's call for consistency, with the slightest of
preferrences for plain ASCII.

I spotted UTF-8 in two error messages, which might still be unadvisable:

hw/misc/tmp105.c:        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " =
=C2=B0C is out of range",
hw/misc/tmp421.c:        error_setg(errp, "value %" PRId64 ".%03" PRIu64 " =
=C2=B0C is out of range",

>> +/**
>> + * Convert string @nptr to a finite double.
>> + *
>> + * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
>> + * with -EINVAL and no conversion is performed.
>> + */
>> +int qemu_strtod_finite(const char *nptr, const char **endptr, double *r=
esult)
>> +{
>> +    double tmp;
>> +    int ret;
>> +
>> +    ret =3D qemu_strtod(nptr, endptr, &tmp);
>> +    if (ret) {
>> +        return ret;
>
> So, if we overflow, we are returning -ERANGE but with nothing stored
> into *result.  This is different from qemu_strtod(), where a return of
> -ERANGE guarantees that *result is one of 4 values (+/- 0.0/inf).
> That seems awkward.

Violates the contract's "like qemu_strtod()".

>> +    } else if (!isfinite(tmp)) {
>> +        if (endptr) {
>> +            *endptr =3D nptr;
>> +        }
>> +        return -EINVAL;
>
> Rewinding back to the start of "inf" is interesting, but matches your
> documentation.

Yes.  I like it.

>> +    }
>> +
>> +    *result =3D tmp;
>> +    return ret;
>> +}
>> +
>
> I think you still need to fix -ERANGE handling before I can give R-b.
