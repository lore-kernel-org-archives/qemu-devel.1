Received: from eggs.gnu.org ([209.51.188.92]:34855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gj08y-0002ox-SW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gj08y-0006pn-26
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:11:00 -0500
Received: from mail-bgr052101133055.outbound.protection.outlook.com
	([52.101.133.55]:6338
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gj08x-0006je-68
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:10:59 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon, 14 Jan 2019 11:10:44 +0000
Message-ID: <20190114111040.GA2480@rkaganb.sw.ru>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
	<1546900184-27403-3-git-send-email-venu.busireddy@oracle.com>
	<20190109105223-mutt-send-email-mst@kernel.org>
	<e496ce78-462d-7675-9e97-6cbac2038489@oracle.com>
	<20190110220906-mutt-send-email-mst@kernel.org>
	<85064076-89af-028d-a614-e20f64830a66@oracle.com>
In-Reply-To: <85064076-89af-028d-a614-e20f64830a66@oracle.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1CCA4DE58DFC1A46BD49881AADF7F811@eurprd08.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 2/5] virtio_net: Add
 support for "Data Path Switching" during Live Migration.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: si-wei liu <si-wei.liu@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Jan 10, 2019 at 11:09:09PM -0800, si-wei liu wrote:
> On 01/10/2019 07:20 PM, Michael S. Tsirkin wrote:
> > On Thu, Jan 10, 2019 at 06:09:23PM -0800, si-wei liu wrote:
> > > 
> > > On 01/09/2019 07:56 AM, Michael S. Tsirkin wrote:
> > > > On Mon, Jan 07, 2019 at 05:29:41PM -0500, Venu Busireddy wrote:
> > > > > @@ -207,6 +226,14 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
> > > > >        int i;
> > > > >        for (i = 0; i < ACPI_PCIHP_MAX_HOTPLUG_BUS; ++i) {
> > > > > +        /*
> > > > > +         * Set the acpi_pcihp_pci_status[].down bits of all the
> > > > > +         * failover_primary devices so that the devices are ejected
> > > > > +         * from the guest. We can't use the qdev_unplug() as well as the
> > > > > +         * hotplug_handler to unplug the devices, because the guest may
> > > > > +         * not be in a state to cooperate.
> > > > > +         */
> > > > > +        acpi_pcihp_cleanup_failover_primary(s, i);
> > > > >            acpi_pcihp_update_hotplug_bus(s, i);
> > > > >        }
> > > > >    }
> > > > I really don't want acpi to know anything about failover.
> > > > 
> > > > All that needs to happen is sending a device delete request
> > > > to guest. Should work with any hotplug removal:
> > > > pci standard,acpi, etc.
> > > > 
> > > As the code comments above indicated, there was issue uncovered that the
> > > guest may not be in a state to respond to interrupt during reboot.
> > If you request removal then hotplug machinery normally will eject
> > the device on system reset. You need to request it early enough though.
> With asynchronous nature of interrupt injection and guest handling, there's
> no way you can guarantee it's early enough, do you?

I wonder if it can be better addressed by some "eject-on-parent-reset"
or "eject-on-vm-reset" property which would automatically eject the
device when the parent bridge or the vm is reset, so that the device is
in predictably unplugged state on every boot?

Roman.
