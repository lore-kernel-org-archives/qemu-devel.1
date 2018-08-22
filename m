Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fsVRS-0001Tc-Je
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fsVOL-0005fI-SR
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:49:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fsVOL-0005ew-Ju
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:49:53 -0400
Date: Wed, 22 Aug 2018 12:49:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180822154948.GR18995@localhost.localdomain>
References: <20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
	<20180822120135.GN18995@localhost.localdomain>
	<20180822122601.GI12750@redhat.com>
	<20180822125455.GP18995@localhost.localdomain>
	<20180822134440.GK12750@redhat.com>
	<20180822141828.GQ18995@localhost.localdomain>
	<20180822145720.GL12750@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180822145720.GL12750@redhat.com>
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

On Wed, Aug 22, 2018 at 03:57:20PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Aug 22, 2018 at 11:18:28AM -0300, Eduardo Habkost wrote:
> > On Wed, Aug 22, 2018 at 02:44:40PM +0100, Daniel P. Berrang=E9 wrote:
[...]
> > > An explicit virtio-transitional device is still two separate
> > > devices pretending to be the same thing, but magically changing
> > > their identity at runtime. We've already got that situation with
> > > existing device models, and I'm loathe to see us add 2nd device
> > > model with that same behaviour, just for sake of having a slightly
> > > different PCI bus placement strategy to support outdated guest OS.
> >=20
> > Your seem to be describing what the current "virtio" device is:
> > it becomes a non-transitional (modern-only) Virtio device on some
> > cases, and becomes a transitional Virtio device on other cases.
> > It is two devices pretending to be the same thing.  That's
> > exactly what I would like applications to get rid of.
> >=20
> > Now, the above is really not an accurate description of
> > transitional Virtio devices.  A transitional Virtio device is
> > something clearly specified in the Virtio spec, and it just means
> > a device that supports two types of drivers.  It's not different
> > from a x86_64 CPU that can run 32-bit OSes.
> >=20
> > See:
> > http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.h=
tml#x1-60001
> > http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.h=
tml#x1-3090004
>=20
> When I say a device pretending to be 2 different devices, I'm
> generally referring to the fact that a single QEMU device model
> can expose two different PCI device IDs depending on how it is
> configured and/or placed.

Understood.  Then you are not describing transitional Virtio, you
are just describing QEMU's disable-legacy=3Dauto behavior (which is
the default).


>=20
> > > > > Honestly though, the longer this discussion goes on, the more I=
 think
> > > > > the answer is just "do nothing". All this time spent on discuss=
ion,
> > > > > and future time spent on implementing new logic in apps, is mer=
ely
> > > > > to support running RHEL-6 on Q35.  I think we should just say t=
hat
> > > > > RHEL-6 should use i440fx forever and be done with it.
> > > >=20
> > > > I'm not sure if you are saying that we (Red Hat) shouldn't spend
> > > > time implementing it, or that the libvirt upstream project should
> > > > reject the patches if somebody implements it.  I would understand
> > > > the former, but not the latter.
> > >=20
> > > Even if someone is willing to implement it in libvirt, we have to
> > > consider the cost of supporting it in both libvirt and applications
> > > using libvirt and the complexity it adds to our story about the
> > > docs / best practices for configuring guests.
> > >=20
> > > Even though I do kind of like the virtio-0.9/virtio-1.0 device mode=
l
> > > as concepts, I'm yet to be convinced that implementing them in libv=
irt
> > > and then also in all the downstream applications (oVirt, OpenStack,
> > > virt-manager, cockpit, etc) is actually worth the cost.
> > >=20
> > > There's little compelling reason to care about running outdated OS
> > > like RHEL-6 on Q35 in general. The motivation behind it is just
> > > coming from an artifically created problem downstream, by wishing
> > > to drop the i440fx machine at some still undeteremined point in the
> > > future. By the time that future comes, RHEL-6 may well even be
> > > end of life making the entire exercise a pointless.
> >=20
> > I'm all for making a cost/benefit analysis, but I don't think you
> > are taking into account the costs of keeping the confusing
> > semantics of existing "virtio" devices.
> >=20
> > If you still want to refuse to provide a sane way to configure
> > transitional Virtio devices, I really won't care.  But I believe
> > the interface you are trying to keep is actually the one you are
> > criticizing ("two separate devices pretending to be the same
> > thing, but magically changing their identity at runtime").
>=20
> Yeah, I guess I should make a distinction between what I would
> do if it was a clean slate, and what we should do given our existing
> practice.
>=20
> If we had a clean slate I would not like to see our current impl
> done.  Given that it already exists, however, we're stuck with
> that forever. So the question is whether implementing any of
> the alternative options is a net benefit for libvirt & mgmt apps
> overall. My gut feeling is that despite the downsides of the
> current impl, it is not worth trying todo something different.

Fair enough.

>=20
> The thing that has really tipped my mind this way is that even
> if we provide new device models, mgmt apps will be loathe to
> actually use them because it will prevent live migration of
> those guests to hosts with older libvirt.

This might be an issue for some apps, but is it going to happen
in practice?  Don't they all need mechanisms to flip a switch and
enable features that require newer host software, already?

>=20
> So my feeling is we should do the work to enable use of Q35
> by default in mgmt apps, for guest OS where it is known to
> work correctly today. Every other OS should just stick with
> i440fx as we already know that works for them today and Q35
> doesn't offer legacy OS compelling enough benefits to switch.

I'd still prefer if libvirt provided a saner configuration
mechanism, and let libosinfo and management apps decide what
works best for them.

If it helps, I can send QEMU patches to make
virtio-0.9/virtio-1.0-non-transitional/virtio-1.0-transitional
appear as different device types.  libvirt would then be able to
check if the device type implements "pci-express-device" or
"conventional-pci-device", instead of adding device-specific
placement logic.

--=20
Eduardo
