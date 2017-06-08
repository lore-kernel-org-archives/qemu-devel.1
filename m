Received: from eggs.gnu.org ([2001:4830:134:3::10]:58991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIp4w-0001Zs-Pi
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIp4s-0002uY-SM
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:29:50 -0400
Date: Thu, 8 Jun 2017 14:14:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608041408.GX13397@umbus.fritz.box>
References: <1496823627-17609-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VnCKLxguT6BBzdXa"
Content-Disposition: inline
In-Reply-To: <1496823627-17609-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Adjust firmware name for PCI
 bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, abologna@redhat.com


--VnCKLxguT6BBzdXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 10:20:27AM +0200, Thomas Huth wrote:
> SLOF uses "pci" as name for PCI bridges nodes in the device tree instead
> of "pci-bridges", so booting via bootindex from a device behind a PCI
> bridge currently does not work since QEMU passes the wrong name in the
> "qemu,boot-list" property. Fix it by changing the name of the PCI bridge
> nodes to "pci" instead.
>=20
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1459170
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.10.

> ---
>  hw/ppc/spapr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 91b4057..27b1f3c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2441,6 +2441,12 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>          return g_strdup_printf("disk@%"PRIX64, (uint64_t)id << 32);
>      }
> =20
> +    if (g_str_equal("pci-bridge", qdev_fw_name(dev))) {
> +        /* SLOF uses "pci" instead of "pci-bridge" for PCI bridges */
> +        PCIDevice *pcidev =3D CAST(PCIDevice, dev, TYPE_PCI_DEVICE);
> +        return g_strdup_printf("pci@%x", PCI_SLOT(pcidev->devfn));
> +    }
> +
>      return NULL;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VnCKLxguT6BBzdXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOM8QAAoJEGw4ysog2bOSmrkP/30YtJCI7DTVAAbx1/m/GM81
ibYy0UzJRCSJWF+T1lByUGCJ+65qUsDd73s6dgHEyy6AqKVVE6ziZlhpSkC/POOS
cY8JXpdCUYoPLXsKBU7gyG4GZRVSF5qbzcxTF4HkOAjippjm8udPfTWu1AsR8C+G
N3UQUupL0ma7jAboiP1pPh75Q7Mk7F8TRj8aPG7waUfLK8SoZdbFbeWi15HfI0kx
It6xqWNAdeFLVW1WpizpGByYCOfUSrrddO9l+KdPkbJUesRiWVI9QTPuXXNSJ85q
4OyCiS9zQ39EdumVB5lD5INXMt1EcDIFMOa+30pdap1Be+gB5VBm4Qdr5VBEygds
fbPQLtA4FewulroQjWawCazvZNfr8wLrjojTtLa18mOkO2W+7ZURfOXqdaexyQgI
VMKBFCnYWYGfE3cekY4p8qAGe2481GxfEQ9zKz0B2uy3qSTM4WdxVZPaY6BYNvDt
uc4mceiDIjJRm3XeDMS2NNBaeBYZrb0MkDqsKp1gk/JEmaXDxn/fTky/tialP+cn
kIrcZL22l6qkAiBwadF8Zy8Qd7kzmvLUD3uIe8enIgf68zUrqiPL81L5ZIHONIq0
wkG2oxbyS/K13qEde4UUQ3xRXI4ovxGuKySnd98h5gCZZMRJ+kxVHJan6PYSH1ah
+XKNENJgh8/fDRATN2V5
=WflA
-----END PGP SIGNATURE-----

--VnCKLxguT6BBzdXa--
