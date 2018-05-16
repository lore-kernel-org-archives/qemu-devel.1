Received: from eggs.gnu.org ([2001:4830:134:3::10]:45433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fItsR-0005Ua-9s
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fItsO-00039v-5H
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fItsN-00036c-Vv
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6381040214E2
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 10:41:42 +0000 (UTC)
References: <20180417140802.16711-1-pbonzini@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <0a51d026-8b9f-9925-1229-10e3766907bb@redhat.com>
Date: Wed, 16 May 2018 12:41:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180417140802.16711-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] exec: reintroduce MemoryRegion caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Hi Paolo,

On 04/17/2018 04:07 PM, Paolo Bonzini wrote:
> MemoryRegionCache was reverted to "normal" address_space_* operations
> for 2.9, due to lack of support for IOMMUs.  This series reinstates
> optimizations, caching only the IOMMU translation but not the IOMMU
> lookup and target AddressSpace translation.
> 
> Patches 1 to 3 prepare by introducing a new function
> address_space_translate_iommu (split out of address_space_translate)
> and new header files for declarations shared by regular and "cached"
> address_space_* functions.  Patch 4 uses them to introduce both
> the slow path for IOMMU and MMIO cached regions, and the fast path
> for RAM cached regions.

This patch seems to cause a regression with ARM vsmmu + virtio-blk-pci. Reverting it looks to fix the issue. Otherwise I get:

Program received signal SIGSEGV, Segmentation fault.
address_space_lduw_internal_cached_slow (endian=DEVICE_LITTLE_ENDIAN, result=0x0, attrs=..., addr=2, cache=0xffffa81110a0) at /home/augere/UPSTREAM/qemu/memory_ldst.inc.c:242
242	            val = lduw_le_p(ptr);
(gdb) where
#0  address_space_lduw_internal_cached_slow (endian=DEVICE_LITTLE_ENDIAN, result=0x0, attrs=..., addr=2, cache=0xffffa81110a0) at /home/augere/UPSTREAM/qemu/memory_ldst.inc.c:242
#1  address_space_lduw_le_cached_slow (cache=0xffffa81110a0, addr=addr@entry=2, attrs=..., attrs@entry=..., result=0x0) at /home/augere/UPSTREAM/qemu/memory_ldst.inc.c:273
#2  0x0000000000511c74 in address_space_lduw_le_cached (result=0x0, attrs=..., addr=2, cache=<optimized out>) at /home/augere/UPSTREAM/qemu/include/exec/memory_ldst_cached.inc.h:56
#3  lduw_le_phys_cached (addr=2, cache=<optimized out>) at /home/augere/UPSTREAM/qemu/include/exec/memory_ldst_phys.inc.h:91
#4  virtio_lduw_phys_cached (pa=2, cache=<optimized out>, vdev=<optimized out>) at /home/augere/UPSTREAM/qemu/include/hw/virtio/virtio-access.h:166
#5  vring_avail_idx (vq=0x1cfe2d0) at /home/augere/UPSTREAM/qemu/hw/virtio/virtio.c:227
#6  virtio_queue_set_notification (vq=0x1cfe2d0, enable=0) at /home/augere/UPSTREAM/qemu/hw/virtio/virtio.c:324
#7  0x0000000000511d2c in virtio_queue_set_notification (vq=<optimized out>, enable=<optimized out>) at /home/augere/UPSTREAM/qemu/hw/virtio/virtio.c:318
#8  0x00000000004aa158 in virtio_blk_handle_vq (s=0x1cf32b0, vq=0x1cfe2d0) at /home/augere/UPSTREAM/qemu/hw/block/virtio-blk.c:605
#9  0x00000000005113f0 in virtio_queue_notify_aio_vq (vq=0x1cfe2d0) at /home/augere/UPSTREAM/qemu/hw/virtio/virtio.c:1515
#10 0x000000000087cbf0 in aio_dispatch_handlers (ctx=ctx@entry=0x15300e0) at util/aio-posix.c:406
#11 0x000000000087d3f8 in aio_dispatch (ctx=0x15300e0) at util/aio-posix.c:437
#12 0x0000000000879f30 in aio_ctx_dispatch (source=<optimized out>, callback=<optimized out>, user_data=<optimized out>) at util/async.c:261
#13 0x0000ffffbeee97a0 in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
#14 0x000000000087c678 in glib_pollfds_poll () at util/main-loop.c:215
#15 os_host_main_loop_wait (timeout=<optimized out>) at util/main-loop.c:263
#16 main_loop_wait (nonblocking=nonblocking@entry=0) at util/main-loop.c:522
#17 0x0000000000423dd8 in main_loop () at vl.c:1943
#18 main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4675

Investigating further ...

Thanks

Eric
> 
> Paolo
> 
> Paolo Bonzini (4):
>   exec: move memory access declarations to a common header, inline
>     *_phys functions
>   exec: small changes to flatview_do_translate
>   exec: extract address_space_translate_iommu, fix page_mask corner case
>   exec: reintroduce MemoryRegion caching
> 
>  exec.c                                | 245 ++++++++++++++++++++------
>  include/exec/cpu-all.h                |  79 ++++-----
>  include/exec/memory-internal.h        |   3 +
>  include/exec/memory.h                 | 209 ++++++++++------------
>  include/exec/memory_ldst.inc.h        |  71 ++++++++
>  include/exec/memory_ldst_cached.inc.h | 108 ++++++++++++
>  include/exec/memory_ldst_phys.inc.h   | 147 ++++++++++++++++
>  memory.c                              |   4 +-
>  memory_ldst.inc.c                     | 126 -------------
>  9 files changed, 651 insertions(+), 341 deletions(-)
>  create mode 100644 include/exec/memory_ldst.inc.h
>  create mode 100644 include/exec/memory_ldst_cached.inc.h
>  create mode 100644 include/exec/memory_ldst_phys.inc.h
> 
