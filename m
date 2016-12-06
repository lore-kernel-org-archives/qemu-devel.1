Received: from eggs.gnu.org ([2001:4830:134:3::10]:53521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEBmZ-00077s-Cg
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cEBmW-0006E3-7c
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:11:27 -0500
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:40903)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cEBmV-0006Dc-TX
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 04:11:24 -0500
Received: from player762.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 89D5521A7C
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 10:11:22 +0100 (CET)
Date: Tue, 6 Dec 2016 10:11:10 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161206101110.164b8a93@bahia>
In-Reply-To: <7663fe2f-ae4e-dccd-6422-bd2fba5c9e7d@linux.vnet.ibm.com>
References: <148095126363.31351.4484514300033863622.stgit@bahia>
	<20161205164200.49bec0f6.cornelia.huck@de.ibm.com>
	<20161205164829.GB14457@thinpad.lan.raisama.net>
	<20161205182555.2e988ac6.cornelia.huck@de.ibm.com>
	<20161205174130.GH13060@thinpad.lan.raisama.net>
	<7663fe2f-ae4e-dccd-6422-bd2fba5c9e7d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.8] qdev: apply global properties in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 5 Dec 2016 19:14:40 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 12/05/2016 06:41 PM, Eduardo Habkost wrote:
> > On Mon, Dec 05, 2016 at 06:25:55PM +0100, Cornelia Huck wrote: =20
> >> > On Mon, 5 Dec 2016 14:48:29 -0200
> >> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >> >  =20
> >>> > > On Mon, Dec 05, 2016 at 04:42:00PM +0100, Cornelia Huck wrote: =20
> >>>> > > > On Mon, 05 Dec 2016 16:21:22 +0100
> >>>> > > > Greg Kurz <groug@kaod.org> wrote:
> >>>> > > >  =20
> >>>>> > > > > The current code recursively applies global properties from=
 child up to
> >>>>> > > > > parent. So, if you have:
> >>>>> > > > >=20
> >>>>> > > > > -global virtio-pci.disable-modern=3Don
> >>>>> > > > > -global virtio-blk-pci.disable-modern=3Doff
> >>>>> > > > >=20
> >>>>> > > > > Then the default value of disable-modern for a virtio-blk-p=
ci device is on,
> >>>>> > > > > which looks wrong from an OOP perspective.
> >>>>> > > > >=20
> >>>>> > > > > This patch reverses the logic, so that a child property alw=
ays prevail. =20
> >>>> > > >=20
> >>>> > > > This sounds reasonable...
> >>>> > > >  =20
> >>>>> > > > >=20
> >>>>> > > > > This fixes a subtle bug that got introduced in 2.7 with com=
mit "9a4c0e220d8a
> >>>>> > > > > hw/virtio-pci: fix virtio behaviour" for older (< 2.7) mach=
ine types: the
> >>>>> > > > > HW_COMPAT_2_6 macro contains global virtio-pci.disable-* pr=
operties which
> >>>>> > > > > would silently override global properties passed on the com=
mand line for
> >>>>> > > > > virtio subtypes.
> >>>>> > > > >=20
> >>>>> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> >>>>> > > > > ---
> >>>>> > > > >=20
> >>>>> > > > > AFAIK, libvirt's XML doesn't know about modern/legacy modes=
 for virtio
> >>>>> > > > > devices. Early adopters of virtio 1.0 had to rely on the <q=
emu:commandline>
> >>>>> > > > > tag to pass global properties to QEMU. This patch ensures t=
hat XML files
> >>>>> > > > > used with older machine types remain valid with newer versi=
ons of QEMU.
> >>>>> > > > >=20
> >>>>> > > > > FWIW I guess it could help to have this fix in 2.8, and als=
o probably in
> >>>>> > > > > 2.7.1. =20
> >>>> > > >=20
> >>>> > > > ...but I'm a bit worried about doing that change this late in =
the
> >>>> > > > cycle, as we may introduce subtle changes for other configurat=
ions. At
> >>>> > > > the very least, we should look over the existing backwards com=
pat
> >>>> > > > properties (I'll look at those I'm familiar with). =20
> >>> > >=20
> >>> > > This patch would change the behavior for:
> >>> > >  -global virtio-blk-pci.disable-modern=3Don
> >>> > >  -global virtio-pci.disable-modern=3Doff
> >>> > >=20
> >>> > > And I am not sure the new behavior would be correct. Shouldn't we
> >>> > > apply the properties in the order specified in the command-line? =
=20
> >> >=20
> >> > Probably; but how should this interact with compat props? =20
> > compat props should be always applied in the order they appear.
> > -global should always be applied after compat props.
> >=20
> > So, it looks like we have two additional reasons to just follow
> > the order the global properties were registered.
> >  =20
>=20
> How about a docs update?=20
>=20
> Given the current doc:
> """
> -global driver.prop=3Dvalue
> -global driver=3Ddriver,property=3Dproperty,value=3Dvalue
>     Set default value of driver's property prop to value, e.g.:
>=20
>          qemu-system-i386 -global ide-drive.physical_block_size=3D4096 -d=
rive
> file=3Dfile,if=3Dide,index=3D0,media=3Ddisk
>=20
>     In particular, you can use this to set driver properties for devices =
which
>     are created automatically by the machine model. To create a device wh=
ich is
>     not created automatically and set properties on it, use -device.
>=20
>     -global driver.prop=3Dvalue is shorthand for -global driver=3Ddriver,=
property=3Dprop,
> value=3Dvalue. The longhand syntax works even when
>     driver contains a dot.=20
> """
> I think this OOP argument, which I do not completely understand,

With the current code, properties from the parent classes implicitly
prevail and this has nothing to do with command line order, or order
of appearance in HW_COMPAT_*.

=46rom an OOP perspective, we usually expect child classes to override
parent classes behavior, not the contrary.

> is not the right direction.
>=20
> Yet I do not think the current state of documentation gives a
> definitive answer on what behavior should take place in the
> scenarios described above.
>=20

True, the documentation doesn't mention anything about the QEMU
object model. And the user cannot even think that virtio-pci
exists and is the parent of virtio-blk-pci...

> Maybe it's my mistake, but I did not find a statement about
> the order in which global properties are to be applied
> (please point me to it if I've missed it).
>=20

True, so this should be the implicit command line order.

> Another problem with the doc (IMHO) is that it's not
> really defined what a driver is. So I can't even tell if
> -global virtio-pci.disable-modern=3Doff is even legit on
> the command line.
>=20

True, virtio-pci.disable-modern is an internal compat thing and
it silentyl overrides virtio-blk-pci.disable-modern which is a
legit option. Passing virtio-pci.disable-modern to the command
line is just messing with undocumented internals... and should
probably be disallowed.

> Regarding the order compat props. applied before command line it
> makes a lot of sense to me with the documentation stating "In=20
> particular, you can use this to set driver properties for devices which
> are created automatically by the machine model."
>=20

I agree. So, as written several times in this thread, the only thing
we can do now is changing the virtio-pci compat props to be applied
to each subtype, so that they don't silently undo -global.

Cheers.

--
Greg
