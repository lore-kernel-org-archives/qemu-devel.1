Received: from eggs.gnu.org ([209.51.188.92]:51705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjZM-0000uG-Pi
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:41:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gjjZL-0007dv-NY
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:41:16 -0500
References: <20190116113523.9213-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <21b43e07-1fa1-294b-1227-02e8e9a4e434@redhat.com>
Date: Wed, 16 Jan 2019 12:41:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190116113523.9213-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 00/10] qdev: Hotplug handler chaining +
 virtio-pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On 16.01.19 12:35, David Hildenbrand wrote:
> This series implements supprt for hotplug handler chaining (proposed
> by Igor), something that is necessary to turn selected virtio devices into
> memory devices. Planned devices inlude virtio-mem and virtio-pmem. The
> current prototype of virtio-pmem is included.
> 
> The machine hotplug handler can intercept hotplug handler calls
> to properly prepare/teardown the memory device part of a device. Control
> is then passed on to the actual bus hotplug handler. So the default hotplug
> handler is effectively overwritten to make interception possible.
> 
> It is based on the following patches/series
> - [PULL v2 01/49] pci/pcie: stop plug/unplug if the slot is locked
> -- Soon upstream
> - [PATCH v1] pc: Use hotplug_handler_(plug|unplug|unplug_request)
> -- Queued by Paolo
> - [PATCH v2 0/6] s390x/pci: hotplug handler fixes and reworks
> -- Partially queued
> 
> Patch 1-3 are the preparations for hotplug handler chaining. The remaining
> patches are a modified prototype of virtio-pmem.
> 
> I modified Pankajs work to work with this series. virtio-pmem is included
> as it was requested during review of previous preparations to showcase a
> real user, so we can discuss if this is good enough for us or if we have
> to do further changes.
> 
> More details about virtio-pmem (including the Linux guest driver side)
> can be found at:
>     https://lkml.org/lkml/2018/7/13/102
>     https://lkml.org/lkml/2019/1/9/756
> 
> Example: defining a simple virtio-pmem device (on /dev/zero for simplicity):
> 
>     qemu-system-x86_64 \
>      -machine pc \
>      -monitor stdio \
>      -m 8G,maxmem=20G \
>      -object memory-backend-file,id=mem1,mem-path=/dev/zero,size=4G \
>      -device virtio-pmem-pci,id=vp1,memdev=mem1
> 
> QEMU 3.0.50 monitor - type 'help' for more information
> (qemu) info memory-devices
> Memory device [virtio-pmem]: "vp1"
>   memaddr: 0x240000000
>   size: 4294967296
>   memdev: /objects/mem1
> 
> (qemu) info memory_size_summary
> base memory: 8589934592
> plugged memory: 4294967296
> 

The current state can be found on:
https://github.com/davidhildenbrand/qemu.git : memory_device

-- 

Thanks,

David / dhildenb
