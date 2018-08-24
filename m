Received: from eggs.gnu.org ([2001:4830:134:3::10]:46064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ftFOv-0007NZ-0K
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ftFBv-0001W2-V7
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:44:11 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:48872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ftFBv-0001Up-ML
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 12:44:07 -0400
Received: from player695.ha.ovh.net (unknown [10.109.143.183])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6347DE8C81
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 18:44:06 +0200 (CEST)
References: <153512460418.276612.14744411474887601809.stgit@bahia>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <aa0cef01-b6c9-9710-a56f-bd50a580d354@kaod.org>
Date: Fri, 24 Aug 2018 18:44:00 +0200
MIME-Version: 1.0
In-Reply-To: <153512460418.276612.14744411474887601809.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fix potential NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 08/24/2018 05:30 PM, Greg Kurz wrote:
> Commit 2c88b098e76fd added a call to SPAPR_MACHINE_GET_CLASS(spapr) in
> spapr_phb_realize() before we check spapr isn't NULL. This causes QEMU
> to crash when starting a non-pseries machine with a sPAPR PHB.
>=20
> This could be fixed by setting the smc variable after the null check,
> but it seems more explicit to use a ternary operator to skip the call
> to SPAPR_MACHINE_GET_CLASS() if spapr is NULL, since spapr_phb_realize(=
)
> will return immediately in this case.
>=20
> This was reported by Coverity (CID 1395170 and 1395183).
>=20
> Fixes: 2c88b098e76fde0c7fcc0476dd3f80ce58409505
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/spapr_pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 5cd676e4430d..6bcb4f419b6b 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1559,7 +1559,7 @@ static void spapr_phb_realize(DeviceState *dev, E=
rror **errp)
>      sPAPRMachineState *spapr =3D
>          (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
>                                                    TYPE_SPAPR_MACHINE);
> -    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> +    sPAPRMachineClass *smc =3D spapr ? SPAPR_MACHINE_GET_CLASS(spapr) =
: NULL;
>      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
>=20
