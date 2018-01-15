Received: from eggs.gnu.org ([2001:4830:134:3::10]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8CR-0002KH-8r
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eb8CM-0008Oj-PN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 12:05:30 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34c87c41-eb49-0e2b-3857-9bb3ba86c8d4@redhat.com>
Date: Mon, 15 Jan 2018 11:05:19 -0600
MIME-Version: 1.0
In-Reply-To: <1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qn9hYKcLP0KyLXx27XZ3cSWzrGvQCdxlM"
Subject: Re: [Qemu-devel] [PATCH v3 1/8] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qn9hYKcLP0KyLXx27XZ3cSWzrGvQCdxlM
From: Eric Blake <eblake@redhat.com>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com
Message-ID: <34c87c41-eb49-0e2b-3857-9bb3ba86c8d4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/8] s390-ccw: update libc
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
 <1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
In-Reply-To: <1516034665-27606-2-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/15/2018 10:44 AM, Collin L. Walling wrote:
> Moved:
>   memcmp from bootmap.h to libc.h (renamed from _memcmp)
>   strlen from sclp.c to libc.h (renamed from _strlen)
>=20
> Added C standard functions:
>   isdigit
>   atoi
>=20
> Added non-C standard function:
>   itostr
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---

> +++ b/pc-bios/s390-ccw/libc.c
> @@ -0,0 +1,83 @@
> +/*
> + * libc-style definitions and functions
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU General Public License as published by t=
he
> + * Free Software Foundation; either version 2 of the License, or (at y=
our
> + * option) any later version.

I'm not a lawyer, but generically, the GPL and its variants depend on a
copyright owner to actually work.  You may want to add a copyright line.

> + */
> +
> +#include "libc.h"
> +#include "s390-ccw.h"
> +
> +/**
> + * atoi:
> + * @str: the string to be converted.
> + *
> + * Given a string @str, convert it to an integer. Any non-numerical va=
lue
> + * will terminate the conversion.
> + *
> + * Returns: an integer converted from the string @str.
> + */
> +int atoi(const char *str)
> +{
> +    int i;
> +    int val =3D 0;
> +
> +    for (i =3D 0; str[i]; i++) {
> +        char c =3D str[i];
> +        if (!isdigit(c)) {
> +            break;
> +        }
> +        val *=3D 10;
> +        val +=3D c - '0';

Silently gives garbage on integer overflow, but matches the fact that
POSIX atoi() can't flag errors.  However, it does not handle leading
whitespace nor '-', which means it is NOT doing a POSIX-compatible
atoi() implementation; naming it atoi() is perhaps thus a disservice to
end users.

> +    }
> +
> +    return val;
> +}
> +
> +/**
> + * itostr:
> + * @num: the integer to be converted.
> + * @str: a pointer to a string to store the conversion.
> + * @len: the length of the passed string.
> + *
> + * Given an integer @num, convert it to a string. The string @str must=
 be
> + * allocated beforehand. The resulting string will be null terminated =
and
> + * returned.
> + *
> + * Returns: the string @str of the converted integer @num.
> + */
> +static char *_itostr(int num, char *str, size_t len)
> +{
> +    long num_len =3D 1;
> +    int tmp =3D num;
> +    int i;
> +
> +    /* Count length of num */
> +    while ((tmp /=3D 10) > 0) {
> +        num_len++;
> +    }
> +
> +    /* Check if we have enough space for num and null */
> +    if (len <=3D num_len) {
> +        return 0;
> +    }
> +
> +    /* Convert int to string */
> +    for (i =3D num_len - 1; i >=3D 0; i--) {
> +        str[i] =3D num % 10 + '0';
> +        num /=3D 10;
> +    }

No handling of negative integers?

> +
> +    str[num_len] =3D '\0';
> +
> +    return str;
> +}
> +
> +char *itostr(int num, char *str, size_t len)
> +{
> +    char *tmp =3D _itostr(num, str, len);
> +    IPL_assert(tmp !=3D 0, "array too small for itostr conversion");
> +    return tmp;
> +}
> diff --git a/pc-bios/s390-ccw/libc.h b/pc-bios/s390-ccw/libc.h
> index 0142ea8..00268e3 100644
> --- a/pc-bios/s390-ccw/libc.h
> +++ b/pc-bios/s390-ccw/libc.h
> @@ -42,4 +42,35 @@ static inline void *memcpy(void *s1, const void *s2,=
 size_t n)
>      return s1;
>  }
> =20
> +static inline int memcmp(const void *s1, const void *s2, size_t n)
> +{
> +    int i;
> +    const uint8_t *p1 =3D s1, *p2 =3D s2;
> +
> +    for (i =3D 0; i < n; i++) {

Are you safe comparing int to size_t, or would it be safer to use size_t
for your iterator?  I guess this shim is unlikely to be abused by
someone trying to compare 2G of memory at once.

> +        if (p1[i] !=3D p2[i]) {
> +            return p1[i] > p2[i] ? 1 : -1;
> +        }
> +    }

Not the fastest of implementations, but that probably doesn't matter
(the complexity of writing a vectored implementation that works on a
long or larger per loop iteration is important in a generic libc, but
less so in a compatibility shim).

> +
> +    return 0;
> +}
> +
> +static inline size_t strlen(const char *str)
> +{
> +    size_t i;
> +    for (i =3D 0; *str; i++) {
> +        str++;
> +    }
> +    return i;

Again, not the fastest implementation, but that shouldn't matter.

> +}
> +
> +static inline int isdigit(int c)
> +{
> +    return (c >=3D '0') && (c <=3D '9');
> +}
> +
> +int atoi(const char *str);
> +char *itostr(int num, char *str, size_t len);
> +
>  #endif
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Qn9hYKcLP0KyLXx27XZ3cSWzrGvQCdxlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpc308ACgkQp6FrSiUn
Q2olNwf/aFsHJbZE6/zXrTfihj/C++fc7jlFMpI79+w91PPPvLYx0XhDOWSesroF
JJJJVkWGzX+BXtneYOqFx7RiMz7Yf9ZBAaUSfUtz56mfgb2KTiOOTeYGAEOORUKD
a0ZzmGUYX42C6vo9gUZDmw1QSC/xPNuimc0PfgjgQamKH0djg1RCCXngKf9ZEg3+
rPN70O8As6W294+UXXEnT51ZmKh1VzzvNwGjAosBJLp474ZVOPKHvwFpy1hNVo+W
7pXNgnb/SyPjjzdtK2IXIRE36cQ21EQsju5LD0pQB5qDY3TEi33nDH+Lea7OBdbq
E+SaXmGXvLwSBD3Oxsu7wtb1K3F5TQ==
=QdbA
-----END PGP SIGNATURE-----

--Qn9hYKcLP0KyLXx27XZ3cSWzrGvQCdxlM--
