Received: from eggs.gnu.org ([2001:4830:134:3::10]:58709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUQru-0002mi-VU
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 02:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUQrr-0000nE-Nl
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 02:08:54 -0400
Date: Sat, 16 Jun 2018 16:26:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180616062603.GA13231@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901304242.252222.9947658955703347553.stgit@bahia.lan>
	<20180615000225.GC4129@umbus.fritz.box>
	<20180615001431.GF4129@umbus.fritz.box>
	<20180615075805.1213ed06@bahia.lan>
	<20180615062915.GU4129@umbus.fritz.box>
	<20180615090724.6755df6f@bahia.lan>
	<20180615100147.0acfa6f2@bahia.lan>
	<20180615123244.GB2363@umbus.fritz.box>
	<20180615152256.49e5e97f@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20180615152256.49e5e97f@bahia.lan>
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


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 03:24:18PM +0200, Greg Kurz wrote:
> On Fri, 15 Jun 2018 22:32:44 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jun 15, 2018 at 10:01:47AM +0200, Greg Kurz wrote:
> > > On Fri, 15 Jun 2018 09:07:24 +0200
> > > Greg Kurz <groug@kaod.org> wrote:
> > >  =20
> > > > On Fri, 15 Jun 2018 16:29:15 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >  =20
> > > > > On Fri, Jun 15, 2018 at 07:58:05AM +0200, Greg Kurz wrote:   =20
> > > > > > On Fri, 15 Jun 2018 10:14:31 +1000
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >      =20
> > > > > > > On Fri, Jun 15, 2018 at 10:02:25AM +1000, David Gibson wrote:=
     =20
> > > > > > > > On Thu, Jun 14, 2018 at 11:50:42PM +0200, Greg Kurz wrote: =
      =20
> > > > > > > > > The spapr_realize_vcpu() function doesn't rollback in cas=
e of error.
> > > > > > > > > This isn't a problem with coldplugged CPUs because the ma=
chine won't
> > > > > > > > > start and QEMU will exit. Hotplug is a different story th=
ough: the
> > > > > > > > > CPU thread is started under object_property_set_bool() an=
d it assumes
> > > > > > > > > it can access the CPU object.
> > > > > > > > >=20
> > > > > > > > > If icp_create() fails, we return an error without unregis=
tering the
> > > > > > > > > reset handler for this CPU, and we let the underlying QEM=
U thread for
> > > > > > > > > this CPU alive. Since spapr_cpu_core_realize() doesn't ca=
re to unrealize
> > > > > > > > > already realized CPUs either, but happily frees all of th=
em anyway, the
> > > > > > > > > CPU thread crashes instantly:
> > > > > > > > >=20
> > > > > > > > > (qemu) device_add host-spapr-cpu-core,core-id=3D1,id=3Dgku
> > > > > > > > > GKU: failing icp_create (cpu 0x11497fd0)
> > > > > > > > >                              ^^^^^^^^^^
> > > > > > > > > Program received signal SIGSEGV, Segmentation fault.
> > > > > > > > > [Switching to Thread 0x7fffee3feaa0 (LWP 24725)]
> > > > > > > > > 0x00000000104c8374 in object_dynamic_cast_assert (obj=3D0=
x11497fd0,
> > > > > > > > >                                                   ^^^^^^^=
^^^^^^^
> > > > > > > > >                                              pointer to t=
he CPU object
> > > > > > > > > 623         trace_object_dynamic_cast_assert(obj ? obj->c=
lass->type->name
> > > > > > > > > (gdb) p obj->class->type
> > > > > > > > > $1 =3D (Type) 0x0
> > > > > > > > > (gdb) p * obj
> > > > > > > > > $2 =3D {class =3D 0x10ea9c10, free =3D 0x11244620,
> > > > > > > > >                                  ^^^^^^^^^^
> > > > > > > > >                               should be g_free
> > > > > > > > > (gdb) p g_free
> > > > > > > > > $3 =3D {<text variable, no debug info>} 0x7ffff282bef0 <g=
_free>
> > > > > > > > >=20
> > > > > > > > > obj is a dangling pointer to the CPU that was just destro=
yed in
> > > > > > > > > spapr_cpu_core_realize().
> > > > > > > > >=20
> > > > > > > > > This patch adds proper rollback to both spapr_realize_vcp=
u() and
> > > > > > > > > spapr_cpu_core_realize().
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>       =20
> > > > > > > >=20
> > > > > > > > Applied to ppc-for-3.0, since it definitely looks to fix so=
me
> > > > > > > > problems.       =20
> > > > > > >=20
> > > > > > > Uh.. actually it has a definite bug - the first exit point wi=
ll call
> > > > > > > g_free() on an uninitialized spapr_cpu.  I fixed it up with a=
 NULL
> > > > > > > initialization in my tree.     =20
> > > > > >=20
> > > > > > Ah... as said in the cover letter, all the series is based on m=
achine_data
> > > > > > being set before the call to object_property_set_bool()... Mayb=
e I should
> > > > > > have made that explicit with a preparatory patch... Sorry.     =
=20
> > > > >=20
> > > > > Ah, that makes sense.
> > > > >=20
> > > > > So, I ended up having to rework a little differently, after I yan=
ked
> > > > > by intc -> machine_data patch because it broke things for clg.  I
> > > > > think I've fixed it up correctly now - if you can check the latest
> > > > > ppc-for-3.0 I pushed out, that would be great.
> > > > >    =20
> > > >=20
> > > > I'll do this ASAP. =20
> > >=20
> > > Oops, I've just spotted a nit in my original patch, that causes
> > > QEMU to crash if threads > 1... but I had only tested with single
> > > threaded cores :) =20
> >=20
> > >  =20
> > > > +err_unrealize:
> > > > +    while (--j >=3D 0) {
> > > > +        spapr_unrealize_vcpu(sc->threads[i]); =20
> > >                                            ^^^
> > >                                        should be j =20
> >=20
> > Ah, yes.  I've fixed that up in my tree.
> >=20
>=20
> +        spapr_unrealize_vcpu(sc->threads[j);
>=20
> Almost fixed ;)

Oops, fixed now.

>=20
> >=20
> > >=20
> > > Appart from that, it looks good. =20
> >=20
> >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlskrXkACgkQbDjKyiDZ
s5Kv1hAAgqnjPFyuVA9Z8s8RjQR3ldh09nRN4OUGwuIYds/SPzRV2b9/oSCHSTfg
EjZQgw5vwIrsyVHTMWzWL9ty8eVI+9gNtlZkHKl2rIQITcKFN4/sjvJ0ZtS0Gcqh
f/LhmlGngX5vIx3QIGRvVxasy7pwBlMzbHHgf345VOO403nxQaLtJuCoHdCgoLEb
4B+Z8GZBPSrPEFtMrMuP5XHoyBO1oHVsLUYVIvf1vCDFYjQmMaVqg0q/UBz7PRHC
zVGOQVs8ux39cWLZa6QhXO/J4rB3K5h6n4KxoNshZly+19NARW3PNOukPk0FNxei
0CKi5TOqGGAi3bF6nyiSR5+MLpf6UXV58bS8RtqVKP0SrC+yVkhCThZKfVbVXopZ
SD+p7tTYlXYyg6TZrhn/A9i19SJtdCpfsSZSIIRSgpPKw0R1hRTNfGLZQUFULOVU
EgG0cPchJf/MQWguKHsgpR40zmcpgf5lOVotG1wCwUyBEXP4x8bNRLpGxnH+YYl3
3kYBCEnMqiFfDDzjPjjtu+dz8Yd/+hltj0/vaM+DwOOMNmv4Kv0hbtBa6zV1dM/P
y+e6KGOA4bGFXVxbuOVtwUsVa4Yeuz5p2htW3xDvT3mycyaej0o9HfkuI2biIjQf
B94HH208foU5DjHzmpPfZOIyrjb8xVpS9MiWOwf6T3Dz2nSERLU=
=ocJ7
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
