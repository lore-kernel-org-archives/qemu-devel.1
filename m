Received: from eggs.gnu.org ([2001:4830:134:3::10]:49914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWjw-0002MZ-WE
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYWjs-00064U-Bo
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYWjs-00063k-2y
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:09:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC571C00DB82
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 12:08:58 +0000 (UTC)
References: <20170714190827.4083-1-eblake@redhat.com>
	<20170714190827.4083-6-eblake@redhat.com>
	<87zibzl8py.fsf@dusky.pond.sub.org>
	<ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
	<9674afa4-78b3-044b-4e5f-4014888ff03e@redhat.com>
	<87379ql28s.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ac668b9d-3ee4-7e63-efed-4d092b2adb78@redhat.com>
Date: Fri, 21 Jul 2017 07:08:57 -0500
MIME-Version: 1.0
In-Reply-To: <87379ql28s.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1Klp9vkoIMcRXnPoox6rWJ4FUA8uJeTgU"
Subject: Re: [Qemu-devel] [PATCH 5/5] qtest: Document calling conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1Klp9vkoIMcRXnPoox6rWJ4FUA8uJeTgU
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <ac668b9d-3ee4-7e63-efed-4d092b2adb78@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] qtest: Document calling conventions
References: <20170714190827.4083-1-eblake@redhat.com>
 <20170714190827.4083-6-eblake@redhat.com> <87zibzl8py.fsf@dusky.pond.sub.org>
 <ff471aeb-51dc-1abd-f512-f1a93db3752c@redhat.com>
 <9674afa4-78b3-044b-4e5f-4014888ff03e@redhat.com>
 <87379ql28s.fsf@dusky.pond.sub.org>
In-Reply-To: <87379ql28s.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 01:42 AM, Markus Armbruster wrote:
>> But with json-lexer style, %s MODIFIES its input.
>=20
> Your assertion "MODIFIES its input" confused me briefly, because I read=

> it as "side effect on the argument string".  That would be bonkers.
> What you mean is it doesn't emit the argument string unmodified.

Yes. I'm not sure how I could have worded that better; maybe "does not
do a straight passthrough of its input"

>> So adding the format immediately causes lots of warnings, such as:
>>
>>   CC      tests/vhost-user-test.o
>> tests/vhost-user-test.c: In function =E2=80=98test_migrate=E2=80=99:
>> tests/vhost-user-test.c:668:5: error: format not a string literal and =
no
>> format arguments [-Werror=3Dformat-security]
>>      rsp =3D qmp(cmd);
>>      ^~~
>=20
>     cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
>                           "'arguments': { 'uri': '%s' } }",
>                           uri);
>     rsp =3D qmp(cmd);
>     g_free(cmd);
>     g_assert(qdict_haskey(rsp, "return"));
>     QDECREF(rsp);
>=20
> For this to work, @uri must not contain funny characters.
>=20
> Shouldn't we simply use the built-in quoting here?

We can - but there are a lot of tests that have to be updated.

>=20
>     rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }",=
 uri);
>     g_assert(qdict_haskey(rsp, "return"));
>     QDECREF(rsp);
>=20
>>
>>   CC      tests/boot-order-test.o
>> tests/boot-order-test.c: In function =E2=80=98test_a_boot_order=E2=80=99=
:
>> tests/boot-order-test.c:46:26: error: zero-length gnu_printf format
>> string [-Werror=3Dformat-zero-length]
>>      qmp_discard_response("");   /* HACK: wait for event */
>>                           ^~
>=20
> Should use qmp_eventwait().  Doesn't because it predates it.

We can - but there are a lot of tests that have to be updated.

>=20
>> but we CAN'T rewrite those to qmp("%s", command).
>=20
> Got more troublemakers?

When I worked on getting rid of qobject_from_jsonf(), I was able to
reduce the tests down to JUST using %s, which I then handled locally in
qmp() rather than relying on qobject_from_jsonf().  Going the opposite
direction and more fully relying on qobject_from_jsonf() by fixing
multiple tests that were using older idioms is also an approach (in the
opposite direction I originally took) - but the more work it is, the
less likely that this patch is 2.10 material.

>=20
>> Now you can sort-of understand why my larger series wanted to get rid =
of
>> qobject_from_jsonf(), since our use of GCC_FMT_ATTR() there is a lie?
>=20
> I don't think it's a lie.  qobject_from_jsonf() satisfies the attribute=

> format(printf, ...) contract: it fetches varargs exactly like printf().=

> What it does with them is of no concern to this attribute.

I still find it odd that you can't safely turn foo(var) into foo("%s", va=
r).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1Klp9vkoIMcRXnPoox6rWJ4FUA8uJeTgU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllx7tkACgkQp6FrSiUn
Q2oJhggAhNVizXMt8LVxDeCliNd3HBE5QZFlkkxR2CCUUdF2IRKIoy+Wm6vWSb+g
GSJ72Qr1g3vynuDoHllMKmy9q8Pb/DkZcjqahbgCdHpbOYuV7RHdjcju2QYF5X7g
CH2jVORD+z+Ebcl+WC5BcAEGJ+xuzIFrdn/acLqYGXXAzl+Cjny4frSldw8V1KkR
mr4XFcS27qbA9FpmsCgxfB8jO/ZaJt8SCK8ZeQjaCCAZiuvN+CbljerzbFhf91wD
L1q18A0J1gPTCmtKmXOtRLC7KVeHoM6p7iZslyXuzIX2Gq3R5aMLd08FbQhQytAV
IwHO9PtKzVzDALSclKTZ3DDlcrFRFA==
=kUjr
-----END PGP SIGNATURE-----

--1Klp9vkoIMcRXnPoox6rWJ4FUA8uJeTgU--
