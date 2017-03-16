Received: from eggs.gnu.org ([2001:4830:134:3::10]:44622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1coRSJ-00014H-IR
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1coRSG-0003lI-DH
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:12:23 -0400
Date: Thu, 16 Mar 2017 17:12:14 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170316091214.GC27579@stefanha-x1.localdomain>
References: <20170305025605.3824-1-sauravsachidanand@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <20170305025605.3824-1-sauravsachidanand@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2] util: Use
 g_malloc/g_free in envlist.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Saurav Sachidanand <sauravsachidanand@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, laurent@vivier.eu


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2017 at 02:56:05AM +0000, Saurav Sachidanand wrote:
> diff --git a/util/envlist.c b/util/envlist.c
> index e86857e70a..a42eefa5fe 100644
> --- a/util/envlist.c
> +++ b/util/envlist.c
> @@ -17,16 +17,14 @@ static int envlist_parse(envlist_t *envlist,
>      const char *env, int (*)(envlist_t *, const char *));
>=20
>  /*
> - * Allocates new envlist and returns pointer to that or
> - * NULL in case of error.
> + * Allocates new envlist and returns pointer to it.
>   */
>  envlist_t *
>  envlist_create(void)
>  {
>  	envlist_t *envlist;
>=20
> -	if ((envlist =3D malloc(sizeof (*envlist))) =3D=3D NULL)
> -		return (NULL);
> +  envlist =3D g_malloc(sizeof(*envlist));

Please use tabs to indent in this file.  Normally QEMU coding style uses
4-space indentation but this file contains old code and it's easiest to
leave it undisturbed.

>=20
>  	QLIST_INIT(&envlist->el_entries);
>  	envlist->el_count =3D 0;
> @@ -49,9 +47,9 @@ envlist_free(envlist_t *envlist)
>  		QLIST_REMOVE(entry, ev_link);
>=20
>  		free((char *)entry->ev_var);
> -		free(entry);
> +    g_free(entry);
>  	}
> -	free(envlist);
> +  g_free(envlist);
>  }
>=20
>  /*
> @@ -156,15 +154,15 @@ envlist_setenv(envlist_t *envlist, const char *env)
>  	if (entry !=3D NULL) {
>  		QLIST_REMOVE(entry, ev_link);
>  		free((char *)entry->ev_var);
> -		free(entry);
> +    g_free(entry);
>  	} else {
>  		envlist->el_count++;
>  	}
>=20
> -	if ((entry =3D malloc(sizeof (*entry))) =3D=3D NULL)
> -		return (errno);
> -	if ((entry->ev_var =3D strdup(env)) =3D=3D NULL) {
> -		free(entry);
> +  entry =3D g_malloc(sizeof(*entry));
> +  entry->ev_var =3D strdup(env);

Could this be converted to g_strdup() in a separate patch?

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYylbuAAoJEJykq7OBq3PIYIMH/jFZM+oBZ0rbwFn1jWUrEZFT
aKCECaIUnw++7EA3k7Zsx4dY5xLR+ENA3PN/9h+63oQG0qgCxvUE/z5UiN+KGrTp
4iAf4gPv7GWPJO0hljfrjdLcMC/abQyl2z4rS7cXoIFVKqjbnxo9u0glb6ylI47x
zYrR4rWeJUJKmmb/y31d+k7b9VZP4CdpLCe9j7leZ9XlWUv5VD91UwrvMmP5B63x
6K+p5f7BOPG+t0zqt8wSO1UFJ3e4vvGrPfhCIfgXP/BJJ3pAohxuSH0ZpBE9tNmX
32z0E7HS7gGkJuGQfGYSm3JfnziSU5NwasmyADDruPlkA7an17CYbLa4hwbjf48=
=qC5H
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
