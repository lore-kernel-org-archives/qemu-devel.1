Received: from eggs.gnu.org ([2001:4830:134:3::10]:46037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpyLN-0004rW-OY
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpyLJ-00023K-Rl
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:31:33 -0400
Date: Mon, 20 Mar 2017 14:31:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320143125.GB17887@stefanha-x1.localdomain>
References: <20170319162715.2260-1-sauravsachidanand@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OJWLbGElk4npXSe3"
Content-Disposition: inline
In-Reply-To: <20170319162715.2260-1-sauravsachidanand@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] util: Use
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


--OJWLbGElk4npXSe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 19, 2017 at 04:27:15PM +0000, Saurav Sachidanand wrote:
> @@ -48,10 +46,10 @@ envlist_free(envlist_t *envlist)
>  		entry =3D envlist->el_entries.lh_first;
>  		QLIST_REMOVE(entry, ev_link);
> =20
> -		free((char *)entry->ev_var);
> +		g_free(entry->ev_var);

You need to keep the const casts to silence the compiler.  Here, ...

> @@ -155,18 +152,14 @@ envlist_setenv(envlist_t *envlist, const char *env)
> =20
>  	if (entry !=3D NULL) {
>  		QLIST_REMOVE(entry, ev_link);
> -		free((char *)entry->ev_var);
> +		g_free(entry->ev_var);

here, ...

> @@ -201,8 +194,8 @@ envlist_unsetenv(envlist_t *envlist, const char *env)
>  	}
>  	if (entry !=3D NULL) {
>  		QLIST_REMOVE(entry, ev_link);
> -		free((char *)entry->ev_var);
> +		g_free(entry->ev_var);

and here.

The problem is that const char * is not supposed to be freed.  The type
would need to be non-const.  Most of the code does treat the string as
const, so it's nice to have it except for the final free().

--OJWLbGElk4npXSe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz+e9AAoJEJykq7OBq3PIqjkH+wZ8LbauT/uFs5gEgvRezIOi
WNilawJjEJW0j4GqLhZ+brL0qypAx7ZKH8u8ca2rdQWUMhpBdod++Zd+E31l3bR3
0xfdmc65Sx66vzf0HxbePPXSGcYO7/M5zGv1UqZ6kahO0JQZXIjKKW1UiMtakSKU
f/xc29YVkVDMqvVrSd6pVWO5ibqHlVXr1U0q6vrfFL695kNUUvPP7QOCronLYqQI
TEGMdVR1Mn8Jo4V3aii+0W+du59bDh1drjUBb9f4ToR73o1h49DsPTa7kzXyHQNS
wl2aa3Tl5gSm3PDcr42FSph43mtDVYbA3vxuZllChETawEL4c3lPFXSg3LTviy4=
=Exep
-----END PGP SIGNATURE-----

--OJWLbGElk4npXSe3--
