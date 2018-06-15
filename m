Received: from eggs.gnu.org ([2001:4830:134:3::10]:42383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTigF-0001JR-Q9
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 02:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTigC-0000Eo-OO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 02:57:55 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:50837)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTigC-0000DT-EH
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 02:57:52 -0400
Received: from player688.ha.ovh.net (unknown [10.109.120.60])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 56A12B6869
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 08:57:50 +0200 (CEST)
Date: Fri, 15 Jun 2018 08:57:43 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180615085743.10d0cd62@bahia.lan>
In-Reply-To: <20180615000829.GE4129@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901307192.252222.7502403316148525219.stgit@bahia.lan>
	<20180615000829.GE4129@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/fCNDUCHE0PsSPk/g9fWBJCO";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 5/5] spapr_cpu_core: simplify
 spapr_cpu_core_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>

--Sig_/fCNDUCHE0PsSPk/g9fWBJCO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Jun 2018 10:08:29 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 14, 2018 at 11:51:11PM +0200, Greg Kurz wrote:
> > There's no real reason to create all CPUs in a first pass and to realize
> > them in a second pass. Merging these two loops makes the code simpler.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> I'm a bit uncertain about this one.  It's correct at the moment, but
> I'm wondering if there might be things we want to do wile the cpu
> objects are constructed, but not initialized.
>=20

Yeah, I thought about that also, but I couldn't find any case...

> In fact, I thought I wanted something like that for allowing earlier
> initialization of the default caps values, though in the end I found a
> simpler and better approach.
>=20
> So, I'm holding off on this one for the time being.
>=20

Sure.

> > ---
> >  hw/ppc/spapr_cpu_core.c |   25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 0ebaf804a9bc..f52af20e0096 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -172,7 +172,8 @@ error:
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > -static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error **=
errp)
> > +static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i,
> > +                                     sPAPRMachineState *spapr, Error *=
*errp)
> >  {
> >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(sc);
> >      CPUCore *cc =3D CPU_CORE(sc);
> > @@ -201,9 +202,16 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore =
*sc, int i, Error **errp)
> >          goto err;
> >      }
> > =20
> > +    spapr_realize_vcpu(cpu, spapr, &local_err);
> > +    if (local_err) {
> > +        goto err_unparent;
> > +    }
> > +
> >      object_unref(obj);
> >      return cpu;
> > =20
> > +err_unparent:
> > +    object_unparent(obj);
> >  err:
> >      object_unref(obj);
> >      error_propagate(errp, local_err);
> > @@ -212,6 +220,7 @@ err:
> > =20
> >  static void spapr_delete_vcpu(PowerPCCPU *cpu)
> >  {
> > +    spapr_unrealize_vcpu(cpu);
> >      object_unparent(OBJECT(cpu));
> >  }
> > =20
> > @@ -226,7 +235,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> >      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> >      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> >      Error *local_err =3D NULL;
> > -    int i, j;
> > +    int i;
> > =20
> >      if (!spapr) {
> >          error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine=
");
> > @@ -235,24 +244,14 @@ static void spapr_cpu_core_realize(DeviceState *d=
ev, Error **errp)
> > =20
> >      sc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
> >      for (i =3D 0; i < cc->nr_threads; i++) {
> > -        sc->threads[i] =3D spapr_create_vcpu(sc, i, &local_err);
> > +        sc->threads[i] =3D spapr_create_vcpu(sc, i, spapr, &local_err);
> >          if (local_err) {
> >              goto err;
> >          }
> >      }
> > =20
> > -    for (j =3D 0; j < cc->nr_threads; j++) {
> > -        spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
> > -        if (local_err) {
> > -            goto err_unrealize;
> > -        }
> > -    }
> >      return;
> > =20
> > -err_unrealize:
> > -    while (--j >=3D 0) {
> > -        spapr_unrealize_vcpu(sc->threads[i]);
> > -    }
> >  err:
> >      while (--i >=3D 0) {
> >          spapr_delete_vcpu(sc->threads[i]);
> >  =20
>=20


--Sig_/fCNDUCHE0PsSPk/g9fWBJCO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsjY2cACgkQcdTV5YIv
c9YFKQ/+KWloitsQSdnxLsVuP0oL9s4ArOD2o7lpdRi1RjVBr9qhbs/ax/9yNX2B
QZ3kbobqN//jA+F4vGCdW5Vtw6cSGmXmLnW3KukunpPPMx94kC8Krs+G+BkvhAMi
Q+102TRbzKpGl9Rl1D7JsSRx2x1FLe2RzgPITab2MTloX1roINSJh0MVGliTZQiN
SElKGk1k7/OoEi2OMcv+zDMMnpw765mQDN4Y8r1ioq2SuIp2tVJzMxwg29i92bXv
3i08QvU9wECgXB93cOTeIza86FEZjpW0vZrMY/wwM/ESZIbRq9EmS6mfKHvBCqkO
yuHqM0WFVja9ZhBt5E9FgdDB/ghFFzLlgN4W4/viDcc29hH5a0InogksAaDqCjmw
V67JNXjUwVJJczJEGM5quBv0y6ECo7hrltt2qK/CwnTAtww69ikCrsnipAbxd0kk
gqaCi6INC3q8+D/9mjyAqz+9t0wu4+Y5V/y2f9Bc9qIENDeljQ3A1jF/xI6b3zTj
TzxMnwOBDbzhd7gCxKimJC/gMITzvvd1ea9PP/7kS0TxOtbd/4IkAmr/xMVg/dhd
u09x5HioktqSykOEPLHzx6p1hnZ3LMnerKm8buTcNf68L/4d9z7Rv3i8jDwBQ/mp
vQtRNkGb3tpu6ncwMfQ96XDL583eJVtQksZDhYwywTePwuk+4Jg=
=LCXI
-----END PGP SIGNATURE-----

--Sig_/fCNDUCHE0PsSPk/g9fWBJCO--
