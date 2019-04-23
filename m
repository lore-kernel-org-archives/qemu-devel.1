Received: from eggs.gnu.org ([209.51.188.92]:38626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hIkup-00057f-Dg
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 22:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hIkum-0000mb-G9
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 22:12:11 -0400
Date: Tue, 23 Apr 2019 11:20:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190423012057.GA31496@umbus.fritz.box>
References: <20190422195020.1494-1-philmd@redhat.com>
	<20190422195020.1494-6-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20190422195020.1494-6-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hw/ppc: Implement
 fw_cfg_arch_key_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 09:50:18PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Implement fw_cfg_arch_key_name(), which returns the name of a
> ppc-specific key.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

What ppc machines actually use fw_cfg?  I know pseries and powernv
don't.

> ---
>  hw/ppc/Makefile.objs |  2 +-
>  hw/ppc/fw_cfg.c      | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 hw/ppc/fw_cfg.c
>=20
> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> index 1111b218a04..ae940981553 100644
> --- a/hw/ppc/Makefile.objs
> +++ b/hw/ppc/Makefile.objs
> @@ -1,5 +1,5 @@
>  # shared objects
> -obj-y +=3D ppc.o ppc_booke.o fdt.o
> +obj-y +=3D ppc.o ppc_booke.o fdt.o fw_cfg.o
>  # IBM pSeries (sPAPR)
>  obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_vio.o spapr_events=
=2Eo
>  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
> diff --git a/hw/ppc/fw_cfg.c b/hw/ppc/fw_cfg.c
> new file mode 100644
> index 00000000000..a88b5c4bde2
> --- /dev/null
> +++ b/hw/ppc/fw_cfg.c
> @@ -0,0 +1,45 @@
> +/*
> + * fw_cfg helpers (PPC specific)
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Author:
> + *   Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/ppc/ppc.h"
> +#include "hw/nvram/fw_cfg.h"
> +
> +const char *fw_cfg_arch_key_name(uint16_t key)
> +{
> +    static const struct {
> +        uint16_t key;
> +        const char *name;
> +    } fw_cfg_arch_wellknown_keys[] =3D {
> +        {FW_CFG_PPC_WIDTH, "width"},
> +        {FW_CFG_PPC_HEIGHT, "height"},
> +        {FW_CFG_PPC_DEPTH, "depth"},
> +        {FW_CFG_PPC_TBFREQ, "tbfreq"},
> +        {FW_CFG_PPC_CLOCKFREQ, "clockfreq"},
> +        {FW_CFG_PPC_IS_KVM, "is_kvm"},
> +        {FW_CFG_PPC_KVM_HC, "kvm_hc"},
> +        {FW_CFG_PPC_KVM_PID, "pid"},
> +        {FW_CFG_PPC_NVRAM_ADDR, "nvram_addr"},
> +        {FW_CFG_PPC_BUSFREQ, "busfreq"},
> +        {FW_CFG_PPC_NVRAM_FLAT, "nvram_flat"},
> +        {FW_CFG_PPC_VIACONFIG, "viaconfig"},
> +    };
> +
> +    for (size_t i =3D 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++=
) {
> +        if (fw_cfg_arch_wellknown_keys[i].key =3D=3D key) {
> +            return fw_cfg_arch_wellknown_keys[i].name;
> +        }
> +    }
> +    return NULL;
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly+aHcACgkQbDjKyiDZ
s5K8Ng//SAbwWizfTobNUXBQgCMEtUx2RQwnov/uF3uCUauWbuHSFqnUv32hjVjD
dEjt47mByme7liW4Zft0T1GVeZSf17+4VvbF3b7b1ApHxW6EMJyBxgS1LYNce021
h079CsDBsV9lQYr36tQrYP5GR+NEqt6OphbVEguE3LeQ92MGfaKByz0dXamaQrQL
pWptZ/I/veE6vujRI2DBmtN13mxCsS5TZun2aO3MhcbiuavVFEaWXsUs711okurs
CtrWxGmoZppx125EzJrkeqVZi1WUG/g6qk5Bdio6TLTNLqghwx7xHxJASpuK/VB8
fqXp5AGbk/7YAh58ef6JRuGXJejqITrVjcSR5aQ01Xxhw+kqPihHs27Uguj9aCbB
qrcQ1+AAsqwmoy3e7Jq6jE3xwumQha24jEyhAKZrbGWQTvpPCDXzGKSU5VNjl2eE
cLIVuJA6KOyAms3kN2okxKBBS25CjKfbdhdzbjKCaUVZ4kCHZpX352CP1kMyD43p
R7FZbWvu9aDNUVIrIvgCLUzEK+EZKDoF56Aao01oDjkXpo/lRPNk8k7LmL49x7oS
lU5OwqLg+CnIBC3CupOGAzBDodL0r9ke7J5UZ1oYQiOlka5sohpF2fv8D+91hm5r
eJLfDXpYfURSLLe7MHE1Y91V3bsMYLNrtYfDCzk/zMic4WrhUdQ=
=HL/c
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
