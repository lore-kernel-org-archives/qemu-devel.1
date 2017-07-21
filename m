Received: from eggs.gnu.org ([2001:4830:134:3::10]:38117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZ79-0003Yk-2k
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZ74-0007Ua-Eb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:41:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYZ74-0007TQ-46
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:41:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE32B883BC
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:41:04 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com>
Date: Fri, 21 Jul 2017 09:39:23 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="33NdQiRSpWP99No2skkvONMX5x4KQL0H7"
Subject: Re: [Qemu-devel] [PATCH 4/9] tests: Clean up string interpolation
 into QMP input (simple cases)
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
--33NdQiRSpWP99No2skkvONMX5x4KQL0H7
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <295a3dcc-5165-cc23-26a2-ffb4d8ccb144@redhat.com>
Subject: Re: [PATCH 4/9] tests: Clean up string interpolation into QMP input
 (simple cases)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> When you build QMP input manually like this
>=20
>     cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
>                           "'arguments': { 'uri': '%s' } }",
>                           uri);
>     rsp =3D qmp(cmd);
>     g_free(cmd);
>=20
> you're responsible for escaping the interpolated values for JSON.  Not
> done here, and therefore works only for sufficiently nice @uri.  For
> instance, if @uri contained a single "'", qobject_from_jsonv() would
> fail, qmp_fd_sendv() would misinterpret the failure as empty input and
> do nothing, and the test would hang waiting for a response that never
> comes.
>=20
> Leaving interpolation into JSON to qmp() is more robust:
>=20
>     rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }",=
 uri);
>=20
> It's also more concise.
>=20
> Clean up the simple cases where we interpolate exactly a JSON value.
>=20
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> ---
> +    qmp_fd_send(fixture->fd,
> +                "\xff{'execute': 'guest-sync-delimited',"
> +                " 'arguments': {'id': %u } }",

Ouch. Per 2/9:
 * json-lexer.c (only understands '%((l|ll|I64)?d|[ipsf])').

That will need to be %d now. Or, more likely, we need to update the
comments in json-lexer.c and in 2/9 (/me goes to read json-lexer.c...)
    /* escape */
    [IN_ESCAPE_LL] =3D {
        ['d'] =3D JSON_ESCAPE,
        ['u'] =3D JSON_ESCAPE,
    },
=2E..
    [IN_ESCAPE] =3D {
        ['d'] =3D JSON_ESCAPE,
        ['i'] =3D JSON_ESCAPE,
        ['p'] =3D JSON_ESCAPE,
        ['s'] =3D JSON_ESCAPE,
        ['u'] =3D JSON_ESCAPE,
        ['f'] =3D JSON_ESCAPE,
        ['l'] =3D IN_ESCAPE_L,
        ['I'] =3D IN_ESCAPE_I,

Aha, that 'd' should be '[du]' in all of the comments.

> @@ -411,10 +408,10 @@ static void test_qga_file_ops(gconstpointer fix)
> =20
>      enc =3D g_base64_encode(helloworld, sizeof(helloworld));
>      /* write */
> -    cmd =3D g_strdup_printf("{'execute': 'guest-file-write',"
> -                          " 'arguments': { 'handle': %" PRId64 ","
> -                          " 'buf-b64': '%s' } }", id, enc);
> -    ret =3D qmp_fd(fixture->fd, cmd);
> +    ret =3D qmp_fd(fixture->fd,
> +                 "{'execute': 'guest-file-write',"
> +                 " 'arguments': { 'handle': %" PRId64 ", 'buf-b64': %s=
 } }",

Ouch; you are reverting commit 1792d7d0. We tried hard to make
json-lexer.c understand lots of different 64-bit format spellings, but
we KNOW that we don't support MacOS (see commit 29a6731).  We either
need to beef up json-lexer.c to understand %qd, or get rid of JSON
psuedo-strings, if we expect this to work; otherwise, you should use
%lld and long long instead of PRId64 and uint64_t.

Overall, I like the patch, but we need to fix the problems for the next
round of this series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--33NdQiRSpWP99No2skkvONMX5x4KQL0H7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyEhsACgkQp6FrSiUn
Q2r25Qf9FtfMvsAqEePWaIDpmjrZFGcYmjhjrbF6ddgv8cPlPhe6YxtjRgBlaNhW
LIHYrFZySgyt6xjLA6WDcr7m17NAjwvaPTFLn7nhx3bkfOFZTaE0R6BnS+3+GQbk
N1BDi6cEzG7XUDEh2IQWBS5kgE36v7q7+TD+4izCsM0XRIgDorMks/CP0sEr1aZm
AUFozooGYYgBTsSU98DIrD4Fv363KGLoCgmGeaZcgO/GzDCvtBt/2YiuTZ8a6LC6
JswplrtKkUYeOlqwmVpM46cHN2qUKL8hHlZe//fplM7xaBqHxr8AtrlS+MAM8VJa
tbx7eNe5dcG07pMb/4GLnTu9pXg8VA==
=FcQQ
-----END PGP SIGNATURE-----

--33NdQiRSpWP99No2skkvONMX5x4KQL0H7--
