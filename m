Received: from eggs.gnu.org ([2001:4830:134:3::10]:52426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1pj-0001Bm-Ga
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI1pf-00038C-Ki
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 19:54:51 -0400
Date: Tue, 6 Jun 2017 09:19:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170605231958.GC13397@umbus.fritz.box>
References: <1496678118-27350-1-git-send-email-felipe@nutanix.com>
	<1496678118-27350-2-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RyB1I56Pcq42iZjE"
Content-Disposition: inline
In-Reply-To: <1496678118-27350-2-git-send-email-felipe@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: Allow boot from vhost-*-scsi
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Mike Cui <cui@nutanix.com>


--RyB1I56Pcq42iZjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 04:55:18PM +0100, Felipe Franciosi wrote:
> The current implementation of spapr_get_fw_dev_path() doesn't take into
> consideration vhost-*-scsi devices. This makes said devices unbootable
> on PPC as SLOF is unable to work out the path to scan boot disks.
>=20
> This makes VMs bootable on spapr when using vhost-*-scsi by implementing
> a disk path for VHostSCSICommon (which currently includes both
> vhost-user-scsi and vhost-scsi).
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Mike Cui <cui@nutanix.com>

Applied to ppc-for-2.10, thanks.

> ---
>  hw/ppc/spapr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ab3aab1..1c87886 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -57,6 +57,7 @@
>  #include "hw/pci/pci.h"
>  #include "hw/scsi/scsi.h"
>  #include "hw/virtio/virtio-scsi.h"
> +#include "hw/virtio/vhost-scsi-common.h"
> =20
>  #include "exec/address-spaces.h"
>  #include "hw/usb.h"
> @@ -2388,6 +2389,7 @@ static char *spapr_get_fw_dev_path(FWPathProvider *=
p, BusState *bus,
>      ((type *)object_dynamic_cast(OBJECT(obj), (name)))
>      SCSIDevice *d =3D CAST(SCSIDevice,  dev, TYPE_SCSI_DEVICE);
>      sPAPRPHBState *phb =3D CAST(sPAPRPHBState, dev, TYPE_SPAPR_PCI_HOST_=
BRIDGE);
> +    VHostSCSICommon *vsc =3D CAST(VHostSCSICommon, dev, TYPE_VHOST_SCSI_=
COMMON);
> =20
>      if (d) {
>          void *spapr =3D CAST(void, bus->parent, "spapr-vscsi");
> @@ -2444,6 +2446,12 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>          return g_strdup_printf("pci@%"PRIX64, phb->buid);
>      }
> =20
> +    if (vsc) {
> +        /* Same logic as virtio above */
> +        unsigned id =3D 0x1000000 | (vsc->target << 16) | vsc->lun;
> +        return g_strdup_printf("disk@%"PRIX64, (uint64_t)id << 32);
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

--RyB1I56Pcq42iZjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZNeceAAoJEGw4ysog2bOSNVsP/jKUosNJdQy+tyfcfBRX87fU
gi8mqgmQDKsecAOQMKI965oT2tq6xoSsdhf2dOXtzbyrBxkXDx2+dWbaJhkd+Cx6
SuOUC73EOZQK9tUoyMCbC6glJOrhZtIiuLyTr5UbYbKRsQDxeWwangq+IX6s3ajR
JA3X2ENLsNZMIeOxuvNeLteJtK0pHlzyz+4YyyqnQi3RlnQAo09fi+io5Ziyv/nw
++LiPgZD/gdnZYenM3TrAuaXbjMry3dXLJThfnpi4k0tuo8PUBjy6XSuAnZCtZwD
85HZXOWmGW2IVumG2Z5uAPBAoDReaA3eLTHn8g2ed+MMwlmqhIHB2XfaJxxUiNv6
8cVE+OH/wybvej8/Zv8JtvNZq8ysP/oyNgV3zURvG4sGsHnlPhPCei+vU6qE/Ckf
tw8KWaKRUV0S4ApeByFfEclQTuAmpEgloE9ia5aSlW0HUIa7Z+qExMVNVcEBXQIn
kQPY9bGTLPlDvH6vqjzxMIU7wppjHb7jFh93ARkTRUHg855oGVuRO3+apaYY/1rk
xuwck3mfZBTyJ1fQPLm1lKcefBKkO2wdEJN2B7es3tBdjHLv/PXMGzeA3i+YqrmP
OQBrzwjlAptP0mUuyl9ZG4JmoO/Cm9rTd2DXQpafmuZ3dnh/8SbWRl/w9K4iJaHJ
uPt/5JT5lKWFZweXPoA6
=QUZS
-----END PGP SIGNATURE-----

--RyB1I56Pcq42iZjE--
