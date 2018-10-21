Received: from eggs.gnu.org ([2001:4830:134:3::10]:57089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEJ6J-00037Y-Bl
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEJ55-0000Xc-Cf
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 15:08:08 -0400
Date: Sun, 21 Oct 2018 18:38:20 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181021173820.GD2215@umbus>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a2FkP9tdjPU2nyhF"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-3-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 02/45] vl.c deprecate incorrect CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>


--a2FkP9tdjPU2nyhF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:39PM -0300, Eduardo Habkost wrote:
> From: Igor Mammedov <imammedo@redhat.com>
>=20
> -smp [cpus],sockets/cores/threads[,maxcpus] should describe topology
> so that total number of logical CPUs [sockets * cores * threads]
> would be equal to [maxcpus], however historically we didn't have
> such check in QEMU and it is possible to start VM with an invalid
> topology.
> Deprecate invalid options combination so we can make sure that
> the topology VM started with is always correct in the future.
> Users with an invalid sockets/cores/threads/maxcpus values should
> fix their CLI to make sure that
>    [sockets * cores * threads] =3D=3D [maxcpus]
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Message-Id: <1536836762-273036-2-git-send-email-imammedo@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  vl.c                 |  7 +++++++
>  qemu-deprecated.texi | 12 ++++++++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/vl.c b/vl.c
> index 4e25c78bff..027d04c7ca 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1235,6 +1235,13 @@ static void smp_parse(QemuOpts *opts)
>              exit(1);
>          }
> =20
> +        if (sockets * cores * threads !=3D max_cpus) {
> +            warn_report("Invalid CPU topology deprecated: "
> +                        "sockets (%u) * cores (%u) * threads (%u) "
> +                        "!=3D maxcpus (%u)",
> +                        sockets, cores, threads, max_cpus);
> +        }
> +
>          smp_cpus =3D cpus;
>          smp_cores =3D cores;
>          smp_threads =3D threads;
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 11b870c5c1..5d2d7a3588 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -86,6 +86,18 @@ for these file types is 'host_cdrom' or 'host_device' =
as appropriate.
>  The @option{name} parameter of the @option{-net} option is a synonym
>  for the @option{id} parameter, which should now be used instead.
> =20
> +@subsection -smp (invalid topologies) (since 3.1)
> +
> +CPU topology properties should describe whole machine topology including
> +possible CPUs.
> +
> +However, historically it was possible to start QEMU with an incorrect to=
pology
> +where @math{@var{n} <=3D @var{sockets} * @var{cores} * @var{threads} < @=
var{maxcpus}},
> +which could lead to an incorrect topology enumeration by the guest.
> +Support for invalid topologies will be removed, the user must ensure
> +topologies described with -smp include all possible cpus, i.e.
> +  @math{@var{sockets} * @var{cores} * @var{threads} =3D @var{maxcpus}}.
> +
>  @section QEMU Machine Protocol (QMP) commands
> =20
>  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a2FkP9tdjPU2nyhF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvMuYwACgkQbDjKyiDZ
s5JDig/5AU+8EdxrE6ysYLety6twLv162003yw1dC/ZcWhwZEVO18rYmld22uS1S
qPVx2sCJrXh82xQNra2wajNAMHqMRdg0empoDb9AuFlQR6uVqfYNt1rbCue47/O0
+IHUh3V8DWV6P/gzUTvPUTqhwRXJpakoogCbLnEBLgixAmTZRuiatqiiB1CQLn4H
1eR1rQt6yg1GFpFmlo1UR5RKNa8tl01e2qj3hcktSnaeKQWCE+PHOKVZCsSWkhvc
qv67wZ26Q9Wyn4RWw4THbUsA1U2h4n0k2QFPtea59p+2Kl49EZzekpKkPeV43Dd2
MSvdWfvP102sEjlgftrN8FWeQJX7jq8FNQOgAq2a5h+J4zjLvJoxFNh8F9ZfsFOj
WwpJe2L2Y1eJmJR1lmUvVdii61NUO5uvQDI5opB2xReajrCTfeIFryqiTd3Kmg4G
cAtY8YXBhG4SC24PSaWDLCzgevoWIaGvxj3wFW7JlqpDq32YJEJcY7wAxBQEskY4
AVqRuwyulSgjsvlKkqPCwWDWT3shZR9u4iYUj/mQKegmeWYU0I2MIbKahf5xxQJW
cXdeZovywR3UjIL2SXi+jP3pSUfi7WUbF12pNm2mQweMxfbBqT+RaYIrVGNpgtsF
6p01oY0EGUhS586EBsQ1U5SfUhK+pddPWwRX5iw9M3PxpWHq7rI=
=IaX3
-----END PGP SIGNATURE-----

--a2FkP9tdjPU2nyhF--
