Received: from eggs.gnu.org ([2001:4830:134:3::10]:37439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gCjIX-0002mO-NR
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:43:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gCjIR-0007kQ-GA
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:43:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gCjIR-0007hQ-3d
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:43:23 -0400
Message-ID: <048ea4797a31e3a584c36453e6cad10403462e55.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 17 Oct 2018 12:43:02 +0200
In-Reply-To: <d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net> <20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: Laine Stump <laine@redhat.com>, "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>

On Tue, 2018-10-16 at 15:12 -0400, Laine Stump wrote:
> On 10/16/2018 01:02 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Oct 15, 2018 at 03:14:04PM -0300, Eduardo Habkost wrote:
> > How about using only the major digit in the device names eg
> >=20
> >   'virtio-blk-0.x'
> >   'virtio-blk-1.x'
> >=20
> > to make it clearer that we cover 1.0 and 1.1 (and 1.2, etc
> > by the same device.
>=20
> +1 from me on either "-1" or "-1.x", and a -1 on "-1.0" or "-modern".

Agreed on using the major version number rather than a non-specific
string, and since the number refers to the virtio protocol version
I would expect the result to be

  virtio-0-blk-pci
  virtio-1-blk-pci

and so on.

The proposal doesn't directly address the interaction between virtio
protocol version and slot type. Admittedly, I don't recall all the
details myself, but the point is that I would like to see the slot
type mentioned explicitly in the device name to avoid confusion, so
the above might end up looking more like

  virtio-0-blk-pci
  virtio-1-blk-pci
  virtio-1-blk-pcie

with the last one very clearly not being usable on i440fx. I might
have gotten some details wrong in the example, but you get the idea.

[...]
> > Apps using the new device model names would either make themselves
> > incompatible with older libvirt/QEMU, or they would increase their
> > code complexity & testing matrix by having to support both old & new
> > names. The usage would also harm migration to older hosts.
> >=20
> > This just to be able to switch from i440fx to q35 for OS which don't
> > support virtio-1.0, but for such old OS, q35 isn't offering any
> > compelling features, so they might as well stick with the thing that
> > is known to work well.
>=20
> The *current* compelling reason is to permit management apps to use Q35
> for "old" OSes that don't have a driver for virtio-1.0, (and especially
> *new* management apps that want to support only Q35 from the start), bu=
t
> there are other future advantages that will make us appreciate that thi=
s
> was done. For example, libosinfo currently reports separately that an
> supports virtio-0.9 devices and/or virtio-1.0 devices, but a management
> app would need to have extra logic to take account of the fact that the
> only way to get a virtio-0.9 device would be to place it on a
> conventional PCI bus; if qemu offers the two as separate devices then
> all the management app has to do is use the device that libosinfo tells
> it to use, and it will automatically be placed on the right kind of bus=
.
> (and I've heard from Eduardo that eventually we'll be able to learn the
> PCI ID of the devices from qmp introspection, so the management app wil=
l
> be able to just look for a device ID that is on both the qemu and the O=
S
> list, and use that).
>=20
> Obviously using these devices will make it impossible to migrate a gues=
t
> that uses them to an older host that doesn't have "new" qemu + libvirt,
> but if that's important to a management app, then they can just do
> things in the more complicated manner needed by the "combined" virtio
> device variants. (Again, if a management app is just being
> designed/written now, it can assume these new devices from the start an=
d
> ignore the older combined device).
>=20
> In the end, having a device that changed PCI ID depending on what kind
> of slot it was plugged into was an idea "too clever for its own good",
> should be avoided when new devices are added in the future, and we
> should at least provide an alternative that doesn't do that for existin=
g
> devices.

Agreed, the current situation is kind of a mess and taking steps
towards solving it will pay off in the long term.

At the same time, we should not fool ourselves into thinking it will
take less than *years* before applications such as virt-manager can
actually take advantage of the new devices without compromising their
support for old libvirt and QEMU versions too much.

So if we're doing this to rectify some questionable design choices
with the goal of having a better situation in the long run, then by
all means we should go ahead; but if we think this will allow us to
run RHEL 6 on q35 in the short term, then our efforts are probably
misguided.

--=20
Andrea Bolognani / Red Hat / Virtualization
