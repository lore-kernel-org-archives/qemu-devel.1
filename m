Received: from eggs.gnu.org ([2001:4830:134:3::10]:38728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTiG1-0003wb-3X
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 02:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTiFz-0005Zy-VK
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 02:30:49 -0400
Date: Fri, 15 Jun 2018 16:29:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180615062915.GU4129@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901304242.252222.9947658955703347553.stgit@bahia.lan>
	<20180615000225.GC4129@umbus.fritz.box>
	<20180615001431.GF4129@umbus.fritz.box>
	<20180615075805.1213ed06@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3pZQ0wszfDg7ZRO+"
Content-Disposition: inline
In-Reply-To: <20180615075805.1213ed06@bahia.lan>
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


--3pZQ0wszfDg7ZRO+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 15, 2018 at 07:58:05AM +0200, Greg Kurz wrote:
> On Fri, 15 Jun 2018 10:14:31 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jun 15, 2018 at 10:02:25AM +1000, David Gibson wrote:
> > > On Thu, Jun 14, 2018 at 11:50:42PM +0200, Greg Kurz wrote: =20
> > > > The spapr_realize_vcpu() function doesn't rollback in case of error.
> > > > This isn't a problem with coldplugged CPUs because the machine won't
> > > > start and QEMU will exit. Hotplug is a different story though: the
> > > > CPU thread is started under object_property_set_bool() and it assum=
es
> > > > it can access the CPU object.
> > > >=20
> > > > If icp_create() fails, we return an error without unregistering the
> > > > reset handler for this CPU, and we let the underlying QEMU thread f=
or
> > > > this CPU alive. Since spapr_cpu_core_realize() doesn't care to unre=
alize
> > > > already realized CPUs either, but happily frees all of them anyway,=
 the
> > > > CPU thread crashes instantly:
> > > >=20
> > > > (qemu) device_add host-spapr-cpu-core,core-id=3D1,id=3Dgku
> > > > GKU: failing icp_create (cpu 0x11497fd0)
> > > >                              ^^^^^^^^^^
> > > > Program received signal SIGSEGV, Segmentation fault.
> > > > [Switching to Thread 0x7fffee3feaa0 (LWP 24725)]
> > > > 0x00000000104c8374 in object_dynamic_cast_assert (obj=3D0x11497fd0,
> > > >                                                   ^^^^^^^^^^^^^^
> > > >                                              pointer to the CPU obj=
ect
> > > > 623         trace_object_dynamic_cast_assert(obj ? obj->class->type=
->name
> > > > (gdb) p obj->class->type
> > > > $1 =3D (Type) 0x0
> > > > (gdb) p * obj
> > > > $2 =3D {class =3D 0x10ea9c10, free =3D 0x11244620,
> > > >                                  ^^^^^^^^^^
> > > >                               should be g_free
> > > > (gdb) p g_free
> > > > $3 =3D {<text variable, no debug info>} 0x7ffff282bef0 <g_free>
> > > >=20
> > > > obj is a dangling pointer to the CPU that was just destroyed in
> > > > spapr_cpu_core_realize().
> > > >=20
> > > > This patch adds proper rollback to both spapr_realize_vcpu() and
> > > > spapr_cpu_core_realize().
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> > >=20
> > > Applied to ppc-for-3.0, since it definitely looks to fix some
> > > problems. =20
> >=20
> > Uh.. actually it has a definite bug - the first exit point will call
> > g_free() on an uninitialized spapr_cpu.  I fixed it up with a NULL
> > initialization in my tree.
>=20
> Ah... as said in the cover letter, all the series is based on machine_data
> being set before the call to object_property_set_bool()... Maybe I should
> have made that explicit with a preparatory patch... Sorry.

Ah, that makes sense.

So, I ended up having to rework a little differently, after I yanked
by intc -> machine_data patch because it broke things for clg.  I
think I've fixed it up correctly now - if you can check the latest
ppc-for-3.0 I pushed out, that would be great.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3pZQ0wszfDg7ZRO+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsjXLsACgkQbDjKyiDZ
s5IYVw/+MnD7iA9JEg2hZOGpxZuijWf9By9GBwmxQkOdRwuic+tQAI91yfYrtprd
WOpe9/xKePIoeho3F+k1OW/Hk44NYQ/XJeXLNJLWHwuopMm8kH7wXXeyBUc3/M9j
mgPSUvOB9wCNOfEnbnJsOyehkfcsEWYgO4QPHjpFe0sM4TMbKR43ImrWouXOxhqP
87jpUmf2SFN6JA/EXyXZc6HSF6TuHjHhW+N20Zu3ISYLb94McbFFMiOf+dPpIfaM
NTdgIHxq+mFg861ZGPpVLwdfVey+4JW0yvnvEZPLR5RvJeg+wy+FOqPlULVitvu2
PIZDXChUWC7l4w4xpF732qb91n6mzL4LPnanqIj4MQU7qi3KSiz40eoZkvOjqyU0
iRthxS4dxl4cRdNo+Kh5hpyVguNB2jHC3DvuHIDiLeqkfbEJXmGVZJQrfUpUrAoJ
wGYmI30WErGVKuCkC4V4puVdxKocPOEAfGXqI44OHJeknPhiWDHF3lCCFJUKGiK8
WB6YzKyUlV39cRPq0GcFPrZd7ydnEmR2dSagKwm/AMf0GFIo4QXs/XR2CdZjIA5B
lAAcdXMmuyDp+DoGwOeIf45M0T24jlSlsK5lSJLA8js4dCWhHt6f5AzTLgCn4Cdf
2WLFG5eR186vIkDejjHdLtpnYRaVeaIvCoaIO0ftGQen6yqYQyM=
=jK0U
-----END PGP SIGNATURE-----

--3pZQ0wszfDg7ZRO+--
