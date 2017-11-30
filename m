Received: from eggs.gnu.org ([2001:4830:134:3::10]:54879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKLsn-00075x-JK
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:15:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKLsh-0002WA-GP
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 05:15:53 -0500
Date: Thu, 30 Nov 2017 16:55:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130055542.GG3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ijywFOGgtBfiIjQx"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-18-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
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


--ijywFOGgtBfiIjQx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:47PM +0100, C=E9dric Le Goater wrote:
> The XIVE object is designed to be always available, so it is created
> unconditionally on newer machines.

There doesn't actually seem to be anything dependent on machine
version here.

> Depending on the configuration and
> the guest capabilities, the CAS negotiation process will decide which
> interrupt model to use, legacy or XIVE.
>=20
> The XIVE model makes use of the full range of the IRQ number space
> because the IRQ numbers for the CPU IPIs are allocated in the range
> below XICS_IRQ_BASE, which is unused by XICS.

Ok.  And I take it 4096 is enough space for the XIVE IPIs for the
forseeable future?

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr.c         | 34 ++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  2 ++
>  2 files changed, 36 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5d3325ca3c88..0e0107c8272c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -56,6 +56,7 @@
>  #include "hw/ppc/spapr_vio.h"
>  #include "hw/pci-host/spapr.h"
>  #include "hw/ppc/xics.h"
> +#include "hw/ppc/spapr_xive.h"
>  #include "hw/pci/msi.h"
> =20
>  #include "hw/pci/pci.h"
> @@ -204,6 +205,29 @@ static void xics_system_init(MachineState *machine, =
int nr_irqs, Error **errp)
>      }
>  }
> =20
> +static sPAPRXive *spapr_xive_create(sPAPRMachineState *spapr, int nr_irq=
s,
> +                                    Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    Object *obj;
> +
> +    obj =3D object_new(TYPE_SPAPR_XIVE);
> +    object_property_add_child(OBJECT(spapr), "xive", obj, &error_abort);
> +    object_property_set_int(obj, nr_irqs, "nr-irqs",  &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
> +    object_property_set_bool(obj, true, "realized", &local_err);
> +    if (local_err) {
> +        goto error;
> +    }
> +
> +    return SPAPR_XIVE(obj);
> +error:
> +    error_propagate(errp, local_err);
> +    return NULL;
> +}
> +
>  static int spapr_fixup_cpu_smt_dt(void *fdt, int offset, PowerPCCPU *cpu,
>                                    int smt_threads)
>  {
> @@ -2360,6 +2384,16 @@ static void ppc_spapr_init(MachineState *machine)
>      /* Set up Interrupt Controller before we create the VCPUs */
>      xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
> =20
> +    /* We don't have KVM support yet, so check for irqchip=3Don */
> +    if (kvm_enabled() && machine_kernel_irqchip_required(machine)) {
> +        error_report("kernel_irqchip requested. no XIVE support");

I think you want an actual exit(1) here, no?  error_report() will
print an error but keep going.

> +    } else {
> +        /* XIVE uses the full range of IRQ numbers. The CPU IPIs will
> +         * use the range below XICS_IRQ_BASE, which is unused by XICS. */
> +        spapr->xive =3D spapr_xive_create(spapr, XICS_IRQ_BASE + XICS_IR=
QS_SPAPR,
> +                                        &error_fatal);

XICS_IRQ_BASE =3D=3D 4096, and XICS_IRQS_SPAPR (which we should rename at
some point) =3D=3D 1024.

So we have a total irq space of 5k, which is a bit odd.  I'd be ok
with rounding it out to 8k for newer machines if that's useful.
Sparse allocations in there might make life easier for getting
consistent irq numbers without an "allocator" per se (because we can
use different regions for VIO, PCI intx, MSI, etc. etc.).

> +    }
> +
>      /* Set up containers for ibm,client-architecture-support negotiated =
options
>       */
>      spapr->ov5 =3D spapr_ovec_new();
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9a3885593c86..90e2b0f6c678 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -14,6 +14,7 @@ struct sPAPRNVRAM;
>  typedef struct sPAPREventLogEntry sPAPREventLogEntry;
>  typedef struct sPAPREventSource sPAPREventSource;
>  typedef struct sPAPRPendingHPT sPAPRPendingHPT;
> +typedef struct sPAPRXive sPAPRXive;
> =20
>  #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
>  #define SPAPR_ENTRY_POINT       0x100
> @@ -127,6 +128,7 @@ struct sPAPRMachineState {
>      MemoryHotplugState hotplug_memory;
> =20
>      const char *icp_type;
> +    sPAPRXive  *xive;
>  };
> =20
>  #define H_SUCCESS         0

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ijywFOGgtBfiIjQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofnVsACgkQbDjKyiDZ
s5IxoA//XmcOcrO3G5Mtu1uutobLu089WXq3CRONcbD9bAppX33VQVCjaye6+DuT
Cc9p3uVRnWddv5JjN/hQkeHTDV7aiCxNsH19e3tCTWG+E2U5LPHFjUEiVdKLFWD7
Z2hXojDnw3Ohwit7DCHmwSPVI9kuHufPF0EmQBdAfuKt8OdTSz6GdhlVxuOye+Qa
0WhOZsBXxw3WbN8+5AVQxr/w2zbPMJY+gkOh3claMKj1Q6YEsd/+GWixp/NAJaOf
XYHp/4pOofCZMrFf1wXyBYvzEko1Nb+I+ZvZNAWeIl18RUDeZQ/xViyy4Q/i6Map
KmGIEgf+PkXiF0krR7Mt0i3GVNwnKlRy+z6nwtThng874knFK/rYYK0CEJlpk2OL
2938HmUCBVxn6uX0Nd+tjqVvO/RJWqHLKgCvfeGinh7PZ6ZjobOSj3qylMrMMZfA
pT5bjDYeN3oy/lSd6sIICLy7R7eAA9yEcryXgeMfTtYm0RGE+mnyCA2VDRXr9B4H
iPNVCLkDgDonGWQ09XExFcQYepJIXVcq0SFIRoDZ5ZiwHypqYB+AXLDd5jkBMc2B
hO8ZqOVXIOsJkK4H92c51+Vnp7gc+V/AUHL9GPMSUPNLeX7zBQ2PPwIHAE6dQ7PQ
M7gnRu8esDYfwxQtmkMwEYvXk6432Y2NroDY/uuKjSTWrLYV8tY=
=rNpD
-----END PGP SIGNATURE-----

--ijywFOGgtBfiIjQx--
