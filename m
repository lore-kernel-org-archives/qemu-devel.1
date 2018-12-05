Received: from eggs.gnu.org ([2001:4830:134:3::10]:52699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUMWg-0003l0-Iz
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 21:02:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUMWe-0004oE-At
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 21:02:58 -0500
Date: Wed, 5 Dec 2018 12:44:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181205014404.GD28910@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-20-clg@kaod.org>
	<20181128044257.GC2251@umbus.fritz.box>
	<62423058-3603-942a-915f-f9e6afd7b4cc@kaod.org>
	<1d8b8604-f962-5647-3283-7949c52d3bcc@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <1d8b8604-f962-5647-3283-7949c52d3bcc@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 19/36] spapr: add a 'pseries-3.1-xive'
 machine type
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


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 04:14:12PM +0100, C=E9dric Le Goater wrote:
> On 11/28/18 11:37 PM, C=E9dric Le Goater wrote:
> > On 11/28/18 5:42 AM, David Gibson wrote:
> >> On Fri, Nov 16, 2018 at 11:57:12AM +0100, C=E9dric Le Goater wrote:
> >>> The interrupt mode is statically defined to XIVE only for this machin=
e.
> >>> The guest OS is required to have support for the XIVE exploitation
> >>> mode of the POWER9 interrupt controller.
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>> ---
> >>>  include/hw/ppc/spapr_irq.h |  1 +
> >>>  hw/ppc/spapr.c             | 36 +++++++++++++++++++++++++++++++-----
> >>>  hw/ppc/spapr_irq.c         |  3 +++
> >>>  3 files changed, 35 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >>> index c3b4c38145eb..b299dd794bff 100644
> >>> --- a/include/hw/ppc/spapr_irq.h
> >>> +++ b/include/hw/ppc/spapr_irq.h
> >>> @@ -33,6 +33,7 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr);
> >>>  typedef struct sPAPRIrq {
> >>>      uint32_t    nr_irqs;
> >>>      uint32_t    nr_msis;
> >>> +    uint8_t     ov5;
> >>
> >> I'm a bit confused as to what exactly this represents..
> >=20
> > The option vector 5 bits advertised by CAS for the platform. What the
> > hypervisor supports.
>=20
> 0x80 both mode
> 0x40 XIVE only
> 0x00 XICS only

Yes....

>=20
> >>
> >>>      void (*init)(sPAPRMachineState *spapr, int nr_irqs, int nr_serve=
rs,
> >>>                   Error **errp);
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index ad1692cdcd0f..8fbb743769db 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -1097,12 +1097,14 @@ static void spapr_dt_rtas(sPAPRMachineState *=
spapr, void *fdt)
> >>>      spapr_dt_rtas_tokens(fdt, rtas);
> >>>  }
> >>> =20
> >>> -/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU =
features
> >>> - * that the guest may request and thus the valid values for bytes 24=
=2E.26 of
> >>> - * option vector 5: */
> >>> -static void spapr_dt_ov5_platform_support(void *fdt, int chosen)
> >>> +/* Prepare ibm,arch-vec-5-platform-support, which indicates the MMU
> >>> + * and the XIVE features that the guest may request and thus the val=
id
> >>> + * values for bytes 23..26 of option vector 5: */
> >>> +static void spapr_dt_ov5_platform_support(sPAPRMachineState *spapr, =
void *fdt,
> >>> +                                          int chosen)
> >>>  {
> >>>      PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> >>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> >>> =20
> >>>      char val[2 * 4] =3D {
> >>>          23, 0x00, /* Xive mode, filled in below. */
> >>> @@ -1123,7 +1125,11 @@ static void spapr_dt_ov5_platform_support(void=
 *fdt, int chosen)
> >>>          } else {
> >>>              val[3] =3D 0x00; /* Hash */
> >>>          }
> >>> +        /* TODO: test KVM support */
> >>> +        val[1] =3D smc->irq->ov5;
> >>>      } else {
> >>> +        val[1] =3D smc->irq->ov5;
> >>
> >> ..here it seems to be a specific value for this OV5 byte, indicating t=
he
> >> supported intc...
> >=20
> > yes.>=20
> >>
> >>> +
> >>>          /* V3 MMU supports both hash and radix in tcg (with dynamic =
switching) */
> >>>          val[3] =3D 0xC0;
> >>>      }
> >>> @@ -1191,7 +1197,7 @@ static void spapr_dt_chosen(sPAPRMachineState *=
spapr, void *fdt)
> >>>          _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_p=
ath));
> >>>      }
> >>> =20
> >>> -    spapr_dt_ov5_platform_support(fdt, chosen);
> >>> +    spapr_dt_ov5_platform_support(spapr, fdt, chosen);
> >>> =20
> >>>      g_free(stdout_path);
> >>>      g_free(bootlist);
> >>> @@ -2622,6 +2628,11 @@ static void spapr_machine_init(MachineState *m=
achine)
> >>>      /* advertise support for ibm,dyamic-memory-v2 */
> >>>      spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
> >>> =20
> >>> +    /* advertise XIVE */
> >>> +    if (smc->irq->ov5) {
> >>
> >> ..but here it seems to be a bool indicating XIVE support specifically.
> >=20
> > ah. yes. I need to check this part. That was a while ago.
>=20
> This is advertising XIVE again if the machine supports it. We need to=20
> populate the DT node "ibm,arch-vec-5-platform-support" in routine
> spapr_dt_ov5_platform_support() *and* also to update the machine field=20
> spapr->ov5. But it seems redundant to me.=20
>=20
> spapr->ov5 should be used to build the DT. Shouldn't it ? Or I really=20
> missed something.

Possibly, but we are talking PAPR here, which is the king of putting
the same information in multiple places, differently encoded.  You'll
need to check it.

Regardless please don't use if (smc->irq->ov5) as a shortcut for if
(smc->irq->ov5 !=3D XICS_ONLY).  The latter is much clearer and doesn't
mislead as to the type of ...->ov5.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwHLWQACgkQbDjKyiDZ
s5Kgow//coTHQHwFq06ZQUqCxlYswWRUJUNEZFLOvo65ayasjXJNitYgkMwd8qdz
Qrb1NMSS1kPSUFvsJRdrvpnC5PmylnDMSr1iyZ5Rah+IAxWM+LQsCfAPNzuicHI/
PKxqa3mVqjg1zH6dHWwrW42oX4oCmJFnigr6VpDWx3jCpkeC4nUEG9zaHRBOUL9b
chF8dxQoaZ+g1AH5Iauo4NuRbFvMiXJjMFFu3+tLT6TjvCtHHhqHOyOAFSvFiCYp
Fa3Xu457TEWv68IttZLGLRpUXzN0jMU4q+Or1IjYXMIyreY4yJKkF57FsEvNkrif
ubla9PX26M76fQE/IufJ6S0ooKOJnJ5N/tERpbLVwRln7dEQDoa3ZYdqTIXSvWjM
uS2Bw5XLpv1cLo+ci9QYxS/k6f/MIUg0CnzkWhMuiZSC6dke3KHLAttib1R9BG9G
N4i0VLby2UwEFm/FTo881c9Adzw2nXwquMK3LjR8d3bdXOtLLVjgmkcEHzt/F1up
BK4R9ukcvP4E/IbiuyZBG0OPKdfFr9IXau+qabfLsqpjO67nhhDr+6QspYeXDgHy
yJcuz6auHn6S3Tie8cLMCifI3xzq7vqSpYPelY4DNkPbrWuXOpzIT6JkgQIWCgRg
URFJMzCK/KcVvC2+Apy8MdjSSlkaMdCwkWLQ6QGnretTqs2JyfA=
=4Cmk
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
