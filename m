Received: from eggs.gnu.org ([2001:4830:134:3::10]:36159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsUe5-0002Np-G1
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsUe2-0007oL-8p
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:02:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsUe1-0007nj-W9
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:02:02 -0400
Date: Wed, 22 Aug 2018 16:01:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822150155.GM12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
	<20180822120135.GN18995@localhost.localdomain>
	<20180822122601.GI12750@redhat.com>
	<20180822125455.GP18995@localhost.localdomain>
	<20180822134440.GK12750@redhat.com>
	<cb831d07-a3f2-9c6a-dbd4-a727c8f13e4f@laine.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb831d07-a3f2-9c6a-dbd4-a727c8f13e4f@laine.org>
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
To: Laine Stump <laine@laine.org>
Cc: Libvirt <libvir-list@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Andrea Bolognani <abologna@redhat.com>, qemu list <qemu-devel@nongnu.org>

On Wed, Aug 22, 2018 at 10:37:12AM -0400, Laine Stump wrote:
> On 08/22/2018 09:44 AM, Daniel P. Berrang=C3=A9 wrote:
> > Even if someone is willing to implement it in libvirt, we have to
> > consider the cost of supporting it in both libvirt and applications
> > using libvirt and the complexity it adds to our story about the
> > docs / best practices for configuring guests.
> >
> > Even though I do kind of like the virtio-0.9/virtio-1.0 device model
> > as concepts, I'm yet to be convinced that implementing them in libvir=
t
> > and then also in all the downstream applications (oVirt, OpenStack,
> > virt-manager, cockpit, etc) is actually worth the cost.
>=20
> I'm starting to lean towards this opinion too - I was thinking about
> this over the weekend, and it does seem like the code in the management
> apps will be convoluted/complex/your favorite adjective. Going into thi=
s
> I had the naive impression that a simple bit of logic in the management
> application could just take the union of supported devices from
> libosinfo(guestOS) and domaincapabilities(qemu), then pick the top mode=
l
> name from the list. It's unfortunately not that simple, so we're going
> to end up with a bunch of extra code in the management application
> (multiplied by the number of management apps, multiplied by the number
> of different virtio devices) and that code will need to be maintained.
>=20
> In the meantime, the only advantages over just giving up and using 440f=
x
> for RHEL6 would be 1) consistent support for using Q35 on all
> "supported" guest OSes, 2) the possibility of doing SecureBoot, and 2)
> being able to someday in the future eliminate all 440fx-specific code
> from the set of code that needs to be tested/maintained by downstream
> maintainers. (1) is nice and clean, but the value is dubious if it's
> achieved by "unclean" code elsewhere. (2) is a non-feature for almost
> everyone, and (3) isn't going to happen anyway, since any existing
> guests have already been setup using 440fx as the machinetype, and we
> can't force people to change the machinetype of an existing guest (as
> Dan says, over the amount of time needed to make that an acceptable
> requirement, the guest OSes in question could likely reach EOL anyway).

Two notes

 - The notion of "supported" guest OS is an invention of downstream
   distro vendors.

 - RHEL-6 doesn't support SecureBoot at all, even on bare metal.
   IOW the possibility of SecureBoot with KVM for RHEL-6 doesn't
   even arise to begin with.

> (NB: of course if we want to require 440fx for RHEL6, we'll still need
> to do the work on libosinfo to report "supported machinetype", and on
> all the management applications to honor that information)

Yes, we still have plenty of work todo across the mgmt apps just to get
Q35 used by default in the first place.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
