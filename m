Received: from eggs.gnu.org ([2001:4830:134:3::10]:48447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGZ75-0005vX-PO
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 18:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGZ71-000702-PB
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 18:34:59 -0500
Date: Mon, 20 Nov 2017 10:12:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171119231251.GC19214@umbus.fritz.box>
References: <151092340873.11818.16813698420232981002.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <151092340873.11818.16813698420232981002.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH for-2.11] spapr: reset DRCs after devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-stable@nongnu.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2017 at 01:56:48PM +0100, Greg Kurz wrote:
> A DRC with a pending unplug request releases its associated device at
> machine reset time.
>=20
> In the case of LMB, when all DRCs for a DIMM device have been reset,
> the DIMM gets unplugged, causing guest memory to disappear. This may
> be very confusing for anything still using this memory.
>=20
> This is exactly what happens with vhost backends, and QEMU aborts
> with:
>=20
> qemu-system-ppc64: used ring relocated for ring 2
> qemu-system-ppc64: qemu/hw/virtio/vhost.c:649: vhost_commit: Assertion
>  `r >=3D 0' failed.
>=20
> The issue is that each DRC registers a QEMU reset handler, and we
> don't control the order in which these handlers are called (ie,
> a LMB DRC will unplug a DIMM before the virtio device using the
> memory on this DIMM could stop its vhost backend).
>=20
> To avoid such situations, let's reset DRCs after all devices
> have been reset.
>=20
> Reported-by: Mallesh N. Koti <mallesh@linux.vnet.ibm.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.  I'll be looking at preparing a pull request
today.

> ---
>  hw/ppc/spapr.c     |   21 +++++++++++++++++++++
>  hw/ppc/spapr_drc.c |    7 -------
>  2 files changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6841bd294b3c..6285f7211f9a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1411,6 +1411,19 @@ static void find_unknown_sysbus_device(SysBusDevic=
e *sbdev, void *opaque)
>      }
>  }
> =20
> +static int spapr_reset_drcs(Object *child, void *opaque)
> +{
> +    sPAPRDRConnector *drc =3D
> +        (sPAPRDRConnector *) object_dynamic_cast(child,
> +                                                 TYPE_SPAPR_DR_CONNECTOR=
);
> +
> +    if (drc) {
> +        spapr_drc_reset(drc);
> +    }
> +
> +    return 0;
> +}
> +
>  static void ppc_spapr_reset(void)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
> @@ -1434,6 +1447,14 @@ static void ppc_spapr_reset(void)
>      }
> =20
>      qemu_devices_reset();
> +
> +    /* DRC reset may cause a device to be unplugged. This will cause tro=
ubles
> +     * if this device is used by another device (eg, a running vhost bac=
kend
> +     * will crash QEMU if the DIMM holding the vring goes away). To avoi=
d such
> +     * situations, we reset DRCs after all devices have been reset.
> +     */
> +    object_child_foreach_recursive(object_get_root(), spapr_reset_drcs, =
NULL);
> +
>      spapr_clear_pending_events(spapr);
> =20
>      /*
> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
> index 915e9b51c40c..e3b122968e89 100644
> --- a/hw/ppc/spapr_drc.c
> +++ b/hw/ppc/spapr_drc.c
> @@ -455,11 +455,6 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
>      }
>  }
> =20
> -static void drc_reset(void *opaque)
> -{
> -    spapr_drc_reset(SPAPR_DR_CONNECTOR(opaque));
> -}
> -
>  bool spapr_drc_needed(void *opaque)
>  {
>      sPAPRDRConnector *drc =3D (sPAPRDRConnector *)opaque;
> @@ -518,7 +513,6 @@ static void realize(DeviceState *d, Error **errp)
>      }
>      vmstate_register(DEVICE(drc), spapr_drc_index(drc), &vmstate_spapr_d=
rc,
>                       drc);
> -    qemu_register_reset(drc_reset, drc);
>      trace_spapr_drc_realize_complete(spapr_drc_index(drc));
>  }
> =20
> @@ -529,7 +523,6 @@ static void unrealize(DeviceState *d, Error **errp)
>      gchar *name;
> =20
>      trace_spapr_drc_unrealize(spapr_drc_index(drc));
> -    qemu_unregister_reset(drc_reset, drc);
>      vmstate_unregister(DEVICE(drc), &vmstate_spapr_drc, drc);
>      root_container =3D container_get(object_get_root(), DRC_CONTAINER_PA=
TH);
>      name =3D g_strdup_printf("%x", spapr_drc_index(drc));
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloSD/IACgkQbDjKyiDZ
s5KO+g/9GB4n+gYaEp+rf7J/HcNOHuhlSpl/hIR15aAbzjbGYKQaaTTrcFZe854l
Hbtg5fzz+dg4rh36eSAaIPH27YpRtePoUf94WfuZrQ+3CZdzrliYLUuyfiYNejHk
B6prdIQq3en0yvK0nrEYBQOEy1yA1BB7YJHO0Suxtn1Jr6jPmeU8B7rDPQXVuHmX
qy70CYV7W9jkjSJYTNd5Y8Kze4vtsOkuBlQC5UzyNCfkVe7Wz3zgQk/8eHyNgmTq
k36v462xb3gFaDCLarFjtzE0y5zcuWJgpckZKV8rIoRNwqRskWVprBdohiPy2KoL
ieWUJPW+Ua3AcfDrRO7e5xb0SUA7FoFhZN3flP1QD/FkjKE2VlNC8BbQsS+rO5MG
c3U/zOpBg8ET+v4RmsTngkk2JFFloK+Ekr4ECm/lcDO6iZZM8vimIJ76qhB/SZys
iykfyXmcTjVF/CouAaoihoOd0r1rMRipNEYw2NvFBt4/TEo5tenJu+KERG+qeVJp
bnhjagtsRavFTD37VDMa0wDF9flHQhXd0vXAMqeTm3HVGcxAqnH1huh33rzNF0Pn
7KTOlRXgDEcGnWijmE8SjOLhLK7dwp0AA3M9wdocHL/eBvyR2KrtyA2CGfIv93PJ
1Qx4hvp5M7LqaQTIZ8oDH8sYS69gHtBWKX/bD72eFswTitSSaR4=
=ofor
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
