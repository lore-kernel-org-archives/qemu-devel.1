Received: from eggs.gnu.org ([209.51.188.92]:34282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0cHd-0001uO-QU
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 20:20:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0cHb-0007Y7-Su
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 20:20:45 -0500
Date: Mon, 4 Mar 2019 11:52:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304005258.GF7792@umbus.fritz.box>
References: <20190301031912.28809-1-sjitindarsingh@gmail.com>
	<20190301031912.28809-2-sjitindarsingh@gmail.com>
	<1551414405.2210.18.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline
In-Reply-To: <1551414405.2210.18.camel@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [PATCH 2/2] target/ppc/spapr: Add
 SPAPR_CAP_CCF_ASSIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mpe@ellerman.id.au


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 03:26:45PM +1100, Suraj Jitindar Singh wrote:
> On Fri, 2019-03-01 at 14:19 +1100, Suraj Jitindar Singh wrote:
> > Introduce a new spapr_cap SPAPR_CAP_CCF_ASSIST to be used to indicate
> > the requirement for a hw-assisted version of the count cache flush
> > workaround.
> >=20
> > The count cache flush workaround is a software workaround which can
> > be
> > used to flush the count cache on context switch. Some revisions of
> > hardware may have a hardware accelerated flush, in which case the
> > software flush can be shortened. This cap is used to set the
> > availability of such hardware acceleration for the count cache flush
> > routine.
> >=20
> > The availability of such hardware acceleration is indicated by the
> > H_CPU_CHAR_BCCTR_FLUSH_ASSIST flag being set in the characteristics
> > returned from the KVM_PPC_GET_CPU_CHAR ioctl.
> >=20
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  hw/ppc/spapr.c         |  2 ++
> >  hw/ppc/spapr_caps.c    | 25 +++++++++++++++++++++++++
> >  hw/ppc/spapr_hcall.c   |  3 +++
> >  include/hw/ppc/spapr.h |  5 ++++-
> >  target/ppc/kvm.c       | 14 ++++++++++++++
> >  target/ppc/kvm_ppc.h   |  6 ++++++
> >  6 files changed, 54 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 1df324379f..708e18dcdf 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2086,6 +2086,7 @@ static const VMStateDescription vmstate_spapr =3D
> > {
> >          &vmstate_spapr_cap_nested_kvm_hv,
> >          &vmstate_spapr_dtb,
> >          &vmstate_spapr_cap_large_decr,
> > +        &vmstate_spapr_cap_ccf_assist,
> >          NULL
> >      }
> >  };
> > @@ -4319,6 +4320,7 @@ static void
> > spapr_machine_class_init(ObjectClass *oc, void *data)
> >      smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 16; /* 64kiB
> > */
> >      smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] =3D SPAPR_CAP_OFF;
> >      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D
> > SPAPR_CAP_ON;
> > +    smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
> >      spapr_caps_add_properties(smc, &error_abort);
> >      smc->irq =3D &spapr_irq_xics;
> >      smc->dr_phb_enabled =3D true;
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 74a48a423a..f03f2f64e7 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -436,6 +436,21 @@ static void
> > cap_large_decr_cpu_apply(sPAPRMachineState *spapr,
> >      ppc_store_lpcr(cpu, lpcr);
> >  }
> > =20
> > +static void cap_ccf_assist_apply(sPAPRMachineState *spapr, uint8_t
> > val,
> > +                                 Error **errp)
> > +{
> > +    uint8_t kvm_val =3D kvmppc_get_cap_count_cache_flush_assist();
> > +
> > +    if (tcg_enabled() && val) {
> > +        /* TODO - for now only allow broken for TCG */
> > +        error_setg(errp,
> > +"Requested count cache flush assist capability level not supported
> > by tcg, try cap-ccf-assist=3Doff");
> > +    } else if (kvm_enabled() && (val > kvm_val)) {
> > +        error_setg(errp,
> > +"Requested count cache flush assist capability level not supported
> > by kvm, try cap-ccf-assist=3Doff");
> > +    }
>=20
> Actually, this should probably be non-fatal if the count cache flush
> routine isn't enabled

Since the new cap values aren't enabled by default, I've applied
anyway.  You can make this error non-fatal in a followup.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8dukACgkQbDjKyiDZ
s5LcuA//Xdob7RgWBxiOzKQljKgP8kisXffnSXd2eEh+jGc9JCZaW0j/YwFMJnKt
MME6h9mD9mvKIPDYW+uvAsaIo1a9HzeT4yyKom3hoLUCTc0Cpdteq7+gF//sjvNH
AXbIbqdA89+k+tgR61G/ob6y2wQbp7Ki8EpRTYx0AsN7MNwntVuEjucBkEMmwlrh
haZM45VWSYXcQdqHT2Ln3NebpyPQlZeiCcSxlZ9ewnS9RDIkwmm5VC9vIoMljfvZ
eLaPfwDLpuKgh4uJ7kXu43+8CgzmYTV16QcpS69gOLUKN30Ke+QBmL5iQ9XB75m0
Ovzft9q3sEAQvqAPto6GIeuuQPT0iUkP3UXxI0bIhlj8Xe5pudugmGbP+zMfeXat
MDcDzdjgs9sVO2aqBixHYV+tLKfPTVIgXHfZS54vfxhsjn5MATky/aaHvQja7DDZ
PqRpcCNEP4MqD6r9HwfAxcBB2ceJMkNFa81vEls9wkzpcm/Jhwdvlp1iHkzl4EN5
pxVPolia09fXXp+ObpAyhUDN9n/QhBIE+E7BJGLw/BR80sgQD3agdj/OpNEaBDjK
o2kUvDPomOjgsHVlRfnaXIxfU8TbALnjkhcgXyeEhQqktMY3H1J13uJbvwufeO8T
4OGYC5F9VTwZo/tR7af74A+Q4w/BoMuquBxbTz2chsKle0oaqFQ=
=ZizA
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
