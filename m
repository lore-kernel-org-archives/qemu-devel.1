Received: from eggs.gnu.org ([209.51.188.92]:50668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gm1vx-00083D-HH
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gm1vs-0000wQ-Uy
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:42:03 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190118101415.GC4530@dhcp-200-176.str.redhat.com>
References: <cover.1547475602.git.berto@igalia.com>
	<20190116135444.GA16898@stefanha-x1.localdomain>
	<w51d0ov2z9h.fsf@maestria.local.igalia.com>
	<20190118095652.GA21579@stefanha-x1.localdomain>
	<20190118101415.GC4530@dhcp-200-176.str.redhat.com>
Date: Tue, 22 Jan 2019 14:56:34 +0100
Message-ID: <w51womwokx9.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/6] Acquire the AioContext during
 _realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com

On Fri 18 Jan 2019 11:14:15 AM CET, Kevin Wolf wrote:
> There are two ways to trigger the crash even without
> x-blockdev-set-iothread:
>
> * device_del, then device_add for a device with iothread (virtio-scsi;
>   may or may not exist with virtio-blk)
>   https://bugzilla.redhat.com/show_bug.cgi?id=1656276
>
> * Simply attach two devices with iothread to the the same node
>   https://bugzilla.redhat.com/show_bug.cgi?id=1662508

While having a look at this I found another crash. Here's how to
reproduce it (wait for the events after each system_reset):

   { "execute": "qmp_capabilities" }
   { "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0"}}
   { "execute": "device_add", "arguments": {"id": "vb0", "driver": "virtio-blk", "drive": "hd0"}}
   { "execute": "system_reset"}

   { "execute": "device_del", "arguments": {"id": "vb0"}}
   { "execute": "system_reset"}

   { "execute": "device_add", "arguments": {"id": "vb0", "driver": "virtio-blk", "drive": "hd0"}}
   { "execute": "system_reset"}

   { "execute": "device_del", "arguments": {"id": "vb0"}}
   { "execute": "system_reset"}

   { "execute": "device_add", "arguments": {"id": "vb0", "driver": "virtio-blk", "drive": "hd0"}}
   { "execute": "system_reset"}

kvm_mem_ioeventfd_add: error adding ioeventfd: No space left on device
Aborted

git-bisect points to this commit:

   commit 3ac7d43a6fbb5d4a3d01fc9a055c218030af3727
   Author: Paolo Bonzini <pbonzini@redhat.com>
   Date:   Wed Nov 28 17:28:45 2018 +0100

       memory: update coalesced_range on transaction_commit

       The e1000 driver calls memory_region_add_coalescing but
       kvm_coalesce_mmio_region is never called for those regions.  The bug
       dates back to the introduction of the memory region API; to fix it,
       delete and re-add coalesced MMIO ranges when building the FlatViews.
       
       Because coalesced MMIO regions apply to all address spaces, the
       has_coalesced_range flag has to be changed into an int.

Berto
