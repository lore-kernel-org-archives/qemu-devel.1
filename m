Received: from eggs.gnu.org ([2001:4830:134:3::10]:44687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP3YK-0003M6-NQ
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gP3YG-0001qM-CP
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:46:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gP3YG-0001o8-4O
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:46:40 -0500
Date: Tue, 20 Nov 2018 10:46:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181120104605.GF25047@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<20181115100559.GE10900@redhat.com>
	<20181115115056.65cf3659.cohuck@redhat.com>
	<20181120004454.GA4755@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181120004454.GA4755@habkost.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Mon, Nov 19, 2018 at 10:44:54PM -0200, Eduardo Habkost wrote:
> On Thu, Nov 15, 2018 at 11:50:56AM +0100, Cornelia Huck wrote:
> > On Thu, 15 Nov 2018 10:05:59 +0000
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >=20
> > > On Wed, Nov 14, 2018 at 09:38:31PM -0200, Eduardo Habkost wrote:
> > > > Many of the current virtio-*-pci device types actually represent
> > > > 3 different types of devices:
> > > > * virtio 1.0 non-transitional devices
> > > > * virtio 1.0 transitional devices
> > > > * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
> > > >=20
> > > > That would be just an annoyance if it didn't break our device/bus
> > > > compatibility QMP interfaces.  With this multi-purpose device
> > > > type, there's no way to tell management software that
> > > > transitional devices and legacy devices require a Conventional
> > > > PCI bus.
> > > >=20
> > > > The multi-purpose device types would also prevent us from telling
> > > > management software what's the PCI vendor/device ID for them,
> > > > because their PCI IDs change at runtime depending on the bus
> > > > where they were plugged.
> > > >=20
> > > > This patch adds separate device types for each of those virtio
> > > > device flavors:
> > > >=20
> > > > - virtio-*-pci: the existing multi-purpose device types
> > > >   - Configurable using `disable-legacy` and `disable-modern`
> > > >     properties
> > > >   - Legacy driver support is automatically enabled/disabled
> > > >     depending on the bus where it is plugged
> > > >   - Supports Conventional PCI and PCI Express buses
> > > >     (but Conventional PCI is incompatible with
> > > >     disable-legacy=3Doff)
> > > >   - Changes PCI vendor/device IDs at runtime
> > > > - virtio-*-pci-transitional: virtio-1.0 device supporting legacy =
drivers
> >=20
> > It's a virtio-1 (not 1.0) device. Otherwise, I like this terminology
> > better.
> >=20
> > > >   - Supports Conventional PCI buses only, because
> > > >     it has a PIO BAR =20
> > >=20
> > > Am I right in thinking that this is basically identical
> > > to virtio-*-pci, aside from only being valid for PCI
> > > buses ?
> > >=20
> > > IOW, libvirt can expose this device even if QEMU does
> > > not support it, by simply using the existing device
> > > type and only ever placing it in a PCI bus ?
> > >=20
> > > If libvirt did this compatibility approach, can you
> > > confirm this would be live migration state compatible.
> > >=20
> > > ie can live migrate virtio-*-pci -> virtio-*-pci-transitional,
> > > provided only PCI bus was used.
> >=20
> > It also needs to make sure that neither disable-legacy nor
> > disable-modern is set. Then this would have a compatible state AFAICS=
.
> >=20
> > >=20
> > > > - virtio-*-pci-non-transitional: modern-only
> > > >   - Supports both Conventional PCI and PCI Express buses =20
> > >=20
> > > IIUC, libvirt can again provide compatibility with old
> > > QEMU by simply using the existing device type and setting
> > > disable-legacy ?  Can you confirm this would be live
> > > migration compatible
> > >=20
> > >   virtio-*-pci + disable-legacy -> virtio-*pci-non-transitional
> >=20
> > I think yes.
>=20
> This is exactly how it is implemented internally, but I'm not
> promising that this will be kept compatible forever.  And I
> wouldn't like to make that promise unless there's an important
> use case for that.
>
> We could easily ensure it will be compatible in pc-4.0 and older,
> though.  Would that be enough for the use case we have in mind?

I guess that as long as it is compat in all existing machine types,
it doesn't matter what new machine types do.

Libvirt would only use the back compat stuff with QEMU < 4.0, in
which case you can guarantee a machine type < pc-4.0. If libvirt
saw a QEMU >=3D 4.0, it would never use the back compat approach,
so it wouldn't matter if >=3D pc-4.0 were not compatible. ie for
live migration it would be a case of

   QEMU-3.1  + pc-3.1 -----> QEMU_4.0 + pc-3.1

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
