Received: from eggs.gnu.org ([209.51.188.92]:54273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1ggZAy-00028c-C1
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1ggZAx-0005Nq-7y
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:59:00 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1ggZAw-0005Mx-Uz
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 12:58:59 -0500
Date: Mon, 7 Jan 2019 11:58:54 -0600
From: Venu Busireddy <venu.busireddy@oracle.com>
Message-ID: <20190107175854.GA6932@troi>
References: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
	<1544458548-5986-3-git-send-email-venu.busireddy@oracle.com>
	<6f1e76f0-4871-95fb-4691-d10c216a0826@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f1e76f0-4871-95fb-4691-d10c216a0826@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] virtio_net: Add support for "Data Path
 Switching" during Live Migration.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 2018-12-10 13:28:42 -0600, Eric Blake wrote:
> On 12/10/18 10:15 AM, Venu Busireddy wrote:
> > Added two new events, FAILOVER_PLUG_PRIMARY and FAILOVER_UNPLUG_PRIMARY.
> > The first is emitted when the guest negotiates the F_STANDBY feature
> > bit. The second is emitted when the virtio_net driver is removed, either
> > manually or as a result of guest reboot. Management stack can use these
> > events to determine when to plug/unplug the VF device to/from the guest.
> > 
> > Also, the Virtual Functions will be automatically removed from the guest
> > if the guest is rebooted. To properly identify the VFIO devices that
> > must be removed, a new property named "x-failover-primary" is added to
> > the vfio-pci devices. Only the vfio-pci devices that have this property
> > enabled are removed from the guest upon reboot.
> > 
> > Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> > ---
> 
> > +++ b/qapi/net.json
> > @@ -683,3 +683,47 @@
> >   ##
> >   { 'event': 'NIC_RX_FILTER_CHANGED',
> >     'data': { '*name': 'str', 'path': 'str' } }
> > +
> > +##
> > +# @FAILOVER_PLUG_PRIMARY:
> > +#
> > +# Emitted when the guest successfully loads the driver after the STANDBY
> > +# feature bit is negotiated.
> > +#
> > +# @device: Indicates the virtio_net device.
> > +#
> > +# @path: Indicates the device path.
> > +#
> > +# Since: 3.0
> 
> You've missed 3.0, and even 3.1.  This should be 4.0.

Sorry for the delay in responding...

Posted v2 including your suggestion at
https://lists.oasis-open.org/archives/virtio-dev/201901/msg00046.html

Thanks!

> 
> > +#
> > +# Example:
> > +#
> > +# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
> > +#     "event": "FAILOVER_PLUG_PRIMARY",
> > +#     "data": {"device": "net0", "path": "/machine/peripheral/net0/virtio-backend"} }
> > +#
> > +##
> > +{ 'event': 'FAILOVER_PLUG_PRIMARY',
> > +  'data': {'*device': 'str', 'path': 'str'} }
> > +
> > +##
> > +# @FAILOVER_UNPLUG_PRIMARY:
> > +#
> > +# Emitted when the guest resets the virtio_net driver.
> > +# The reset can be the result of either unloading the driver or a reboot.
> > +#
> > +# @device: Indicates the virtio_net device.
> > +#
> > +# @path: Indicates the device path.
> > +#
> > +# Since: 3.0
> 
> and again
> 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
