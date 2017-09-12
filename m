Received: from eggs.gnu.org ([2001:4830:134:3::10]:35292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpS-0004fK-VG
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1drcpP-0005OO-SG
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 00:29:42 -0400
Date: Tue, 12 Sep 2017 13:58:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170912035835.GB2774@umbus.fritz.box>
References: <150516425752.1593.1536226898929735667.stgit@bahia.lan>
	<20170912032753.GA2774@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <20170912032753.GA2774@umbus.fritz.box>
Subject: Re: [Qemu-devel] [PATCH v2] spapr_cpu_core: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 01:27:53PM +1000, David Gibson wrote:
> On Mon, Sep 11, 2017 at 11:10:57PM +0200, Greg Kurz wrote:
> > This patch removes the qdev_get_machine() calls that are made
> > in spapr_cpu_core.c in situations where we can get an existing
> > pointer for the MachineState by either passing it as an argument
> > to the function or by using other already available pointers.
> >=20
> > Credits to Daniel Henrique Barboza for the idea and the changelog
> > text.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v2: - fixed typo in spapr_cpu_reset()
>=20
> Applied to ppc-for-2.11.

Wait... no.  The second hunk is fine, but the first isn't.

>=20
> > ---
> >  hw/ppc/spapr_cpu_core.c |    8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index dc9df0d393d1..0f32532abe99 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -73,8 +73,8 @@ void spapr_cpu_parse_features(sPAPRMachineState *spap=
r)
> > =20
> >  static void spapr_cpu_reset(void *opaque)
> >  {
> > -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >      PowerPCCPU *cpu =3D opaque;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(cpu->vhyp);

Although we prefer to avoid the global when we can, it's preferable to
breaking abstraction by maching the machine reach into the cpu
internals here.

Arguably, instead of having this special machine-registered cpu reset
function we should instead have a hook in vhyp which is called by the
cpu core's reset function, but that would be a different change.

> >      CPUState *cs =3D CPU(cpu);
> >      CPUPPCState *env =3D &cpu->env;
> > =20
> > @@ -162,10 +162,10 @@ static void spapr_cpu_core_unrealizefn(DeviceStat=
e *dev, Error **errp)
> >      g_free(sc->threads);
> >  }
> > =20
> > -static void spapr_cpu_core_realize_child(Object *child, Error **errp)
> > +static void spapr_cpu_core_realize_child(Object *child,
> > +                                         sPAPRMachineState *spapr, Err=
or **errp)
> >  {
> >      Error *local_err =3D NULL;
> > -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> >      CPUState *cs =3D CPU(child);
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >      Object *obj;
> > @@ -254,7 +254,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> >      for (j =3D 0; j < cc->nr_threads; j++) {
> >          obj =3D sc->threads + j * size;
> > =20
> > -        spapr_cpu_core_realize_child(obj, &local_err);
> > +        spapr_cpu_core_realize_child(obj, spapr, &local_err);
> >          if (local_err) {
> >              goto err;
> >          }
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm3W2kACgkQbDjKyiDZ
s5Izaw//XWK3L/tTJPbgb1VJmXBALCpf/YfzKZR4ddsIPZSF8Xh2t/8af9u1gTP0
9DEeu9oQBGrrjkRi5A2UikW34bLPiBqAVHZ6AuEfv8Di+Yiw/0HabNPBzk5FqlRL
td75ltHZ9BufqWKyrtPaxxZUwsJErsg6vMVAK+CwYvdng4hu0wNcCSz5sDcAWFC8
5MysJQ9XSPIwOxiPes04hIDGFb0mBPcsJzaB4MnTDnOd88aDyni1r43B90OAtRC2
FqBoncrJ/AxvPBMottk7+5Mq2gwwBLSB0+YX1wcfzofLonOG8w8Zn/S+92qiOD2s
sV56YaOz1ukyNcSk93/pdhy5JsqqpnQvYQunntiyzekC/qbdO53pw/LCIXLRtiPl
pmQeaZV3bsL/qHYbUHeftVoMZTlDCZcFatGZlMbbnYQ7O0eoL/mIN/+6ldzMWGMC
QyAXw10WzOT9YEa7whb2xP4r/MAJeM7ofgnOLTMB5fWTbMEuWPCid64at7GhbvLy
afhnGUfjxqOEhX7eeZWfwyUGLUS4F+tYMobdxv0MZQz2J0jgkTx34aJXp7AJ/IAk
FWKOfxlUU1YhC4xKfkoIwadvfBxAvuZxxP+Y22vuAWJ68P5f/3CSMrOvXT8ydjvT
odFQTnPHZruvSZIX5M9J/G4msR7lt8T/I1WhNcEfHHMZKpgYNHQ=
=qq4q
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
