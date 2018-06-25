Received: from eggs.gnu.org ([2001:4830:134:3::10]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXPWZ-0004he-8I
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fXPWX-00085R-Tv
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 07:19:11 -0400
Date: Mon, 25 Jun 2018 12:18:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180625111859.GG18580@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622154042.GS23296@redhat.com>
	<20180622175359.GJ4366@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622175359.GJ4366@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 25/26] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, pkrempa@redhat.com

On Fri, Jun 22, 2018 at 07:54:00PM +0200, Kevin Wolf wrote:
> Am 22.06.2018 um 17:40 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Fri, Jun 22, 2018 at 04:25:13PM +0200, Kevin Wolf wrote:
> > > This was in fact one release longer than our deprecation policy say=
s.
> > > Are we serious about the deprecation policy or aren't we?
> > >=20
> > > I might consider reverting a change if it turned out that this requ=
ires
> > > some massive work in libvirt. But I think this one should be rather=
 easy
> > > to fix in libvirt until 3.0 is released.
> >=20
> > I've got a patch mostly ready that converts libvirt to setting these =
things
> > on the frontend device, however, I've got some queries...
> >=20
> >  - usb-storage  - doesn't appear to support geometry or werror/rerror
> >=20
> >    Will we loose functionality by stopping use of -drive for werror
> >=20
> >    Loosing geometry feels relevant too, unless it was already ignored
> >    when set opf -drive ?
>=20
> You're right, usb-storage doesn't allow using -device to specify these,
> and it does use the values from -drive.
>=20
> For werror/rerror, we should clearly implement the option forwarding to
> scsi-disk so that you can make use of it.

This missing werror item looks like a blocker for libvirt to be
able to switch to using -blockdev without a regression.

> I'm not sure how sane specifying a non-standard CHS geometry for a USB
> stick actually is. As an additional difficulty, usb-storage internally
> creates a scsi-disk device (not scsi-hd), which is also considered
> legacy and doesn't support the geometry options either, so it's not jus=
t
> simple forwarding. We removed an actual feature there, but that feature
> was probably never intended nor used.
>=20
> If someone comes up with a compelling reason why they really need to
> configure the CHS geometry of their USB sticks, I guess we can do it. M=
y
> real USB sticks I tested don't even support MODE_PAGE_HD_GEOMETRY
> (though they have MODE_PAGE_FLEXIBLE_DISK_GEOMETRY).

I don't think libvirt has a compelling reason. The ability to set CHS
on usb-storage is just something we got for free because it used the
same -drive syntax as other disk device frontends. It would be nice to
avoid the regression but I doubt people will actually notice in practice
as usb-storage users are few & far between, and even fewer of those will
care about CHS.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
