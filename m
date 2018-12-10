Received: from eggs.gnu.org ([2001:4830:134:3::10]:48316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWREy-0007TB-UG
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWREu-0005di-RP
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:29:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gWREu-0005Ks-C4
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 14:29:12 -0500
References: <1544458548-5986-1-git-send-email-venu.busireddy@oracle.com>
	<1544458548-5986-3-git-send-email-venu.busireddy@oracle.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f1e76f0-4871-95fb-4691-d10c216a0826@redhat.com>
Date: Mon, 10 Dec 2018 13:28:42 -0600
MIME-Version: 1.0
In-Reply-To: <1544458548-5986-3-git-send-email-venu.busireddy@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Venu Busireddy <venu.busireddy@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On 12/10/18 10:15 AM, Venu Busireddy wrote:
> Added two new events, FAILOVER_PLUG_PRIMARY and FAILOVER_UNPLUG_PRIMARY.
> The first is emitted when the guest negotiates the F_STANDBY feature
> bit. The second is emitted when the virtio_net driver is removed, either
> manually or as a result of guest reboot. Management stack can use these
> events to determine when to plug/unplug the VF device to/from the guest.
> 
> Also, the Virtual Functions will be automatically removed from the guest
> if the guest is rebooted. To properly identify the VFIO devices that
> must be removed, a new property named "x-failover-primary" is added to
> the vfio-pci devices. Only the vfio-pci devices that have this property
> enabled are removed from the guest upon reboot.
> 
> Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
> ---

> +++ b/qapi/net.json
> @@ -683,3 +683,47 @@
>   ##
>   { 'event': 'NIC_RX_FILTER_CHANGED',
>     'data': { '*name': 'str', 'path': 'str' } }
> +
> +##
> +# @FAILOVER_PLUG_PRIMARY:
> +#
> +# Emitted when the guest successfully loads the driver after the STANDBY
> +# feature bit is negotiated.
> +#
> +# @device: Indicates the virtio_net device.
> +#
> +# @path: Indicates the device path.
> +#
> +# Since: 3.0

You've missed 3.0, and even 3.1.  This should be 4.0.

> +#
> +# Example:
> +#
> +# <- {"timestamp": {"seconds": 1432121972, "microseconds": 744001},
> +#     "event": "FAILOVER_PLUG_PRIMARY",
> +#     "data": {"device": "net0", "path": "/machine/peripheral/net0/virtio-backend"} }
> +#
> +##
> +{ 'event': 'FAILOVER_PLUG_PRIMARY',
> +  'data': {'*device': 'str', 'path': 'str'} }
> +
> +##
> +# @FAILOVER_UNPLUG_PRIMARY:
> +#
> +# Emitted when the guest resets the virtio_net driver.
> +# The reset can be the result of either unloading the driver or a reboot.
> +#
> +# @device: Indicates the virtio_net device.
> +#
> +# @path: Indicates the device path.
> +#
> +# Since: 3.0

and again


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
