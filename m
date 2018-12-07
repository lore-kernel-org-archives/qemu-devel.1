Received: from eggs.gnu.org ([2001:4830:134:3::10]:35760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7BK-0001iG-Di
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 22:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gV7BF-0004pR-A4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 22:52:02 -0500
Date: Fri, 7 Dec 2018 14:46:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181207034649.GA10945@umbus.fritz.box>
References: <20181205232251.10446-1-clg@kaod.org>
	<20181205232251.10446-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20181205232251.10446-12-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v6 11/37] spapr/xive: use the VCPU id as a
 NVT identifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 12:22:25AM +0100, C=E9dric Le Goater wrote:
> The IVPE scans the O/S CAM line of the XIVE thread interrupt contexts
> to find a matching Notification Virtual Target (NVT) among the NVTs
> dispatched on the HW processor threads.
>=20
> On a real system, the thread interrupt contexts are updated by the
> hypervisor when a Virtual Processor is scheduled to run on a HW
> thread. Under QEMU, the model will emulate the same behavior by
> hardwiring the NVT identifier in the thread context registers at
> reset.
>=20
> The NVT identifier used by the sPAPRXive model is the VCPU id. The END
> identifier is also derived from the VCPU id. A set of helpers doing
> the conversion between identifiers are provided for the hcalls
> configuring the sources and the ENDs.
>=20
> The model does not need a NVT table but The XiveRouter NVT operations
> are provided to perform some extra checks in the routing algorithm.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index eef5830d45c6..8da7a8bee949 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -26,6 +26,27 @@
>  #define SPAPR_XIVE_VC_BASE   0x0006010000000000ull
>  #define SPAPR_XIVE_TM_BASE   0x0006030203180000ull
> =20
> +/*
> + * The allocation of VP blocks is a complex operation in OPAL and the
> + * VP identifiers have a relation with the number of HW chips, the
> + * size of the VP blocks, VP grouping, etc. The QEMU sPAPR XIVE
> + * controller model does not have the same constraints and can use a
> + * simple mapping scheme of the CPU vcpu_id
> + *
> + * These identifiers are never returned to the OS.
> + */
> +
> +#define SPAPR_XIVE_NVT_BASE 0x400
> +
> +/*
> + * sPAPR NVT and END indexing helpers
> + */
> +static uint32_t spapr_xive_nvt_to_target(sPAPRXive *xive, uint8_t nvt_bl=
k,
> +                                  uint32_t nvt_idx)
> +{
> +    return nvt_idx - SPAPR_XIVE_NVT_BASE;
> +}
> +
>  /*
>   * On sPAPR machines, use a simplified output for the XIVE END
>   * structure dumping only the information related to the OS EQ.
> @@ -40,7 +61,8 @@ static void spapr_xive_end_pic_print_info(sPAPRXive *xi=
ve, XiveEND *end,
>      uint32_t nvt =3D GETFIELD_BE32(END_W6_NVT_INDEX, end->w6);
>      uint8_t priority =3D GETFIELD_BE32(END_W7_F0_PRIORITY, end->w7);
> =20
> -    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d", nvt,
> +    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d",
> +                   spapr_xive_nvt_to_target(xive, 0, nvt),
>                     priority, qindex, qentries, qgen);
> =20
>      xive_end_queue_pic_print_info(end, 6, mon);
> @@ -246,6 +268,33 @@ static int spapr_xive_write_end(XiveRouter *xrtr, ui=
nt8_t end_blk,
>      return 0;
>  }
> =20
> +static int spapr_xive_get_nvt(XiveRouter *xrtr,
> +                              uint8_t nvt_blk, uint32_t nvt_idx, XiveNVT=
 *nvt)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(xrtr);
> +    uint32_t vcpu_id =3D spapr_xive_nvt_to_target(xive, nvt_blk, nvt_idx=
);
> +    PowerPCCPU *cpu =3D spapr_find_cpu(vcpu_id);
> +
> +    if (!cpu) {
> +        return -1;
> +    }
> +
> +    /*
> +     * sPAPR does not maintain a NVT table. Return that the NVT is
> +     * valid if we have found a matching CPU
> +     */
> +    nvt->w0 =3D cpu_to_be32(NVT_W0_VALID);
> +    return 0;
> +}
> +
> +static int spapr_xive_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk,
> +                                uint32_t nvt_idx, XiveNVT *nvt,
> +                                uint8_t word_number)
> +{
> +    /* no NVT table */
> +    return 0;

Should this ever get called.  IIUC, we don't need to write back to the
NVTs because the papr machine should never hit a non-scheduled NVT.
But in that case should this actually be a no-op, or should it be an
g_assert_not_reached()?

> +}
> +
>  static const VMStateDescription vmstate_spapr_xive_end =3D {
>      .name =3D TYPE_SPAPR_XIVE "/end",
>      .version_id =3D 1,
> @@ -308,6 +357,8 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
>      xrc->get_eas =3D spapr_xive_get_eas;
>      xrc->get_end =3D spapr_xive_get_end;
>      xrc->write_end =3D spapr_xive_write_end;
> +    xrc->get_nvt =3D spapr_xive_get_nvt;
> +    xrc->write_nvt =3D spapr_xive_write_nvt;
>  }
> =20
>  static const TypeInfo spapr_xive_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwJ7SQACgkQbDjKyiDZ
s5JJnhAA3jOFgTQak85bkL3EgsqN0b23mYiXIGdgeqPEXYXuEy9XO/0eqht8cJQp
ft63Y72wZLHO+blMdbFhcYkG7BbKLjBAR0xm+f/JLYg6lOmlEyZd5SbFrEXjTYqV
wkm19B7tJ9q0hXjSqyy22cKFacYdtTQxTHW/JM1/q6w4DHVNeKMEftEdK7qSJ6gq
6IZk+pua6eZrSnPtu24y4SCrSQJI5+umCP5kvlddKXheAbMJyuxxcg4RLpyBmGXd
gNYQOH6z8rvZJY7ciKRjNopQbdXQXsyFzed22DFG7Lqhmyorvb1gc5xF/pcFhqD3
1REb4lW4jCZUhzKnTUv2dnqJhpOWS2F7iipWv6kvTfXi7aUTpmVBX54aGrgeSNhs
Ik5+SGgNlQb4XwvzTtHv4JpswpS7VP5pX1oe3whpbjplqFpUUamC+rtpBSpQcPX6
9Iq4loZNMKlMAzZq/0/IAa5akEwYFFwI2IlN5j1I5rabME7ZajFg/PqMiOFoafGi
H6mVYabhv+P0w07VBPYq3BbJEWR03Y5jmqrq4JTmelUZgYnALdpQsEx/mP4XwU5s
X+lMKR5r5/KQCXv8rxUTvuVP5xm/4xcLgaVCjJhY3YKVSquOGwDHgKe11pwCro0x
pl0vUJM3QoBiB06PbrySgV31lJVZyeFEUqdWZ5wcRlVec4o4tWo=
=+zRk
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
