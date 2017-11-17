Received: from eggs.gnu.org ([2001:4830:134:3::10]:38431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eFYa5-0007w5-E0
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:48:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eFYa2-0007pU-NS
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 23:48:45 -0500
Date: Fri, 17 Nov 2017 15:48:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171117044825.GA26448@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20171110152017.24324-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 03/11] spapr: introduce new
 XICSFabric operations for an IRQ allocator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 03:20:09PM +0000, C=E9dric Le Goater wrote:
> Currently, the ICSState 'ics' object of the sPAPR machine acts as the
> global interrupt source handler and also as the IRQ number allocator
> for the machine. Some IRQ numbers are allocated very early in the
> machine initialization sequence to populate the device tree, and this
> is a problem to introduce the new POWER XIVE interrupt model, as it
> needs to share the IRQ numbers with the older model.
>=20
> To prepare ground for XIVE, here is a set of new XICSFabric operations
> to let the machine handle directly the IRQ number allocation and to
> decorrelate the allocation from the interrupt source object :
>=20
>     bool (*irq_test)(XICSFabric *xi, int irq);
>     int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
>     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>=20
> In these prototypes, the 'irq' parameter refers to a number in the
> global IRQ number space. Indexes for arrays storing different state
> informations on the interrupts, like the ICSIRQState, are usually
> named 'srcno'.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This doesn't seem sensible to me.  When I said you should move irq
allocation to the machine, I mean actually move the code.  The only
user of irq allocation should be in the machine, so we shouldn't need
to indirect via the XICSFabric interface to do that.

And, we shouldn't be using XICSFabric things for XIVE.

> ---
>  hw/ppc/spapr.c        | 19 +++++++++++++++++++
>  include/hw/ppc/xics.h |  4 ++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a2dcbee07214..84d68f2fdbae 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3536,6 +3536,21 @@ static ICPState *spapr_icp_get(XICSFabric *xi, int=
 vcpu_id)
>      return cpu ? ICP(cpu->intc) : NULL;
>  }
> =20
> +static bool spapr_irq_test(XICSFabric *xi, int irq)
> +{
> +    return false;
> +}
> +
> +static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
> +{
> +    return -1;
> +}
> +
> +static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
> +{
> +    ;
> +}
> +
>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
>                                   Monitor *mon)
>  {
> @@ -3630,6 +3645,10 @@ static void spapr_machine_class_init(ObjectClass *=
oc, void *data)
>      xic->ics_get =3D spapr_ics_get;
>      xic->ics_resend =3D spapr_ics_resend;
>      xic->icp_get =3D spapr_icp_get;
> +    xic->irq_test =3D spapr_irq_test;
> +    xic->irq_alloc_block =3D spapr_irq_alloc_block;
> +    xic->irq_free_block =3D spapr_irq_free_block;
> +
>      ispc->print_info =3D spapr_pic_print_info;
>      /* Force NUMA node memory size to be a multiple of
>       * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 28d248abad61..30e7f2e0a7dd 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -175,6 +175,10 @@ typedef struct XICSFabricClass {
>      ICSState *(*ics_get)(XICSFabric *xi, int irq);
>      void (*ics_resend)(XICSFabric *xi);
>      ICPState *(*icp_get)(XICSFabric *xi, int server);
> +    /* IRQ allocator helpers */
> +    bool (*irq_test)(XICSFabric *xi, int irq);
> +    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
> +    void (*irq_free_block)(XICSFabric *xi, int irq, int num);
>  } XICSFabricClass;
> =20
>  #define XICS_IRQS_SPAPR               1024

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloOahkACgkQbDjKyiDZ
s5LlMg/9GyLBybq1TKVGoVOc9oS54elwxq19aU+WVNPlsaXpcOA6XHd8z//Nl7Ko
O8OHHb5LvtbNuTufuAschCR6IRx7/e+RW8/RGvGev4hbt+y4LFUg+8jZNnlneJw9
yGKuvIzmyR+Ho3N98XeR4LtCjb+ddGsUdKHR1mIGqwgTARjK8bWnZiTvf1ccaBrk
H/cBED0WTmQ5wJNT4mLsHKPWO60mY3l41N8hE+BwM477uls0CNWQliGsA9uLG35Y
X0Jhn4HegPyK2qYICsl9ZcHcD+F8KSR/V+7OUDG7FNZkJsQj3Iu7d+BF4k2SnuIG
sQYlbs1Isqb19H2Sn1IRyIcbZ2uzumQ++uT1FWZa6PlQLp8Ts96lGQL4QyPpOLlj
Tqci+29ykbuUeuu4qMiAO6pdzsEIgYUH9NYNw7MpbkuFJSsdBIPDUdfcNjTqHft0
lFFYElm1zE880uPIInAYw7glD99kYdYFBI2NwwuhfzGddBeT4k5S3Cy5IDazsGQc
qHtgMji6y5gLYt1Xr/+JN3VeMpL/jq+6D6qtlZOet5I/51ttzgguE/DfO/O4uCP0
/Bm3e3AgFUF3Nf8nRAfVa2mP9AwAVM+ApyfMN//EcJe6+S0jWlR/1YpTvdhMJVTf
EYFk6ZJihKFiLzbDjunVVHRDgGlMuPJFwsBIfLhJJq+5DFdjjrU=
=9THJ
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
