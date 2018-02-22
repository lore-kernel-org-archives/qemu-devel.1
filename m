Received: from eggs.gnu.org ([2001:4830:134:3::10]:59846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozXh-0005ru-0d
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eozXf-0002LM-Ta
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:40:45 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-12-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a298c2cb-f2d9-afef-ea2f-587378ba37a9@redhat.com>
Date: Thu, 22 Feb 2018 23:40:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-12-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ogX3dOtRmOWKuI0ck1Y9VcjDIlMY1PO91"
Subject: Re: [Qemu-devel] [PATCH v2 11/36] qdict: Introduce
 qdict_rename_keys()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ogX3dOtRmOWKuI0ck1Y9VcjDIlMY1PO91
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <a298c2cb-f2d9-afef-ea2f-587378ba37a9@redhat.com>
Subject: Re: [PATCH v2 11/36] qdict: Introduce qdict_rename_keys()
References: <20180221135404.27598-1-kwolf@redhat.com>
 <20180221135404.27598-12-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-21 14:53, Kevin Wolf wrote:
> A few block drivers will need to rename .bdrv_create options for their
> QAPIfication, so let's have a helper function for that.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qapi/qmp/qdict.h |   6 +++
>  qobject/qdict.c          |  34 ++++++++++++++
>  tests/check-qdict.c      | 113 +++++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 153 insertions(+)

[...]

> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index ec628f3453..5f8f3be9ff 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -665,6 +665,117 @@ static void qdict_crumple_test_empty(void)

[...]

> +    /* Renames are processed top to bottom */
> +    renames =3D (QDictRenames[]) {
> +        { "abc",        "tmp" },
> +        { "abcdef",     "abc" },
> +        { "number",     "abcdef" },
> +        { "flag",       "number" },
> +        { "nothing",    "flag" },
> +        { "tmp",        "nothing" },
> +        { NULL , NULL }
> +    };

A bit confusing to follow, but I guess nobody will have to follow it
after me and Eric.

> +    copy =3D qdict_clone_shallow(dict);
> +    qdict_rename_keys(copy, renames, &error_abort);
> +
> +    g_assert_cmpstr(qdict_get_str(copy, "nothing"), =3D=3D, "foo");
> +    g_assert_cmpstr(qdict_get_str(copy, "abc"), =3D=3D, "bar");
> +    g_assert_cmpint(qdict_get_int(copy, "abcdef"), =3D=3D, 42);
> +    g_assert_cmpint(qdict_get_bool(copy, "number"), =3D=3D, true);
> +    g_assert(qobject_type(qdict_get(copy, "flag")) =3D=3D QTYPE_QNULL)=
;
> +    g_assert(!qdict_haskey(copy, "tmp"));
> +
> +    QDECREF(copy);
> +
> +    /* Conflicting renam */

*rename

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ogX3dOtRmOWKuI0ck1Y9VcjDIlMY1PO91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqPRtQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AQVUH+gIM7ke8UhrfrJFFXH2Zu2Q9ZlZrE12t
53zKaMwN6GJbWTEw8Xfs3CSsEa5uXNz1q3EALCQGqKfG9up07cVze/uUS+/s9HyH
zr+F3pB6tVI3rWSf6EFO5GuBNxXI9X43lR1umIELLB8WDScJ9f1L8vd+MTQ4dOGT
PCwGjJPfdVLI/Y44gZLgfJrpNJNiuhTdCsXuMTvG6lMZhwQOCibQ0hVdU/fUDZGk
SYZQMcJqhpe6D8TES4H1G6wg0o3I6hP4QxUsO8qJBSm5QsUc4A/sENtDy6JWgoc1
qbSXOErH1odTUN1mPFnvW1a+adySXXjPZTnNXTIVM0R0WBLi66ZQCHc=
=5mCn
-----END PGP SIGNATURE-----

--ogX3dOtRmOWKuI0ck1Y9VcjDIlMY1PO91--
