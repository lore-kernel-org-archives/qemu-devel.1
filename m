Received: from eggs.gnu.org ([2001:4830:134:3::10]:58811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6K7s-0006Hd-06
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6K7r-0001DW-2C
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:01:12 -0400
Date: Fri, 5 May 2017 02:51:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170504165109.GI14413@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-10-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a7XSrSxqzVsaECgU"
Content-Disposition: inline
In-Reply-To: <1493816238-33120-10-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/24] numa: add check that board
 supports cpu_index to node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--a7XSrSxqzVsaECgU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 02:57:03PM +0200, Igor Mammedov wrote:
> Default node mapping initialization already checks that board
> supports cpu_index to node mapping and refuses to start if
> it's not supported. Do the same for explicitly provided
> mapping "-numa node,cpus=3D..."
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Makes sense in the series at present, although it might be obsoleted
by other suggested changes.

> ---
>  numa.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/numa.c b/numa.c
> index ab1661d..b517870 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -140,10 +140,12 @@ uint32_t numa_get_node(ram_addr_t addr, Error **err=
p)
>      return -1;
>  }
> =20
> -static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error=
 **errp)
> +static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
> +                            QemuOpts *opts, Error **errp)
>  {
>      uint16_t nodenr;
>      uint16List *cpus =3D NULL;
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> =20
>      if (node->has_nodeid) {
>          nodenr =3D node->nodeid;
> @@ -162,6 +164,10 @@ static void numa_node_parse(NumaNodeOptions *node, Q=
emuOpts *opts, Error **errp)
>          return;
>      }
> =20
> +    if (!mc->cpu_index_to_instance_props) {
> +        error_report("CPUs to NUMA node mapping isn't supported");
> +        exit(1);
> +    }
>      for (cpus =3D node->cpus; cpus; cpus =3D cpus->next) {
>          if (cpus->value >=3D max_cpus) {
>              error_setg(errp,
> @@ -215,6 +221,7 @@ static void numa_node_parse(NumaNodeOptions *node, Qe=
muOpts *opts, Error **errp)
>  static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      NumaOptions *object =3D NULL;
> +    MachineState *ms =3D opaque;
>      Error *err =3D NULL;
> =20
>      {
> @@ -229,7 +236,7 @@ static int parse_numa(void *opaque, QemuOpts *opts, E=
rror **errp)
> =20
>      switch (object->type) {
>      case NUMA_OPTIONS_TYPE_NODE:
> -        numa_node_parse(&object->u.node, opts, &err);
> +        numa_node_parse(ms, &object->u.node, opts, &err);
>          if (err) {
>              goto end;
>          }
> @@ -303,7 +310,7 @@ void parse_numa_opts(MachineState *ms)
>          numa_info[i].node_cpu =3D bitmap_new(max_cpus);
>      }
> =20
> -    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, NULL, NULL=
)) {
> +    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL))=
 {
>          exit(1);
>      }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a7XSrSxqzVsaECgU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZC1v9AAoJEGw4ysog2bOSDrMP/22VwihVh0KTIlnv8rAWehGO
Hx4cNtxD3o3MzTBV3zUgiw99YGjS+fird4i/Gg41oOm97nBRAs+UYsrGpZ3In1Zz
5mHFTKgGtwJoeN4QxS1g1/ZubOt7gOqCQKRujofMykK4IkSBhML5F71Qg1NT6cEA
D/SdMv4I8QTzIFKdOtpmujnjCXwEBPwIwMo4+tx+NrOcRyPypeh+13JnZNBQmf6w
0pQpa6119Any6DpKYWlLHn7NQqiNXkV63EUFA2PRaujHffLzynAkCRNPlSh4Iitp
StnUyPEybVdsbwQ8tHCOyXVT15Bphk075dANmDbbeqfHhx8uNUb/OZ2seOSuRTUE
tFrUYhbylQVtfKXnBWjkBWChwatbj8P2fPBLksuq9ygboa+slYxvsFdE3zqb3qDd
Zy0a4qtZ/uKRgM8Zo0ZOi/TVT3tdwBk6mhMzev2Pul+JLcC9k7MCphB3ZWTlEkfE
JbOmAt/BQ9PQmId78sm0qKYLSndBmU/iAAbruNgIXl6zyRXHcBvflcZrhO7nGurI
mOvt+RjXnIs+4ObOHQnknT/peDH/eyblaCj67BC3EbPHdgCsYwBUUUCxx0jwpOlD
rl7rUqobVNch8GfQG82dD0wO5/zv9773qUkzm7hj6xC0rtSq73kxKlUdCN0GV3Ij
7B+6Fy7ZIKYI7PAPZG4Q
=IKki
-----END PGP SIGNATURE-----

--a7XSrSxqzVsaECgU--
