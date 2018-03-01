Received: from eggs.gnu.org ([2001:4830:134:3::10]:34389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1erPHM-0007w6-85
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1erPHJ-0000kZ-1F
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:33:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1erPHI-0000iK-OG
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 09:33:48 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w21EX2Xn028479
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 09:33:41 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2geg9xrvm7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:33:41 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 07:33:40 -0700
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 1 Mar 2018 09:33:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <079a5da7-6586-b974-6b99-e5de055b1bd1@linux.vnet.ibm.com>
Subject: [Qemu-devel] [BUG] I/O thread segfault for QEMU on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>

Hi,

I have been noticing some segfaults for QEMU on s390x, and I have been 
hitting this issue quite reliably (at least once in 10 runs of a test 
case). The qemu version is 2.11.50, and I have systemd created coredumps
when this happens.

Here is a back trace of the segfaulting thread:


#0  0x000003ffafed202c in swapcontext () from /lib64/libc.so.6
#1  0x000002aa355c02ee in qemu_coroutine_new () at 
util/coroutine-ucontext.c:164
#2  0x000002aa355bec34 in qemu_coroutine_create 
(entry=entry@entry=0x2aa3550f7a8 <blk_aio_read_entry>, 
opaque=opaque@entry=0x3ffa002afa0) at util/qemu-coroutine.c:76
#3  0x000002aa35510262 in blk_aio_prwv (blk=0x2aa65fbefa0, 
offset=<optimized out>, bytes=<optimized out>, qiov=0x3ffa002a9c0, 
co_entry=co_entry@entry=0x2aa3550f7a8 <blk_aio_read_entry>, flags=0,
     cb=0x2aa35340a50 <virtio_blk_rw_complete>, opaque=0x3ffa002a960) at 
block/block-backend.c:1299
#4  0x000002aa35510376 in blk_aio_preadv (blk=<optimized out>, 
offset=<optimized out>, qiov=<optimized out>, flags=<optimized out>, 
cb=<optimized out>, opaque=0x3ffa002a960) at block/block-backend.c:1392
#5  0x000002aa3534114e in submit_requests (niov=<optimized out>, 
num_reqs=<optimized out>, start=<optimized out>, mrb=<optimized out>, 
blk=<optimized out>) at 
/usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:372
#6  virtio_blk_submit_multireq (blk=<optimized out>, 
mrb=mrb@entry=0x3ffad77e640) at 
/usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:402
#7  0x000002aa353422e0 in virtio_blk_handle_vq (s=0x2aa6611e7d8, 
vq=0x3ffb0f5f010) at /usr/src/debug/qemu-2.11.50/hw/block/virtio-blk.c:620
#8  0x000002aa3536655a in virtio_queue_notify_aio_vq 
(vq=vq@entry=0x3ffb0f5f010) at 
/usr/src/debug/qemu-2.11.50/hw/virtio/virtio.c:1515
#9  0x000002aa35366cd6 in virtio_queue_notify_aio_vq (vq=0x3ffb0f5f010) 
at /usr/src/debug/qemu-2.11.50/hw/virtio/virtio.c:1511
#10 virtio_queue_host_notifier_aio_poll (opaque=0x3ffb0f5f078) at 
/usr/src/debug/qemu-2.11.50/hw/virtio/virtio.c:2409
#11 0x000002aa355a8ba4 in run_poll_handlers_once 
(ctx=ctx@entry=0x2aa65f99310) at util/aio-posix.c:497
#12 0x000002aa355a9b74 in run_poll_handlers (max_ns=<optimized out>, 
ctx=0x2aa65f99310) at util/aio-posix.c:534
#13 try_poll_mode (blocking=true, ctx=0x2aa65f99310) at util/aio-posix.c:562
#14 aio_poll (ctx=0x2aa65f99310, blocking=blocking@entry=true) at 
util/aio-posix.c:602
#15 0x000002aa353d2d0a in iothread_run (opaque=0x2aa65f990f0) at 
iothread.c:60
#16 0x000003ffb0f07e82 in start_thread () from /lib64/libpthread.so.0
#17 0x000003ffaff91596 in thread_start () from /lib64/libc.so.6


I don't have much knowledge about i/o threads and the block layer code 
in QEMU, so I would like to report to the community about this issue.
I believe this very similar to the bug that I reported upstream couple 
of days ago 
(https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04452.html).

Any help would be greatly appreciated.

Thanks
Farhan
