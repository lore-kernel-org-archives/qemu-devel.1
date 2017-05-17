Received: from eggs.gnu.org ([2001:4830:134:3::10]:47919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAyR9-0006gk-Ov
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAyR6-0005zr-MJ
	for qemu-devel@nongnu.org; Wed, 17 May 2017 08:52:19 -0400
References: <20170516072414.19025-1-famz@redhat.com>
	<20170516080737.GB27669@lemon.lan>
	<e780d3d8-43f1-f46d-2858-7554a334246b@redhat.com>
	<20170516122528.GC27669@lemon.lan>
	<3799c1f5-5b22-fe05-4c98-4cd76c716551@redhat.com>
	<20170517015530.GD27669@lemon.lan>
	<2070505842.8419962.1495004335579.JavaMail.zimbra@redhat.com>
	<20170517120041.GA17629@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d575d0cc-9082-13ec-8903-6ae5dd1628cd@redhat.com>
Date: Wed, 17 May 2017 14:52:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170517120041.GA17629@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 17/05/2017 14:00, Fam Zheng wrote:
> On Wed, 05/17 02:58, Paolo Bonzini wrote:
>> The child property is deleted when bus_unparent calls object_unparent:
>>
>>     while ((kid = QTAILQ_FIRST(&bus->children)) != NULL) {
>>         DeviceState *dev = kid->child;
>>         object_unparent(OBJECT(dev));
>>     }
>>
>> and in turn bus_unparent is called by the VirtIOSCSIPCI's unparent
>> callback (device_unparent):
>>
>>     while (dev->num_child_bus) {
>>         bus = QLIST_FIRST(&dev->child_bus);
>>         object_unparent(OBJECT(bus));
>>     }
> 
> OK, sorry for being dumb, these are way over my head. Let me try again:
> 
> I count three references before unplug:
> 
> a.1) object_property_add_child in virtio_instance_init_common as virtio-backend
> a.2) qdev_set_parent_bus in virtio_scsi_pci_realize by virtio-pci-bus
> a.3) qbus_set_hotplug_handler in virtio_scsi_device_realize for 
> 
> Only two object_unref()'s happen in unplug, respectively:
> 
> b.1) object_finalize_child_property, matches a.1)
> b.2) bus_remove_child, matches a.2)
> 
> Do we need cleanup for a.3) ? The patch below does fix the crash for me.

Yes, good catch.  Either there, or in bus_unparent.

Paolo
