Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsshR-0003W0-OH
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fssRi-00057k-6X
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:26:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58086 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fssRh-000570-So
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:26:54 -0400
Date: Thu, 23 Aug 2018 17:26:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180823162647.GQ23703@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <68a98c1b-e6dd-f2df-1499-17c2b8b583be@redhat.com>
	<20180817092936.GC11124@redhat.com>
	<e8a14a22915569b492adb414e5ccc98dcf64a24d.camel@redhat.com>
	<39b3c8b8-25eb-3a8e-3a5a-abd584a11e2c@laine.org>
	<f961907dde47f1a7fa3be400bed6356f136ec704.camel@redhat.com>
	<20180822120135.GN18995@localhost.localdomain>
	<20180822122601.GI12750@redhat.com>
	<20180822125455.GP18995@localhost.localdomain>
	<87r2ipcbfs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2ipcbfs.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Libvirt <libvir-list@redhat.com>, Laine Stump <laine@laine.org>, Andrea Bolognani <abologna@redhat.com>, qemu list <qemu-devel@nongnu.org>

On Thu, Aug 23, 2018 at 06:08:55PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
>=20
> > On Wed, Aug 22, 2018 at 01:26:01PM +0100, Daniel P. Berrang=C3=A9 wro=
te:
> >> On Wed, Aug 22, 2018 at 09:01:35AM -0300, Eduardo Habkost wrote:
> >> > On Wed, Aug 22, 2018 at 12:36:27PM +0200, Andrea Bolognani wrote:
> >> > > On Tue, 2018-08-21 at 14:21 -0400, Laine Stump wrote:
> >> > > > On 08/17/2018 06:35 AM, Andrea Bolognani wrote:
> >> > > > > If we decide we want to explicitly spell out the options ins=
tead
> >> > > > > of relying on QEMU changing behavior based on the slot type,=
 which
> >> > > > > is probably a good idea anyway, I think we should have
> >> > > > >=20
> >> > > > >   virtio-0.9 =3D> disable-legacy=3Dno,disable-modern=3Dno
> >> > > > >   virtio-1.0 =3D> disable-legacy=3Dyes,disable-modern=3Dno
> >> > > > >=20
> >> > > > > There's basically no reason to have a device legacy-only rat=
her
> >> > > > > than transitional, and spelling out both options instead of =
only
> >> > > > > one of them just seems more robust.
> >> > > >=20
> >> > > > I agree with both of those, but the counter-argument is that "=
virtio"
> >> > > > already describes a transitional device like your proposal for
> >> > > > virtio-0.9 (at least today), and it makes the versioned models=
 less
> >> > > > orthogonal. In the end, I could go either way...
> >> > >=20
> >> > > Yeah, Dan already made that argument and convinced me that we
> >> > > should use virtio-0.9 for legacy only, virtio-1.0 for modern onl=
y
> >> > > and plain virtio for no enforced behavior / transitional.
> >> >=20
> >> > I don't understand why we are optimizing the new system for the
> >> > less useful use cases:
> >> >=20
> >> > I don't see a use case where virtio-0.9 (legacy-only) would be
> >> > more useful than virtio-transitional.  I don't see why anybody
> >> > would prefer a legacy-only device instead of a transitional
> >> > device.  Even if your guest has only legacy drivers, it might be
> >> > upgraded and get new drivers in the future.
> >> >=20
> >> > I don't see a use case where virtio-1.0 (modern-only) would be
> >> > more useful than "virtio".  If you are running i440fx, you get a
> >> > transitional device with "virtio", and I don't see why anybody
> >> > would prefer a modern-only device.  If you are running Q35, you
> >> > already get a modern-only device with "virtio".
> >> >=20
> >> > The most useful feature users need is the ability to ask for a
> >> > transitional virtio device on Q35, and this use case is
> >> > explicitly being left out of the proposal.  Why?
> >>=20
> >> You can already get a transitional device on Q35, albeit with manual
> >> placement. Adding flags for magic placement for the existing devices
> >> is not something that is suitable for the XML. The ability to get
> >> legacy-only, or modern-only doesn't exist today in any way, so that
> >> would be a valid new feature.
> >
> > Transitional devices and modern-only devices are different kinds
> > of devices.  Making the guest see a different type of device
> > depending on where it's plugged is why we got into this mess,
>=20
> Every time we make -device FOO result in a different device depending o=
n
> context, device configuration or placement, it eventually joins our
> collection of Very Bad Ideas.  Different PCI device IDs are a clear
> indicator of device difference.
>=20
> Instances of this class of Very Bad Ideas I've addressed myself:
>=20
> * I deprecated "ivshmem" in favor of "ivshmem-plain" and
>   "ivshmem-doorbell".
>=20
> * I split "ide-drive" into of "ide-hd" and "ide-cd" (deprecation wasn't
>   fashionable back then)
>=20
> * I split "scsi-disk" into "scsi-hd" and "scsi-cd" (likewise)
>=20
> One time pain, long term gain.

The pain in those three cases was largely non-existant and/or
hidden. Almost no one ever used ivshmem, so by extension almost
no one was impacted by need to use different names. It was also
not migratable, so there was no need to care about compatibility
with older versions. For ide-drive/scsi-disk, the change was
completely hidden inside libvirt and wasn't ABI sensitive so
didn't affect apps or migration.

> We should consider addressing virtio devices, too: deprecate the
> chameleon device models an adequate grace period.

The change discussed here would have major impact by comparison
as it would be telling every single app to change what they do,
and the change would prevent their guests being compatible with
older libvirt. I don't think the gain outweighs the costs of
making the changes across every mgmt app, even ignoring the cost
of the backcompatibility problems

> >> Honestly though, the longer this discussion goes on, the more I thin=
k
> >> the answer is just "do nothing". All this time spent on discussion,
> >> and future time spent on implementing new logic in apps, is merely
> >> to support running RHEL-6 on Q35.
>=20
> I strenously disagree.  This is first and foremost about correcting a
> design mistake we made.
>
> > I'm not sure if you are saying that we (Red Hat) shouldn't spend
> > time implementing it, or that the libvirt upstream project should
> > reject the patches if somebody implements it.  I would understand
> > the former, but not the latter.
>=20
> I would be willing to listen a reasoned argument why correcting the
> design mistake is not worthwhile.  I'm unwilling to listen to more
> downstream blaming.  Please stop it.

There are countless mistakes in both QEMU & libvirt, but only some of
them are worth the cost of changing. I'm not seeing a compelling reason
why this change is worthwhile. The impact of the design mistake is narrow
and only raised because of downstream desire to change even legacy OS
to use Q35 when there's no benefit to those OS of such a change.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
