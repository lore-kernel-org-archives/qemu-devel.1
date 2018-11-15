Received: from eggs.gnu.org ([2001:4830:134:3::10]:38849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gNKXp-0000Yk-5K
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gNKXj-0008DL-Fu
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:31:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47057)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gNKXh-0007x5-FT
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:30:59 -0500
Message-ID: <c1b4a0ee39dfddeb19f1be46710c10cbefd3f07a.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 15 Nov 2018 17:29:24 +0100
In-Reply-To: <20181114233831.10374-1-ehabkost@redhat.com>
References: <20181114233831.10374-1-ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Wed, 2018-11-14 at 21:38 -0200, Eduardo Habkost wrote:
> Many of the current virtio-*-pci device types actually represent
> 3 different types of devices:
> * virtio 1.0 non-transitional devices
> * virtio 1.0 transitional devices
> * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
>=20
> That would be just an annoyance if it didn't break our device/bus
> compatibility QMP interfaces.  With this multi-purpose device
> type, there's no way to tell management software that
> transitional devices and legacy devices require a Conventional
> PCI bus.
>=20
> The multi-purpose device types would also prevent us from telling
> management software what's the PCI vendor/device ID for them,
> because their PCI IDs change at runtime depending on the bus
> where they were plugged.
>=20
> This patch adds separate device types for each of those virtio
> device flavors:
>=20
> - virtio-*-pci: the existing multi-purpose device types
>   - Configurable using `disable-legacy` and `disable-modern`
>     properties
>   - Legacy driver support is automatically enabled/disabled
>     depending on the bus where it is plugged
>   - Supports Conventional PCI and PCI Express buses
>     (but Conventional PCI is incompatible with
>     disable-legacy=3Doff)
>   - Changes PCI vendor/device IDs at runtime
> - virtio-*-pci-transitional: virtio-1.0 device supporting legacy driver=
s
>   - Supports Conventional PCI buses only, because
>     it has a PIO BAR
> - virtio-*-pci-non-transitional: modern-only
>   - Supports both Conventional PCI and PCI Express buses

So, my understanding was that transitional devices would be suitable
for both PCI and PCIe slots and non-transitional devices could only
work in PCIe slots, but based on the above it looks like I got it
pretty much completely wrong? I'm not too surprised that would be
the case, to be honest: keeping this stuff straight in my head has
always been a bit of a challenge, so I can't possibly not welcome a
proposal like this, which will spell it out a bit more :)

Let me try to map the interactions out:

  * virtio-*-pci-transitional
    + plugged into PCI slot
      - shows up as vendor1/device1
    + plugged into PCIe slot
      - doesn't work

  * virtio-*-pci-non-transitional
    + plugged into PCI slot
      - shows up as vendor2/device2
    + plugged into PCIe slot
      - shows up as vendor2/device2

  * virtio-*-pci
    + plugged into PCI slot
      - shows up as vendor1/device1
        (same as virtio-*-pci-transitional)
    + plugged into PCIe slot
      - shows up as vendor2/device2
        (same as virtio-*-pci-non-transitional)

Does that look about right?

Once all the various pieces have fallen into place, when adding a
device to a guest running a modern OS we would find out through
libosinfo that it supports vendor2/device2 (and vendor1/device1
too, I guess?) so we would choose the non-transitional variant and
plug it into PCIe when possible (q35) or PCI otherwise (pc); on
the other hand, an older guest OS like CentOS 6 will only advertise
support for vendor1/device1, so we'd have to use the transitional
variant instead and plug it into a PCI slot regardless of the
machine type, which more specifically means building a
pcie.0 <- pcie-root-port <- pcie-pci-bridge topology for q35
guests.

If all of the above is correct, then it sounds like a feasible
enough plan to me, though of course it be a long time before users
and management applications can rely on these new device types
being available in downstream distributions...

One thing that I'm very much not convinced about is the naming,
specifically leaving the virtio revision out: I get it that we
Should Never Need=E2=84=A2 another major version of the spec, but I'm
afraid discounting the possibility outright might prove to be
shortsighted and come back to bite us later, so I'd much rather
keep it.

And once that's done, "non-transitional" (while matching the
language of the spec) starts to look a bit unnecessary when you
could simply have

  virtio-*-pci
  virtio-*-pci-1
  virtio-*-pci-1-transitional

instead. But I don't feel as strongly about this as I do about
keeping the virtio revision in the device name :)

--=20
Andrea Bolognani / Red Hat / Virtualization
