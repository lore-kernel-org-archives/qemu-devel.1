Received: from eggs.gnu.org ([2001:4830:134:3::10]:56233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSIUE-0007XJ-Ea
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSIUB-0000Xc-6N
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:43:06 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:50636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSIUA-0000WH-Uv
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 03:43:03 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id CAAAB7DBA1
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 09:42:59 +0200 (CEST)
Date: Tue, 4 Jul 2017 09:42:52 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170704094252.7dc1cac5@bahia.lan>
In-Reply-To: <69bd5d32-3f59-b28a-38e8-25952fecee10@linux.vnet.ibm.com>
References: <149909367669.21100.17690903693542179077.stgit@bahia.lan>
	<69bd5d32-3f59-b28a-38e8-25952fecee10@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/qxtVwTOKO59D+732U7DkBBA";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: fix memory hotplug
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/qxtVwTOKO59D+732U7DkBBA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 3 Jul 2017 14:03:07 -0300
Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:

> On 07/03/2017 11:54 AM, Greg Kurz wrote:
> > QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
> > Let's propagate the error instead, like it is done everywhere else
> > where spapr_drc_attach() is called.
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > Changes in v2: - added rollback code
> > ---
> >   hw/ppc/spapr.c |   26 ++++++++++++++++++++++----
> >   1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 70b3fd374e2b..ba8f57a5a054 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
> >       int i, fdt_offset, fdt_size;
> >       void *fdt;
> >       uint64_t addr =3D addr_start;
> > +    Error *local_err =3D NULL;
> >
> >       for (i =3D 0; i < nr_lmbs; i++) {
> >           drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> > @@ -2611,7 +2612,18 @@ static void spapr_add_lmbs(DeviceState *dev, uin=
t64_t addr_start, uint64_t size,
> >           fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
> >                                                   SPAPR_MEMORY_BLOCK_SI=
ZE);
> >
> > -        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> > +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > +        if (local_err) {
> > +            while (addr > addr_start) {
> > +                addr -=3D SPAPR_MEMORY_BLOCK_SIZE;
> > +                drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> > +                                      addr / SPAPR_MEMORY_BLOCK_SIZE);
> > +                spapr_drc_detach(drc, dev, NULL); =20
>=20
> Question: why pass NULL instead of '&local_err' in detach() ?

local_err already contains the error returned by spapr_drc_attach(), it
cannot be used anymore.

> Can we ignore any
> any error that happens in detach() because you're propagating the=20
> local_err set
> in spapr_drc_attach() already?
>=20

This is a rollback path: the best we can do is to try to undo the
already attached DRCs...

> ps: I am aware that ATM detach() does not propagate anything to the errp=
=20
> being
> passed. I don't think it's wise to write new code based on this=20
> assumption though.
>=20

... and indeed detach() cannot fail with the current code base. :)

David was even planning to drop the errp argument in the "spapr:
Refactor spapr_drc_detach()" patch.

Otherwise, maybe pass &error_abort since failing to rollback is
likely to be a bug ?

Cheers,

--
Greg

>=20
> Thanks,
>=20
>=20
> Daniel
>=20
> > +            }
> > +            g_free(fdt);
> > +            error_propagate(errp, local_err);
> > +            return;
> > +        }
> >           addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> >       }
> >       /* send hotplug notification to the
> > @@ -2651,14 +2663,20 @@ static void spapr_memory_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> >       addr =3D object_property_get_uint(OBJECT(dimm),
> >                                       PC_DIMM_ADDR_PROP, &local_err);
> >       if (local_err) {
> > -        pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
> > -        goto out;
> > +        goto out_unplug;
> >       }
> >
> >       spapr_add_lmbs(dev, addr, size, node,
> >                      spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
> > -                   &error_abort);
> > +                   &local_err);
> > +    if (local_err) {
> > +        goto out_unplug;
> > +    }
> > +
> > +    return;
> >
> > +out_unplug:
> > +    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
> >   out:
> >       error_propagate(errp, local_err);
> >   }
> >
> > =20
>=20


--Sig_/qxtVwTOKO59D+732U7DkBBA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllbRvwACgkQAvw66wEB28JTJACgiflJOQWs5+K9HmnsuBBhny+2
xNIAoI/1QPFMrD9Wu1swLI2AIkEgdWck
=FW4G
-----END PGP SIGNATURE-----

--Sig_/qxtVwTOKO59D+732U7DkBBA--
