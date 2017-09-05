Received: from eggs.gnu.org ([2001:4830:134:3::10]:47044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpJdv-0001zb-Lf
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpJdq-0004Cq-Mi
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:36:15 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:52092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpJdq-0004BM-Gs
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 15:36:10 -0400
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id C20497498E
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 21:36:08 +0200 (CEST)
Date: Tue, 5 Sep 2017 21:35:58 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170905213558.6f9b390c@bahia>
In-Reply-To: <20170809050842.GI13670@umbus.fritz.box>
References: <1501119055-4060-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<CAFEAcA_t8EDNnWTeRzuHEcdfq3DJFTN3ug=DHnGvWef3=wyFzA@mail.gmail.com>
	<20170727105348.GG7970@umbus.fritz.box>
	<20170727115042.GL2555@redhat.com>
	<20170808134008.0648ab2e@w520.home>
	<20170809050842.GI13670@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/NMDivIyjQh7dvP1mTMOcF9/";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qdev/vfio: defer DEVICE_DEL
 to avoid races with libvirt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

--Sig_/NMDivIyjQh7dvP1mTMOcF9/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2017 15:08:42 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Aug 08, 2017 at 01:40:08PM -0600, Alex Williamson wrote:
> > On Thu, 27 Jul 2017 12:50:42 +0100
> > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> >  =20
> > > On Thu, Jul 27, 2017 at 08:53:48PM +1000, David Gibson wrote: =20
> > > > On Thu, Jul 27, 2017 at 10:11:48AM +0100, Peter Maydell wrote:   =20
> > > > > On 27 July 2017 at 02:30, Michael Roth <mdroth@linux.vnet.ibm.com=
> wrote:   =20
> > > > > > In particular, Mellanox CX4 adapters on PowerNV hosts might not=
 be fully
> > > > > > quiesced by vfio-pci's finalize() routine until up to 6s after =
the
> > > > > > DEVICE_DELETED was emitted, leading to detach-device on the lib=
virt side pretty
> > > > > > much always crashing the host.   =20
> > > > >=20
> > > > > My initial naive thought is that if the host kernel can crash then
> > > > > this is a host kernel bug... shouldn't the host kernel refuse
> > > > > the subsequent libvirt rebind if it would cause a crash ?   =20
> > > >=20
> > > > I think so too, but I haven't been able to convince Alex.  Nor
> > > > find time to fix it in the kernel myself.   =20
> > >=20
> > > I think we need to fix both the QEMU premature sending of DEVICE_DELE=
TED
> > > and the kernel bug that allowed the crash. =20
> >=20
> >=20
> > Where do we stand on this for v2.10?  I'd like to see it get in.  There
> > may be things to fix in the kernel, some of them may already be fixed
> > in the latest development kernel, but ultimately the kernel considers
> > driver binding to be a trusted operation and if userspace doesn't
> > understand all the dependencies, they shouldn't be doing it.  In this
> > case libvirt is using the DEVICE_DELETED signal with the assumption
> > that the device has been fully released by QEMU, which is of course not
> > accurate (libvirt could test this, but chooses not to).  libvirt
> > therefore begins trying to unbind a device that is still in use, we try
> > to handle it, but see official kernel stance that userspace is
> > responsible for understanding device dependencies, so we can only do so
> > much.
> >=20
> > IMO, the next step along those lines would be that libvirt needs to
> > understand that even once a device is fully released from QEMU, it's
> > not necessarily safe to re-bind the device to a host driver.  If the
> > device is a member of a group where other devices are still in use by
> > userspace, this will violate user/host device isolation and the kernel
> > will crash to protect itself.  At best I may be able to improve this to
> > killing the userspace process making use of the conflicting device, but
> > the kernel view is that userspace (libvirt) has mandated to bind the
> > device to the host driver and we must make it so, the user is
> > responsible for the consequences.  Thanks, =20
>=20
> Merging it for 2.10 seems like a good idea to me to, but it's not
> really my area of expertise, and therefore not my call.
>=20

It looks like there was some kind of consensus on this series, but it
didn't make it for 2.10. Is there something more to discuss ?

Cheers,

--
Greg

--Sig_/NMDivIyjQh7dvP1mTMOcF9/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWa78ngAKCRAC/DrrAQHb
wi9FAJoCLqISB6elNx0e5DvKZfDfxioBtQCdEx1sdOPN4uZUYVWfYNjIkNJEamU=
=h6+0
-----END PGP SIGNATURE-----

--Sig_/NMDivIyjQh7dvP1mTMOcF9/--
