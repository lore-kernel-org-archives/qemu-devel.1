Received: from eggs.gnu.org ([2001:4830:134:3::10]:44600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dS2RA-0003Gc-4X
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dS2R7-0008OZ-0k
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:34:52 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:49884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dS2R6-0008Nf-Pe
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:34:48 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 4B09B817D9
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 16:34:46 +0200 (CEST)
Date: Mon, 3 Jul 2017 16:34:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170703163437.48721aee@bahia.lan>
In-Reply-To: <20170703154326.030e08bc@nial.brq.redhat.com>
References: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
	<20170703154326.030e08bc@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/ELhdQ7_vUwGgCPqVqDnJoxO";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: fix memory hotplug error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>

--Sig_/ELhdQ7_vUwGgCPqVqDnJoxO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jul 2017 15:43:26 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Mon, 03 Jul 2017 14:21:31 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
> > Let's propagate the error instead, like it is done everywhere else
> > where spapr_drc_attach() is called.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 70b3fd374e2b..e103be500189 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
> >      int i, fdt_offset, fdt_size;
> >      void *fdt;
> >      uint64_t addr =3D addr_start;
> > +    Error *local_err =3D NULL;
> > =20
> >      for (i =3D 0; i < nr_lmbs; i++) {
> >          drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> > @@ -2611,7 +2612,12 @@ static void spapr_add_lmbs(DeviceState *dev, uin=
t64_t addr_start, uint64_t size,
> >          fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
> >                                                  SPAPR_MEMORY_BLOCK_SIZ=
E);
> > =20
> > -        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> > +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > +        if (local_err) {
> > +            g_free(fdt);
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> >          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> >      }
> >      /* send hotplug notification to the
> > @@ -2657,7 +2663,7 @@ static void spapr_memory_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
> > =20
> >      spapr_add_lmbs(dev, addr, size, node,
> >                     spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> > -                   &error_abort);
> > +                   &local_err); =20
> where is code that handles error condition?
>  i.e. undo what pc_dimm_memory_plug() has done
>=20

Oops, you're right and I also need to add some rollback in
spapr_add_lmbs() as well... :-\

> > =20
> >  out:
> >      error_propagate(errp, local_err);
> >=20
> >  =20
>=20


--Sig_/ELhdQ7_vUwGgCPqVqDnJoxO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllaVf0ACgkQAvw66wEB28K5ugCfYKuwUmi6dIrP61Vvlx0f3Yb1
OmcAn3pLU53o4vZOpxBUE5uFtf2I4/rA
=N7ih
-----END PGP SIGNATURE-----

--Sig_/ELhdQ7_vUwGgCPqVqDnJoxO--
