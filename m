Received: from eggs.gnu.org ([2001:4830:134:3::10]:41796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgFul-0004k2-K3
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgFug-0003Me-NZ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:15:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgFug-0003MS-7Z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 14:15:50 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5930C635C1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 19:15:50 +0000 (UTC)
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-6-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <632c95e7-781d-acc6-5020-fddb02314c15@redhat.com>
Date: Tue, 21 Feb 2017 13:15:47 -0600
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-6-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ne2PNVnIq4TprihjB1AkJu4OWbgXbTkPC"
Subject: Re: [Qemu-devel] [PATCH v2 05/30] glib-compat: add
 g_test_add_data_func_full fallback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ne2PNVnIq4TprihjB1AkJu4OWbgXbTkPC
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <632c95e7-781d-acc6-5020-fddb02314c15@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/30] glib-compat: add
 g_test_add_data_func_full fallback
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
 <20170221141451.28305-6-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> Move the fallback from qtest_add_data_func_full() to glib-compat.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/glib-compat.h | 21 +++++++++++++++++++++
>  tests/libqtest.c      | 10 ----------
>  2 files changed, 21 insertions(+), 10 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index 0cd24ffbe9..863c8cf73d 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -328,4 +328,25 @@ static inline void g_source_set_name_by_id(guint t=
ag, const char *name)
>  #define g_test_subprocess() (0)
>  #endif
> =20
> +
> +#if !GLIB_CHECK_VERSION(2, 34, 0)
> +static inline void
> +g_test_add_data_func_full(const char *path,
> +                          gpointer data,
> +                          gpointer fn,
> +                          gpointer data_free_func)
> +{
> +#if GLIB_CHECK_VERSION(2, 26, 0)
> +    /* back-compat casts, remove this once we can require new-enough g=
lib */
> +    g_test_add_vtable(path, 0, data, NULL,
> +                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_fr=
ee_func);
> +#else
> +    /* back-compat casts, remove this once we can require new-enough g=
lib */

The comments are somewhat dead here, since they are guarded by
GLIB_CHECK_VERSION that states what the new-enough glib is (and the
older versions won't be changing).

>      gchar *path =3D g_strdup_printf("/%s/%s", qtest_get_arch(), str);
> -#if GLIB_CHECK_VERSION(2, 34, 0)
>      g_test_add_data_func_full(path, data, fn, data_free_func);
> -#elif GLIB_CHECK_VERSION(2, 26, 0)
> -    /* back-compat casts, remove this once we can require new-enough g=
lib */
> -    g_test_add_vtable(path, 0, data, NULL,
> -                      (GTestFixtureFunc)fn, (GTestFixtureFunc) data_fr=
ee_func);
> -#else
> -    /* back-compat casts, remove this once we can require new-enough g=
lib */

But since it is code motion, I don't care if you keep or remove the
comments.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Ne2PNVnIq4TprihjB1AkJu4OWbgXbTkPC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrJHjAAoJEKeha0olJ0NqBREH/3PVvYrIroJm/rvhjDR8FXZK
rAnLitul0YIw++QqN7gITnaU1V4LR4ac5LKtmixx8c8Io6GacmxF/8tWWZBtV238
E4tErU5RVYsXb2SFZ3u0SQ7etjTqOUzMasjqKBUKZid5iZ3Z6ZIJi3kdaslaGX2o
6wFe/74DUYuVjzhTBm78Z1lygq+KaLKyEOB/aS+Cwzgu2OPwFjDLX+QlSHKdDHUI
iuw6Y/V2uCmGfywRQhthknRM9KNBqrTiGKkG1jiK9V1t+KWVvsClB30eZqxyLkzY
fGojGefW2RjZ2sIea6popuvyvrxZd5MD4tP98fpehD7EJ/i7doK+4ihjquwxa8I=
=qTHd
-----END PGP SIGNATURE-----

--Ne2PNVnIq4TprihjB1AkJu4OWbgXbTkPC--
