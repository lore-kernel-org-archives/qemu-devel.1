Received: from eggs.gnu.org ([2001:4830:134:3::10]:33483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTnuQ-0006yU-GE
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTnuP-0006c4-4g
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:32:54 -0400
Date: Fri, 15 Jun 2018 22:32:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615123244.GB2363@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901304242.252222.9947658955703347553.stgit@bahia.lan>
	<20180615000225.GC4129@umbus.fritz.box>
	<20180615001431.GF4129@umbus.fritz.box>
	<20180615075805.1213ed06@bahia.lan>
	<20180615062915.GU4129@umbus.fritz.box>
	<20180615090724.6755df6f@bahia.lan>
	<20180615100147.0acfa6f2@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20180615100147.0acfa6f2@bahia.lan>
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


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 10:01:47AM +0200, Greg Kurz wrote:
> On Fri, 15 Jun 2018 09:07:24 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Fri, 15 Jun 2018 16:29:15 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Fri, Jun 15, 2018 at 07:58:05AM +0200, Greg Kurz wrote: =20
> > > > On Fri, 15 Jun 2018 10:14:31 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > On Fri, Jun 15, 2018 at 10:02:25AM +1000, David Gibson wrote:   =
=20
> > > > > > On Thu, Jun 14, 2018 at 11:50:42PM +0200, Greg Kurz wrote:     =
=20
> > > > > > > The spapr_realize_vcpu() function doesn't rollback in case of=
 error.
> > > > > > > This isn't a problem with coldplugged CPUs because the machin=
e won't
> > > > > > > start and QEMU will exit. Hotplug is a different story though=
: the
> > > > > > > CPU thread is started under object_property_set_bool() and it=
 assumes
> > > > > > > it can access the CPU object.
> > > > > > >=20
> > > > > > > If icp_create() fails, we return an error without unregisteri=
ng the
> > > > > > > reset handler for this CPU, and we let the underlying QEMU th=
read for
> > > > > > > this CPU alive. Since spapr_cpu_core_realize() doesn't care t=
o unrealize
> > > > > > > already realized CPUs either, but happily frees all of them a=
nyway, the
> > > > > > > CPU thread crashes instantly:
> > > > > > >=20
> > > > > > > (qemu) device_add host-spapr-cpu-core,core-id=3D1,id=3Dgku
> > > > > > > GKU: failing icp_create (cpu 0x11497fd0)
> > > > > > >                              ^^^^^^^^^^
> > > > > > > Program received signal SIGSEGV, Segmentation fault.
> > > > > > > [Switching to Thread 0x7fffee3feaa0 (LWP 24725)]
> > > > > > > 0x00000000104c8374 in object_dynamic_cast_assert (obj=3D0x114=
97fd0,
> > > > > > >                                                   ^^^^^^^^^^^=
^^^
> > > > > > >                                              pointer to the C=
PU object
> > > > > > > 623         trace_object_dynamic_cast_assert(obj ? obj->class=
->type->name
> > > > > > > (gdb) p obj->class->type
> > > > > > > $1 =3D (Type) 0x0
> > > > > > > (gdb) p * obj
> > > > > > > $2 =3D {class =3D 0x10ea9c10, free =3D 0x11244620,
> > > > > > >                                  ^^^^^^^^^^
> > > > > > >                               should be g_free
> > > > > > > (gdb) p g_free
> > > > > > > $3 =3D {<text variable, no debug info>} 0x7ffff282bef0 <g_fre=
e>
> > > > > > >=20
> > > > > > > obj is a dangling pointer to the CPU that was just destroyed =
in
> > > > > > > spapr_cpu_core_realize().
> > > > > > >=20
> > > > > > > This patch adds proper rollback to both spapr_realize_vcpu() =
and
> > > > > > > spapr_cpu_core_realize().
> > > > > > >=20
> > > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>     =20
> > > > > >=20
> > > > > > Applied to ppc-for-3.0, since it definitely looks to fix some
> > > > > > problems.     =20
> > > > >=20
> > > > > Uh.. actually it has a definite bug - the first exit point will c=
all
> > > > > g_free() on an uninitialized spapr_cpu.  I fixed it up with a NULL
> > > > > initialization in my tree.   =20
> > > >=20
> > > > Ah... as said in the cover letter, all the series is based on machi=
ne_data
> > > > being set before the call to object_property_set_bool()... Maybe I =
should
> > > > have made that explicit with a preparatory patch... Sorry.   =20
> > >=20
> > > Ah, that makes sense.
> > >=20
> > > So, I ended up having to rework a little differently, after I yanked
> > > by intc -> machine_data patch because it broke things for clg.  I
> > > think I've fixed it up correctly now - if you can check the latest
> > > ppc-for-3.0 I pushed out, that would be great.
> > >  =20
> >=20
> > I'll do this ASAP.
>=20
> Oops, I've just spotted a nit in my original patch, that causes
> QEMU to crash if threads > 1... but I had only tested with single
> threaded cores :)

>=20
> > +err_unrealize:
> > +    while (--j >=3D 0) {
> > +        spapr_unrealize_vcpu(sc->threads[i]);
>                                            ^^^
>                                        should be j

Ah, yes.  I've fixed that up in my tree.


>=20
> Appart from that, it looks good.



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjsewACgkQbDjKyiDZ
s5Jfww//ayayULloWKYH73diCX5yXZlxKfNFBwO1kTaKrYnJDuxSynZPJgMtoD75
8ear6+KFs2p7vWP4AUGts6nEXxQjwlRNMpDRGLvJA9U/XIu9yXESi/U+OmY4YO1D
f1Le1k5/XZE6ThZ9Wt6Snz9hwrqYePypW68lDzxFIMZJeaMT2E7FE/ebQI8QME0j
pvl0T/w3BRYNAUhv13blx2T7sPAixstxwmVTcrCWRKLxlea6A2N2q2gpFbxgREUc
N9ELElnH9SmbygkXaHruN7cBZTbDKkfNkbNqvnODGbzj1ELfVKOAC2uycSEWL0MC
p2FC4dPdh02rgqwjf51YxfSN7sp7H2LLwolsGsDdBu3WIK3Bd1YZgaS/3U+E9vKW
Qjk0Ca6NPUvoo0Z1TRAjEI0Z6FnMSx9dQx4SA7Zu40HvmhG8lwxezrfhaNth2Qc4
vSSy9jxWNwk+OIeC/zhc+zT0pHASX7NMuGVWepBsJNYrv79c/PuzgVRZ+K+PaK/4
FDK6GBdh4xkzdQsxlSa08sNqorSZODWf/ZuaX96ud0FX5xI2T08mfwPQ7wYi1Bzk
LUmHCj/kd0DIOUvT9p94z5CmiQAWIcH9TDSWokoj2CKukbdmiJA/6ilSbLYot88V
lSivvIRlWpNsCTQ+dN9/0V5q0Uulnhz1WLyCMC0JJm1ujXyWHNY=
=nJHd
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
