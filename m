Received: from eggs.gnu.org ([2001:4830:134:3::10]:38526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVFYU-0002KQ-Nb
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVFYP-0001qH-Ne
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:11:42 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:32923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVFYP-0001pX-H4
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:11:37 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id E65B167EB7
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 13:11:35 +0200 (CEST)
Date: Wed, 12 Jul 2017 13:11:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170712131130.05a248cd@bahia.lan>
In-Reply-To: <20170712102237.GB5377@in.ibm.com>
References: <149985291912.20899.12562819149683053534.stgit@bahia.lan>
	<20170712102237.GB5377@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/KiU0yxEzEf2pNQH_IltZ7Qr";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: fix potential memory leak in
 spapr_core_plug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

--Sig_/KiU0yxEzEf2pNQH_IltZ7Qr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2017 15:52:37 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> On Wed, Jul 12, 2017 at 11:48:39AM +0200, Greg Kurz wrote:
> > Since commit 5c1da81215c7 ("spapr: Remove unnecessary differences betwe=
en
> > hotplug and coldplug paths"), the CPU DT for the DRC is always allocate=
d.
> > This causes a memory leak for pseries-2.6 and older machine types, that
> > don't support CPU hotplug and don't allocate DRCs for CPUs.
> >=20
> > Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c |    9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 12b3f099d4c9..4a480e1c1dd9 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2993,8 +2993,6 @@ static void spapr_core_plug(HotplugHandler *hotpl=
ug_dev, DeviceState *dev,
> >      CPUState *cs =3D CPU(core->threads);
> >      sPAPRDRConnector *drc;
> >      Error *local_err =3D NULL;
> > -    void *fdt =3D NULL;
> > -    int fdt_offset =3D 0;
> >      int smt =3D kvmppc_smt_threads();
> >      CPUArchId *core_slot;
> >      int index;
> > @@ -3009,9 +3007,12 @@ static void spapr_core_plug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
> >=20
> >      g_assert(drc || !mc->has_hotpluggable_cpus);
> >=20
> > -    fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> > -
> >      if (drc) {
> > +        void *fdt;
> > +        int fdt_offset;
> > +
> > +        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> > +
> >          spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> >          if (local_err) {
> >              g_free(fdt); =20
>=20
> You say this in the patch description already, but want to note explicitly
> that this prevents double allocation for pseries-2.6 and ealier types and
> not for newer machine types.
>=20

This DT node doesn't have the exact same use as the one allocated in
spapr_populate_cpus_dt_node(). Here, it is needed by the DRC logic:

$ git grep 'drc->fdt' hw/ppc/spapr_drc.c
hw/ppc/spapr_drc.c:    if (!drc->fdt) {
hw/ppc/spapr_drc.c:    fdt =3D drc->fdt;
hw/ppc/spapr_drc.c:    fdt_offset =3D drc->fdt_start_offset;
hw/ppc/spapr_drc.c:    drc->fdt =3D fdt;
hw/ppc/spapr_drc.c:    drc->fdt_start_offset =3D fdt_start_offset;
hw/ppc/spapr_drc.c:    g_free(drc->fdt);
hw/ppc/spapr_drc.c:    drc->fdt =3D NULL;
hw/ppc/spapr_drc.c:    drc->fdt_start_offset =3D 0;
hw/ppc/spapr_drc.c:    if (!drc->fdt) {
hw/ppc/spapr_drc.c:        ccs->fdt_offset =3D drc->fdt_start_offset;
hw/ppc/spapr_drc.c:        tag =3D fdt_next_tag(drc->fdt, ccs->fdt_offset, =
&fdt_offset_next);
hw/ppc/spapr_drc.c:            name =3D fdt_get_name(drc->fdt, ccs->fdt_off=
set, NULL);
hw/ppc/spapr_drc.c:            prop =3D fdt_get_property_by_offset(drc->fdt=
, ccs->fdt_offset,
hw/ppc/spapr_drc.c:            name =3D fdt_string(drc->fdt, fdt32_to_cpu(p=
rop->nameoff));

and

void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
                      int fdt_start_offset, Error **errp)
{
    ...
    g_assert(fdt);

So I'm not sure it is worth to mention the double allocation.

Cheers,

--
Greg

> Regards,
> Bharata.
>=20


--Sig_/KiU0yxEzEf2pNQH_IltZ7Qr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllmA+IACgkQAvw66wEB28KiLwCff+2AXt+7NOu1aIC11ZPXmeag
o0cAnjT6EMt5IvtZyN9x6m/lIR2H9NAx
=4NEW
-----END PGP SIGNATURE-----

--Sig_/KiU0yxEzEf2pNQH_IltZ7Qr--
