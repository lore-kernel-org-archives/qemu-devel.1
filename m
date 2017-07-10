Received: from eggs.gnu.org ([2001:4830:134:3::10]:38793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dUfnj-00023D-1C
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dUfne-0001d4-2l
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 17:01:03 -0400
Message-ID: <1499720443.2865.15.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 11 Jul 2017 07:00:43 +1000
In-Reply-To: <9a7a16a0-f14f-bc65-d503-e2aee028633f@kaod.org>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-4-git-send-email-clg@kaod.org>
	<20170710102655.GE4083@umbus.fritz.box>
	<9a7a16a0-f14f-bc65-d503-e2aee028633f@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 03/26] target/ppc/POWER9: add
 POWERPC_EXCP_POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 2017-07-10 at 14:49 +0200, C=C3=A9dric Le Goater wrote:
> On 07/10/2017 12:26 PM, David Gibson wrote:
> > On Wed, Jul 05, 2017 at 07:13:16PM +0200, C=C3=A9dric Le Goater wrote=
:
> > > Prepare ground for the new exception model XIVE of POWER9.
> >=20
> > I'm a bit confused by this.  The excp_model is about the CPU core's
> > irq model, not the external irq controller's.
>=20
> yes this is true, but the POWER9 CPU is the only criteria we have=20
> to distinguish a machine supporting XIVE and XICS from one only=20
> supporting XICS.

Why ? I don't understand.

We do want an EXCP_POWER9 for other things, like the fact that we have
a separate interrupt input for hypervisor, with associated vectors
etc...  but that still doesn't relate to what interrupt controller is
there.

> My idea was to use this flag to activate the OV5_XIVE_EXPLOIT bit=20
> in ibm,arch-vec-5-platform-support ov5_platform, like this is done
> for the MMU. See spapr_dt_ov5_platform_support()

I disagree, the MMU is in the core, the XIVE isn't. It would be
possibly to make a P9 core if a XICS in theory :-)

> > Now.. I could imagine the POWER9 having a different core model that
> > came along with XIVE, but I can't see this new model being used for
> > anything anywhere in the rest of the series.
>=20
> See patch 26. But, maybe, I am taking a shortcut and we need another
> family of flags.=20

Or just some kind of enum for the interrupt controller, how do we do
with OpenPIC vs. XICS already ? Old POWER3 had OpenPIC.

> Thanks,
>=20
> C.=20
>=20
> > >=20
> > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > ---
> > >  target/ppc/cpu-qom.h        | 2 ++
> > >  target/ppc/excp_helper.c    | 9 ++++++---
> > >  target/ppc/translate.c      | 3 ++-
> > >  target/ppc/translate_init.c | 2 +-
> > >  4 files changed, 11 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > > index d0cf6ca2a971..d7b78cf3f71c 100644
> > > --- a/target/ppc/cpu-qom.h
> > > +++ b/target/ppc/cpu-qom.h
> > > @@ -132,6 +132,8 @@ enum powerpc_excp_t {
> > >      POWERPC_EXCP_POWER7,
> > >      /* POWER8 exception model           */
> > >      POWERPC_EXCP_POWER8,
> > > +    /* POWER9 exception model           */
> > > +    POWERPC_EXCP_POWER9,
> > >  };
> > > =20
> > >  /*****************************************************************=
************/
> > > diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> > > index 3a9f0861e773..dc7dff36a580 100644
> > > --- a/target/ppc/excp_helper.c
> > > +++ b/target/ppc/excp_helper.c
> > > @@ -148,9 +148,11 @@ static inline void powerpc_excp(PowerPCCPU *cp=
u, int excp_model, int excp)
> > >       */
> > >  #if defined(TARGET_PPC64)
> > >      if (excp_model =3D=3D POWERPC_EXCP_POWER7 ||
> > > -        excp_model =3D=3D POWERPC_EXCP_POWER8) {
> > > +        excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> > > +        excp_model =3D=3D POWERPC_EXCP_POWER9) {
> > >          lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> > > -        if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
> > > +        if (excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> > > +            excp_model =3D=3D POWERPC_EXCP_POWER9) {
> > >              ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SH=
IFT;
> > >          } else {
> > >              ail =3D 0;
> > > @@ -651,7 +653,8 @@ static inline void powerpc_excp(PowerPCCPU *cpu=
, int excp_model, int excp)
> > >          if (!(new_msr & MSR_HVB) && (env->spr[SPR_LPCR] & LPCR_ILE=
)) {
> > >              new_msr |=3D (target_ulong)1 << MSR_LE;
> > >          }
> > > -    } else if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
> > > +    } else if (excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> > > +               excp_model =3D=3D POWERPC_EXCP_POWER9) {
> > >          if (new_msr & MSR_HVB) {
> > >              if (env->spr[SPR_HID0] & HID0_HILE) {
> > >                  new_msr |=3D (target_ulong)1 << MSR_LE;
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index c0cd64d927c2..2d8c1b9e6836 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -7064,7 +7064,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f=
, fprintf_function cpu_fprintf,
> > > =20
> > >  #if defined(TARGET_PPC64)
> > >      if (env->excp_model =3D=3D POWERPC_EXCP_POWER7 ||
> > > -        env->excp_model =3D=3D POWERPC_EXCP_POWER8) {
> > > +        env->excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> > > +        env->excp_model =3D=3D POWERPC_EXCP_POWER9) {
> > >          cpu_fprintf(f, "HSRR0 " TARGET_FMT_lx " HSRR1 " TARGET_FMT=
_lx "\n",
> > >                      env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
> > >      }
> > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_ini=
t.c
> > > index 53aff5a7b734..b8c7b8150318 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -8962,7 +8962,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void =
*data)
> > >      pcc->sps =3D &POWER7_POWER8_sps;
> > >      pcc->radix_page_info =3D &POWER9_radix_page_info;
> > >  #endif
> > > -    pcc->excp_model =3D POWERPC_EXCP_POWER8;
> > > +    pcc->excp_model =3D POWERPC_EXCP_POWER9;
> > >      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
> > >      pcc->bfd_mach =3D bfd_mach_ppc64;
> > >      pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
