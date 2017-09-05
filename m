Received: from eggs.gnu.org ([2001:4830:134:3::10]:33800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpFJo-0007jJ-5k
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpFJj-0007En-94
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:59:12 -0400
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:58490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpFJi-0007Dq-Vv
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:59:07 -0400
Received: from player157.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 1EC09AAD92
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 16:59:05 +0200 (CEST)
Date: Tue, 5 Sep 2017 16:58:59 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170905165859.550d1600@bahia>
In-Reply-To: <20170904233147.g4froekilptpud5h@tungsten.ozlabs.ibm.com>
References: <747daf1a700a5340eeeedd9d98188bf89f75bb85.1504161284.git.sam.bobroff@au1.ibm.com>
	<20170904101945.A6B6EAC041@b01ledav006.gho.pok.ibm.com>
	<20170904233147.g4froekilptpud5h@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/hbtp5EvnD3GCyP_KrMo/WzM";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/1] ppc: spapr: Move VCPU ID
 calculation into sPAPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

--Sig_/hbtp5EvnD3GCyP_KrMo/WzM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Sep 2017 09:31:47 +1000
Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:

> On Mon, Sep 04, 2017 at 12:18:57PM +0200, Greg Kurz wrote:
> > On Thu, 31 Aug 2017 16:38:46 +1000
> > Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
> >  =20
> > > Move the calculation of a CPU's VCPU ID out of the generic PPC code
> > > (ppc_cpu_realizefn()) and into sPAPR specific code
> > > (spapr_cpu_core_realize()) where it belongs.
> > >=20
> > > Unfortunately, due to the way things are ordered, we still need to
> > > default the VCPU ID in ppc_cpu_realizfn() but at least doing that
> > > doesn't require any interaction with sPAPR.
> > >=20
> > > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > > ---
> > > This is follow up work arising from my work to clean up the way CPU V=
CPU IDs are
> > > handled on PowerPC. It had looked like it would be difficult to move =
the actual
> > > VCPU ID calculation out of generic code but it turned out to be OK.
> > >=20
> > > It's based on dgibson/ppc-for-2.11.
> > >=20
> > > Cheers,
> > > Sam.
> > >=20
> > >  hw/ppc/spapr_cpu_core.c     | 11 +++++++++++
> > >  target/ppc/translate_init.c | 18 +++---------------
> > >  2 files changed, 14 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 5e319d9bbb..84dcc6e264 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -211,6 +211,7 @@ error:
> > > =20
> > >  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
> > >  {
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > >      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> > >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> > >      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> > > @@ -237,6 +238,16 @@ static void spapr_cpu_core_realize(DeviceState *=
dev, Error **errp)
> > >          cs =3D CPU(obj);
> > >          cpu =3D POWERPC_CPU(cs);
> > >          cs->cpu_index =3D cc->core_id + i;
> > > +        cpu->vcpu_id =3D (cc->core_id * spapr->vsmt / smp_threads) +=
 i; =20
> >=20
> > According to what we currently have in the generic code, this should be:
> >=20
> > ((cc->core_id + i) / smp_threads) * spapr->vsmt + ((cc->core_id + i) % =
smp_threads)
> >=20
> > but since cc->core_id is a multiple of smp_threads and i < cc->nr_threa=
ds <=3D smp_threads,
> > then we can indeed simplify the computation as you did. :)
> >=20
> > \o/
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org> =20
>=20
> Thanks for the review, and the nice simplification was David's idea :-)
>=20

Yeah, David said so earlier... I probably missed the mail with the
suggestion while I was on vacation. :)

> > > +        if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
> > > +            error_setg(&local_err, "Can't create CPU with id %d in K=
VM",
> > > +                       cpu->vcpu_id);
> > > +            error_append_hint(&local_err, "Adjust the number of cpus=
 to %d "
> > > +                              "or try to raise the number of threads=
 per core\n",
> > > +                              cpu->vcpu_id * smp_threads / spapr->vs=
mt);
> > > +            goto err;
> > > +        }
> > > +
> > > =20
> > >          /* Set NUMA node for the threads belonged to core  */
> > >          cpu->node_id =3D sc->node_id;
> > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > > index 7f6a349e43..1f7286c893 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -9903,28 +9903,15 @@ static void ppc_cpu_realizefn(DeviceState *de=
v, Error **errp)
> > >      PowerPCCPU *cpu =3D POWERPC_CPU(dev);
> > >      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> > >      Error *local_err =3D NULL;
> > > -#if !defined(CONFIG_USER_ONLY)
> > > -    int max_smt =3D kvmppc_smt_threads();
> > > -#endif
> > > =20
> > >      cpu_exec_realizefn(cs, &local_err);
> > >      if (local_err !=3D NULL) {
> > >          error_propagate(errp, local_err);
> > >          return;
> > >      }
> > > -
> > > -#if !defined(CONFIG_USER_ONLY)
> > > -    cpu->vcpu_id =3D (cs->cpu_index / smp_threads) * max_smt
> > > -        + (cs->cpu_index % smp_threads);
> > > -
> > > -    if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
> > > -        error_setg(errp, "Can't create CPU with id %d in KVM", cpu->=
vcpu_id);
> > > -        error_append_hint(errp, "Adjust the number of cpus to %d "
> > > -                          "or try to raise the number of threads per=
 core\n",
> > > -                          cpu->vcpu_id * smp_threads / max_smt);
> > > -        goto unrealize;
> > > +    if (cpu->vcpu_id =3D=3D UNASSIGNED_CPU_INDEX) {
> > > +        cpu->vcpu_id =3D cs->cpu_index;
> > >      }
> > > -#endif
> > > =20
> > >      if (tcg_enabled()) {
> > >          if (ppc_fixup_cpu(cpu) !=3D 0) {
> > > @@ -10625,6 +10612,7 @@ static void ppc_cpu_initfn(Object *obj)
> > >      CPUPPCState *env =3D &cpu->env;
> > > =20
> > >      cs->env_ptr =3D env;
> > > +    cpu->vcpu_id =3D UNASSIGNED_CPU_INDEX;
> > > =20
> > >      env->msr_mask =3D pcc->msr_mask;
> > >      env->mmu_model =3D pcc->mmu_model; =20
> >  =20
>=20
>=20


--Sig_/hbtp5EvnD3GCyP_KrMo/WzM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa67swAKCRAC/DrrAQHb
wiapAJ9wgDPoZD15ALn/HL5KhmQYjdUBCgCcDl4w8Gnwbfa0RJ18bg4/VUAWaKE=
=hSFn
-----END PGP SIGNATURE-----

--Sig_/hbtp5EvnD3GCyP_KrMo/WzM--
