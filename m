Received: from eggs.gnu.org ([2001:4830:134:3::10]:49176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1ja-0003Dy-SC
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz1jU-0005Vg-PX
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:30:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz1jU-0005T2-Ft
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:30:08 -0400
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-6-eblake@redhat.com>
	<87k22dw4r2.fsf@dusky.pond.sub.org>
	<c9564021-896a-2c29-8f74-0921e94d292a@redhat.com>
	<87lgkurtiw.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7893edd1-4f6c-7954-f682-e27824b8c984@redhat.com>
Date: Mon, 2 Oct 2017 09:30:04 -0500
MIME-Version: 1.0
In-Reply-To: <87lgkurtiw.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B9PFWaNn6ch8mpBpGULCtJxmeRbqPQoaf"
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B9PFWaNn6ch8mpBpGULCtJxmeRbqPQoaf
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <7893edd1-4f6c-7954-f682-e27824b8c984@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-6-eblake@redhat.com> <87k22dw4r2.fsf@dusky.pond.sub.org>
 <c9564021-896a-2c29-8f74-0921e94d292a@redhat.com>
 <87lgkurtiw.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgkurtiw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 12:46 AM, Markus Armbruster wrote:

>>>> +    /*
>>>> +     * This seemingly unnecessary copy is required in case va_list
>>>> +     * is an array type.
>>>> +     */
>>>
>>> --verbose?
>>>
>>>> +    va_copy(ap_copy, ap);
>>>> +    obj =3D qobject_from_json_internal(string, &ap_copy, &error_abo=
rt);
>>>> +    va_end(ap_copy);
>>
>> Code motion. But if the comment needs to be more verbose in the
>> destination than it was on the source, the rationale is that C99/POSIX=

>> allows 'typedef something va_list[]' (that is, where va_list is an arr=
ay
>> of some other type), although I don't know of any modern OS that
>> actually defines it like that.  Based on C pointer-decay rules, '&ap'
>> has a different type based on whether va_list was a struct/pointer or =
an
>> array type, when 'va_list ap' was passed as a parameter; so we can't
>> portably use qobject_from_json_internal(string, &ap, &error_abort).  T=
he
>> va_copy() is what lets us guarantee that &ap_list is a pointer to a
>> va_list regardless of the type of va_list (because va_copy was declare=
d
>> locally, rather than in a parameter list, and is therefore not subject=

>> to pointer decay), and NOT an accidental pointer to first element of t=
he
>> va_list array on platforms where va_list is an array.
>=20
> I'm dense this Monday morning --- I still can't see where exactly
> passing &ap directly goes wrong.
>=20
> Two cases:
>=20
> 1. va_list is a typedef name for a non-array type T.
>=20
> 2. va_list is a typedef name for an array type E[].
>=20
> What are the types of actual argument &ap and formal parameter va_list
> *ap in either case?
>=20
> How exactly does case 2 break?

An example program is probably the best to visualize the problem:

$ cat typefun.c
#include <stdio.h>

typedef struct T {
    int i[5];
} T;
typedef struct E {
    int i;
} E;

typedef T list1;
typedef E list2[5];

void bar(const char *prefix, list1 *l1, list2 *l2) {
    printf ("%s: %zu %zu\n", prefix, sizeof(&l1), sizeof(&l2));
}

void foo(list1 l1, list2 l2) {
    printf ("parameter sizes: %zu %zu\n", sizeof(l1), sizeof(l2));
    bar("called with address of parameter", &l1, &l2);
}

int main(void) {
    list1 l1;
    list2 l2;
    printf ("local variable sizes: %zu %zu\n", sizeof(l1), sizeof(l2));
    bar("called with address of local variable", &l1, &l2);
    foo(l1, l2);
    return 0;
}

$ gcc -o typefun -Wall typefun.c
typefun.c: In function =E2=80=98foo=E2=80=99:
typefun.c:18:61: warning: =E2=80=98sizeof=E2=80=99 on array function para=
meter =E2=80=98l2=E2=80=99 will
return size of =E2=80=98E * {aka struct E *}=E2=80=99 [-Wsizeof-array-arg=
ument]
     printf ("parameter sizes: %zu %zu\n", sizeof(l1), sizeof(l2));
                                                             ^
typefun.c:17:26: note: declared here
 void foo(list1 l1, list2 l2) {
                          ^~
typefun.c:19:50: warning: passing argument 3 of =E2=80=98bar=E2=80=99 fro=
m incompatible
pointer type [-Wincompatible-pointer-types]
     bar("called with address of parameter", &l1, &l2);
                                                  ^
typefun.c:13:6: note: expected =E2=80=98E (*)[5] {aka struct E (*)[5]}=E2=
=80=99 but
argument is of type =E2=80=98E ** {aka struct E **}=E2=80=99
 void bar(const char *prefix, list1 *l1, list2 *l2) {
      ^~~

$ ./typefun
local variable sizes: 20 20
called with address of local variable: 8 8
parameter sizes: 20 8
called with address of parameter: 8 8

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--B9PFWaNn6ch8mpBpGULCtJxmeRbqPQoaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSTWwACgkQp6FrSiUn
Q2o9QQgArR8pzuJTAKnYiPKolhH5TAjQHAVhFap2FOm/jyp8USa82zEdKhs6cmme
kyb0ix1yhvvJ7grmMI6bYa1eBGogTE3a+1NqWJf/0n3iTPiSVbgIE2lf/RRGpRgh
vnZseoQ1vERpN4viLvS2qQUmdnPA7aJTo77Bk6d6OXouPfbDoTnuv9epL8YRYNeo
kUXdhIev6dyWB9ZKI458kxSnSyMrcbv9bCTclkYhOJPyGVNqxFxJrAl+hwG8eAfW
ExVNDJOlVTKVN4cpgzxOfiO5BE0EWhFkXK/SJ7To19lUdsSnXSZteqJ2IFTVSLWO
mi5/5I5H2g8NjtG8qxtb8ReudUb8fQ==
=lMk4
-----END PGP SIGNATURE-----

--B9PFWaNn6ch8mpBpGULCtJxmeRbqPQoaf--
