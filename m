Received: from eggs.gnu.org ([2001:4830:134:3::10]:56783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciNMW-0000v6-DR
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1ciNMT-00057V-AG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:37:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47144
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1ciNMT-00057N-35
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:37:17 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1RFY8FI090295
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 10:37:16 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28vku01qhv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 10:37:15 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 27 Feb 2017 15:37:14 -0000
Date: Mon, 27 Feb 2017 16:37:08 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170227160609.0d49a87d.cornelia.huck@de.ibm.com>
References: <baa954b4-53fc-2b4e-b79c-917ba9171a60@de.ibm.com>
	<20170227160609.0d49a87d.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170227163708.796ab27f.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] segfault use VRingMemoryRegionCaches for avail and
 used ring vs num-queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Mon, 27 Feb 2017 16:06:09 +0100
Cornelia Huck <cornelia.huck@de.ibm.com> wrote:

> On Mon, 27 Feb 2017 15:09:30 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > Paolo,
> > 
> > commit 97cd965c070152bc626c7507df9fb356bbe1cd81
> > "virtio: use VRingMemoryRegionCaches for avail and used rings"
> > does cause a segfault on my s390 system when I use num-queues.
> > 
> > gdb --args qemu-system-s390x -nographic -enable-kvm -m 1G -drive file=/var/lib/libvirt/qemu/image.zhyp137,if=none,id=d1 -device virtio-blk-ccw,drive=d1,iothread=io1,num-queues=2 -object iothread,id=io1
> 
> (...)
> 
> > (gdb) bt
> > #0  0x0000000001024a26 in address_space_translate_cached (cache=0x38, addr=2, xlat=0x3ffe587bff8, plen=0x3ffe587bff0, is_write=false) at /home/cborntra/REPOS/qemu/exec.c:3187
> > #1  0x0000000001025596 in address_space_lduw_internal_cached (cache=0x38, addr=2, attrs=..., result=0x0, endian=DEVICE_BIG_ENDIAN) at /home/cborntra/REPOS/qemu/memory_ldst.inc.c:264
> > #2  0x0000000001025846 in address_space_lduw_be_cached (cache=0x38, addr=2, attrs=..., result=0x0) at /home/cborntra/REPOS/qemu/memory_ldst.inc.c:322
> > #3  0x000000000102597e in lduw_be_phys_cached (cache=0x38, addr=2) at /home/cborntra/REPOS/qemu/memory_ldst.inc.c:340
> > #4  0x0000000001114856 in virtio_lduw_phys_cached (vdev=0x1c57cd0, cache=0x38, pa=2) at /home/cborntra/REPOS/qemu/include/hw/virtio/virtio-access.h:164
> > #5  0x000000000111523c in vring_avail_idx (vq=0x3fffde1e090) at /home/cborntra/REPOS/qemu/hw/virtio/virtio.c:201
> > #6  0x0000000001115bba in virtio_queue_empty (vq=0x3fffde1e090) at /home/cborntra/REPOS/qemu/hw/virtio/virtio.c:332
> > #7  0x000000000111c312 in virtio_queue_host_notifier_aio_poll (opaque=0x3fffde1e0f8) at /home/cborntra/REPOS/qemu/hw/virtio/virtio.c:2294
> > #8  0x000000000147a036 in run_poll_handlers_once (ctx=0x1bb8bb0) at /home/cborntra/REPOS/qemu/util/aio-posix.c:490
> > #9  0x000000000147a2fe in try_poll_mode (ctx=0x1bb8bb0, blocking=true) at /home/cborntra/REPOS/qemu/util/aio-posix.c:566
> > #10 0x000000000147a3ca in aio_poll (ctx=0x1bb8bb0, blocking=true) at /home/cborntra/REPOS/qemu/util/aio-posix.c:595
> > #11 0x00000000011a0176 in iothread_run (opaque=0x1bb86c0) at /home/cborntra/REPOS/qemu/iothread.c:59
> > #12 0x000003ffe9087bc4 in start_thread () at /lib64/libpthread.so.0
> > #13 0x000003ffe8f8a9f2 in thread_start () at /lib64/libc.so.6
> > 
> > It seems to make a difference if its the boot disk or not. Maybe the reset of the
> > devices that the bootloader does before handling over control to Linux creates
> > some trouble here.
> 
> I can reproduce this (the root cause seems to be that the bootloader
> only sets up the first queue but the dataplane code wants to handle
> both queues); this particular problem is fixed by 
> https://patchwork.ozlabs.org/patch/731445/ but then I hit a similar
> problem later:
> 
> 0x0000000010019b46 in address_space_translate_cached (cache=0x60, addr=0, 
>     xlat=0x3fffcb7e420, plen=0x3fffcb7e418, is_write=false)
>     at /root/git/qemu/exec.c:3187
> 3187	    assert(addr < cache->len && *plen <= cache->len - addr);
> 
> (...)
> 
> (gdb) bt
> #0  0x0000000010019b46 in address_space_translate_cached (cache=0x60, addr=0, 
>     xlat=0x3fffcb7e420, plen=0x3fffcb7e418, is_write=false)
>     at /root/git/qemu/exec.c:3187
> #1  0x000000001001a5fe in address_space_lduw_internal_cached (cache=0x60, 
>     addr=0, attrs=..., result=0x0, endian=DEVICE_BIG_ENDIAN)
>     at /root/git/qemu/memory_ldst.inc.c:264
> #2  0x000000001001a88e in address_space_lduw_be_cached (cache=0x60, addr=0, 
>     attrs=..., result=0x0) at /root/git/qemu/memory_ldst.inc.c:322
> #3  0x000000001001a9c6 in lduw_be_phys_cached (cache=0x60, addr=0)
>     at /root/git/qemu/memory_ldst.inc.c:340
> #4  0x00000000100fa876 in virtio_lduw_phys_cached (vdev=0x10bc2ce0, cache=0x60, 
>     pa=0) at /root/git/qemu/include/hw/virtio/virtio-access.h:164
> #5  0x00000000100fb536 in vring_used_flags_set_bit (vq=0x3fffdebc090, mask=1)
>     at /root/git/qemu/hw/virtio/virtio.c:255
> #6  0x00000000100fb7fa in virtio_queue_set_notification (vq=0x3fffdebc090, 
>     enable=0) at /root/git/qemu/hw/virtio/virtio.c:297
> #7  0x0000000010101d22 in virtio_queue_host_notifier_aio_poll_begin (
>     n=0x3fffdebc0f8) at /root/git/qemu/hw/virtio/virtio.c:2285
> #8  0x00000000103f4164 in poll_set_started (ctx=0x10ae8230, started=true)
>     at /root/git/qemu/util/aio-posix.c:338
> #9  0x00000000103f4d5a in try_poll_mode (ctx=0x10ae8230, blocking=true)
>     at /root/git/qemu/util/aio-posix.c:553
> #10 0x00000000103f4e56 in aio_poll (ctx=0x10ae8230, blocking=true)
>     at /root/git/qemu/util/aio-posix.c:595
> #11 0x000000001017ea36 in iothread_run (opaque=0x10ae7d40)
>     at /root/git/qemu/iothread.c:59
> #12 0x000003fffd6084c6 in start_thread () from /lib64/libpthread.so.0
> #13 0x000003fffd502ec2 in thread_start () from /lib64/libc.so.6
> 
> I think we may be missing guards for not-yet-setup queues in other
> places; maybe we can centralize this instead of playing whack-a-mole?

With the following applied (probably whitespace damaged), my guest
starts:

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e487e36..28906e5 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -287,6 +287,9 @@ static inline void vring_set_avail_event(VirtQueue *vq, uint16_t val)
 void virtio_queue_set_notification(VirtQueue *vq, int enable)
 {
     vq->notification = enable;
+    if (!vq->vring.desc) {
+        return;
+    }
 
     rcu_read_lock();
     if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {

Maybe introduction of caches just exposed bugs that were already there
(trying to muck with vring state for queues that have not been setup?)
Should we stick some asserts into the respective functions to help
flush out the remaining bugs?
