Received: from eggs.gnu.org ([2001:4830:134:3::10]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqOFR-0008Od-95
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqOFN-00026x-4H
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cqOFM-00025T-RE
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:11:05 -0400
References: <1490118290-6133-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <37080340-bd84-ec1b-6a43-584eb1e31f76@redhat.com>
Date: Tue, 21 Mar 2017 13:11:00 -0500
MIME-Version: 1.0
In-Reply-To: <1490118290-6133-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Rphbs1wmEB3qgeimo8JKlsV10J9lJLOUs"
Subject: Re: [Qemu-devel] [PATCH] test-qobject-input-visitor: Cover
 visit_type_uint64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rphbs1wmEB3qgeimo8JKlsV10J9lJLOUs
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <37080340-bd84-ec1b-6a43-584eb1e31f76@redhat.com>
Subject: Re: [PATCH] test-qobject-input-visitor: Cover visit_type_uint64()
References: <1490118290-6133-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1490118290-6133-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2017 12:44 PM, Markus Armbruster wrote:
> The new test demonstrates known bugs: integers between INT64_MAX+1 and
> UINT64_MAX rejected, and integers between INT64_MIN and -1 are
> accepted modulo 2^64.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-qobject-input-visitor.c | 30 ++++++++++++++++++++++++++++++=

>  1 file changed, 30 insertions(+)
>=20
> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-in=
put-visitor.c
> index 6eb48fe..f965743 100644
> --- a/tests/test-qobject-input-visitor.c
> +++ b/tests/test-qobject-input-visitor.c
> @@ -116,6 +116,34 @@ static void test_visitor_in_int(TestInputVisitorDa=
ta *data,
>      g_assert_cmpint(res, =3D=3D, value);
>  }
> =20
> +static void test_visitor_in_uint(TestInputVisitorData *data,
> +                                const void *unused)
> +{
> +    Error *err =3D NULL;
> +    uint64_t res =3D 0;
> +    int value =3D 42;
> +    Visitor *v;
> +
> +    v =3D visitor_input_test_init(data, "%d", value);

Another place where I have to rebase my work that gets rid of the
dynamic JSON parser, if we want to revive that patch series; but don't
let it stop you on this patch.

> +
> +    visit_type_uint64(v, NULL, &res, &error_abort);
> +    g_assert_cmpuint(res, =3D=3D, (uint64_t)value);
> +
> +    /* BUG: value between INT64_MIN and -1 accepted modulo 2^64 */
> +
> +    v =3D visitor_input_test_init(data, "%d", -value);

Not necessarily a bug - libvirt exploits this behavior.  So even if we
fix the real bug, namely...

> +
> +    visit_type_uint64(v, NULL, &res, &error_abort);
> +    g_assert_cmpuint(res, =3D=3D, (uint64_t)-value);
> +
> +    /* BUG: value between INT64_MAX+1 and UINT64_MAX rejected */
> +
> +    v =3D visitor_input_test_init(data, "18446744073709551574");

=2E..this, we may be stuck keeping the modulo 2^64 parsing around for
back-compat.

At any rate, your test is a welcome addition; and as it only touches the
testsuite, it is still 2.9 material if desired.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Rphbs1wmEB3qgeimo8JKlsV10J9lJLOUs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0Wy0AAoJEKeha0olJ0Nq2eEIAJ8ADGp/1Lukh+3gHZAPwfgh
PJfGqu86BXncv7+GAO+fMCiUkbsCeairUyKeVgLpZ62b56rH//U3wCdKz+4feHOr
ss19Yi2/FbnjtgpL53pCNxDSZeC8PB9ecJVPLBsZk5pTgOljLpos7HN5/bNBBWG3
uwEUaUrny5TM1as3MOilynLVt+6IoK7H15JOXjV15CphvWtYF6oIMJz6CzxtdJSP
NE6aKIgPE+FGQ1DVE1uj4l1W2hjOjsz8BEtOK6UaYgCgg7umVNZd71YFmRxM+13O
sw69aZlPTGi5A4RR4kgF0rJ/fHlVSGx1n+8SRBA/w14PjSx+o/i57yATgaQWPsc=
=gjgb
-----END PGP SIGNATURE-----

--Rphbs1wmEB3qgeimo8JKlsV10J9lJLOUs--
