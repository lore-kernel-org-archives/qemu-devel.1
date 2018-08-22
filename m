Received: from eggs.gnu.org ([2001:4830:134:3::10]:34952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fsUZO-0000cp-OY
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fsUZL-0004lm-II
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:57:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fsUZL-0004kQ-Bw
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:57:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CBC304023820
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 14:57:09 +0000 (UTC)
Date: Wed, 22 Aug 2018 22:57:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180822145707.GJ3878@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] virtio_stw_phys_cached crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, pbonzini@redhat.com

On master (13b7b188501) and v3.0.0, booting the OpenBSD install63.iso with a
virtio-net (slirp backend) device gives this assertion failure:

(gdb) bt
#0  0x00007f6f25703feb in raise () at /lib64/libc.so.6
#1  0x00007f6f256ee5c1 in abort () at /lib64/libc.so.6
#2  0x00007f6f256ee491 in _nl_load_domain.cold.0 () at /lib64/libc.so.6
#3  0x00007f6f256fc752 in  () at /lib64/libc.so.6
#4  0x000055d966f5b5d6 in address_space_stw_le_cached (cache=0x7f6f040fd700, addr=516, val=1, attrs=..., result=0x0)
    at /stor/work/qemu/include/exec/memory_ldst_cached.inc.h:85
#5  0x000055d966f5b804 in stw_le_phys_cached (cache=0x7f6f040fd700, addr=516, val=1) at /stor/work/qemu/include/exec/memory_ldst_phys.inc.h:121
#6  0x000055d966f5c3e7 in virtio_stw_phys_cached (vdev=0x55d969aeeff0, cache=0x7f6f040fd700, pa=516, value=1) at /stor/work/qemu/include/hw/virtio/virtio-access.h:195
#7  0x000055d966f5cef8 in vring_set_avail_event (vq=0x7f6f181df110, val=1) at /stor/work/qemu/hw/virtio/virtio.c:324
#8  0x000055d966f5e1c8 in virtqueue_pop (vq=0x7f6f181df110, sz=48) at /stor/work/qemu/hw/virtio/virtio.c:883
#9  0x000055d966f2d69b in virtio_net_handle_ctrl (vdev=0x55d969aeeff0, vq=0x7f6f181df110) at /stor/work/qemu/hw/net/virtio-net.c:986
#10 0x000055d966f5ffb9 in virtio_queue_notify_vq (vq=0x7f6f181df110) at /stor/work/qemu/hw/virtio/virtio.c:1534
#11 0x000055d966f6224d in virtio_queue_host_notifier_read (n=0x7f6f181df178) at /stor/work/qemu/hw/virtio/virtio.c:2451
#12 0x000055d9673ef460 in aio_dispatch_handlers (ctx=0x55d96891af90) at /stor/work/qemu/util/aio-posix.c:406
#13 0x000055d9673ef5f3 in aio_dispatch (ctx=0x55d96891af90) at /stor/work/qemu/util/aio-posix.c:437
#14 0x000055d9673eae25 in aio_ctx_dispatch (source=0x55d96891af90, callback=0x0, user_data=0x0) at /stor/work/qemu/util/async.c:261
#15 0x00007f6f28b578ad in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#16 0x000055d9673ee040 in glib_pollfds_poll () at /stor/work/qemu/util/main-loop.c:215
#17 0x000055d9673ee0ae in os_host_main_loop_wait (timeout=0) at /stor/work/qemu/util/main-loop.c:238
#18 0x000055d9673ee167 in main_loop_wait (nonblocking=0) at /stor/work/qemu/util/main-loop.c:497
#19 0x000055d96702efd0 in main_loop () at /stor/work/qemu/vl.c:1866
#20 0x000055d9670368bd in main (argc=22, argv=0x7ffdef327638, envp=0x7ffdef3276f0) at /stor/work/qemu/vl.c:4644

No surprise, bisection points to

commit 48564041a73adbbff52834f9edbe3806fceefab7
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Sun Mar 18 18:26:36 2018 +0100

    exec: reintroduce MemoryRegion caching

Fam
