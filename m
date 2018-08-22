Received: from eggs.gnu.org ([2001:4830:134:3::10]:40983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsTRK-0008CX-O7
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsTRH-0007Il-IN
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:44:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsTRH-0007Hx-46
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 09:44:47 -0400
Date: Wed, 22 Aug 2018 14:44:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822134440.GK12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
	<20180822120135.GN18995@localhost.localdomain>
	<20180822122601.GI12750@redhat.com>
	<20180822125455.GP18995@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180822125455.GP18995@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] clean/simple Q35 support in libvirt+QEMU
 for guest OSes that don't support virtio-1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Libvirt <libvir-list@redhat.com>, qemu list <qemu-devel@nongnu.org>, Laine Stump <laine@laine.org>

On Wed, Aug 22, 2018 at 09:54:55AM -0300, Eduardo Habkost wrote:
> On Wed, Aug 22, 2018 at 01:26:01PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Aug 22, 2018 at 09:01:35AM -0300, Eduardo Habkost wrote:
> > > On Wed, Aug 22, 2018 at 12:36:27PM +0200, Andrea Bolognani wrote:
> > > > On Tue, 2018-08-21 at 14:21 -0400, Laine Stump wrote:
> > > > > On 08/17/2018 06:35 AM, Andrea Bolognani wrote:
> > > > > > If we decide we want to explicitly spell out the options inst=
ead
> > > > > > of relying on QEMU changing behavior based on the slot type, =
which
> > > > > > is probably a good idea anyway, I think we should have
> > > > > >=20
> > > > > >   virtio-0.9 =3D> disable-legacy=3Dno,disable-modern=3Dno
> > > > > >   virtio-1.0 =3D> disable-legacy=3Dyes,disable-modern=3Dno
> > > > > >=20
> > > > > > There's basically no reason to have a device legacy-only rath=
er
> > > > > > than transitional, and spelling out both options instead of o=
nly
> > > > > > one of them just seems more robust.
> > > > >=20
> > > > > I agree with both of those, but the counter-argument is that "v=
irtio"
> > > > > already describes a transitional device like your proposal for
> > > > > virtio-0.9 (at least today), and it makes the versioned models =
less
> > > > > orthogonal. In the end, I could go either way...
> > > >=20
> > > > Yeah, Dan already made that argument and convinced me that we
> > > > should use virtio-0.9 for legacy only, virtio-1.0 for modern only
> > > > and plain virtio for no enforced behavior / transitional.
> > >=20
> > > I don't understand why we are optimizing the new system for the
> > > less useful use cases:
> > >=20
> > > I don't see a use case where virtio-0.9 (legacy-only) would be
> > > more useful than virtio-transitional.  I don't see why anybody
> > > would prefer a legacy-only device instead of a transitional
> > > device.  Even if your guest has only legacy drivers, it might be
> > > upgraded and get new drivers in the future.
> > >=20
> > > I don't see a use case where virtio-1.0 (modern-only) would be
> > > more useful than "virtio".  If you are running i440fx, you get a
> > > transitional device with "virtio", and I don't see why anybody
> > > would prefer a modern-only device.  If you are running Q35, you
> > > already get a modern-only device with "virtio".
> > >=20
> > > The most useful feature users need is the ability to ask for a
> > > transitional virtio device on Q35, and this use case is
> > > explicitly being left out of the proposal.  Why?
> >=20
> > You can already get a transitional device on Q35, albeit with manual
> > placement. Adding flags for magic placement for the existing devices
> > is not something that is suitable for the XML. The ability to get
> > legacy-only, or modern-only doesn't exist today in any way, so that
> > would be a valid new feature.
>=20
> Transitional devices and modern-only devices are different kinds
> of devices.  Making the guest see a different type of device
> depending on where it's plugged is why we got into this mess, why
> would we recommend applications to rely on this behavior?
>=20
> That's why I like your virtio-0.9/virtio-1.0 proposal.  I just
> don't see why you think virtio-transitional should be out of it.

An explicit virtio-transitional device is still two separate
devices pretending to be the same thing, but magically changing
their identity at runtime. We've already got that situation with
existing device models, and I'm loathe to see us add 2nd device
model with that same behaviour, just for sake of having a slightly
different PCI bus placement strategy to support outdated guest OS.

> > Honestly though, the longer this discussion goes on, the more I think
> > the answer is just "do nothing". All this time spent on discussion,
> > and future time spent on implementing new logic in apps, is merely
> > to support running RHEL-6 on Q35.  I think we should just say that
> > RHEL-6 should use i440fx forever and be done with it.
>=20
> I'm not sure if you are saying that we (Red Hat) shouldn't spend
> time implementing it, or that the libvirt upstream project should
> reject the patches if somebody implements it.  I would understand
> the former, but not the latter.

Even if someone is willing to implement it in libvirt, we have to
consider the cost of supporting it in both libvirt and applications
using libvirt and the complexity it adds to our story about the
docs / best practices for configuring guests.

Even though I do kind of like the virtio-0.9/virtio-1.0 device model
as concepts, I'm yet to be convinced that implementing them in libvirt
and then also in all the downstream applications (oVirt, OpenStack,
virt-manager, cockpit, etc) is actually worth the cost.

There's little compelling reason to care about running outdated OS
like RHEL-6 on Q35 in general. The motivation behind it is just
coming from an artifically created problem downstream, by wishing
to drop the i440fx machine at some still undeteremined point in the
future. By the time that future comes, RHEL-6 may well even be
end of life making the entire exercise a pointless.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
