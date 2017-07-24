Received: from eggs.gnu.org ([2001:4830:134:3::10]:47725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZTqf-0001Lw-KU
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZTqe-0008D5-5H
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 23:15:57 -0400
Date: Mon, 24 Jul 2017 12:49:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724024902.GA17228@umbus.fritz.box>
References: <1500612666-19521-1-git-send-email-bharata@linux.vnet.ibm.com>
	<20170721065736.GD3717@umbus.fritz.box>
	<6fc11647-997b-114c-e7ef-a8e9d72eb361@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <6fc11647-997b-114c-e7ef-a8e9d72eb361@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [FIX PATCH v2] spapr: Fix QEMU abort
 during memory unplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 08:23:02AM -0300, Daniel Henrique Barboza wrote:
>=20
>=20
> On 07/21/2017 03:57 AM, David Gibson wrote:
> > On Fri, Jul 21, 2017 at 10:21:06AM +0530, Bharata B Rao wrote:
> > > Commit 0cffce56 (hw/ppc/spapr.c: adding pending_dimm_unplugs to
> > > sPAPRMachineState) introduced a new way to track pending LMBs of DIMM
> > > device that is marked for removal. Since this commit we can hit the
> > > assert in spapr_pending_dimm_unplugs_add() in the following situation:
> > >=20
> > > - DIMM device removal fails as the guest doesn't allow the removal.
> > > - Subsequent attempt to remove the same DIMM would hit the assert
> > >    as the corresponding sPAPRDIMMState is still part of the
> > >    pending_dimm_unplugs list.
> > >=20
> > > Fix this by removing the assert and conditionally adding the
> > > sPAPRDIMMState to pending_dimm_unplugs list only when it is not
> > > already present.
> > >=20
> > > Fixes: 0cffce56ae3501c5783d779f97993ce478acf856
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Applied to ppc-for-2.10.
> >=20
> > > ---
> > > Changes in v2:
> > > - sPAPRDIMMState is now allocated within spapr_pending_dimm_unplugs_a=
dd()
> > >    itself (David Gibson)
> > > - spapr_recover_pending_dimm_state() should never return a NULL sPAPR=
DIMMState,
> > >    added an assert for the same.
> > >=20
> > >   hw/ppc/spapr.c | 37 +++++++++++++++++++++----------------
> > >   1 file changed, 21 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 1cb09e7..2465b27 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2850,11 +2850,25 @@ static sPAPRDIMMState *spapr_pending_dimm_unp=
lugs_find(sPAPRMachineState *s,
> > >       return dimm_state;
> > >   }
> > > -static void spapr_pending_dimm_unplugs_add(sPAPRMachineState *spapr,
> > > -                                           sPAPRDIMMState *dimm_stat=
e)
> > > +static sPAPRDIMMState *spapr_pending_dimm_unplugs_add(sPAPRMachineSt=
ate *spapr,
> > > +                                                      uint32_t nr_lm=
bs,
> > > +                                                      PCDIMMDevice *=
dimm)
> > >   {
> > > -    g_assert(!spapr_pending_dimm_unplugs_find(spapr, dimm_state->dim=
m));
> > > -    QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, dimm_state, nex=
t);
> > > +    sPAPRDIMMState *ds =3D NULL;
> > > +
> > > +    /*
> > > +     * If this request is for a DIMM whose removal had failed earlier
> > > +     * (due to guest's refusal to remove the LMBs), we would have th=
is
> > > +     * dimm already in the pending_dimm_unplugs list. In that
> > > +     * case don't add again.
> > > +     */
> > > +    if (!spapr_pending_dimm_unplugs_find(spapr, dimm)) {
> > > +        ds =3D g_malloc0(sizeof(sPAPRDIMMState));
> > > +        ds->nr_lmbs =3D nr_lmbs;
> > > +        ds->dimm =3D dimm;
> > > +        QTAILQ_INSERT_HEAD(&spapr->pending_dimm_unplugs, ds, next);
> > > +    }
> > > +    return ds;
> In case unplugs_find() founds a DIMM state (the condition this patch is
> trying to fix), ds is
> returned as NULL. This is working because unplug_request() does not use t=
he
> return value
> of unplugs_add() and because recover() is only called if find() returns
> NULL. Still not
> so pretty.
>=20
> What makes sense here is something like:
>=20
>     ds =3D spapr_pending_dimm_unplugs_find(spapr, dimm);
>     if (!ds) {
>         (...)
>     }
>     return ds;
>=20
> I think this is not worth sending a v3, David can amend it in the tree.
> After amending feel
> free to add my

Good point, amended.

>=20
> Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
>=20
>=20
>=20
>=20
> > >   }
> > >   static void spapr_pending_dimm_unplugs_remove(sPAPRMachineState *sp=
apr,
> > > @@ -2875,7 +2889,6 @@ static sPAPRDIMMState *spapr_recover_pending_di=
mm_state(sPAPRMachineState *ms,
> > >       uint32_t avail_lmbs =3D 0;
> > >       uint64_t addr_start, addr;
> > >       int i;
> > > -    sPAPRDIMMState *ds;
> > >       addr_start =3D object_property_get_int(OBJECT(dimm), PC_DIMM_AD=
DR_PROP,
> > >                                            &error_abort);
> > > @@ -2891,11 +2904,7 @@ static sPAPRDIMMState *spapr_recover_pending_d=
imm_state(sPAPRMachineState *ms,
> > >           addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> > >       }
> > > -    ds =3D g_malloc0(sizeof(sPAPRDIMMState));
> > > -    ds->nr_lmbs =3D avail_lmbs;
> > > -    ds->dimm =3D dimm;
> > > -    spapr_pending_dimm_unplugs_add(ms, ds);
> > > -    return ds;
> > > +    return spapr_pending_dimm_unplugs_add(ms, avail_lmbs, dimm);
> > >   }
> > >   /* Callback to be called during DRC release. */
> > > @@ -2911,6 +2920,7 @@ void spapr_lmb_release(DeviceState *dev)
> > >        * during the unplug process. In this case recover it. */
> > >       if (ds =3D=3D NULL) {
> > >           ds =3D spapr_recover_pending_dimm_state(spapr, PC_DIMM(dev)=
);
> > > +        g_assert(ds);
> > >           /* The DRC being examined by the caller at least must be co=
unted */
> > >           g_assert(ds->nr_lmbs);
> > >       }
> > > @@ -2942,18 +2952,13 @@ static void spapr_memory_unplug_request(Hotpl=
ugHandler *hotplug_dev,
> > >       uint64_t addr_start, addr;
> > >       int i;
> > >       sPAPRDRConnector *drc;
> > > -    sPAPRDIMMState *ds;
> > > -
> > >       addr_start =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_A=
DDR_PROP,
> > >                                            &local_err);
> > >       if (local_err) {
> > >           goto out;
> > >       }
> > > -    ds =3D g_malloc0(sizeof(sPAPRDIMMState));
> > > -    ds->nr_lmbs =3D nr_lmbs;
> > > -    ds->dimm =3D dimm;
> > > -    spapr_pending_dimm_unplugs_add(spapr, ds);
> > > +    spapr_pending_dimm_unplugs_add(spapr, nr_lmbs, dimm);
> > >       addr =3D addr_start;
> > >       for (i =3D 0; i < nr_lmbs; i++) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1YBwACgkQbDjKyiDZ
s5KkzRAAvbq+yyZEILwzvW9LtXQ4q6diFNNxvfkwOpnKKwLMhtn+9nZrhwKBQ/uJ
QBofxK3tOfj4rPanh6vbV8j9d1cyXXDm15xmc5TzPXGdP8mkeD+7OipxMonunpOK
sTfRScf3gcN8ZNw9FlPPqpMwlk5DCTVevt+1tDHio+MiOIMxTmceO6phja6DCaXi
oWoLtjCDUVaOsvHZLOf42bLOfYEtdQzJk1PDGBXR0u9bWUKs6OMU+g0pIQXKtxsf
L8RMzyBslvDiDa8koaxYfWiL2HCgK744XmCc0Gkt1OXf/pLpK5iHBTWEplvYCB9V
HeM5uOjkhs0uVRS+zyelijmJRArvYKlJPnLNAH7+HitTCDqCpnI/LEottvKOmJ6e
WOzuAGuxoz2kULAMTUIW+hYplEVSfc4PYRbxsLcNyf+/yAmOB6wm75FANxyl5f27
rqreICCQwMZPkdbxri2QDVwQVh5ioMWdFlQ1GkqNqvHaM+wGtAKkhECaxw4AI1pm
y22VwhZGVk4hcC1F8ajNrtqjU+5+AfNA0DuyVcyIR5r2CvIH6pXkuciVEzEq5AxD
WQo47gyVPfIUhVxBF3qiiboaC05/2wSLzq6qn/pLcyZ8MAq/iwTYpmu18Fz9liUD
egnywBLmcAKKt0rYZk0Ys4nI+Vb4aLq2NqFDj6HdChysV14RbrU=
=h8JG
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
