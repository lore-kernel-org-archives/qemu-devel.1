Received: from eggs.gnu.org ([2001:4830:134:3::10]:34549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gCnPN-0008Qh-Qe
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gCnPI-0001dM-RM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gCnPI-0001bk-HO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:06:44 -0400
Date: Wed, 17 Oct 2018 11:06:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181017110249-mutt-send-email-mst@kernel.org>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<048ea4797a31e3a584c36453e6cad10403462e55.camel@redhat.com>
	<20181017150137.GX31060@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181017150137.GX31060@habkost.net>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Laine Stump <laine@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>

On Wed, Oct 17, 2018 at 12:01:37PM -0300, Eduardo Habkost wrote:
> On Wed, Oct 17, 2018 at 12:43:02PM +0200, Andrea Bolognani wrote:
> > On Tue, 2018-10-16 at 15:12 -0400, Laine Stump wrote:
> > > On 10/16/2018 01:02 PM, Daniel P. Berrang=E9 wrote:
> > > > On Mon, Oct 15, 2018 at 03:14:04PM -0300, Eduardo Habkost wrote:
> > > > How about using only the major digit in the device names eg
> > > >=20
> > > >   'virtio-blk-0.x'
> > > >   'virtio-blk-1.x'
> > > >=20
> > > > to make it clearer that we cover 1.0 and 1.1 (and 1.2, etc
> > > > by the same device.
> > >=20
> > > +1 from me on either "-1" or "-1.x", and a -1 on "-1.0" or "-modern=
".
> >=20
> > Agreed on using the major version number rather than a non-specific
> > string, and since the number refers to the virtio protocol version
> > I would expect the result to be
> >=20
> >   virtio-0-blk-pci
> >   virtio-1-blk-pci
> >=20
> > and so on.
> >=20
> > The proposal doesn't directly address the interaction between virtio
> > protocol version and slot type. [...]
>=20
> It does.  See the interface names added to each device type.
>=20
>=20
> >                           [...] Admittedly, I don't recall all the
> > details myself, but the point is that I would like to see the slot
> > type mentioned explicitly in the device name to avoid confusion, so
> > the above might end up looking more like
> >=20
> >   virtio-0-blk-pci
> >   virtio-1-blk-pci
> >   virtio-1-blk-pcie
> >=20
> > details myself, but the point is that I would like to see the slot
> > type mentioned explicitly in the device name to avoid confusion, so
> > the above might end up looking more like
> >=20
> >   virtio-0-blk-pci
> >   virtio-1-blk-pci
> >   virtio-1-blk-pcie
> >=20
> > with the last one very clearly not being usable on i440fx. I might
> > have gotten some details wrong in the example, but you get the idea.
>=20
> The difference between the devices is not just the bus type: it
> is a different type of device with different behavior.  Using the
> bus type to differentiate them would be misleading.
>=20
> e.g. both modern and transitional virtio devices can be plugged
> to Conventional PCI buses, but they have different PCI IDs.
>=20
> I'm considering doing this in v2:
>=20
> * Remove the -0.9 device type, because nobody seems to need it
> * Add two device types:
>   * virtio-1-blk-pci-non-transitional
>   * virtio-1-blk-pci-transitional
>=20
> This way, we:
> * Include only the major version of the spec (so
>   we don't require new device types for virtio 1.1, 1.2, etc),
> * Use terms that come from the Virtio spec itself, to avoid
>   ambiguity.

I'd say just drop "1" completely then.  E.g. transitional and legacy
have same ID's, differences are internal and not interesting to users.
If spec comes up with a new type of device it will come up with a new
term for it, I am sure.

> >=20
> > [...]
> > > > Apps using the new device model names would either make themselve=
s
> > > > incompatible with older libvirt/QEMU, or they would increase thei=
r
> > > > code complexity & testing matrix by having to support both old & =
new
> > > > names. The usage would also harm migration to older hosts.
> > > >=20
> > > > This just to be able to switch from i440fx to q35 for OS which do=
n't
> > > > support virtio-1.0, but for such old OS, q35 isn't offering any
> > > > compelling features, so they might as well stick with the thing t=
hat
> > > > is known to work well.
> > >=20
> > > The *current* compelling reason is to permit management apps to use=
 Q35
> > > for "old" OSes that don't have a driver for virtio-1.0, (and especi=
ally
> > > *new* management apps that want to support only Q35 from the start)=
, but
> > > there are other future advantages that will make us appreciate that=
 this
> > > was done. For example, libosinfo currently reports separately that =
an
> > > supports virtio-0.9 devices and/or virtio-1.0 devices, but a manage=
ment
> > > app would need to have extra logic to take account of the fact that=
 the
> > > only way to get a virtio-0.9 device would be to place it on a
> > > conventional PCI bus; if qemu offers the two as separate devices th=
en
> > > all the management app has to do is use the device that libosinfo t=
ells
> > > it to use, and it will automatically be placed on the right kind of=
 bus.
> > > (and I've heard from Eduardo that eventually we'll be able to learn=
 the
> > > PCI ID of the devices from qmp introspection, so the management app=
 will
> > > be able to just look for a device ID that is on both the qemu and t=
he OS
> > > list, and use that).
> > >=20
> > > Obviously using these devices will make it impossible to migrate a =
guest
> > > that uses them to an older host that doesn't have "new" qemu + libv=
irt,
> > > but if that's important to a management app, then they can just do
> > > things in the more complicated manner needed by the "combined" virt=
io
> > > device variants. (Again, if a management app is just being
> > > designed/written now, it can assume these new devices from the star=
t and
> > > ignore the older combined device).
> > >=20
> > > In the end, having a device that changed PCI ID depending on what k=
ind
> > > of slot it was plugged into was an idea "too clever for its own goo=
d",
> > > should be avoided when new devices are added in the future, and we
> > > should at least provide an alternative that doesn't do that for exi=
sting
> > > devices.
> >=20
> > Agreed, the current situation is kind of a mess and taking steps
> > towards solving it will pay off in the long term.
> >=20
> > At the same time, we should not fool ourselves into thinking it will
> > take less than *years* before applications such as virt-manager can
> > actually take advantage of the new devices without compromising their
> > support for old libvirt and QEMU versions too much.
> >=20
> > So if we're doing this to rectify some questionable design choices
> > with the goal of having a better situation in the long run, then by
> > all means we should go ahead; but if we think this will allow us to
> > run RHEL 6 on q35 in the short term, then our efforts are probably
> > misguided.
>=20
> Good point.  You might be right about oVirt and OpenStack, but
> I'm assuming at least some applications (maybe KubeVirt?) don't
> care about supporting old libvirt/QEMU versions and won't have
> that problem.
>=20
> --=20
> Eduardo
