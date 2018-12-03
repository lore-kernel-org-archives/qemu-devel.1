Received: from eggs.gnu.org ([2001:4830:134:3::10]:33355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gTqfE-0003M6-2G
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gTqfA-0007JU-6f
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:01:39 -0500
Date: Mon, 3 Dec 2018 17:01:27 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181203170127.349625de.cohuck@redhat.com>
In-Reply-To: <20181128145455.11733-1-david@redhat.com>
References: <20181128145455.11733-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] qdev: Let the hotplug_unplug() caller
 delete the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org

On Wed, 28 Nov 2018 15:54:55 +0100
David Hildenbrand <david@redhat.com> wrote:

> When unplugging a device, at one point the device will be destroyed
> via object_unparent(). This will, one the one hand, unrealize the
> device hierarchy to be removed, and on the other hand, destroy/free the
> device hierarchy.
>=20
> When chaining interrupt handlers, we want to overwrite a bus hotplug

s/interrupt/hotplug/, no?

> handler by the machine hotplug handler, to be able to perform
> some part of the plug/unplug and to forward the calls to the bus hotplug
> handler.
>=20
> For now, the bus hotplug handler would trigger an object_unparent(), not
> allowing us to perform some unplug action on a device after we forwarded
> the call to the bus hotplug handler. The device would be gone at that
> point.
>=20
> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>     machine_unplug_handler(dev) {
>         /* eventually do unplug stuff */
>         bus_unplug_handler(dev) -> calls object_unparent(dev)
>         /* dev is gone, we can't do more unplug stuff */
>     }
>=20
> So move the object_unparent() to the original caller of the unplug. For
> now, keep the unrealize() at the original places of the
> object_unparent().
>=20
> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>     machine_unplug_handler(dev) {
>         /* eventually do unplug stuff */
>         bus_unplug_handler(dev) -> calls unrealize(dev)
>         /* we can do more unplug stuff but device already unrealized */
>     }
> object_unparent(dev)
>=20
> In the long run, every unplug action should be factored out of the
> unrealize() function into the unplug handler (especially for PCI). Then
> we can get rid of the additonal unrealize() calls and object_unparent()
> will properly unrealize the device hierarchy after the device has been
> unplugged.
>=20
> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>     machine_unplug_handler(dev) {
>         /* eventually do unplug stuff */
>         bus_unplug_handler(dev) -> only unplugs, does not unrealize
>         /* we can do more unplug stuff */
>     }
> object_unparent(dev) -> will unrealize
>=20
>=20
> The original approach was suggested by Igor Mammedov for the PCI
> part, but I extended it to all hotplug handlers. I consider this one
> step into the right direction.

=46rom my limited overview of the hotplug infrastructure, this looks
reasonable.

>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>=20
> I might still be missing some cases, but I want to get some feedback first
> if this makes sense.
>=20
> This is based on the series:
>     [PATCH v3 00/11] pci: hotplug handler reworks=E2=80=8B
>=20
>  hw/acpi/cpu.c            |  1 +
>  hw/acpi/memory_hotplug.c |  1 +
>  hw/acpi/pcihp.c          |  3 ++-
>  hw/core/qdev.c           |  3 +--
>  hw/i386/pc.c             |  5 ++---
>  hw/pci/pcie.c            |  3 ++-
>  hw/pci/shpc.c            |  3 ++-
>  hw/ppc/spapr.c           |  4 ++--
>  hw/ppc/spapr_pci.c       |  3 ++-
>  hw/s390x/css-bridge.c    |  2 +-
>  hw/s390x/s390-pci-bus.c  | 12 ++++++++++--
>  qdev-monitor.c           |  9 +++++++--
>  12 files changed, 33 insertions(+), 16 deletions(-)

> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 9abd49a9dc..a84e80f6dd 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -988,7 +988,11 @@ static void s390_pcihost_unplug(HotplugHandler *hotp=
lug_dev, DeviceState *dev,
>                                   pbdev->fh, pbdev->fid);
>      bus =3D pci_get_bus(pci_dev);
>      devfn =3D pci_dev->devfn;
> -    object_unparent(OBJECT(pci_dev));
> +    if (OBJECT(pci_dev) =3D=3D OBJECT(dev)) {
> +        object_property_set_bool(OBJECT(pci_dev), false, "realized", NUL=
L);
> +    } else {
> +        object_unparent(OBJECT(pci_dev));
> +    }
>      s390_pci_msix_free(pbdev);
>      s390_pci_iommu_free(s, bus, devfn);
>      pbdev->pdev =3D NULL;
> @@ -997,7 +1001,11 @@ out:
>      pbdev->fid =3D 0;
>      QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
>      g_hash_table_remove(s->zpci_table, &pbdev->idx);
> -    object_unparent(OBJECT(pbdev));
> +    if (OBJECT(pbdev) =3D=3D OBJECT(dev)) {
> +        object_property_set_bool(OBJECT(pbdev), false, "realized", NULL);
> +    } else {
> +        object_unparent(OBJECT(pbdev));
> +    }

That's a bit... ugly. Not really your code, but the inherent ugliness
of the architecture it uncovers; we basically have two devices paired
with each other and we need to unplug them both, regardless on which of
the two unplug is called.

Maybe add a comment explaining it a bit?

It looks correct, though; but I haven't tested it :)

Nothing bad jumped out at me from the rest of your patch, either.
