Received: from eggs.gnu.org ([2001:4830:134:3::10]:45670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fsQcc-0000YD-JV
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fsQV7-0008M5-8k
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:36:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37754 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1fsQV6-0008LG-Fw
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:36:33 -0400
Message-ID: <f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 22 Aug 2018 12:36:27 +0200
In-Reply-To: <39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: Laine Stump <laine@laine.org>, Libvirt <libvir-list@redhat.com>
Cc: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu list <qemu-devel@nongnu.org>

On Tue, 2018-08-21 at 14:21 -0400, Laine Stump wrote:
> On 08/17/2018 06:35 AM, Andrea Bolognani wrote:
> > If we decide we want to explicitly spell out the options instead
> > of relying on QEMU changing behavior based on the slot type, which
> > is probably a good idea anyway, I think we should have
> >=20
> >   virtio-0.9 =3D> disable-legacy=3Dno,disable-modern=3Dno
> >   virtio-1.0 =3D> disable-legacy=3Dyes,disable-modern=3Dno
> >=20
> > There's basically no reason to have a device legacy-only rather
> > than transitional, and spelling out both options instead of only
> > one of them just seems more robust.
>=20
> I agree with both of those, but the counter-argument is that "virtio"
> already describes a transitional device like your proposal for
> virtio-0.9 (at least today), and it makes the versioned models less
> orthogonal. In the end, I could go either way...

Yeah, Dan already made that argument and convinced me that we
should use virtio-0.9 for legacy only, virtio-1.0 for modern only
and plain virtio for no enforced behavior / transitional.

> The problem I can see with the virtio-1.0 model name is that if
> management applications start putting that into their XML (even though
> "virtio" would yield a working guest), the guests will be unable to
> migrate to another machine that has the same version of qemu, but an
> older libvirt that doesn't understand the virtio-1.0 model number. If
> that's acceptable, then management apps can being always specifying the
> version for virtio whether it's old or new. If not, then they should
> continue to use plain "virtio" unless they specifically need to force
> virtio-0.9.

Well, even using virtio-0.9 could be considered problematic,
because at least from the QEMU point of view there's nothing
preventing the guest from working correctly as long as the version
is recent enough that disable-legacy/disable-modern are available.

AFAIK management applications such as oVirt and OpenStack usually
require specific, reasonably recent versions of QEMU and libvirt,
so they could make sure virtio-0.9 and virtio-1.0 are understood
by all nodes in the cluster that way.

For something like virt-manager where the coupling is loose
perhaps it would make sense to use virtio-0.9 only on q35 when
the OS requires it and plain virtio everywhere else for the time
being, then switch to always using virtio-0.9 and virtio-1.0
after a Reasonable Amount of Time=E2=84=A2 has passed.

--=20
Andrea Bolognani / Red Hat / Virtualization
