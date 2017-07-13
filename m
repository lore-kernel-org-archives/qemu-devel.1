Received: from eggs.gnu.org ([2001:4830:134:3::10]:37263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVUrT-0001gG-Gk
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 23:32:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVUrO-0002FL-S1
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 23:32:19 -0400
Date: Thu, 13 Jul 2017 13:31:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170713033137.GW4083@umbus.fritz.box>
References: <149985291912.20899.12562819149683053534.stgit@bahia.lan>
	<20170712102237.GB5377@in.ibm.com>
	<20170712131130.05a248cd@bahia.lan>
	<20170713032458.GC5377@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xsILJLaVOAbiPmXa"
Content-Disposition: inline
In-Reply-To: <20170713032458.GC5377@in.ibm.com>
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
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--xsILJLaVOAbiPmXa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 08:54:58AM +0530, Bharata B Rao wrote:
> On Wed, Jul 12, 2017 at 01:11:30PM +0200, Greg Kurz wrote:
> > On Wed, 12 Jul 2017 15:52:37 +0530
> > Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> >=20
> > > On Wed, Jul 12, 2017 at 11:48:39AM +0200, Greg Kurz wrote:
> > > > Since commit 5c1da81215c7 ("spapr: Remove unnecessary differences b=
etween
> > > > hotplug and coldplug paths"), the CPU DT for the DRC is always allo=
cated.
> > > > This causes a memory leak for pseries-2.6 and older machine types, =
that
> > > > don't support CPU hotplug and don't allocate DRCs for CPUs.
> > > >=20
> > > > Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/ppc/spapr.c |    9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 12b3f099d4c9..4a480e1c1dd9 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -2993,8 +2993,6 @@ static void spapr_core_plug(HotplugHandler *h=
otplug_dev, DeviceState *dev,
> > > >      CPUState *cs =3D CPU(core->threads);
> > > >      sPAPRDRConnector *drc;
> > > >      Error *local_err =3D NULL;
> > > > -    void *fdt =3D NULL;
> > > > -    int fdt_offset =3D 0;
> > > >      int smt =3D kvmppc_smt_threads();
> > > >      CPUArchId *core_slot;
> > > >      int index;
> > > > @@ -3009,9 +3007,12 @@ static void spapr_core_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
> > > >=20
> > > >      g_assert(drc || !mc->has_hotpluggable_cpus);
> > > >=20
> > > > -    fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
> > > > -
> > > >      if (drc) {
> > > > +        void *fdt;
> > > > +        int fdt_offset;
> > > > +
> > > > +        fdt =3D spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spa=
pr);
> > > > +
> > > >          spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > > >          if (local_err) {
> > > >              g_free(fdt); =20
> > >=20
> > > You say this in the patch description already, but want to note expli=
citly
> > > that this prevents double allocation for pseries-2.6 and ealier types=
 and
> > > not for newer machine types.
> > >=20
> >=20
> > This DT node doesn't have the exact same use as the one allocated in
> > spapr_populate_cpus_dt_node(). Here, it is needed by the DRC logic:
>=20
> What I mean to say is that even after this fix, for machines types > 2.6,=
 we
> still allocate memory for FDT and go through the code that creates DT ent=
ries
> for CPUs twice. What we create via spapr_populate_cpus_dt_node() is used
> while the CPU DT entries created by spapr_populate_hotplug_cpu_dt() won't
> be used and corresponding drc->fdt is never freed, afaics for boot time
> and cold-plugged CPUs.

Sure, I just don't care that much.  It's not a leak in the sense that
it can continue to lose memory - it just means we allocate (and track)
a bit more than we need to.

> May be this can be fixed during DT code reorg effort that David is
> planning.

Maybe.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xsILJLaVOAbiPmXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZumXAAoJEGw4ysog2bOSAXQP/3F2ZN4Mj6aUdzJK058TGWNv
J0PoVwtJ/fZo74lNguQyUMDUO3J1bUQZi5SPSBJRTfI3ImvgMSDnRJc8vF3kriCo
s/fEZ8+LyLJk27KI8cHe81ZRHW2gph5Rm8FBhcqcawRaa2pu9VrOl3NBC8h3BdbS
zqyMKzK9DWIN4hqJVE0cgCyOyQep1TBbX/AG/y+HfxY9QBLjFkAkfQ37ynlyRZA5
v7t9UL19hTrwuv4x0W9pCfsKrTYHF4aX8UWpvecccFJcsZ0jjxmp+jBf41npMXMy
KCKV9m2zh8lmXv4+RGoL0Debc3mkBaRGGe28Oo2i83OfDh9G5PF8TRbhRsWPI7oK
KLgph3/fsKqQASobwziNgitZS8zFkVkQ8g/lYWv0EiHbakmjWGGsy1CvuSFsApeF
2g0D+2rKWvseAEgA193webM6vT7/yHsM+tlQW1wiM+u+AmBvGGfGUtu+bp/rDYr8
+dClJnr1NCXp7KiPSVIQkjS4XJlqbdX47j6G/TOZoSxiSFiki3/crGB1uWGZKfB3
ZHkRo5wmFP3HSml6O299fxtVfIXF63b0CbKLpkTG2zqQAC+90ROOpuWSlWVIRU8T
jdQdKHym+jU8Dak4SmxpNheXvmdNv/RUUnfalLhKIhjLIx20nhi4DRTaBuE1NSxv
/fvoIMORAoLVjtB5QCiN
=3mJU
-----END PGP SIGNATURE-----

--xsILJLaVOAbiPmXa--
