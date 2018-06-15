Received: from eggs.gnu.org ([2001:4830:134:3::10]:44745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fToiP-0000BJ-FA
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fToiM-0007O8-7B
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:24:33 -0400
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:60701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fToiL-0007MK-Tg
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 09:24:30 -0400
Received: from player750.ha.ovh.net (unknown [10.109.120.76])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3064E13B475
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 15:24:28 +0200 (CEST)
Date: Fri, 15 Jun 2018 15:24:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180615152256.49e5e97f@bahia.lan>
In-Reply-To: <20180615123244.GB2363@umbus.fritz.box>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
	<152901304242.252222.9947658955703347553.stgit@bahia.lan>
	<20180615000225.GC4129@umbus.fritz.box>
	<20180615001431.GF4129@umbus.fritz.box>
	<20180615075805.1213ed06@bahia.lan>
	<20180615062915.GU4129@umbus.fritz.box>
	<20180615090724.6755df6f@bahia.lan>
	<20180615100147.0acfa6f2@bahia.lan>
	<20180615123244.GB2363@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/7eixz=Qc.M7W4lm1K35cxCo";
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

--Sig_/7eixz=Qc.M7W4lm1K35cxCo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Jun 2018 22:32:44 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jun 15, 2018 at 10:01:47AM +0200, Greg Kurz wrote:
> > On Fri, 15 Jun 2018 09:07:24 +0200
> > Greg Kurz <groug@kaod.org> wrote:
> >  =20
> > > On Fri, 15 Jun 2018 16:29:15 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Fri, Jun 15, 2018 at 07:58:05AM +0200, Greg Kurz wrote:   =20
> > > > > On Fri, 15 Jun 2018 10:14:31 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >      =20
> > > > > > On Fri, Jun 15, 2018 at 10:02:25AM +1000, David Gibson wrote:  =
   =20
> > > > > > > On Thu, Jun 14, 2018 at 11:50:42PM +0200, Greg Kurz wrote:   =
    =20
> > > > > > > > The spapr_realize_vcpu() function doesn't rollback in case =
of error.
> > > > > > > > This isn't a problem with coldplugged CPUs because the mach=
ine won't
> > > > > > > > start and QEMU will exit. Hotplug is a different story thou=
gh: the
> > > > > > > > CPU thread is started under object_property_set_bool() and =
it assumes
> > > > > > > > it can access the CPU object.
> > > > > > > >=20
> > > > > > > > If icp_create() fails, we return an error without unregiste=
ring the
> > > > > > > > reset handler for this CPU, and we let the underlying QEMU =
thread for
> > > > > > > > this CPU alive. Since spapr_cpu_core_realize() doesn't care=
 to unrealize
> > > > > > > > already realized CPUs either, but happily frees all of them=
 anyway, the
> > > > > > > > CPU thread crashes instantly:
> > > > > > > >=20
> > > > > > > > (qemu) device_add host-spapr-cpu-core,core-id=3D1,id=3Dgku
> > > > > > > > GKU: failing icp_create (cpu 0x11497fd0)
> > > > > > > >                              ^^^^^^^^^^
> > > > > > > > Program received signal SIGSEGV, Segmentation fault.
> > > > > > > > [Switching to Thread 0x7fffee3feaa0 (LWP 24725)]
> > > > > > > > 0x00000000104c8374 in object_dynamic_cast_assert (obj=3D0x1=
1497fd0,
> > > > > > > >                                                   ^^^^^^^^^=
^^^^^
> > > > > > > >                                              pointer to the=
 CPU object
> > > > > > > > 623         trace_object_dynamic_cast_assert(obj ? obj->cla=
ss->type->name
> > > > > > > > (gdb) p obj->class->type
> > > > > > > > $1 =3D (Type) 0x0
> > > > > > > > (gdb) p * obj
> > > > > > > > $2 =3D {class =3D 0x10ea9c10, free =3D 0x11244620,
> > > > > > > >                                  ^^^^^^^^^^
> > > > > > > >                               should be g_free
> > > > > > > > (gdb) p g_free
> > > > > > > > $3 =3D {<text variable, no debug info>} 0x7ffff282bef0 <g_f=
ree>
> > > > > > > >=20
> > > > > > > > obj is a dangling pointer to the CPU that was just destroye=
d in
> > > > > > > > spapr_cpu_core_realize().
> > > > > > > >=20
> > > > > > > > This patch adds proper rollback to both spapr_realize_vcpu(=
) and
> > > > > > > > spapr_cpu_core_realize().
> > > > > > > >=20
> > > > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>       =20
> > > > > > >=20
> > > > > > > Applied to ppc-for-3.0, since it definitely looks to fix some
> > > > > > > problems.       =20
> > > > > >=20
> > > > > > Uh.. actually it has a definite bug - the first exit point will=
 call
> > > > > > g_free() on an uninitialized spapr_cpu.  I fixed it up with a N=
ULL
> > > > > > initialization in my tree.     =20
> > > > >=20
> > > > > Ah... as said in the cover letter, all the series is based on mac=
hine_data
> > > > > being set before the call to object_property_set_bool()... Maybe =
I should
> > > > > have made that explicit with a preparatory patch... Sorry.     =20
> > > >=20
> > > > Ah, that makes sense.
> > > >=20
> > > > So, I ended up having to rework a little differently, after I yanked
> > > > by intc -> machine_data patch because it broke things for clg.  I
> > > > think I've fixed it up correctly now - if you can check the latest
> > > > ppc-for-3.0 I pushed out, that would be great.
> > > >    =20
> > >=20
> > > I'll do this ASAP. =20
> >=20
> > Oops, I've just spotted a nit in my original patch, that causes
> > QEMU to crash if threads > 1... but I had only tested with single
> > threaded cores :) =20
>=20
> >  =20
> > > +err_unrealize:
> > > +    while (--j >=3D 0) {
> > > +        spapr_unrealize_vcpu(sc->threads[i]); =20
> >                                            ^^^
> >                                        should be j =20
>=20
> Ah, yes.  I've fixed that up in my tree.
>=20

+        spapr_unrealize_vcpu(sc->threads[j);

Almost fixed ;)

>=20
> >=20
> > Appart from that, it looks good. =20
>=20
>=20
>=20


--Sig_/7eixz=Qc.M7W4lm1K35cxCo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlsjvgIACgkQcdTV5YIv
c9bpDg/9E+LK37SLEHkSy19ZHIQYd9xOV5QeR9B6KLEGfEvmFD5/5qqwh+J6ul4m
c08FfAt4jrUjxz4D+K9xw+1PX9n+0zGkB6lgCqng136EEem5q4hr1LQEM6EdyoYx
AGLI6Q4O4ihy02RVdrBoFy40QPMFnnfdzMoozqy/anlt5GTu0CwT+XjnMR7T6lTZ
aWfiB/DtD2mGXPZ+akP02tJIXOblIs5y9a+h3nDbDxmtWLjMU1UXi+Fv+THTWpNU
bEOBzLUttfWwz0t6XO5qZtOwNgc/ENYjjUEFnPKhIQjJZrRKYw2srXPQrenPWEHx
yRZTyCZydwxryzP6StoL6lsAfunW4aZ7NHkhKrBcb/VONMOUldD7zi+cprL00x3r
ZG7pNt92U3ZOx1niTCt6pG65/xddM4Egt6kZwzfqyGaoCoCVXilibTmy56AtmnHb
Xhoj5ZynmR0tnKzXD2R2f4QCDXHqeOeZ9E0MjT90STLBNbEsRjCFge3/gvZWVySp
dIXKZjV7m6AwRw6wHY5okUS4duOTApzHWmbtQN2NA8v/EeboTmSYIs/ffTDeMyEE
vkDeh8gt17Qv1799tUP2ExEpjqmYezF8LJktX5U05oXuo92gf31yZ/acxbHV3vm7
y8ahY2D9wqQ6sezAOoWlnY1ECKhzzRvM/EfjB8FL5JN06vgSP9k=
=pDGb
-----END PGP SIGNATURE-----

--Sig_/7eixz=Qc.M7W4lm1K35cxCo--
