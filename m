Received: from eggs.gnu.org ([2001:4830:134:3::10]:53083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNLPB-0003xB-Dh
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gNLP8-0002MX-6V
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:26:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gNLP6-0007eY-2A
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 12:26:08 -0500
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-2-david@redhat.com>
	<5e2769ed-f017-d684-da9e-115d31c3189b@redhat.com>
	<874lcicntp.fsf@dusky.pond.sub.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2464ddd5-24b3-396b-7ea7-c3e9cf36ffc9@redhat.com>
Date: Thu, 15 Nov 2018 18:25:42 +0100
MIME-Version: 1.0
In-Reply-To: <874lcicntp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/9] cutils: add qemu_strtod() and
 qemu_strtod_finite()
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

On 15.11.18 17:22, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 11/15/18 8:04 AM, David Hildenbrand wrote:
>>> Let's provide a wrapper for strtod().
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   include/qemu/cutils.h |  2 ++
>>>   util/cutils.c         | 38 ++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 40 insertions(+)
>>>
>>
>>
>>> +
>>> +/**
>>> + * Convert string @nptr to a finite double.
>>> + *
>>> + * Works like qemu_strtoul(), except it stores +/-HUGE_VAL on
>>> + * overflow/underflow. "NaN" or "inf" are rejcted with -EINVAL.
>>
>> s/rejcted/rejected/
>=20
> Also, just overflow.  Floating-point underflow is when a computation's
> mathematical result is too close to zero to be represented without
> extraordinary rounding error.

Indeed, as the "man strod" states
"... would cause overflow, plus or minus HUGE_VAL (HUGE_VALF, HUGE_VALL)
is returned (according to the sign of the value)"

>=20
> Skip this paragraph unless you're ready to nerd out.  IEEE 754 section
> 7.5 defines underflow to happen
>=20
>     [...] either
>=20
>     a) after rounding =E2=80=94 when a non-zero result computed as thou=
gh the
>     exponent range were unbounded would lie strictly between =C2=B1b^em=
in,
>     or
>=20
>     b) before rounding =E2=80=94 when a non-zero result computed as tho=
ugh both
>     the exponent range and the precision were unbounded would lie
>     strictly between =C2=B1b^emin.
>=20
> where b^emin is the smallest normal number. =20
>=20
> The "Works like qemu_strtoul()" is a bit lazy.  I guess it works like
> qemu_strtoul() in the sense that it adds to strtod() what qemu_strtoul(=
)
> adds to strtoul().  I consciously didn't take a similar shortcut in
> commit 4295f879bec: I documented both qemu_strtol() and qemu_strtoul()
> in longhand, and used "Works like" shorthand only where that's actually
> the case: qemu_strtoll() works like qemu_strtol(), and qemu_strtoull()
> works like qemu_strtoul().  I'd prefer longhand for qemu_strtod().  It
> costs us a few lines, but it results in a clearer contract.

/**
 * Convert string @nptr to a double.
  *
 * This is a wrapper around strtod() that is harder to misuse.
 * Semantics of @nptr and @endptr match strtod() with differences
 * noted below.
 *
 * @nptr may be null, and no conversion is performed then.
 *
 * If no conversion is performed, store @nptr in *@endptr and return
 * -EINVAL.
 *
 * If @endptr is null, and the string isn't fully converted, return
 * -EINVAL.  This is the case when the pointer that would be stored in
 * a non-null @endptr points to a character other than '\0'.
 *
 * If the conversion overflows @result, store +/-HUGE_VAL, depending on
 * the sign, in @result and return -ERANGE.
 *
 * Else store the converted value in @result, and return zero.
 */

>=20
>>> + */
>>> +int qemu_strtod_finite(const char *nptr, const char **endptr, double=
 *result)
>>> +{
>>> +    int ret =3D qemu_strtod(nptr, endptr, result);
>>
>> On overflow, result is set to HUGE_VAL (aka "inf") with ret set to
>> -ERANGE.  (The C standard uses HUGE_VAL rather than directly requiring
>> infinity on overflow, in order to cater to museum platforms where the
>> largest representable double is still finite; but no one develops qemu
>> on a non-IEEE machine these days so we know that HUGE_VAL =3D=3D INF).
>=20
> Aside: museum clauses like this one make the standard much harder to
> read than necessary.  I wish they'll purge them from C2X.
>=20
>>> +
>>> +    if (!ret && !isfinite(*result)) {
>>> +        return -EINVAL;
>>> +    }
>=20
> qemu_strtol() & friends leave *result alone when they return -EINVAL.
> This one doesn't.  Unlikely to hurt anyone, but I'd prefer to keep them
> consistent.

Will use a temporary and also properly set endptr in case we return
-EINVAL; And add a fully-blown description as noted above :)

>=20
>> This check means that overflow ("1e9999") fails with -ERANGE, while
>> actual infinity ("inf") fails with -EINVAL, letting the user
>> distinguish between the two.  Still, I wonder if assigning a
>> non-finite value into result on -ERANGE is the wisest course of
>> action.  We'll just have to see in the next patches that use this.
>=20
> I guess it's about as "wise" as qemu_strtol() storing LONG_MAX on
> integer overflow.
>=20
> I'm fine with the semantics David picked, as long as they're spelled ou=
t
> in the function contract.

I think for now we're fine treating explicit "infinity" user input as
-EINVAL. We could return something like "HUGE_VAL - 1" along with
-ERANGE, but I guess for now this is overkill. Most callers will bail
out on -ERANGE either way. And if not, they have to make sure they can
deal with HUGE_VAL.

>=20
>> With the typo fix,
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

--=20

Thanks,

David / dhildenb
