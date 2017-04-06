Received: from eggs.gnu.org ([2001:4830:134:3::10]:44075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cw1iR-0001oR-NB
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cw1iQ-0006ly-63
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 03:20:23 -0400
Date: Thu, 6 Apr 2017 15:36:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170406053639.GD12179@umbus>
References: <1491396106-26376-1-git-send-email-clg@kaod.org>
	<1491396106-26376-9-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cQXOx3fnlpmgJsTP"
Content-Disposition: inline
In-Reply-To: <1491396106-26376-9-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 08/21] ipmi: introduce an
 ipmi_bmc_sdr_find() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>


--cQXOx3fnlpmgJsTP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2017 at 02:41:33PM +0200, C=E9dric Le Goater wrote:
> This patch exposes a new IPMI routine to query a sdr entry from the
> sdr table maintained by the IPMI BMC simulator. The API is very
> similar to the internal sdr_find_entry() routine and should be used
> the same way to query one or all sdrs.
>=20
> A typical use would be to loop on the sdrs to build nodes of a device
> tree.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Acked-by: Corey Minyard <cminyard@mvista.com>

I don't know much about IPMI, but since it has Corey's ack, I've
staged 5..8/21 in my for-2.10 tree.  9 I've left for now, since Corey
has comments.

> ---
>  hw/ipmi/ipmi_bmc_sim.c | 16 ++++++++++++++++
>  include/hw/ipmi/ipmi.h |  2 ++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index eae7b2d8c92b..8185a84b76b9 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -416,6 +416,22 @@ static int sdr_find_entry(IPMISdr *sdr, uint16_t rec=
id,
>      return 1;
>  }
> =20
> +int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
> +                      const struct ipmi_sdr_compact **sdr, uint16_t *nex=
trec)
> +
> +{
> +    IPMIBmcSim *ibs =3D IPMI_BMC_SIMULATOR(b);
> +    unsigned int pos;
> +
> +    pos =3D 0;
> +    if (sdr_find_entry(&ibs->sdr, recid, &pos, nextrec)) {
> +        return -1;
> +    }
> +
> +    *sdr =3D (const struct ipmi_sdr_compact *) &ibs->sdr.sdr[pos];
> +    return 0;
> +}
> +
>  static void sel_inc_reservation(IPMISel *sel)
>  {
>      sel->reservation++;
> diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> index 91b83b5bb0b6..0d36cfc6b7f3 100644
> --- a/include/hw/ipmi/ipmi.h
> +++ b/include/hw/ipmi/ipmi.h
> @@ -259,4 +259,6 @@ struct ipmi_sdr_compact {
> =20
>  typedef uint8_t ipmi_sdr_compact_buffer[sizeof(struct ipmi_sdr_compact)];
> =20
> +int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
> +                      const struct ipmi_sdr_compact **sdr, uint16_t *nex=
trec);
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cQXOx3fnlpmgJsTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY5dPlAAoJEGw4ysog2bOSDQMP/0PvY3Z+XFUtg2ZRF8MuAVUx
OK3zpNwYEkmXFZdZG6AV+NICcJ5QwvpbWpyKPIFbF9bo1UU72iORTQDn95sUmV/x
qiNM5UbIs9MYDXbZi9MdFNnsRtJUubIAysgCp6gPoYzPK9J8Zq/92Snlq+ErJ1mp
8o1JdbhPSYx8bjkiChDC+UoGQLEoubs4PXy3hP7NiKnXgUwZZoK1lx3udJRsZ9pX
gH5aKXyNHqAK18XSesUjs1kgE+mTF4F86zxqSQ+00IO5+mUQkaE52b4bOQfp7gIq
cYFPrKIhQH2vEuQWh37TtNx8zbGKQ1EkzsvVG7PzypfsSpAfVHiNwvvrJSdnud/N
F7vN7iHXHMQkddi5Etff90Sj7pNEZEICQaMegUkFgmLkavmG5ch37faxeUix57M2
z8vHw7aGDWeQ424IWswc9x9u94gXl4njb556Q9nc8mlUG5E85W4vcXpN4r+/xChn
FkvK6+A80mI8NYWO8kqGiecJezhRtdDOSuTFrkeMQmB1fnPFzp0x4g4vbzJeBj7l
9NU6jZRjHMA3Id3P2408+9TiACs+505p1Qlc7m6YwPNf+gEXDa00NTTjuFJJZkvM
7xAFxgLjTwp5ZHQh43nGENhBpsJgRwJ4E0UUAXri+RLwR3f07Qu4u8+Be8EpdanC
eRhFe2QmOXIc7LAKH/Vy
=59o7
-----END PGP SIGNATURE-----

--cQXOx3fnlpmgJsTP--
