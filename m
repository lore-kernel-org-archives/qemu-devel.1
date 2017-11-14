Received: from eggs.gnu.org ([2001:4830:134:3::10]:47207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEgw6-0003fD-1X
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:31:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEgw4-0008BR-TU
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:31:54 -0500
References: <20171114180128.17076-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fd1e94a6-66ec-5a31-5956-98af317e9f51@redhat.com>
Date: Tue, 14 Nov 2017 13:31:41 -0600
MIME-Version: 1.0
In-Reply-To: <20171114180128.17076-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="baSiw7KTOa5ed61s62fqll5ULixt4NFvw"
Subject: Re: [Qemu-devel] [PATCH for-2.11? v7 0/6] block: Don't compare
 strings in bdrv_reopen_prepare()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--baSiw7KTOa5ed61s62fqll5ULixt4NFvw
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <fd1e94a6-66ec-5a31-5956-98af317e9f51@redhat.com>
Subject: Re: [PATCH for-2.11? v7 0/6] block: Don't compare strings in
 bdrv_reopen_prepare()
References: <20171114180128.17076-1-mreitz@redhat.com>
In-Reply-To: <20171114180128.17076-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 12:01 PM, Max Reitz wrote:
> bdrv_reopen_prepare() assumes that all BDS options are strings, which i=
s
> not necessarily correct. This series introduces a new qobject_is_equal(=
)
> function which can be used to test whether any options have changed,
> independently of their type.
>=20
>=20
> v7:
> - Patch 6: Fix a clang warning:
>     tests/check-qobject.c:39:24: error: passing an object that undergoe=
s
>                                  default argument promotion to
>                                  'va_start' has undefined behavior
>   TIL: You cannot use va_start(ap, foo) if @foo is a bool.  An int
>        works, however.

I knew that va_arg(ap, bool) was undefined behavior, but didn't realize
va_start(ap, bool_param) was also undefined.  But sure enough, reading
C99 7.15.1.4:

4 The parameter parmN is the identifier of the rightmost parameter in
the variable
parameter list in the function definition (the one just before the ,
=2E..). If the parameter
parmN is declared with the register storage class, with a function or
array type, or
with a type that is not compatible with the type that results after
application of the default
argument promotions, the behavior is undefined.

>        Feel free to explain the long version to me, because I don't
>        think I have fully understood the issue, but it's something like=

>        "Using bools for variadic arguments results in their promotion t=
o
>        an int, but you have to use a type that is promoted to itself
>        (like int)."

So it must be that C99 is trying to cater to platforms that have special
ABI for passing multiple bool on the stack, by stating that the moment
argument promotion is in effect, va_list adjacent to a bool may cause
problems with that special packing in the ABI.  Weird.

>=20
>=20
> git-backport-diff against v6:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/6:[----] [--] 'qapi/qnull: Add own header'
> 002/6:[----] [--] 'qapi/qlist: Add qlist_append_null() macro'
> 003/6:[----] [--] 'qapi: Add qobject_is_equal()'
> 004/6:[----] [--] 'block: qobject_is_equal() in bdrv_reopen_prepare()'
> 005/6:[----] [--] 'iotests: Add test for non-string option reopening'
> 006/6:[0011] [FC] 'tests: Add check-qobject for equality tests'

I still think this is 2.11 material.  Once you fix the typo I point out
separately on 6/6, the changes since v6 look reasonable, so series:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--baSiw7KTOa5ed61s62fqll5ULixt4NFvw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloLRJ0ACgkQp6FrSiUn
Q2piewgAqVmvtS5mAZODe/7v57WnC/UADL118D+XZShIgGouN6GGAlsGsLaLDNkr
jVeQveuAcPnhwuW5JN0rJZbSEArFV35aD4A/2nubJYO+oEiZx9qMHyXZCOtBkige
VfUZd13EkD8x2kJez3/r5U4U9oSIe+sTI5K7k05FIvndB7YcILNfi70Oev2A8S2D
Vj3lQqlokaR/ZkTCy3oGcWKwXp6ZsaQQKNxxOQ4joXNxS69fAXR1jb0xqUlhKnp+
f7k/XQei/vt3fAmAp9LfmRPGlKA4Yq431egZ0TbskTLA3Cpt06435mR6JuyUdiLR
iltUGw+88Qbkumj5cdoEYdy2Ygmt3Q==
=SJf2
-----END PGP SIGNATURE-----

--baSiw7KTOa5ed61s62fqll5ULixt4NFvw--
