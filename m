Received: from eggs.gnu.org ([2001:4830:134:3::10]:45539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPT3z-0003Lv-Nv
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPT3r-0000gf-OH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:01:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPT3r-0000cE-Eh
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:00:59 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-2-david@redhat.com>
	<74608eca-34f8-f85f-39ab-ab98a206b0c1@redhat.com>
	<871s7f8qcz.fsf@dusky.pond.sub.org>
	<3c656208-5569-d48f-9555-11d15389fe90@redhat.com>
Date: Wed, 21 Nov 2018 15:00:32 +0100
In-Reply-To: <3c656208-5569-d48f-9555-11d15389fe90@redhat.com> (David
	Hildenbrand's message of "Wed, 21 Nov 2018 11:35:53 +0100")
Message-ID: <87a7m24jjz.fsf@dusky.pond.sub.org>
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
To: David Hildenbrand <david@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> On 20.11.18 21:07, Markus Armbruster wrote:
>> Eric Blake <eblake@redhat.com> writes:
>>=20
>>> On 11/20/18 3:25 AM, David Hildenbrand wrote:
>>>> Let's provide a wrapper for strtod().
>>>>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>> This changed enough from v1 that I would have dropped R-b to ensure
>>> that reviewers notice the differences.
>
> Indeed, dropping it now ;)
>
>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>   include/qemu/cutils.h |  2 ++
>>>>   util/cutils.c         | 65 +++++++++++++++++++++++++++++++++++++++++=
++
>>>>   2 files changed, 67 insertions(+)
>>>>
>>>
>>>> + * If the conversion overflows, store +/-HUGE_VAL in @result, dependi=
ng
>>>> + * on the sign, and return -ERANGE.
>>>> + *
>>>> + * If the conversion underflows, store =C2=B10.0 in @result, dependin=
g on the
>>>> + * sign, and return -ERANGE.
>>>
>>> The use of UTF-8 =C2=B1 in one place but not both is odd.  I think we'r=
e at
>>> the point where UTF-8 comments are acceptable these days, rather than
>>> trying to keep our codebase ASCII-clean, so I don't care which way you
>>> resolve the inconsistency.
>>=20
>> 217 out of 6455 git-controlled files contain non-ASCII characters.  53
>> of them are binary, and don't count.  In most text files, it's for
>> spelling names of authors properly in comments.  Ample precedence for
>> UTF-8 in comments, I'd say.
>>=20
>> That said, I second Eric's call for consistency, with the slightest of
>> preferrences for plain ASCII.
>
> I'll just go with +/-. Thanks.
>
>>=20
>> I spotted UTF-8 in two error messages, which might still be unadvisable:
>>=20
>> hw/misc/tmp105.c:        error_setg(errp, "value %" PRId64 ".%03" PRIu64=
 " =C2=B0C is out of range",
>> hw/misc/tmp421.c:        error_setg(errp, "value %" PRId64 ".%03" PRIu64=
 " =C2=B0C is out of range",
>>=20
>>>> +/**
>>>> + * Convert string @nptr to a finite double.
>>>> + *
>>>> + * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
>>>> + * with -EINVAL and no conversion is performed.
>>>> + */
>>>> +int qemu_strtod_finite(const char *nptr, const char **endptr, double =
*result)
>>>> +{
>>>> +    double tmp;
>>>> +    int ret;
>>>> +
>>>> +    ret =3D qemu_strtod(nptr, endptr, &tmp);
>>>> +    if (ret) {
>>>> +        return ret;
>>>
>>> So, if we overflow, we are returning -ERANGE but with nothing stored
>>> into *result.  This is different from qemu_strtod(), where a return of
>>> -ERANGE guarantees that *result is one of 4 values (+/- 0.0/inf).
>>> That seems awkward.
>>=20
>> Violates the contract's "like qemu_strtod()".
>
> Right, I missed that. What about something like this:
>
> int qemu_strtod_finite(const char *nptr, const char **endptr, double
> *result)
> {
>     double tmp;
>     int ret;
>
>     ret =3D qemu_strtod(nptr, endptr, &tmp);
>     if (!ret && !isfinite(tmp)) {
>         if (endptr) {
>             *endptr =3D nptr;
>         }
>         ret =3D -EINVAL;
>     }
>
>     if (ret !=3D -EINVAL) {
>         *result =3D tmp;
>     }
>     return ret;
> }

With these changes:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
