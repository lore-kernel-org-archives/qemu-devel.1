Received: from eggs.gnu.org ([209.51.188.92]:56986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghEF7-0002xt-Fd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ghEF5-0000ij-VZ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:50:01 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190109110144.18633-1-stefanha@redhat.com>
References: <20190109110144.18633-1-stefanha@redhat.com>
Date: Wed, 09 Jan 2019 14:49:50 +0100
Message-ID: <w51sgy26iv5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed 09 Jan 2019 12:01:44 PM CET, Stefan Hajnoczi wrote:
> The following QMP command leads to a crash when iothreads are used:
>
>   { 'execute': 'device_del', 'arguments': {'id': 'data'} }

I was trying to reproduce this and I found this crashing in master:

$ qemu-system-x86_64 -enable-kvm -qmp stdio -display none
{ "execute": "qmp_capabilities" }
{ "execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "hd.qcow2"}, "node-name": "hd0"}}
{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
{ "execute": "x-blockdev-set-iothread", "arguments": {"node-name": "hd0", "iothread": "iothread0"}}
{ "execute": "device_add", "arguments": {"id": "virtio0", "driver": "virtio-blk-pci", "drive": "hd0"}}

Thread 1 "qemu-system-x86" received signal SIGABRT, Aborted.
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
51         ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
(gdb) bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:51
#1  [...] in __GI_abort () at abort.c:89
#2  [...] in error_exit () at util/qemu-thread-posix.c:36
#3  [...] in qemu_mutex_unlock_impl () at util/qemu-thread-posix.c:96
#4  [...] in aio_context_release () at util/async.c:516
#5  [...] in blk_prw () at block/block-backend.c:1262
#6  [...] in blk_pread () at block/block-backend.c:1424
#7  [...] in blk_pread_unthrottled () at block/block-backend.c:1279
#8  [...] in guess_disk_lchs () at hw/block/hd-geometry.c:71
#9  [...] in hd_geometry_guess () at hw/block/hd-geometry.c:136
#10 [...] in blkconf_geometry () at hw/block/block.c:99
#11 [...] in virtio_blk_device_realize () at hw/block/virtio-blk.c:944
#12 [...] in virtio_device_realize () at hw/virtio/virtio.c:2538
[...]

Berto
