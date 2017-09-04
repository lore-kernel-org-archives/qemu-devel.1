Received: from eggs.gnu.org ([2001:4830:134:3::10]:33975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1doqqD-0007az-6w
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1doqq6-0005kh-Q5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:51:00 -0400
Date: Mon, 4 Sep 2017 21:12:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170904111212.GC2735@umbus.fritz.box>
References: <747daf1a700a5340eeeedd9d98188bf89f75bb85.1504161284.git.sam.bobroff@au1.ibm.com>
	<20170904121857.1def843f@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20170904121857.1def843f@bahia>
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
To: Greg Kurz <groug@kaod.org>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2017 at 12:18:57PM +0200, Greg Kurz wrote:
> On Thu, 31 Aug 2017 16:38:46 +1000
> Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
>=20
> > Move the calculation of a CPU's VCPU ID out of the generic PPC code
> > (ppc_cpu_realizefn()) and into sPAPR specific code
> > (spapr_cpu_core_realize()) where it belongs.
> >=20
> > Unfortunately, due to the way things are ordered, we still need to
> > default the VCPU ID in ppc_cpu_realizfn() but at least doing that
> > doesn't require any interaction with sPAPR.
> >=20
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> > ---
> > This is follow up work arising from my work to clean up the way CPU VCP=
U IDs are
> > handled on PowerPC. It had looked like it would be difficult to move th=
e actual
> > VCPU ID calculation out of generic code but it turned out to be OK.
> >=20
> > It's based on dgibson/ppc-for-2.11.
> >=20
>=20
> According to what we currently have in the generic code, this should be:
>=20
> ((cc->core_id + i) / smp_threads) * spapr->vsmt + ((cc->core_id + i) % sm=
p_threads)
>=20
> but since cc->core_id is a multiple of smp_threads and i < cc->nr_threads=
 <=3D smp_threads,
> then we can indeed simplify the computation as you did. :)

Right, I suggested this simplication on just that basis.

Applied to ppc-for-2.11.

>=20
> \o/
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > +        if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
> > +            error_setg(&local_err, "Can't create CPU with id %d in KVM=
",
> > +                       cpu->vcpu_id);
> > +            error_append_hint(&local_err, "Adjust the number of cpus t=
o %d "
> > +                              "or try to raise the number of threads p=
er core\n",
> > +                              cpu->vcpu_id * smp_threads / spapr->vsmt=
);
> > +            goto err;
> > +        }
> > +
> > =20
> >          /* Set NUMA node for the threads belonged to core  */
> >          cpu->node_id =3D sc->node_id;
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index 7f6a349e43..1f7286c893 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -9903,28 +9903,15 @@ static void ppc_cpu_realizefn(DeviceState *dev,=
 Error **errp)
> >      PowerPCCPU *cpu =3D POWERPC_CPU(dev);
> >      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> >      Error *local_err =3D NULL;
> > -#if !defined(CONFIG_USER_ONLY)
> > -    int max_smt =3D kvmppc_smt_threads();
> > -#endif
> > =20
> >      cpu_exec_realizefn(cs, &local_err);
> >      if (local_err !=3D NULL) {
> >          error_propagate(errp, local_err);
> >          return;
> >      }
> > -
> > -#if !defined(CONFIG_USER_ONLY)
> > -    cpu->vcpu_id =3D (cs->cpu_index / smp_threads) * max_smt
> > -        + (cs->cpu_index % smp_threads);
> > -
> > -    if (kvm_enabled() && !kvm_vcpu_id_is_valid(cpu->vcpu_id)) {
> > -        error_setg(errp, "Can't create CPU with id %d in KVM", cpu->vc=
pu_id);
> > -        error_append_hint(errp, "Adjust the number of cpus to %d "
> > -                          "or try to raise the number of threads per c=
ore\n",
> > -                          cpu->vcpu_id * smp_threads / max_smt);
> > -        goto unrealize;
> > +    if (cpu->vcpu_id =3D=3D UNASSIGNED_CPU_INDEX) {
> > +        cpu->vcpu_id =3D cs->cpu_index;
> >      }
> > -#endif
> > =20
> >      if (tcg_enabled()) {
> >          if (ppc_fixup_cpu(cpu) !=3D 0) {
> > @@ -10625,6 +10612,7 @@ static void ppc_cpu_initfn(Object *obj)
> >      CPUPPCState *env =3D &cpu->env;
> > =20
> >      cs->env_ptr =3D env;
> > +    cpu->vcpu_id =3D UNASSIGNED_CPU_INDEX;
> > =20
> >      env->msr_mask =3D pcc->msr_mask;
> >      env->mmu_model =3D pcc->mmu_model;
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmtNQwACgkQbDjKyiDZ
s5JVBA/7B2ivDhyL4DDCTo5TRgv0tBjI4heWqvg44C3UVxYaqZjHuGuwRD0C3tb7
P2byChuGoZ/h4YWZLU4NNmEZnrWsqfD9rASl1qThrjKDJKjTRKs/qLTW8hsbgTBb
F/lKlwTMESx9S+g/60bPdj2QMQdHY698zMT+aavtaowcuZFcEB9845GBVtJqwoMN
KW+rxJ6iWqNeH4JmmfHDbb7GIl5W2rxv9C8SIE7z3S+8KlT8Eq1Ewj5HaWoK948c
smehMLOr8P/BAvrL8wMb6rcpgbLezIw65riH+pBJSOU78nlz+mPo1gX0lD++Vq3d
pqKb18nIwtVCBg/cYVUfF+i+ukiZ4CQV8j5L7N9b9HoO1U65JKb6EIRwBpkez74K
AoxKwTJdCVyB4IJ7DgaWpw+OBpYaBApHgvKUbbXBvuQsaNZJN4taat8gw0VS+i9x
leB51MJZzcKGoaGoNNBiJmu4IX+D5sUfvWCHuWLPfNt4bl9gD8AJXiDwXQFWT0Kb
00pSfD2qaur8WC7Ye5a8r9C409ipYhlyLdbjM9gqTk3YGi9JaSTo1d81H1KtSUAr
GciEsigrCOea8ru+zhDj9BWrP8d+yA1Lb8B1OGbaM/DSSrkh82hxbhpeyipxGmLs
Gm4ESin0Wi/5EfoxruYvcwfrjBMKJsKuSAC1eigltKH+YJF1Uu8=
=QPh6
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
