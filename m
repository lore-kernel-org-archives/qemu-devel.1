Received: from eggs.gnu.org ([2001:4830:134:3::10]:50941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ch2SC-0004of-6D
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ch2S8-0001OO-TT
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:05:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ch2S8-0001O7-L5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:05:36 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD2B57FB60
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 23:05:36 +0000 (UTC)
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <052e93bd-fce0-93bc-69f5-bdf893d5f508@redhat.com>
Date: Thu, 23 Feb 2017 17:05:34 -0600
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MkMJlOSD1diSu26LIkHpmdibrFwaG6kcN"
Subject: Re: [Qemu-devel] [PATCH 03/21] qmp-test: New,
 covering basic QMP protocol
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
--MkMJlOSD1diSu26LIkHpmdibrFwaG6kcN
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <052e93bd-fce0-93bc-69f5-bdf893d5f508@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/21] qmp-test: New, covering basic QMP
 protocol
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487886317-27400-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 03:44 PM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/Makefile.include |   5 +-
>  tests/libqtest.c       |  17 ++++--
>  tests/libqtest.h       |   8 +++
>  tests/qmp-test.c       | 139 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  4 files changed, 163 insertions(+), 6 deletions(-)
>  create mode 100644 tests/qmp-test.c
>=20

> +++ b/tests/libqtest.h
> @@ -32,6 +32,14 @@ extern QTestState *global_qtest;
>  QTestState *qtest_init(const char *extra_args);
> =20
>  /**
> + * qtest_init:

Wrong name (too much copy-and-paste)

> + * @extra_args: other arguments to pass to QEMU.
> + *
> + * Returns: #QTestState instance.
> + */
> +QTestState *qtest_init_without_qmp_handshake(const char *extra_args);
> +
> +/**
>   * qtest_quit:
>   * @s: #QTestState instance to operate on.
>   *
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> new file mode 100644
> index 0000000..405e49e
> --- /dev/null
> +++ b/tests/qmp-test.c

> +
> +static void test_malformed(void)
> +{
> +    QDict *resp;
> +
> +    /* Not even a dictionary */
> +    resp =3D qmp("null");
> +    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
> +    QDECREF(resp);
> +

Shall we test an array, integer, and/or boolean literal as well?

> +    /* No "execute" key */
> +    resp =3D qmp("{}");
> +    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
> +    QDECREF(resp);
> +
> +    /* "execute" isn't a string */
> +    resp =3D qmp("{ 'execute': true }");
> +    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
> +    QDECREF(resp);
> +
> +    /* "arguments" isn't a dictionary */
> +    resp =3D qmp("{ 'execute': 'no-such-cmd', 'arguments': [] }");
> +    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
> +    QDECREF(resp);
> +
> +    /* extra key */
> +    resp =3D qmp("{ 'execute': 'no-such-cmd', 'extra': true }");
> +    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
> +    QDECREF(resp);

Worth testing "{ 'arguments': {} }"?

> +}
> +
> +static void test_qmp_protocol(void)
> +{
> +    QDict *resp, *q, *ret;
> +    QList *capabilities;
> +
> +    global_qtest =3D qtest_init_without_qmp_handshake(common_args);
> +
> +    /* Test greeting */
> +    resp =3D qmp_receive();
> +    q =3D qdict_get_qdict(resp, "QMP");
> +    g_assert(q);
> +    test_version(qdict_get(q, "version"));
> +    capabilities =3D qdict_get_qlist(q, "capabilities");
> +    g_assert(capabilities && qlist_empty(capabilities));
> +    QDECREF(resp);
> +
> +    /* Test valid command before handshake */
> +    resp =3D qmp("{ 'execute': 'query-version' }");
> +    g_assert_cmpstr(get_error_class(resp), =3D=3D, "CommandNotFound");=

> +    QDECREF(resp);
> +
> +    /* Test malformed commands before handshake */
> +    test_malformed();
> +
> +    /* Test handshake */
> +    resp =3D qmp("{ 'execute': 'qmp_capabilities' }");
> +    ret =3D qdict_get_qdict(resp, "return");
> +    g_assert(ret && !qdict_size(ret));
> +    QDECREF(resp);
> +
> +    /* Test repeated handshake */
> +    resp =3D qmp("{ 'execute': 'qmp_capabilities' }");
> +    g_assert_cmpstr(get_error_class(resp), =3D=3D, "CommandNotFound");=

> +    QDECREF(resp);
> +
> +    /* Test valid command */
> +    resp =3D qmp("{ 'execute': 'query-version' }");
> +    test_version(qdict_get(resp, "return"));
> +    QDECREF(resp);
> +
> +    /* Test malformed commands */
> +    test_malformed();
> +
> +    /* Test 'id' */
> +    resp =3D qmp("{ 'execute': 'query-name', 'id': 'cookie#1' }");
> +    ret =3D qdict_get_qdict(resp, "return");
> +    g_assert(ret);
> +    g_assert_cmpstr(qdict_get_try_str(resp, "id"), =3D=3D, "cookie#1")=
;
> +    QDECREF(resp);
> +
> +    /* Test command failure with 'id' */
> +    resp =3D qmp("{ 'execute': 'human-monitor-command', 'id': 2 }");
> +    g_assert_cmpstr(get_error_class(resp), =3D=3D, "GenericError");
> +    g_assert_cmpint(qdict_get_int(resp, "id"), =3D=3D, 2);
> +    QDECREF(resp);

id can be _any JSON_ (at one point, QMP crashed if id included a null
literal); so maybe we should have more id tests such as "'id': null,",
"'id': [ { }, true ]"

But any tests at all is better than our previous state of none, so even
if you don't add tests, but just fix the typo:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--MkMJlOSD1diSu26LIkHpmdibrFwaG6kcN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYr2q+AAoJEKeha0olJ0NqXTAH/0W0f1WTbX3jHec8bHGH9Iem
g7WW4Ns+GwqzwEU5j+nuNB3eoQfWVr/PMarxrVINgo30/wLsclUE7hCVvd2tMopH
XgiOBEcv9XtdNdDRldhzxFxJdLFgSZUOjhbGoWGEka5ILCTPVZ9I8l5ohDQJvLGK
Zm9FvU7K8ri1QpIOMWqXR96YK07xvNuvucCidpn2bxff5aMkQz54nH7FxasqjNev
S1Z7rtwUS6dPj7/ivNgCHwl97GHG+rs/C1zhFSngBust5pyWoylz08w0dt0USgvR
soah/Qw/TFu9lXJSxJDmJ/CnsNTe2DZak6zpIL0XGp8gu6ufHt9C36cjegJUh+0=
=P3ob
-----END PGP SIGNATURE-----

--MkMJlOSD1diSu26LIkHpmdibrFwaG6kcN--
