Received: from eggs.gnu.org ([2001:4830:134:3::10]:60794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSInT-0000qA-GA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSInQ-0003Gz-BT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:02:59 -0400
Received: from 12.mo4.mail-out.ovh.net ([178.33.104.253]:57265)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSInQ-0003F6-3x
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:02:56 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7EA797AB8E
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 10:02:53 +0200 (CEST)
Date: Tue, 4 Jul 2017 10:02:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170704100246.37100aa1@bahia.lan>
In-Reply-To: <20170704035050.GB7689@in.ibm.com>
References: <149908449117.14256.2821600309813941055.stgit@bahia.lan>
	<20170704033143.GA7689@in.ibm.com>
	<20170704035050.GB7689@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/./1JeioI.qsHADOQ.isEBpV";
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
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/./1JeioI.qsHADOQ.isEBpV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Jul 2017 09:20:50 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> On Tue, Jul 04, 2017 at 09:01:43AM +0530, Bharata B Rao wrote:
> > On Mon, Jul 03, 2017 at 02:21:31PM +0200, Greg Kurz wrote: =20
> > > QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
> > > Let's propagate the error instead, like it is done everywhere else
> > > where spapr_drc_attach() is called.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/ppc/spapr.c |   10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 70b3fd374e2b..e103be500189 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, ui=
nt64_t addr_start, uint64_t size,
> > >      int i, fdt_offset, fdt_size;
> > >      void *fdt;
> > >      uint64_t addr =3D addr_start;
> > > +    Error *local_err =3D NULL;
> > >=20
> > >      for (i =3D 0; i < nr_lmbs; i++) {
> > >          drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> > > @@ -2611,7 +2612,12 @@ static void spapr_add_lmbs(DeviceState *dev, u=
int64_t addr_start, uint64_t size,
> > >          fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
> > >                                                  SPAPR_MEMORY_BLOCK_S=
IZE);
> > >=20
> > > -        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> > > +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > > +        if (local_err) {
> > > +            g_free(fdt);
> > > +            error_propagate(errp, local_err);
> > > +            return;
> > > +        } =20
> >=20
> > There is some history to this. I was doing error recovery and propagati=
on
> > here similarly during memory hotplug development phase until Igor
> > suggested that we shoudn't try to recover after we have done guest
> > visible changes.
> >=20
> > Refer to "changes in v6" section in this post:
> > https://lists.gnu.org/archive/html/qemu-ppc/2015-06/msg00296.html
> >=20
> > However at that time we were doing memory add by DRC index method
> > and hence would attach and online one LMB at a time.
> > In that method, if an intermediate attach fails we would end up with a =
few
> > LMBs being onlined by the guest already. However subsequently
> > we have switched (optionally, based on dedicated_hp_event_source) to
> > count-indexed method of hotplug where we do attach of all LMBs one by o=
ne
> > and then request the guest to hotplug all of them at once using count-i=
ndexed
> > method.
> >=20
> > So it will be a bit tricky to abort for index based case and recover
> > correctly for count-indexed case. =20
>=20
> Looked at the code again and realized that though we started with
> index based LMB addition, we later switched to count based addition. Then
> we added support for count-indexed type subject to the presence
> of dedidated hotplug event source while still retaining the support
> for count based addition.
>=20
> So presently we do attach of all LMBs one by one and then do onlining
> (count based or count-indexed based) once. Hence error recovery
> for both cases would be similar now. So I guess you should take care of
> undoing pc_dimm_memory_plug() like Igor mentioned and also undo the
> effects of partial successful attaches.
>=20

I've sent a v2 that adds rollback.

Cheers,

--
Greg


> >=20
> > Regards,
> > Bharata. =20
>=20


--Sig_/./1JeioI.qsHADOQ.isEBpV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllbS6YACgkQAvw66wEB28IuvACff2MWksrneqcT3CPqeDXMEwel
MOcAoIHE/5EcpMqltw3yh+pKOH94T6v1
=47pn
-----END PGP SIGNATURE-----

--Sig_/./1JeioI.qsHADOQ.isEBpV--
