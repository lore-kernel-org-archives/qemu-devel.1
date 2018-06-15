Received: from eggs.gnu.org ([2001:4830:134:3::10]:46274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcIp-0003kj-KD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:09:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcIo-000058-Bg
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:09:19 -0400
Date: Fri, 15 Jun 2018 10:08:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615000829.GE4129@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901307192.252222.7502403316148525219.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <152901307192.252222.7502403316148525219.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 5/5] spapr_cpu_core: simplify
 spapr_cpu_core_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 11:51:11PM +0200, Greg Kurz wrote:
> There's no real reason to create all CPUs in a first pass and to realize
> them in a second pass. Merging these two loops makes the code simpler.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

I'm a bit uncertain about this one.  It's correct at the moment, but
I'm wondering if there might be things we want to do wile the cpu
objects are constructed, but not initialized.

In fact, I thought I wanted something like that for allowing earlier
initialization of the default caps values, though in the end I found a
simpler and better approach.

So, I'm holding off on this one for the time being.

> ---
>  hw/ppc/spapr_cpu_core.c |   25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 0ebaf804a9bc..f52af20e0096 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -172,7 +172,8 @@ error:
>      error_propagate(errp, local_err);
>  }
> =20
> -static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **er=
rp)
> +static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i,
> +                                     sPAPRMachineState *spapr, Error **e=
rrp)
>  {
>      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
>      CPUCore *cc =3D CPU_CORE(sc);
> @@ -201,9 +202,16 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *s=
c, int i, Error **errp)
>          goto err;
>      }
> =20
> +    spapr_realize_vcpu(cpu, spapr, &local_err);
> +    if (local_err) {
> +        goto err_unparent;
> +    }
> +
>      object_unref(obj);
>      return cpu;
> =20
> +err_unparent:
> +    object_unparent(obj);
>  err:
>      object_unref(obj);
>      error_propagate(errp, local_err);
> @@ -212,6 +220,7 @@ err:
> =20
>  static void spapr_delete_vcpu(PowerPCCPU *cpu)
>  {
> +    spapr_unrealize_vcpu(cpu);
>      object_unparent(OBJECT(cpu));
>  }
> =20
> @@ -226,7 +235,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, =
Error **errp)
>      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
>      Error *local_err =3D NULL;
> -    int i, j;
> +    int i;
> =20
>      if (!spapr) {
>          error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine");
> @@ -235,24 +244,14 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> =20
>      sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        sc->threads[i] =3D spapr_create_vcpu(sc, i, &local_err);
> +        sc->threads[i] =3D spapr_create_vcpu(sc, i, spapr, &local_err);
>          if (local_err) {
>              goto err;
>          }
>      }
> =20
> -    for (j =3D 0; j < cc->nr_threads; j++) {
> -        spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
> -        if (local_err) {
> -            goto err_unrealize;
> -        }
> -    }
>      return;
> =20
> -err_unrealize:
> -    while (--j >=3D 0) {
> -        spapr_unrealize_vcpu(sc->threads[i]);
> -    }
>  err:
>      while (--i >=3D 0) {
>          spapr_delete_vcpu(sc->threads[i]);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjA30ACgkQbDjKyiDZ
s5I74BAAliSDfmMqoNPovJoWdy8WojRmT9wxw8D1uMivxNlxZjV1S9r8zqP0EIQn
t0ZE5ezqDmYkuybRG2n4wQqSRIHQfOdzhXdJgEtO7T5q5/5mOoWW1oy9QY8rzz6x
MC0wT/fHPQkNg9qfdyUa2OScQm8NWyEca/TFgRPCTktHmKhUHmTLjqQTZxxDVAxQ
Hzu6yjfXVfAuvzZrc0Q+b2RUBVv5JBJMn+rbr+9XMlpGg/guHEz0+AatHuo3sw7l
3D9RVi5SfP+5GBdDyPThcicCd67d8BogV5srV6cS1lVVZn9CcFiwMXPQUbOgA70a
RcYge+VNo1Ba3gbczfzPKN+Q4pVyIcXExkm0gvL9YMFhl44LNVjLSIFnmo8Su7OG
0LdgU0Bv+m4gL7ciOCmo9AoW9NirdCKTKiEK8Z+QStHlriWvvUgY8ZmS6ZerdHq+
NKkgbTT3AWTLslQenl6A+ZDoj1Y4zU7NNUdgR8x/aKpEzG4H65f8gDeZRtDFtw2G
W5uBHc05cs4ppYOU5u1R341c2WDNgF+3/v8stAw0vX14J3bbjRy5KxVZiJvOn81k
AlERXyijEICKgNwkhR5HjEx7u98QvezkCR8JK3nz2B/zEA3L79SIO7cVvTwSxjQA
i5FqInDD3pV5HRlHeRz1UkKYwMdO0D9jd8JsiSdNXUEnqquFGS0=
=EKJ5
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
