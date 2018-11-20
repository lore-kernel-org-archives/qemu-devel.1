Received: from eggs.gnu.org ([2001:4830:134:3::10]:35822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP8eO-0007Bh-Jq
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gP8eK-0005Ve-IJ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:13:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gP8eK-0005Tk-DA
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 11:13:16 -0500
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-2-david@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <74608eca-34f8-f85f-39ab-ab98a206b0c1@redhat.com>
Date: Tue, 20 Nov 2018 10:13:14 -0600
MIME-Version: 1.0
In-Reply-To: <20181120092542.13102-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 11/20/18 3:25 AM, David Hildenbrand wrote:
> Let's provide a wrapper for strtod().
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

This changed enough from v1 that I would have dropped R-b to ensure that=20
reviewers notice the differences.

> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/qemu/cutils.h |  2 ++
>   util/cutils.c         | 65 ++++++++++++++++++++++++++++++++++++++++++=
+
>   2 files changed, 67 insertions(+)
>=20

> + * If the conversion overflows, store +/-HUGE_VAL in @result, dependin=
g
> + * on the sign, and return -ERANGE.
> + *
> + * If the conversion underflows, store =C2=B10.0 in @result, depending=
 on the
> + * sign, and return -ERANGE.

The use of UTF-8 =C2=B1 in one place but not both is odd.  I think we're =
at=20
the point where UTF-8 comments are acceptable these days, rather than=20
trying to keep our codebase ASCII-clean, so I don't care which way you=20
resolve the inconsistency.

> +/**
> + * Convert string @nptr to a finite double.
> + *
> + * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
> + * with -EINVAL and no conversion is performed.
> + */
> +int qemu_strtod_finite(const char *nptr, const char **endptr, double *=
result)
> +{
> +    double tmp;
> +    int ret;
> +
> +    ret =3D qemu_strtod(nptr, endptr, &tmp);
> +    if (ret) {
> +        return ret;

So, if we overflow, we are returning -ERANGE but with nothing stored=20
into *result.  This is different from qemu_strtod(), where a return of=20
-ERANGE guarantees that *result is one of 4 values (+/- 0.0/inf).  That=20
seems awkward.

> +    } else if (!isfinite(tmp)) {
> +        if (endptr) {
> +            *endptr =3D nptr;
> +        }
> +        return -EINVAL;

Rewinding back to the start of "inf" is interesting, but matches your=20
documentation.

> +    }
> +
> +    *result =3D tmp;
> +    return ret;
> +}
> +

I think you still need to fix -ERANGE handling before I can give R-b.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
