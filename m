Received: from eggs.gnu.org ([2001:4830:134:3::10]:48466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAbqQ-00084S-5e
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAbqL-00065p-7i
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:44:54 -0400
References: <20170516072414.19025-1-famz@redhat.com>
	<20170516080737.GB27669@lemon.lan>
	<e780d3d8-43f1-f46d-2858-7554a334246b@redhat.com>
	<20170516122528.GC27669@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3799c1f5-5b22-fe05-4c98-4cd76c716551@redhat.com>
Date: Tue, 16 May 2017 14:44:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170516122528.GC27669@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] virtio: Move memory_listener_unregister
 to .unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 16/05/2017 14:25, Fam Zheng wrote:
> You are right. Having had another look, I think it's because of this:
> VirtIODevice is an embeded member of VirtIOSCSIPCI therefore it is neve=
r
> "finalized" through QOM reference directly.  Am I right?

What I would expect is:

virtio_instance_init_common:
- create the VirtIODevice with refcount 1
- create a child property for the VirtIODevice (refcount is now 2)
- unref the VirtIODevice (refcount is again 1)

virtio_pci_realize:
- virtio_pci_bus_new creates the virtio bus
- the virtio bus is added as a child property

virtio_scsi_pci_realize:
- qdev_set_parent_bus links the device to the bus (bus and VirtIODevice
refcounts are now 3)
- the VirtIODevice is realized

...
at hot-unplug time:
- the device is unrealized
- the bus is unparented (calling bus_unparent)
  - the device is unparented (calling device_unparent)
    - bus_remove_child is called (bus and VirtIODevice refcounts are now =
1)
    - the VirtIODevice child property is deleted by object_unparent and
the VirtIODevice is finalized
  - the bus child property is deleted by object_unparent and the
VirtIODevice is finalized

Thanks,

Paolo
