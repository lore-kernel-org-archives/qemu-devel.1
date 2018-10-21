Received: from eggs.gnu.org ([2001:4830:134:3::10]:57089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEJ6H-00037Y-Hn
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEJ58-0000YD-7c
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:08:11 -0400
Date: Sun, 21 Oct 2018 18:37:25 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181021173723.GC2215@umbus>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 01/45] hostmem-file: fixed the memory leak
 while get pmem path.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Zhang Yi <yi.z.zhang@linux.intel.com>


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:38PM -0300, Eduardo Habkost wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
>=20
> object_get_canonical_path_component() returns a string which
> must be freed using g_free().
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> Message-Id: <7328fb16c394eaf5d65437d11c2a9343647b6d3d.1535471899.git.yi.z=
=2Ezhang@linux.intel.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  backends/hostmem-file.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
> index e64074954f..639c8d4307 100644
> --- a/backends/hostmem-file.c
> +++ b/backends/hostmem-file.c
> @@ -145,20 +145,26 @@ static void file_memory_backend_set_pmem(Object *o,=
 bool value, Error **errp)
>      HostMemoryBackendFile *fb =3D MEMORY_BACKEND_FILE(o);
> =20
>      if (host_memory_backend_mr_inited(backend)) {
> +        char *path =3D object_get_canonical_path_component(o);
> +
>          error_setg(errp, "cannot change property 'pmem' of %s '%s'",
>                     object_get_typename(o),
> -                   object_get_canonical_path_component(o));
> +                   path);
> +        g_free(path);
>          return;
>      }
> =20
>  #ifndef CONFIG_LIBPMEM
>      if (value) {
>          Error *local_err =3D NULL;
> +        char *path =3D object_get_canonical_path_component(o);
> +
>          error_setg(&local_err,
>                     "Lack of libpmem support while setting the 'pmem=3Don=
'"
>                     " of %s '%s'. We can't ensure data persistence.",
>                     object_get_typename(o),
> -                   object_get_canonical_path_component(o));
> +                   path);
> +        g_free(path);
>          error_propagate(errp, local_err);
>          return;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvMuU0ACgkQbDjKyiDZ
s5KQVRAAujLtGt2u14Wco4jGuGQbcGdgHa7R+y/ybLvp5daHKuQ4TX5hufFEAunj
tthwhwnyqXYzZaZaGmAAkdM9keMYwYMcHqGJmVO7psRbg1PKzIui7GvQn+n2HSZw
tEOP5xOE+8hDTF8/mTJ3AZxR43qZEBvVSFB5ZaFguVvLcBxlkcG+jHSL1HlBeh0I
wrVQ8JOFmxlJuiY9BKAJqHu2Lu+7JKKao6wglT8pX+LpNSVKU/ejn2nMs2W68IP4
JQQlD/3WzgKv09vGDQR3hji+2edBepvkTTp8p4TJFq3QYDe4MJrIOdcYQ5wcI3Jt
+2vsUA4efWMT9MtEa+MPhmLoedYN5M9IZdoj1cv1G0/hs/LrFBhImtMQSRvOYkhg
0TXbYcB3rKdC5ip1T/1nqZs/nikDhNv8oDYJogK+sUeZFytHKs1UXi78UyqVPvNq
tQP2YaChH54jHYwrvMzgmAaBpt+KTB8sMerpEpexI4R6/phO8Ry7Lb0fKxnwaDVg
1mFbf0GOTN6C7nKfhsqSqWLhcyf+DuBCZj5VxoCn1IHpwT+B4gmc+iED4xvP6uvx
dFi6t5VGZsnbRyPtx0iRzY8dVhvguXgDayWEkGOX+biUJ8DsY9XVqmwBGE6RH4FH
EKuwWQK9Ulcabl2e1pF0aTL6DXMBY9XY/iCGG4Z6H/wxg+IdVoM=
=WsnR
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
