Received: from eggs.gnu.org ([2001:4830:134:3::10]:40054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhbkt-0001p9-6j
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fhbkq-00077O-1E
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:24:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fhbkp-00076z-Qm
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 10:24:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FC2477888
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 14:24:02 +0000 (UTC)
Date: Mon, 23 Jul 2018 16:23:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180723162355.55212c75@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 00/11] memory-device: complete
 refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S
	. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu,  5 Jul 2018 13:59:32 +0200
David Hildenbrand <david@redhat.com> wrote:

> This is another part of the original series
>     [PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers
> And is based on
>     [PATCH v3 0/4] pc-dimm: pre_plug "slot" and "addr" assignment
> 
> This series completes refactoring of pre_plug, plug and unplug logic of
> memory devices. With this as a basis, one can easily have e.g. virtio
> based memory devices (virtio-mem, virtio-pmem, virtio-fs?) with minor
> modifications on e.g. x86 and s390x.
> 
> Unfortunately, the "addr" property is already used for virtio devices, so
> we will have to deal with device specific properties. So
> set_addr() for memory devices is introduced to handle that (we already
> have get_addr()).
> 
> The only way I see to avoid that would be for virtio based devices to
> introduce an indirection:
> 
> E.g. right now for my virtio-mem prototype:
> ... -object memory-backend-ram,id=mem0,size=8G \
>     -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,phys-addr=0x12345
Though it seems inconvenient to have different property name,
it is not dimm device (even though it shares GPA resource)
so it is fine for it to have it's own set of properties.
(might make error reporting a bit ugly)

Also what about usecase of mmio based virtio (ARM)?


> To something like:
> ... -object memory-backend-ram,id=mem0,size=8G \
>     -object virtio-mem-backend,id=vmb0,memdev=mem0,addr=0x12345 \
>     -device virtio-mem-pci,id=vm0,vmem=vmb0 \
it's broken conceptually,
backends should deal only with host resource allocation while
'addr' is device model property and belongs to a frontend.

> Or something like (that might be interesting for virtio-pmem):
> ... -device virtio-mem-pci \ /* a virtio-mem bus */
>     -object memory-backend-ram,id=mem0,size=8G \
>     -device virtio-mem-backend,memdev=mem0,addr=0x12345 \
did you mean  ^^^^ virtio-pmem device?

Is it a separate controller and memory resource design
connected together somehow?


> But both alternatives have their pros and cons.
> 
> Opinions?
> 
> David Hildenbrand (11):
>   memory-device: fix error message when hinted address is too small
>   memory-device: introduce separate config option
>   memory-device: get_region_size()/get_plugged_size() might fail
>   memory-device: convert get_region_size() to get_memory_region()
>   memory-device: document MemoryDeviceClass
>   memory-device: add device class function set_addr()
>   pc-dimm: implement memory device class function set_addr()
>   memory-device: complete factoring out pre_plug handling
>   memory-device: complete factoring out plug handling
>   memory-device: complete factoring out unplug handling
>   memory-device: trace when pre_assigning/assigning/unassigning
>     addresses
> 
>  default-configs/i386-softmmu.mak   |  3 +-
>  default-configs/ppc64-softmmu.mak  |  3 +-
>  default-configs/x86_64-softmmu.mak |  3 +-
>  hw/Makefile.objs                   |  2 +-
>  hw/mem/Makefile.objs               |  4 +-
>  hw/mem/memory-device.c             | 60 +++++++++++++++++++-----
>  hw/mem/pc-dimm.c                   | 75 +++++++++++++++++-------------
>  hw/mem/trace-events                |  5 +-
>  include/hw/mem/memory-device.h     | 30 ++++++++----
>  qapi/misc.json                     |  2 +-
>  10 files changed, 126 insertions(+), 61 deletions(-)
> 
