Received: from eggs.gnu.org ([2001:4830:134:3::10]:44157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcub-0006cl-10
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTcuX-0006BU-Rl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 20:48:21 -0400
Date: Fri, 15 Jun 2018 10:14:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615001431.GF4129@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901304242.252222.9947658955703347553.stgit@bahia.lan>
	<20180615000225.GC4129@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline
In-Reply-To: <20180615000225.GC4129@umbus.fritz.box>
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 10:02:25AM +1000, David Gibson wrote:
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
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Applied to ppc-for-3.0, since it definitely looks to fix some
> problems.

Uh.. actually it has a definite bug - the first exit point will call
g_free() on an uninitialized spapr_cpu.  I fixed it up with a NULL
initialization in my tree.

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
> > +    cpu_remove_sync(CPU(cpu));
>=20
> I'm a little unclear on exactly what init the cpu_remove_sync() is
> mirroring, though.
>=20
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
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjBOcACgkQbDjKyiDZ
s5KsXw/+IsGexI6d1Ka+ZjO9EpuIx3iUirTKD9rnra1SrjZN/HvtkdXmD+LbcLwW
KVnXHcmABW31MRQBwDeT3G84+rjZqPl7aMS9IJpBGduFGdyB2X0KumITDWFjDaql
A7qHwlxEQrE7qO7zME1Bhz97O2ovikFwkEn7R+dIGgGCKuI8d6M7fH8F5vhC/1ys
3XSz61QanqZbM1x5+1VdhwIa/hduRZ8n7OgMkPZEEfjVWMLTT80jScZ9OjBohyEP
03tfiYyLuGdE5ovhV6hEuL8GDV9yMazRvj8fEULj7cr6l/xPbFz0V27lfBSIPtiy
ikshHHMTZ9t8NHUcDHA16OtD+EBETJ5QsU8lopgHKLOGEY9rU9dM7FbUyvE8taUa
5cDqg1xZCjKhZ4QF3VST4sE03l6ozzoVtsCpjlgDd+ZG2oAlsBR62Co8pzmBe0DD
KL8iuBQUH+xjvNtQtXXfdBTmXbhCB5uRQf8JaEp6Ir7Hx9fEHKPOb9Az1MgMyeO8
ml6H11Ck3Hs50Om8S6J/ol6UAAKDaQkzd/fpu2ce1u00irYhxG7IO2tAdHGtaZ1P
+ydx0mCgrWb+vn3f33lUgp/wFpNBj4WMMX+QeXPvG2hgE3RyajDEdkQF/Hl+thcf
nTyeMT9hC2m7fReNqDxbPGGElgOyHV/XRZH4T2Jo9MUULmHM8i0=
=Gjyk
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--
