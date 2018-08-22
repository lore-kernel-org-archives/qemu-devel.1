Received: from eggs.gnu.org ([2001:4830:134:3::10]:56252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fsSjL-00086S-6V
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:59:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fsSf7-0004OG-8e
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:55:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fsSf6-0004N1-P3
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:55:00 -0400
Date: Wed, 22 Aug 2018 09:54:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180822125455.GP18995@localhost.localdomain>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
	<20180822120135.GN18995@localhost.localdomain>
	<20180822122601.GI12750@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180822122601.GI12750@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Libvirt <libvir-list@redhat.com>, qemu list <qemu-devel@nongnu.org>, Laine Stump <laine@laine.org>

On Wed, Aug 22, 2018 at 01:26:01PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Aug 22, 2018 at 09:01:35AM -0300, Eduardo Habkost wrote:
> > On Wed, Aug 22, 2018 at 12:36:27PM +0200, Andrea Bolognani wrote:
> > > On Tue, 2018-08-21 at 14:21 -0400, Laine Stump wrote:
> > > > On 08/17/2018 06:35 AM, Andrea Bolognani wrote:
> > > > > If we decide we want to explicitly spell out the options instea=
d
> > > > > of relying on QEMU changing behavior based on the slot type, wh=
ich
> > > > > is probably a good idea anyway, I think we should have
> > > > >=20
> > > > >   virtio-0.9 =3D> disable-legacy=3Dno,disable-modern=3Dno
> > > > >   virtio-1.0 =3D> disable-legacy=3Dyes,disable-modern=3Dno
> > > > >=20
> > > > > There's basically no reason to have a device legacy-only rather
> > > > > than transitional, and spelling out both options instead of onl=
y
> > > > > one of them just seems more robust.
> > > >=20
> > > > I agree with both of those, but the counter-argument is that "vir=
tio"
> > > > already describes a transitional device like your proposal for
> > > > virtio-0.9 (at least today), and it makes the versioned models le=
ss
> > > > orthogonal. In the end, I could go either way...
> > >=20
> > > Yeah, Dan already made that argument and convinced me that we
> > > should use virtio-0.9 for legacy only, virtio-1.0 for modern only
> > > and plain virtio for no enforced behavior / transitional.
> >=20
> > I don't understand why we are optimizing the new system for the
> > less useful use cases:
> >=20
> > I don't see a use case where virtio-0.9 (legacy-only) would be
> > more useful than virtio-transitional.  I don't see why anybody
> > would prefer a legacy-only device instead of a transitional
> > device.  Even if your guest has only legacy drivers, it might be
> > upgraded and get new drivers in the future.
> >=20
> > I don't see a use case where virtio-1.0 (modern-only) would be
> > more useful than "virtio".  If you are running i440fx, you get a
> > transitional device with "virtio", and I don't see why anybody
> > would prefer a modern-only device.  If you are running Q35, you
> > already get a modern-only device with "virtio".
> >=20
> > The most useful feature users need is the ability to ask for a
> > transitional virtio device on Q35, and this use case is
> > explicitly being left out of the proposal.  Why?
>=20
> You can already get a transitional device on Q35, albeit with manual
> placement. Adding flags for magic placement for the existing devices
> is not something that is suitable for the XML. The ability to get
> legacy-only, or modern-only doesn't exist today in any way, so that
> would be a valid new feature.

Transitional devices and modern-only devices are different kinds
of devices.  Making the guest see a different type of device
depending on where it's plugged is why we got into this mess, why
would we recommend applications to rely on this behavior?

That's why I like your virtio-0.9/virtio-1.0 proposal.  I just
don't see why you think virtio-transitional should be out of it.

>=20
> Honestly though, the longer this discussion goes on, the more I think
> the answer is just "do nothing". All this time spent on discussion,
> and future time spent on implementing new logic in apps, is merely
> to support running RHEL-6 on Q35.  I think we should just say that
> RHEL-6 should use i440fx forever and be done with it.

I'm not sure if you are saying that we (Red Hat) shouldn't spend
time implementing it, or that the libvirt upstream project should
reject the patches if somebody implements it.  I would understand
the former, but not the latter.

--=20
Eduardo
