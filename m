Received: from eggs.gnu.org ([2001:4830:134:3::10]:34209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhedn-0008L5-5u
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dhedi-0002BM-9M
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dhedh-00027p-RL
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:24:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6E8B7ACB2
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 16:17:15 +0000 (UTC)
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<20170814215748.5158-3-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c78602cc-80e3-932b-5a0f-e3aa0003a183@redhat.com>
Date: Tue, 15 Aug 2017 11:16:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170814215748.5158-3-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2DDcq9EjedPPFWBQOpQWOx8dDBWfImjov"
Subject: Re: [Qemu-devel] [RFC v4 02/13] qapi: qobject_compare() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2DDcq9EjedPPFWBQOpQWOx8dDBWfImjov
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Laine Stump <laine@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <c78602cc-80e3-932b-5a0f-e3aa0003a183@redhat.com>
Subject: Re: [RFC v4 02/13] qapi: qobject_compare() helper
References: <20170814215748.5158-1-ehabkost@redhat.com>
 <20170814215748.5158-3-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/14/2017 04:57 PM, Eduardo Habkost wrote:
> The helper function will be useful when writing support code to
> deal with device slot information.
>=20
> TODO: documentation is incomplete and unclear, needs to be
> improved.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/qapi/util.h    | 39 +++++++++++++++++++++++++++++
>  qapi/qapi-util.c       | 66 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/test-qapi-util.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)
>=20

> +/**
> + * qobject_compare:
> + *
> + * Compare the value of @a and @b.
> + *
> + * If @a and @b have the same type and the same value (see list
> + * of supported types below), return 0.
> + *
> + * If @a and @b are both strings, return strcmp(a, b).
> + *
> + * If @a and @b are numbers, return a negative value if a < b,
> + * and a positive value if a > b.
> + *
> + * Otherwise (if @a and @b are not the same, have different types,
> + * are of an unsupported type, or are different), return a non-zero va=
lue.

Is this number going to be commutative and distributive, in order to
provide stable qsort()ing?  That is, if comparing a and b gives a
positive number, then comparing b and a should give a negative number;
and if comparing a and b then b and c results in two positive numbers,
then comparing a and c should also give a positive number.  It is
unclear from the documentation whether you are able to make this
guarantee; and without it, it is unsafe to use this comparator in places
that require stability.

> + *
> + * Note that this function doesn't support some types, and may
> + * return false if the types are unsupported, or if the types don't
> + * match exactly.

How is a return of false (=3D=3D 0, which also means equivalent) correct?=


> + *
> + * Supported types:
> + * - QTYPE_QNULL
> + * - QTYPE_QSTRING
> + * - QTYPE_QBOOL
> + * - QTYPE_QNUM (integers only)
> + * - QTYPE_QLIST
> + *
> + * Unsupported (always return false):
> + * - QTYPE_QNUM (non-integer values)
> + * - QTYPE_QDICT
> + *
> + * TODO: rewrite documentation to be clearer.
> + * TODO: support non-integer QTYPE_NUM values and QTYPE_QDICT.

There's another patch series pending for qobject_is_equal(); should
these two patches share approaches or even code?

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01134.html
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02459.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2DDcq9EjedPPFWBQOpQWOx8dDBWfImjov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmTHnkACgkQp6FrSiUn
Q2pzDgf/Ub6ktRf4Efi9wqDOIFQArbSVhKwPbV4NjcuOGLRW+sUpS6iFa9K/ZhFy
OTYTR4Uv/1fXeb+oq/1Ikh0CpI8g3KYxjThZNBGNB/DSHdzpq3/mnUKNtMF3Qoh5
E3qLksBB6dLY/HXYE6ep2TJU2mmCjrQZSBKcWLzg3INv4T+xGWyNF2BVvZb3z+QY
GUlBDmRiauD2YDfEVInEWKodDDQtCCY+Adw/8Kqav8MR4nPkQhygRJN1SVo+ctpE
SoVCuR7H8XaedNx56kuMWabpw5SdiakGKIVtLUTR9KYZ723bL4FYwscbSGJVZ9lX
t49/jG696TF7jYuLK+8GoIAX+e7HjA==
=B6z7
-----END PGP SIGNATURE-----

--2DDcq9EjedPPFWBQOpQWOx8dDBWfImjov--
