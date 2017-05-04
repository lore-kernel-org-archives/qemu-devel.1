Received: from eggs.gnu.org ([2001:4830:134:3::10]:60048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d65Df-0003PK-2l
	for qemu-devel@nongnu.org; Wed, 03 May 2017 21:06:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d65Db-0004Lr-V2
	for qemu-devel@nongnu.org; Wed, 03 May 2017 21:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d65Db-0004LT-NA
	for qemu-devel@nongnu.org; Wed, 03 May 2017 21:06:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA522C04B945
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 01:06:06 +0000 (UTC)
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
	<20170503223846.6559-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0bf4ab7-0265-96cc-f856-4e2502f265e8@redhat.com>
Date: Wed, 3 May 2017 20:06:03 -0500
MIME-Version: 1.0
In-Reply-To: <20170503223846.6559-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GQufD6WHt6ULnMIoHiAuLtQNeFkhwohEM"
Subject: Re: [Qemu-devel] [PATCH v5 1/5] test-keyval: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GQufD6WHt6ULnMIoHiAuLtQNeFkhwohEM
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <a0bf4ab7-0265-96cc-f856-4e2502f265e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/5] test-keyval: fix leaks
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
 <20170503223846.6559-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170503223846.6559-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2017 05:38 PM, Marc-Andr=C3=A9 Lureau wrote:
> Spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-keyval.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Eric blake <eblake@redhat.com>

>=20
> diff --git a/tests/test-keyval.c b/tests/test-keyval.c
> index ba19560a22..c556b1b117 100644
> --- a/tests/test-keyval.c
> +++ b/tests/test-keyval.c
> @@ -628,6 +628,7 @@ static void test_keyval_visit_alternate(void)
>      visit_type_AltNumStr(v, "a", &ans, &error_abort);
>      g_assert_cmpint(ans->type, =3D=3D, QTYPE_QSTRING);
>      g_assert_cmpstr(ans->u.s, =3D=3D, "1");
> +    qapi_free_AltNumStr(ans);
>      visit_type_AltNumInt(v, "a", &ani, &err);
>      error_free_or_abort(&err);
>      visit_end_struct(v, NULL);
> @@ -651,9 +652,12 @@ static void test_keyval_visit_any(void)
>      g_assert(qlist);
>      qstr =3D qobject_to_qstring(qlist_pop(qlist));
>      g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "null");
> +    QDECREF(qstr);
>      qstr =3D qobject_to_qstring(qlist_pop(qlist));
>      g_assert_cmpstr(qstring_get_str(qstr), =3D=3D, "1");
>      g_assert(qlist_empty(qlist));
> +    QDECREF(qstr);
> +    qobject_decref(any);
>      visit_check_struct(v, &error_abort);
>      visit_end_struct(v, NULL);
>      visit_free(v);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GQufD6WHt6ULnMIoHiAuLtQNeFkhwohEM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCn57AAoJEKeha0olJ0NqnDAIAJa6JPpAoGKlKKB9PJhpB4Qc
7LWpJ1Tzrb69dbrOK8SVHoAUU573OHULOCbbtYZOD8YzQuFWWS/KzwxUl3Mp0i0W
HloJn/Cv2Rki9qudXs01J7du7eRhme3YMY3oYYLe1DJZnrhW6GDE0zO+V473tuZD
kkKiZyM0ipwq47iRDJF3FsYOSH2ayFwwkLy17DgBH9HYJ1MGdWt2WqpZgXdzowZ6
4ZJR57qMNBZdUlmpxzrfL7bLA8q9jOP5vZXalI6KYMfCE3KVYRNfI7SyuC8ylnsQ
gqOI4wcm4UQvtd32ZOZlwk8og/LO1ytnfxw/8rK/u9EXA/aBY0t7PvLgID/cLYo=
=l0Mj
-----END PGP SIGNATURE-----

--GQufD6WHt6ULnMIoHiAuLtQNeFkhwohEM--
