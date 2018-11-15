Received: from eggs.gnu.org ([2001:4830:134:3::10]:36486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNKQ9-0003qH-4V
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNKQ6-00039Z-1O
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:23:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNKQ5-00038b-QW
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:23:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181115140501.7872-1-david@redhat.com>
	<20181115140501.7872-2-david@redhat.com>
	<5e2769ed-f017-d684-da9e-115d31c3189b@redhat.com>
Date: Thu, 15 Nov 2018 17:22:58 +0100
In-Reply-To: <5e2769ed-f017-d684-da9e-115d31c3189b@redhat.com> (Eric Blake's
	message of "Thu, 15 Nov 2018 08:23:59 -0600")
Message-ID: <874lcicntp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> On 11/15/18 8:04 AM, David Hildenbrand wrote:
>> Let's provide a wrapper for strtod().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   include/qemu/cutils.h |  2 ++
>>   util/cutils.c         | 38 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>
>
>
>> +
>> +/**
>> + * Convert string @nptr to a finite double.
>> + *
>> + * Works like qemu_strtoul(), except it stores +/-HUGE_VAL on
>> + * overflow/underflow. "NaN" or "inf" are rejcted with -EINVAL.
>
> s/rejcted/rejected/

Also, just overflow.  Floating-point underflow is when a computation's
mathematical result is too close to zero to be represented without
extraordinary rounding error.

Skip this paragraph unless you're ready to nerd out.  IEEE 754 section
7.5 defines underflow to happen

    [...] either

    a) after rounding =E2=80=94 when a non-zero result computed as though t=
he
    exponent range were unbounded would lie strictly between =C2=B1b^emin,
    or

    b) before rounding =E2=80=94 when a non-zero result computed as though =
both
    the exponent range and the precision were unbounded would lie
    strictly between =C2=B1b^emin.

where b^emin is the smallest normal number.=20=20

The "Works like qemu_strtoul()" is a bit lazy.  I guess it works like
qemu_strtoul() in the sense that it adds to strtod() what qemu_strtoul()
adds to strtoul().  I consciously didn't take a similar shortcut in
commit 4295f879bec: I documented both qemu_strtol() and qemu_strtoul()
in longhand, and used "Works like" shorthand only where that's actually
the case: qemu_strtoll() works like qemu_strtol(), and qemu_strtoull()
works like qemu_strtoul().  I'd prefer longhand for qemu_strtod().  It
costs us a few lines, but it results in a clearer contract.

>> + */
>> +int qemu_strtod_finite(const char *nptr, const char **endptr, double *r=
esult)
>> +{
>> +    int ret =3D qemu_strtod(nptr, endptr, result);
>
> On overflow, result is set to HUGE_VAL (aka "inf") with ret set to
> -ERANGE.  (The C standard uses HUGE_VAL rather than directly requiring
> infinity on overflow, in order to cater to museum platforms where the
> largest representable double is still finite; but no one develops qemu
> on a non-IEEE machine these days so we know that HUGE_VAL =3D=3D INF).

Aside: museum clauses like this one make the standard much harder to
read than necessary.  I wish they'll purge them from C2X.

>> +
>> +    if (!ret && !isfinite(*result)) {
>> +        return -EINVAL;
>> +    }

qemu_strtol() & friends leave *result alone when they return -EINVAL.
This one doesn't.  Unlikely to hurt anyone, but I'd prefer to keep them
consistent.

> This check means that overflow ("1e9999") fails with -ERANGE, while
> actual infinity ("inf") fails with -EINVAL, letting the user
> distinguish between the two.  Still, I wonder if assigning a
> non-finite value into result on -ERANGE is the wisest course of
> action.  We'll just have to see in the next patches that use this.

I guess it's about as "wise" as qemu_strtol() storing LONG_MAX on
integer overflow.

I'm fine with the semantics David picked, as long as they're spelled out
in the function contract.

> With the typo fix,
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
