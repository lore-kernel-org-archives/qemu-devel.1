Received: from eggs.gnu.org ([2001:4830:134:3::10]:43750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hWV-0004gb-CT
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:19:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0hWU-0003CS-8g
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 01:19:39 -0400
Date: Sat, 7 Oct 2017 16:19:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171007051925.GJ10050@umbus.fritz.box>
References: <150730254473.16260.6484345241358746630.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aznLbwQ42o7LEaqN"
Content-Disposition: inline
In-Reply-To: <150730254473.16260.6484345241358746630.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fail gracefully with
 non-pseries machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--aznLbwQ42o7LEaqN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 05:09:04PM +0200, Greg Kurz wrote:
> QEMU currently crashes when the user tries to add a spapr-pci-host-bridge
> on a non-pseries machine:
>=20
> $ qemu-system-ppc64 -M ppce500 -device spapr-pci-host-bridge,index=3D1
> hw/ppc/spapr_pci.c:1535:spapr_phb_realize:
> Object 0x1003dacae60 is not an instance of type spapr-machine
> Aborted (core dumped)
>=20
> The same thing happens with the deprecated but still available child type
> spapr-pci-vfio-host-bridge.
>=20
> Fix both by checking the machine type with object_dynamic_cast().
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



> ---
>  hw/ppc/spapr_pci.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5049ced4e8b4..9e85106f51f8 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1507,7 +1507,7 @@ static void spapr_pci_unplug_request(HotplugHandler=
 *plug_handler,
> =20
>  static void spapr_phb_realize(DeviceState *dev, Error **errp)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    sPAPRMachineState *spapr;
>      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> @@ -1519,6 +1519,12 @@ static void spapr_phb_realize(DeviceState *dev, Er=
ror **errp)
>      const unsigned windows_supported =3D
>          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> =20
> +    spapr =3D (sPAPRMachineState *) qdev_get_machine();
> +    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
> +        error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries ma=
chine");
> +        return;
> +    }

This is slightly clunky.  You could instead use OBJECT_CHECK in the
initializer, then just if (!spapr) here.

> +
>      if (sphb->index !=3D (uint32_t)-1) {
>          sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>          Error *local_err =3D NULL;
>=20


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aznLbwQ42o7LEaqN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnYY90ACgkQbDjKyiDZ
s5LFBw/5AWMUKCIIhs2GMZhm6Wl/Wie9VIG7W1AfUMPCKZVy7xte2yi53Ry2UdVL
M/dKcu0uGUFrYbwwN2PJ5qyJKTK4jKFphoR23xgR9ETfZlobRMigMXw1KFc1qmmQ
ne8OzgoXje6o4ozA7xZWJFhLhKzXEfsZ7hY9zmI44Zj6o5PKOgTf+KBC9B/nKCo6
d13lhDh/IKFDF+N9zWq0j2muGDSjevCDuf3z4nRz56LEyzxSw5S44cPzGtWEAXh+
UAHbLs0TNayrsln80hhwXb3npjc4yF+eI2PwRhJaCH7J5NDZjpFGfhqrUG6KFpGC
tI9Bnthxpcq4ZGb2x2EAsLgCGvpYDglW+TfK/rEivJm3tvyxqHDOTc9ItFpmQA/h
ugjrgIpk53obzrmCW84mORfFuLvMKSnZ/XXvZd90o38247zrCKRjSy79c5PzLMXm
wv208GJ9mkHgm6lRGfFK+GtbrwjtjBGhMuuVSOkAD6/At6MZZmXn8XOTlP3Wyihx
/z3UXa/Klfd1mHhSE0KFRS+kAzfDkx1nw3MKYSPr/NKvPOUlRb4MYXxX7j7rfWaW
pzMaAm2k20dieIofSxEYdkd69n+DTNMQNACloJ+otsniH2vq4YuEcP/OD3kfT/bf
rAkI9KB7Zp5stggpLBggKf2ZAddmza4rTaozkJn6KtcBdLTPs5c=
=B94X
-----END PGP SIGNATURE-----

--aznLbwQ42o7LEaqN--
