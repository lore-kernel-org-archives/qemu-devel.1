Received: from eggs.gnu.org ([2001:4830:134:3::10]:40092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVDy7-0000NL-5S
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVDy4-0005DA-1z
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:30:03 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:60682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVDy3-0005CW-Rs
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:30:00 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 61B866C071
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 11:29:57 +0200 (CEST)
Date: Wed, 12 Jul 2017 11:29:44 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170712112944.7bf0f568@bahia.lan>
In-Reply-To: <20170712082637.GA5377@in.ibm.com>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
	<20170711043917.1757-10-david@gibson.dropbear.id.au>
	<20170712082637.GA5377@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Dnnk03HXTrv7/9Z0tXU6uzx";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 09/17] spapr: Remove unnecessary differences
 between hotplug and coldplug paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/Dnnk03HXTrv7/9Z0tXU6uzx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2017 13:56:37 +0530
Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:

> On Tue, Jul 11, 2017 at 02:39:09PM +1000, David Gibson wrote:
> > spapr_drc_attach() has a 'coldplug' parameter which sets the DRC into
> > configured state initially, instead of the usual ISOLATED/UNUSABLE stat=
e.
> > It turns out this is unnecessary: although coldplugged devices do need =
to
> > be in CONFIGURED state once the guest starts, that will already be
> > accomplished by the reset code which will move DRCs for already plugged
> > devices into a coldplug equivalent state.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c             | 13 +++----------
> >  hw/ppc/spapr_drc.c         |  5 ++---
> >  hw/ppc/spapr_pci.c         |  3 +--
> >  include/hw/ppc/spapr_drc.h |  2 +-
> >  4 files changed, 7 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 4fa982d..70b3fd3 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2611,7 +2611,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
> >          fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
> >                                                  SPAPR_MEMORY_BLOCK_SIZ=
E);
> >=20
> > -        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, =
errp);
> > +        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> >          addr +=3D SPAPR_MEMORY_BLOCK_SIZE;
> >      }
> >      /* send hotplug notification to the
> > @@ -2956,17 +2956,10 @@ static void spapr_core_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
> >=20
> >      g_assert(drc || !mc->has_hotpluggable_cpus);
> >=20
> > -    /*
> > -     * Setup CPU DT entries only for hotplugged CPUs. For boot time or
> > -     * coldplugged CPUs DT entries are setup in spapr_build_fdt().
> > -     */
> > -    if (dev->hotplugged) {
> > -        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> > -    }
> > +    fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr); =20
>=20
> A harmless (but still good to get rid of) side effect of this change is

Well, not that harmless... this is leaked for machine types that don't
support CPU hotplug. I'll send a patch.

> that we are now building the CPU device tree for boot time and cold-plugg=
ed
> CPUs twice:
>=20
> first from spapr_core_plug() -> spapr_populate_hotplug_cpu_dt()
> second from spapr_build_fdt() -> spapr_populate_cpus_dt_node()
>=20
> The first one is not used while the 2nd one acutally ends up building
> the CPUs DT entries for the boot time and cold-plugged CPUs.
>=20
> Regards,
> Bharata.
>=20


--Sig_/Dnnk03HXTrv7/9Z0tXU6uzx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlll7AgACgkQAvw66wEB28Jm/wCZAdfB1ejySWmwNqSZplPAyVRp
LYsAn22ctjlz0prVP1AA9umK4pAQk9+o
=w48z
-----END PGP SIGNATURE-----

--Sig_/Dnnk03HXTrv7/9Z0tXU6uzx--
