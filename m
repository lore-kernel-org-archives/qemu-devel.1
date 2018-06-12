Received: from eggs.gnu.org ([2001:4830:134:3::10]:40831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYQn-00047e-Ty
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSYQm-0003QZ-C2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 21:49:09 -0400
Date: Tue, 12 Jun 2018 11:48:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180612014859.GS2737@umbus.fritz.box>
References: <20180611121655.19616-1-david@redhat.com>
	<20180611121655.19616-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3sseE1tnmEs+TkKq"
Content-Disposition: inline
In-Reply-To: <20180611121655.19616-11-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 10/11] pc-dimm: introduce and use
 pc_dimm_memory_pre_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Alexander Graf <agraf@suse.de>


--3sseE1tnmEs+TkKq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 02:16:54PM +0200, David Hildenbrand wrote:
> We'll be factoring out some pc-dimm specific and some memory-device
> checks next.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

ppc parts
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/pc.c             | 2 ++
>  hw/mem/pc-dimm.c         | 5 +++++
>  hw/ppc/spapr.c           | 1 +
>  include/hw/mem/pc-dimm.h | 2 ++
>  4 files changed, 10 insertions(+)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 017396fe84..dc8e7b033b 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1695,6 +1695,8 @@ static void pc_dimm_pre_plug(HotplugHandler *hotplu=
g_dev, DeviceState *dev,
>          error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M=
'");
>          return;
>      }
> +
> +    pc_dimm_memory_pre_plug(dev, MACHINE(hotplug_dev), errp);
>  }
> =20
>  static void pc_dimm_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index bc79dd04d8..995ce22d8d 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -27,6 +27,11 @@
>  #include "sysemu/numa.h"
>  #include "trace.h"
> =20
> +void pc_dimm_memory_pre_plug(DeviceState *dev, MachineState *machine,
> +                             Error **errp)
> +{
> +}
> +
>  void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
>                           uint64_t align, Error **errp)
>  {
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 214286fd2f..54eddc0069 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3202,6 +3202,7 @@ static void spapr_memory_pre_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
>          goto out;
>      }
> =20
> +    pc_dimm_memory_pre_plug(dev, MACHINE(hotplug_dev), errp);
>  out:
>      g_free(mem_dev);
>  }
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index f0e6867803..7d46a0a0cb 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -80,6 +80,8 @@ typedef struct PCDIMMDeviceClass {
> =20
>  int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
> =20
> +void pc_dimm_memory_pre_plug(DeviceState *dev, MachineState *machine,
> +                             Error **errp);
>  void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
>                           uint64_t align, Error **errp);
>  void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3sseE1tnmEs+TkKq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfJosACgkQbDjKyiDZ
s5Jx6RAAxZcm/3a4YaplLgfg08EluCcEyDgneTXHc4bi+U8izPC7vVVtDHYWZsMs
Sh/xGxCFJXrCIz+bazcKC4KeccPEzZHKmxtjH1kT88RknxRvDDzTu2N5rnPHoy/X
VGBI0sE5/skk26vVd5FO4Xd+BMUIuqqamB0SASEXoc85loTtIYSFDangmOMBmT4L
RVDXfhVq+PMx3vKx8qx/JSGwUxkKJSFYerpcq0YudxTD1dqiLQu7C6mG7Md1Lptu
85BRwTOy695mJ38vod9CCfnAU58MH3wf0aJZg3WV+NYVrDygPOgLjeULbLbelmgs
UxF6XnNbK0DqyQW7dMWk4k98mA0hVWH0m9WnSiJKYDd7coP82/sT4oaXGvDg9HjA
JBOHh2o1TxIiF/LkPL+M/qBEauARA0/MWsVaVtmSGjpZU16WIu+jEXgjHX8p3JGS
huLrT53zZvO8Gg0yrxp4w3GfguNLTYmVe0mbmqrx4xPPpkTblEz1p8bxSZvDNeUl
9bT6Xyt9Ywl5EFfp8FKvJEFPHsk33XI0tBOBPq8IfCfH4bhK/jsgGORmr4vy81WV
VF/2PU7GVCnKHyvDUtsS4WNQ1WGWi8xq6OsmXFBNTdbSgf4hnTdH4ynzJzdrce08
49a6T3l3rh3vVioBVN6JBADEa7W+qJyUFggIPwHo2jjBqzb3dV0=
=+ED0
-----END PGP SIGNATURE-----

--3sseE1tnmEs+TkKq--
