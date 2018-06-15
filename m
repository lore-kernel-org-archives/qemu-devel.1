Received: from eggs.gnu.org ([2001:4830:134:3::10]:34074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fThgE-0005wS-Nr
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 01:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fThgB-0007iK-MX
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 01:53:50 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:59305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fThgB-0007hH-Bq
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 01:53:47 -0400
Received: from player691.ha.ovh.net (unknown [10.109.105.67])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 34EB7B1E42
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 07:53:45 +0200 (CEST)
Date: Fri, 15 Jun 2018 07:53:37 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180615075337.16f1fca0@bahia.lan>
In-Reply-To: <20180615000225.GC4129@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901304242.252222.9947658955703347553.stgit@bahia.lan>
	<20180615000225.GC4129@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/ePo96nBFhDTWPg_pS4IttA9";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/5] spapr_cpu_core: add missing rollback
 on realization path
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

--Sig_/ePo96nBFhDTWPg_pS4IttA9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Jun 2018 10:02:25 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Jun 14, 2018 at 11:50:42PM +0200, Greg Kurz wrote:
> > The spapr_realize_vcpu() function doesn't rollback in case of error.
> > This isn't a problem with coldplugged CPUs because the machine won't
> > start and QEMU will exit. Hotplug is a different story though: the
> > CPU thread is started under object_property_set_bool() and it assumes
> > it can access the CPU object.
> >=20
> > If icp_create() fails, we return an error without unregistering the
> > reset handler for this CPU, and we let the underlying QEMU thread for
> > this CPU alive. Since spapr_cpu_core_realize() doesn't care to unrealize
> > already realized CPUs either, but happily frees all of them anyway, the
> > CPU thread crashes instantly:
> >=20
> > (qemu) device_add host-spapr-cpu-core,core-id=3D1,id=3Dgku
> > GKU: failing icp_create (cpu 0x11497fd0)
> >                              ^^^^^^^^^^
> > Program received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7fffee3feaa0 (LWP 24725)]
> > 0x00000000104c8374 in object_dynamic_cast_assert (obj=3D0x11497fd0,
> >                                                   ^^^^^^^^^^^^^^
> >                                              pointer to the CPU object
> > 623         trace_object_dynamic_cast_assert(obj ? obj->class->type->na=
me
> > (gdb) p obj->class->type
> > $1 =3D (Type) 0x0
> > (gdb) p * obj
> > $2 =3D {class =3D 0x10ea9c10, free =3D 0x11244620,
> >                                  ^^^^^^^^^^
> >                               should be g_free
> > (gdb) p g_free
> > $3 =3D {<text variable, no debug info>} 0x7ffff282bef0 <g_free>
> >=20
> > obj is a dangling pointer to the CPU that was just destroyed in
> > spapr_cpu_core_realize().
> >=20
> > This patch adds proper rollback to both spapr_realize_vcpu() and
> > spapr_cpu_core_realize().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Applied to ppc-for-3.0, since it definitely looks to fix some
> problems.
>=20
> > ---
> >  hw/ppc/spapr_cpu_core.c |   12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 003c4c5a79d2..04c818a6ecac 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -159,12 +159,16 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, s=
PAPRMachineState *spapr,
> >      spapr_cpu->icp =3D icp_create(OBJECT(cpu), spapr->icp_type,
> >                                  XICS_FABRIC(spapr), &local_err);
> >      if (local_err) {
> > -        goto error;
> > +        goto error_unregister;
> >      }
> > =20
> >      return;
> > =20
> > +error_unregister:
> > +    qemu_unregister_reset(spapr_cpu_reset, cpu);
> > +    cpu_remove_sync(CPU(cpu)); =20
>=20
> I'm a little unclear on exactly what init the cpu_remove_sync() is
> mirroring, though.
>=20

We have the same call in spapr_unrealize_vcpu(). IIUC it is mirroring
object_property_set_bool(OBJECT(cpu), true, "realized", &local_err).

> >  error:
> > +    g_free(spapr_cpu);
> >      error_propagate(errp, local_err);
> >  }
> > =20
> > @@ -222,11 +226,15 @@ static void spapr_cpu_core_realize(DeviceState *d=
ev, Error **errp)
> >      for (j =3D 0; j < cc->nr_threads; j++) {
> >          spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
> >          if (local_err) {
> > -            goto err;
> > +            goto err_unrealize;
> >          }
> >      }
> >      return;
> > =20
> > +err_unrealize:
> > +    while (--j >=3D 0) {
> > +        spapr_unrealize_vcpu(sc->threads[i]);
> > +    }
> >  err:
> >      while (--i >=3D 0) {
> >          obj =3D OBJECT(sc->threads[i]);
> >  =20
>=20


--Sig_/ePo96nBFhDTWPg_pS4IttA9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsjVGEACgkQcdTV5YIv
c9YdfQ//QTsSg4n80h//mgyfGHYwhppkE2KdQcnJyE81YZW/aO/+IQFUEcZW1l4i
e1hQcyuVJ4hisNEFSURemunV/945ZzDggFgpgRqASoCDwHLrEZZZck8QrdqHrmPK
yn9zDQuXtp5/qSq9DaHA+sr8jwAzD86MdK8bELfRBE/wMlUKsGzBDIv9BNC6Iv+B
Igyrl7VR4q921DaepV5vdIUMk1lRAOgpdyyXzWKOGLNhaPWp2/g6WhREgN7bNSyO
7LpnPeVyeSLAZwZXfej0G9/WOxVyOwgm/5sDEZez+nuEMHkHeSRaGBxoGwc5IMU1
ozpxl1+p50261hAzt+2hRsJoxMi7ch4oZbdY8Zoze4rsYqpl1H0zsiO1A62ukNIH
23479aX0rMd5YDHdUutsxWatUxqFQSOJzmodK7lENGAwMHC1Imr7EBe13U+OYsO+
GC1y7pW/7ndHNa8kPU+NoT/FpCTxxXtMB96cUy6KCuF51Iciq8/jeo2JdwyqNT91
vdFAmQTzGLN28TuC+FH9MsZMcy7y/Esb/5CCuxrMHwOoZeypAF77cRu3VMKGh4AA
EJrR0JE2GLgOYv8aL2LAPeo5VUBZQ0DXO583MdKtelTWwOdNBqklzgQ1nQ1UN7OY
DQ3JulzF+HbUVo7Gnm/S9dgax7It5ZAhQLBAaPWD1YZOt3A2Uos=
=pdzn
-----END PGP SIGNATURE-----

--Sig_/ePo96nBFhDTWPg_pS4IttA9--
