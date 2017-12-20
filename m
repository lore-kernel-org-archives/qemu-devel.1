Received: from eggs.gnu.org ([2001:4830:134:3::10]:45337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRhPl-0002qb-Uf
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRhPi-00031U-EM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:40:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRhPi-00030a-8b
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:40:14 -0500
Date: Wed, 20 Dec 2017 16:40:05 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171220164005.GH12566@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FLPM4o+7JoHGki3m"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 01/27] chardev: use backend chr context
 when watch for fe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--FLPM4o+7JoHGki3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:31PM +0800, Peter Xu wrote:
> In commit 6bbb6c0644 ("chardev: use per-dev context for
> io_add_watch_poll", 2017-09-22) all the chardev watches are converted to
> use per-chardev gcontext to support chardev to be run outside default
> main thread.  However that's still missing one call from the frontend
> code.  Touch that up.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-fe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index ee6d596100..462c529f19 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -356,7 +356,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondi=
tion cond,
>      }
> =20
>      g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);
> -    tag =3D g_source_attach(src, NULL);
> +    tag =3D g_source_attach(src, be->chr->gcontext);

If you respin, it's a little nicer to use the s local variable instead:

    tag =3D g_source_attach(src, s->gcontext);

--FLPM4o+7JoHGki3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOpJlAAoJEJykq7OBq3PIYCEH/33hCJdli1uoJQc5JfwB/Nze
qRTbj+1jNQKrVia4n2/CCCtkEjm3QLVsZkAKcllY4/oRsZFStDGhNW6ej9alByCD
/4635i+5l/OCycoFPe9coPSzSyB5vzrIzC9g8KEWjwa/ty7dhsWv5KnHrvNiHWi7
zWnJNew4QITE/UqE0DwKvJ/uLo4Wwnzw/KD0dY+Im1CfvM+UNtdQTCi2gl5Hc32A
m8ma/SXqbZq/CBB9wVML2h4LiOA67xKCBUas8rdhfGK4HSOAo7hdfblwJ6QVGWv1
qKxzlM78Hm+VwDSYjl94RzRPfU091f1EVBesnaTPEnnIxq1CV+nwYQMFQbvc3J8=
=x52L
-----END PGP SIGNATURE-----

--FLPM4o+7JoHGki3m--
