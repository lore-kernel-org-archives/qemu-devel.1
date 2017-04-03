Received: from eggs.gnu.org ([2001:4830:134:3::10]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1curxV-0004dJ-2V
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 22:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1curxR-0005jh-Si
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 22:43:09 -0400
Date: Mon, 3 Apr 2017 12:22:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170403022228.GB12906@umbus.fritz.box>
References: <1490795611-4762-1-git-send-email-clg@kaod.org>
	<1490795611-4762-8-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <1490795611-4762-8-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v4 7/9] ppc/pnv: extend the machine with a
 XICSFabric interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2017 at 03:53:29PM +0200, C=E9dric Le Goater wrote:
> A XICSFabric QOM interface is used by the XICS layer to manipulate the
> ICP and ICS objects. Let's define the associated handlers for the
> PowerNV machine. All handlers should be defined even if there is no
> ICS under the PowerNV machine yet.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/pnv.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9505ca7dc09a..57560b09e04e 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -34,6 +34,7 @@
>  #include "qemu/cutils.h"
>  #include "qapi/visitor.h"
> =20
> +#include "hw/ppc/xics.h"
>  #include "hw/ppc/pnv_xscom.h"
> =20
>  #include "hw/isa/isa.h"
> @@ -739,6 +740,39 @@ static const TypeInfo pnv_chip_info =3D {
>      .abstract      =3D true,
>  };
> =20
> +/* The XICS layer needs valid handlers for the ICS objects also */
> +static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
> +{
> +    return NULL;
> +}
> +
> +static void pnv_ics_resend(XICSFabric *xi)
> +{
> +}

Putting in stub implementations of the ics hooks doesn't make sense to
me.  Especially since they don't get implemented in the remaining
patches.  Sure, it might stop a SEGV, but the thing can't possibly
actually work without real ICS callbacks, so what's the point?

> +static PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
> +{
> +    CPUState *cs;
> +
> +    CPU_FOREACH(cs) {
> +        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        CPUPPCState *env =3D &cpu->env;
> +
> +        if (env->spr_cb[SPR_PIR].default_value =3D=3D pir) {
> +            return cpu;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
> +{
> +    PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
> +
> +    return cpu ? ICP(cpu->intc) : NULL;
> +}
> +
>  static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
>                                void *opaque, Error **errp)
>  {
> @@ -789,6 +823,7 @@ static void powernv_machine_class_props_init(ObjectCl=
ass *oc)
>  static void powernv_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
> =20
>      mc->desc =3D "IBM PowerNV (Non-Virtualized)";
>      mc->init =3D ppc_powernv_init;
> @@ -799,6 +834,9 @@ static void powernv_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->no_parallel =3D 1;
>      mc->default_boot_order =3D NULL;
>      mc->default_ram_size =3D 1 * G_BYTE;
> +    xic->icp_get =3D pnv_icp_get;
> +    xic->ics_get =3D pnv_ics_get;
> +    xic->ics_resend =3D pnv_ics_resend;
> =20
>      powernv_machine_class_props_init(oc);
>  }
> @@ -809,6 +847,10 @@ static const TypeInfo powernv_machine_info =3D {
>      .instance_size =3D sizeof(PnvMachineState),
>      .instance_init =3D powernv_machine_initfn,
>      .class_init    =3D powernv_machine_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_XICS_FABRIC },
> +        { },
> +    },
>  };
> =20
>  static void powernv_machine_register_types(void)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4bHjAAoJEGw4ysog2bOSKmkP/2vhA2+REs3yEM/aP5w/w07O
gtW+9JvLFmUiEOWgnoYjIQea36jADk0fln5+gZLSj7CyNApK12s+ljPGdwJOb9Ij
cxfgCWniDa9sKax+QF8rAHd5JoD94oNOR/e/F1imGTeC9M0UxHUNWcwMHdlUEV7X
NlPApCnus2eZozAw/3re9ryFjPUuN/PwMCEOJa33KhOq0MG4xTkDdfAlN8mhlija
7pTij+rdP+pRbh+1IvNlyona9D7q10X/gs+Pwt7+gNtgiiXkN6Gkwmx9M0Cen0rU
WSWjcQjwBrwRng0acDk+wWoJ3SxrF+eRD4mTdtM8o6dksamifVyeNlJo1LVJutZt
IV7U68b4DAsw2Y/gdrsuxq2iQGGfIizpPwKC3v5kFR2zsBtjmeKfdz6gwyG/wwAy
aukTSjSQvW5dFczNPZtyoxvcoK9lQd8B7yqxXOkMsO93Q/I90yIbBZejQHF5am20
afRJv48nipwHBuAs+KlupDDTY56avcnYWu9GtEyGKJHZxP6dNWJvWac9Ba1eIg1U
GCiaBi5ZgTRfrXCVG3ik7g+acct12UcUqrTuOgc+/mP51EtvA1LROohhmp35YaOu
xHHCDTv3mivlCntKYydd8y25UATRJPKZqaRyCTZTbH+47n2Y/dGosZX61aW7gBpX
CREszOyxx6xjTW95PAyS
=Ke/s
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
