Received: from eggs.gnu.org ([2001:4830:134:3::10]:40300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cik7U-0003Zd-NK
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cik7O-00031x-FX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:55:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cik7O-00031q-7W
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:55:14 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43BB091C3E
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 15:55:14 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-22-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa12f2f1-7ff3-d58f-011d-25be93722d0e@redhat.com>
Date: Tue, 28 Feb 2017 09:55:11 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-22-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dkXnX3heOk2gGRibLF958Du1iTwJ1Kr1q"
Subject: Re: [Qemu-devel] [PATCH v2 21/26] tests: Cover partial input visit
 of list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dkXnX3heOk2gGRibLF958Du1iTwJ1Kr1q
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <aa12f2f1-7ff3-d58f-011d-25be93722d0e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 21/26] tests: Cover partial input visit of
 list
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-22-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-22-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> Demonstrates a design flaw: there is no way to for input visitors to
> report that a list visit didn't visit the complete input list.  The
> generated list visits always do, but manual visits needn't.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/test-opts-visitor.c          | 41 ++++++++++++++++++++++++++++++=
+++++
>  tests/test-qobject-input-visitor.c | 44 ++++++++++++++++++++++++++++++=
++++++++
>  tests/test-string-input-visitor.c  | 22 +++++++++++++++++++
>  3 files changed, 107 insertions(+)
>=20

> =20
> +static void
> +test_opts_range_unvisited(void)
> +{
> +    intList *list =3D NULL;
> +    intList *tail;
> +    QemuOpts *opts;
> +    Visitor *v;
> +
> +    opts =3D qemu_opts_parse(qemu_find_opts("userdef"), "ilist=3D0-2",=
 false,
> +                           &error_abort);
> +
> +    v =3D opts_visitor_new(opts);
> +
> +    visit_start_struct(v, NULL, NULL, 0, &error_abort);
> +
> +    /* Would be simpler if the visitor genuinely supported virtual wal=
ks */
> +    visit_start_list(v, "ilist", (GenericList **)&list, sizeof(*list),=

> +                     &error_abort);

Although the complexity of adding virtual walks to the string visitor
may not be worth the effort.

> +++ b/tests/test-qobject-input-visitor.c
> @@ -923,6 +923,46 @@ static void test_visitor_in_fail_struct_missing(Te=
stInputVisitorData *data,
>      visit_end_struct(v, NULL);
>  }
> =20
> +static void test_visitor_in_fail_list(TestInputVisitorData *data,
> +                                      const void *unused)
> +{
> +    int64_t i64 =3D -1;
> +    Visitor *v;
> +
> +    /* Unvisited list tail */
> +
> +    v =3D visitor_input_test_init(data, "[ 1, 2, 3 ]");
> +
> +    visit_start_list(v, NULL, NULL, 0, &error_abort);
> +    visit_type_int(v, NULL, &i64, &error_abort);
> +    g_assert_cmpint(i64, =3D=3D, 1);
> +    visit_type_int(v, NULL, &i64, &error_abort);
> +    g_assert_cmpint(i64, =3D=3D, 2);
> +    visit_end_list(v, NULL);
> +    /* BUG: unvisited tail not reported; actually not reportable by de=
sign */

Indeed - the virtual walk is easier. At any rate, good testsuite
addition, and sets the stage for why the next patches fix the design flaw=
=2E

> +}
> +
> +static void test_visitor_in_fail_list_nested(TestInputVisitorData *dat=
a,
> +                                             const void *unused)
> +{
> +    int64_t i64 =3D -1;
> +    Visitor *v;
> +
> +    /* Unvisited nested list tail */
> +
> +    v =3D visitor_input_test_init(data, "[ 0, [ 1, 2, 3 ] ]");

In fact, QAPI does not (currently) allow the creation of one list nested
inside another (at least, not without an intervening struct), so this
particular input can only be walked virtually.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--dkXnX3heOk2gGRibLF958Du1iTwJ1Kr1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtZ1fAAoJEKeha0olJ0NqwRcH/iESw1MQAj0/EAvtjJ7+wwLK
QjlzCOPbOf4a6JVfNC7srl11y5t7wABOTr9SJrDtQadQZ00pMR02YuiBAwGzIvYJ
sW61WSPZUgOWLIL239lT0cqwUfhq5QxiLEjdWBn93cO8ASG9BwpK6FNNYknzkqMW
S/e+2z89OveauIfRde2WQO0KP0Zpns8n6vb2V4kf+kfXu1WkNX6q343NueM01PzO
U3QuopoPaJWnR4MUXTjyBpoXPGkQo6qZIMitmeCBRFJd+h8Ux3p2RLsV0jgahvTZ
ZzxC/blasS/W011Nys8sgJRF63m9ka+NMMOVjSX5RYgj8pUw4QjAjmfVRlZ6j3w=
=rOct
-----END PGP SIGNATURE-----

--dkXnX3heOk2gGRibLF958Du1iTwJ1Kr1q--
