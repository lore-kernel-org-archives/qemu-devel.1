Received: from eggs.gnu.org ([209.51.188.92]:38927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go7Zu-0005B0-TN
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go7Zt-00044B-1M
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:07:58 -0500
Date: Mon, 28 Jan 2019 15:07:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128150747.316dd0a4.cohuck@redhat.com>
In-Reply-To: <20190123195527.29575-2-david@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
	<20190123195527.29575-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2 1/9] qdev: Let the
 hotplug_handler_unplug() caller delete the device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Wed, 23 Jan 2019 20:55:19 +0100
David Hildenbrand <david@redhat.com> wrote:

> When unplugging a device, at one point the device will be destroyed
> via object_unparent(). This will, one the one hand, unrealize the
> removed device hierarchy, and on the other hand, destroy/free the
> device hierarchy.
> 
> When chaining hotplug handlers, we want to overwrite a bus hotplug
> handler by the machine hotplug handler, to be able to perform
> some part of the plug/unplug and to forward the calls to the bus hotplug
> handler.
> 
> For now, the bus hotplug handler would trigger an object_unparent(), not
> allowing us to perform some unplug action on a device after we forwarded
> the call to the bus hotplug handler. The device would be gone at that
> point.
> 
> machine_unplug_handler(dev)
>     /* eventually do unplug stuff */
>     bus_unplug_handler(dev)
>     /* dev is gone, we can't do more unplug stuff */
> 
> So move the object_unparent() to the original caller of the unplug. For
> now, keep the unrealize() at the original places of the
> object_unparent(). For implicitly chained hotplug handlers (e.g. pc
> code calling acpi hotplug handlers), the object_unparent() has to be
> done by the outermost caller. So when calling hotplug_handler_unplug()
> from inside an unplug handler, nothing is to be done.
> 
> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>     machine_unplug_handler(dev) {
>         /* eventually do unplug stuff */
>         bus_unplug_handler(dev) -> calls unrealize(dev)
>         /* we can do more unplug stuff but device already unrealized */
>     }
> object_unparent(dev)
> 
> In the long run, every unplug action should be factored out of the
> unrealize() function into the unplug handler (especially for PCI). Then
> we can get rid of the additonal unrealize() calls and object_unparent()
> will properly unrealize the device hierarchy after the device has been
> unplugged.
> 
> hotplug_handler_unplug(dev) -> calls machine_unplug_handler()
>     machine_unplug_handler(dev) {
>         /* eventually do unplug stuff */
>         bus_unplug_handler(dev) -> only unplugs, does not unrealize
>         /* we can do more unplug stuff */
>     }
> object_unparent(dev) -> will unrealize
> 
> The original approach was suggested by Igor Mammedov for the PCI
> part, but I extended it to all hotplug handlers. I consider this one
> step into the right direction.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
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
>  hw/s390x/s390-pci-bus.c  | 13 ++++++++-----
>  qdev-monitor.c           |  9 +++++++--
>  12 files changed, 31 insertions(+), 19 deletions(-)

s390 parts look reasonable.

Acked-by: Cornelia Huck <cohuck@redhat.com>
