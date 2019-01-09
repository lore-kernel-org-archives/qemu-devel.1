Received: from eggs.gnu.org ([209.51.188.92]:48771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghFST-0003Ce-5z
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:07:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ghFSM-0001Ri-U8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:07:53 -0500
Date: Wed, 9 Jan 2019 16:07:33 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190109150733.GF4867@localhost.localdomain>
References: <20190109142850.27727-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109142850.27727-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] block: Acquire the AioContext in
 guess_disk_lchs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, armbru@redhat.com

Am 09.01.2019 um 15:28 hat Alberto Garcia geschrieben:
> This fixes the following crash:
> 
> { "execute": "blockdev-add",
>   "arguments": {"driver": "null-co", "node-name": "hd0"}}
> { "execute": "object-add",
>   "arguments": {"qom-type": "iothread", "id": "iothread0"}}
> { "execute": "x-blockdev-set-iothread",
>   "arguments": {"node-name": "hd0", "iothread": "iothread0"}}
> { "execute": "device_add",
>   "arguments": {"id": "virtio0", "driver": "virtio-blk-pci",
>                 "drive": "hd0"}}
> qemu: qemu_mutex_unlock_impl: Operation not permitted
> Aborted
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

This looks like the same thing that I talked about with Markus
yesterday. He asked me where to put the acquire/release pair. My answer
was that there is more than one way to do it, but I suspect that the
realize functions of the devices may call the block layer more than once
and putting the acquire/release there might be nicer. We would then
document blkconf_geometry() to assume that the AioContext is already
locked.

There are many calls for node management stuff where we never defined
the locking rules, but where we might reasonably assume that they only
affect things that are only ever accessed from the main thread. But
there are also things like blk_ioctl() in scsi_block_realize(), which
should most certainly run with the lock held.

What do you think?

(I also wondered whether virtio-blk is affected as well or whether it
moves the BlockBackend to the iothread AioContext only later. Your
reproducer answers this question. :-))

Kevin
