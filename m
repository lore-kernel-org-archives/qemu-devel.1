Received: from eggs.gnu.org ([2001:4830:134:3::10]:55978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTjgI-0001Ug-Db
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTjgD-0001J1-E9
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:02:02 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:56248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTjgD-0001IE-4G
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:01:57 -0400
Received: from player797.ha.ovh.net (unknown [10.109.105.38])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 72E92B18D5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 10:01:55 +0200 (CEST)
Date: Fri, 15 Jun 2018 10:01:47 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180615100147.0acfa6f2@bahia.lan>
In-Reply-To: <20180615090724.6755df6f@bahia.lan>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901304242.252222.9947658955703347553.stgit@bahia.lan>
	<20180615000225.GC4129@umbus.fritz.box>
	<20180615001431.GF4129@umbus.fritz.box>
	<20180615075805.1213ed06@bahia.lan>
	<20180615062915.GU4129@umbus.fritz.box>
	<20180615090724.6755df6f@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/b3c6DoRnuD26qtmPVPv=FOv";
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

--Sig_/b3c6DoRnuD26qtmPVPv=FOv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Jun 2018 09:07:24 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 15 Jun 2018 16:29:15 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jun 15, 2018 at 07:58:05AM +0200, Greg Kurz wrote: =20
> > > On Fri, 15 Jun 2018 10:14:31 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >    =20
> > > > On Fri, Jun 15, 2018 at 10:02:25AM +1000, David Gibson wrote:   =20
> > > > > On Thu, Jun 14, 2018 at 11:50:42PM +0200, Greg Kurz wrote:     =20
> > > > > > The spapr_realize_vcpu() function doesn't rollback in case of e=
rror.
> > > > > > This isn't a problem with coldplugged CPUs because the machine =
won't
> > > > > > start and QEMU will exit. Hotplug is a different story though: =
the
> > > > > > CPU thread is started under object_property_set_bool() and it a=
ssumes
> > > > > > it can access the CPU object.
> > > > > >=20
> > > > > > If icp_create() fails, we return an error without unregistering=
 the
> > > > > > reset handler for this CPU, and we let the underlying QEMU thre=
ad for
> > > > > > this CPU alive. Since spapr_cpu_core_realize() doesn't care to =
unrealize
> > > > > > already realized CPUs either, but happily frees all of them any=
way, the
> > > > > > CPU thread crashes instantly:
> > > > > >=20
> > > > > > (qemu) device_add host-spapr-cpu-core,core-id=3D1,id=3Dgku
> > > > > > GKU: failing icp_create (cpu 0x11497fd0)
> > > > > >                              ^^^^^^^^^^
> > > > > > Program received signal SIGSEGV, Segmentation fault.
> > > > > > [Switching to Thread 0x7fffee3feaa0 (LWP 24725)]
> > > > > > 0x00000000104c8374 in object_dynamic_cast_assert (obj=3D0x11497=
fd0,
> > > > > >                                                   ^^^^^^^^^^^^^^
> > > > > >                                              pointer to the CPU=
 object
> > > > > > 623         trace_object_dynamic_cast_assert(obj ? obj->class->=
type->name
> > > > > > (gdb) p obj->class->type
> > > > > > $1 =3D (Type) 0x0
> > > > > > (gdb) p * obj
> > > > > > $2 =3D {class =3D 0x10ea9c10, free =3D 0x11244620,
> > > > > >                                  ^^^^^^^^^^
> > > > > >                               should be g_free
> > > > > > (gdb) p g_free
> > > > > > $3 =3D {<text variable, no debug info>} 0x7ffff282bef0 <g_free>
> > > > > >=20
> > > > > > obj is a dangling pointer to the CPU that was just destroyed in
> > > > > > spapr_cpu_core_realize().
> > > > > >=20
> > > > > > This patch adds proper rollback to both spapr_realize_vcpu() and
> > > > > > spapr_cpu_core_realize().
> > > > > >=20
> > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>     =20
> > > > >=20
> > > > > Applied to ppc-for-3.0, since it definitely looks to fix some
> > > > > problems.     =20
> > > >=20
> > > > Uh.. actually it has a definite bug - the first exit point will call
> > > > g_free() on an uninitialized spapr_cpu.  I fixed it up with a NULL
> > > > initialization in my tree.   =20
> > >=20
> > > Ah... as said in the cover letter, all the series is based on machine=
_data
> > > being set before the call to object_property_set_bool()... Maybe I sh=
ould
> > > have made that explicit with a preparatory patch... Sorry.   =20
> >=20
> > Ah, that makes sense.
> >=20
> > So, I ended up having to rework a little differently, after I yanked
> > by intc -> machine_data patch because it broke things for clg.  I
> > think I've fixed it up correctly now - if you can check the latest
> > ppc-for-3.0 I pushed out, that would be great.
> >  =20
>=20
> I'll do this ASAP.

Oops, I've just spotted a nit in my original patch, that causes
QEMU to crash if threads > 1... but I had only tested with single
threaded cores :)

> +err_unrealize:
> +    while (--j >=3D 0) {
> +        spapr_unrealize_vcpu(sc->threads[i]);
                                           ^^^
                                       should be j

Appart from that, it looks good.

--Sig_/b3c6DoRnuD26qtmPVPv=FOv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsjcmsACgkQcdTV5YIv
c9YOtw//cr2QFFdk4ShML73uyVahVsGcuVHsuoRwDTEV00Td63l4UO019WBnTJck
F0W0hCuBMSKR4l//A3uq1KKRU3gljpp2bbhTnnP+2r6bajCXQulwpRcRRqbNHCR8
Hf83tyvm7DjBKpt3Na3PjP1fmHVvzvFLkijwbQjeirmgh6ete2W/ae+LJQnDNYEO
uGBbRtnQg8Hu6l4KILzqyXxa7v74dYGwAQgfQYZ8eC5Vd/gZoRuPodQi3/y2Gbb2
CMHHuKlzGKJH8NK0KmQw/UkfySpfEUky5F7zemPGWOEdwRbzu0zWGIpp4baPBs9a
aVXsQjQDZma/ut/ZYZ3wqzYYNF2sQ12AkKZNAtSKdo9F5+wvYLfoKacnSEYW/ny/
wOPIDcpjlB83R3Ogkoc1OXoXHqPKmw1JByGPfC8f+vNZl/VTOF3SQAbMYpyzZowq
TA1XGqlUkvlPXlIbhRyQJL78G2CkkZ2G/pqy4UhUPVWj/CNCQlYRGxWQo1kdudOy
rr7WTsjrwki3z3K7LXv0hEtrcrlOpgbYO6J/s41Hhof6xeacxrBXVRpG1QqEvS4S
/pmx7WrFU+C2ngMlXVrEWbBlR8e+Pw2IRrdIb0sPW/L3kraczer2LmhOeu5OF9/g
rRkUXqFghdrb95i+lRhUBirX/5qnn5Us4rGzZi1uzL5V2s/f22Q=
=cq0V
-----END PGP SIGNATURE-----

--Sig_/b3c6DoRnuD26qtmPVPv=FOv--
