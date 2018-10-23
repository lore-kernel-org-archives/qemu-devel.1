Received: from eggs.gnu.org ([2001:4830:134:3::10]:37363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhc-0007I5-KL
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybh-0006q9-Br
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:37 -0400
Date: Tue, 23 Oct 2018 16:06:24 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023150624.GB12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 03/45] vl:c: make sure that sockets are
 calculated correctly in '-smp X' case
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


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:40PM -0300, Eduardo Habkost wrote:
> From: Igor Mammedov <imammedo@redhat.com>
>=20
> commit
>   (5cdc9b76e3 vl.c: Remove dead assignment)
> removed sockets calculation when 'sockets' weren't provided on CLI
> since there wasn't any users for it back then. Exiting checks
> are neither reachable
>    } else if (sockets * cores * threads < cpus) {
> or nor triggerable
>    if (sockets * cores * threads > max_cpus)
> so we weren't noticing wrong topology since then, since users
> recalculate sockets adhoc on their own.
>=20
> However with deprecation check it becomes noticable, for example
>   -smp 2
> will start printing warning:
>   "warning: Invalid CPU topology deprecated: sockets (1) * cores (1) * th=
reads (1) !=3D maxcpus (2)"
> calculating sockets if they weren't specified.
>=20
> Fix it by returning back sockets calculation if it's omitted on CLI.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Message-Id: <1536836762-273036-3-git-send-email-imammedo@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  vl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/vl.c b/vl.c
> index 027d04c7ca..2324321d91 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1199,11 +1199,14 @@ static void smp_parse(QemuOpts *opts)
> =20
>          /* compute missing values, prefer sockets over cores over thread=
s */
>          if (cpus =3D=3D 0 || sockets =3D=3D 0) {
> -            sockets =3D sockets > 0 ? sockets : 1;
>              cores =3D cores > 0 ? cores : 1;
>              threads =3D threads > 0 ? threads : 1;
>              if (cpus =3D=3D 0) {
> +                sockets =3D sockets > 0 ? sockets : 1;
>                  cpus =3D cores * threads * sockets;
> +            } else {
> +                max_cpus =3D qemu_opt_get_number(opts, "maxcpus", cpus);
> +                sockets =3D max_cpus / (cores * threads);
>              }
>          } else if (cores =3D=3D 0) {
>              threads =3D threads > 0 ? threads : 1;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPOO4ACgkQbDjKyiDZ
s5IiUw//VhezYLeCt4lAvdb30JLSMMOaZBavHbln1mK/xMpu+ky/d1zCo80z9Fyy
Lm+yZONfiHHw15XReRIHIJ7dILPvXkpC7hYPLgOAE6/6LxqrQhg4T2dbObDy4W7R
R30GnpV52BWP74QVdkCuU95Jn/R/jqknJPWJnYnvsyrktIWA3JoY6zQIJUYRfw32
s3Q4SgC5Id4PNsj4f3LTj2WujnKRcKdIWgy/Zwv47ol8toh4NpF7PA5+QTE7ZbKE
vT6r84IUGlW2JQ7q5Bi3N3+jrKSkb5rKLoW8SLvnE3fIfV7vTcN0dNimuIbUXUXk
ECiVQT5VWihdPpgB5mmqztSTxIHiajCgL9KiAiSpZC/zbfsBlEyKKqriiyILNTLM
2DMtJeXEAxi5FUoAcc6aHoHPps0uhkOEVoGHq5uhTR9yfvYJU7ufMninFoCtMNQD
uYOq5BYjuot2phjR3/xjJGvxFHSQk3+s7UW37fCs0eIQeeHwBb1PqV7VBn8+cHfN
S76O3F3yG3EZ5/Y9f9hmuG2c716COIKXtgAgmUEN4WT490aumClhirfE/Ck4919h
C8/2tKcF91k4Z1e2dXuXeuPn6B/ljnC63dVIK5ucwzh+qSfzdGmrEADDp6xqgH/T
3irqqT14TL9rha8ywoTt0tfurr87juq7Dcson1BPcrZl9669FWQ=
=Sbi6
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
