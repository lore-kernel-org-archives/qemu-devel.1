Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhE-0006fy-9g
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybx-00076I-Rw
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:51 -0400
Date: Tue, 23 Oct 2018 16:27:23 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152723.GY12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-46-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PxDrs/Fpf4pPiewX"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-46-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 45/45] numa: Clean up error reporting in
 parse_numa()
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


--PxDrs/Fpf4pPiewX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:22PM -0300, Eduardo Habkost wrote:
> From: Markus Armbruster <armbru@redhat.com>
>=20
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  parse_numa() does that, and then fails without setting
> an error.  Its caller main(), via qemu_opts_foreach(), is fine with
> it, but clean it up anyway.
>=20
> While there, give parse_numa() internal linkage.
>=20
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <20181008173125.19678-26-armbru@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/sysemu/numa.h | 1 -
>  numa.c                | 8 +++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
> index 7a0ae751aa..21713b7e2f 100644
> --- a/include/sysemu/numa.h
> +++ b/include/sysemu/numa.h
> @@ -22,7 +22,6 @@ struct NumaNodeMem {
>  };
> =20
>  extern NodeInfo numa_info[MAX_NODES];
> -int parse_numa(void *opaque, QemuOpts *opts, Error **errp);
>  void parse_numa_opts(MachineState *ms);
>  void numa_complete_configuration(MachineState *ms);
>  void query_numa_node_mem(NumaNodeMem node_mem[]);
> diff --git a/numa.c b/numa.c
> index 1d7c49ad43..50ec016013 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -215,7 +215,7 @@ end:
>      error_propagate(errp, err);
>  }
> =20
> -int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
> +static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>  {
>      NumaOptions *object =3D NULL;
>      MachineState *ms =3D MACHINE(opaque);
> @@ -239,7 +239,7 @@ int parse_numa(void *opaque, QemuOpts *opts, Error **=
errp)
>  end:
>      qapi_free_NumaOptions(object);
>      if (err) {
> -        error_report_err(err);
> +        error_propagate(errp, err);
>          return -1;
>      }
> =20
> @@ -444,9 +444,7 @@ void numa_complete_configuration(MachineState *ms)
> =20
>  void parse_numa_opts(MachineState *ms)
>  {
> -    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL))=
 {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, &error_fat=
al);
>  }
> =20
>  void qmp_set_numa_node(NumaOptions *cmd, Error **errp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PxDrs/Fpf4pPiewX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPdsACgkQbDjKyiDZ
s5IY1w/3YTnxWHRx5ccKEb+uu2vnMVPNEVHA02E5QbkE5mQoLmOSDj1j6m567WIG
nI4UcdjRXYM249ZfYQSPlPPzBUtWx5EF0MSal7rriBe9aYD1eVkgJKHqCGykQIiy
MJXNGZJK3B/JJrEAkalfNUWb3H7KLexraAwwWwHJ0P9X/00Yv0ke6VrUyXo7LkD9
DWPS7DYIBdvSzybPN2Aw+GBF8onsiEhOdJsaaz/1xVaeQ+nishSN6M1Vl+8/180r
+Sle7HJHcf0mVB6pI1zAbk353E8Jl1q/faDvYeyh+GGu663Il2c5iRHYpDrndtEn
H0Y6N24eW5APDZKbZ/UV0tOxgYxxG2QvOz4fLLD6WjEP1XzmeCqUZhCACh2/loLz
cWVYjTnhxidPcWxSi52MmvYxRQ9tUjW4cmkzNMS2BRkPjqTKkAKmByezXTpoOaHm
6FiEACjrwcuY12mh5HFyD89McbVEGDw6S3PErn9kN6YzOaAzKTeO7HHJY/0PjHcD
4yqRL4bQY59J/DD8+lUeeiPWunWQw/2CS68Gw1e6EP+t2ucxDPyAa4cRC09FcNev
Mg2CwdCGKZHPIq1akSZ5vB5LGyFtM2HmUNntD7ntTlHBwE4A/zfEfkVR/i8SAXSs
dv/5LKCruK8o425kz7hPlmzUKqi9xD7dSsxB2vgQ2bGpovudKw==
=LZFT
-----END PGP SIGNATURE-----

--PxDrs/Fpf4pPiewX--
