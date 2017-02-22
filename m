Received: from eggs.gnu.org ([2001:4830:134:3::10]:42728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgSq9-00058X-Ub
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgSq6-00008X-Rq
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:04:01 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cgSq6-000088-LB
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 04:03:58 -0500
Received: by mail-wr0-x242.google.com with SMTP id s27so628734wrb.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 01:03:58 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
	<1487681835.2694.76.camel@redhat.com>
	<c0d16fc6-e149-861d-8f82-5a96619606bd@redhat.com>
	<83a2d0c9-23a4-32b1-ffe7-b33bbe9ea25d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <726a3292-9e27-6748-9669-a7c21cbf3b6e@redhat.com>
Date: Wed, 22 Feb 2017 10:03:56 +0100
MIME-Version: 1.0
In-Reply-To: <83a2d0c9-23a4-32b1-ffe7-b33bbe9ea25d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 12/23] virtio: use VRingMemoryRegionCaches
 for avail and used rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>



On 21/02/2017 18:54, Laszlo Ersek wrote:
> Actually, QEMU segfaults. From the dmesg:
> 
> [Tue Feb 21 18:47:28 2017] CPU 0/KVM[8298]: segfault at 48 ip
> 00007fcb5dd02105 sp 00007fcb49efc270 error 4 in
> qemu-system-x86_64[7fcb5dae3000+905000]
> 
> Complete backtrace below. (Thread 11 seems to be the one
> segfaulting.)

Indeed.  It's the virtio-blk device that is segfaulting, please try
this one liner (haven't reproduced it, but it seems obvious with the
backtrace and some sleep).

commit c1aa478c7181c543606ca81404c59e126d66213d
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Feb 22 10:02:37 2017 +0100

    virtio: check for vring setup in virtio_queue_empty
    
    If the vring has not been set up, there is nothing in the virtqueue.
    virtio_queue_host_notifier_aio_poll calls virtio_queue_empty even in
    this case; we have to filter it out just like virtio_queue_notify_aio_vq.
    
    Reported-by: Gerd Hoffmann <kraxel@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 23483c7..e487e36 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2291,7 +2291,7 @@ static bool virtio_queue_host_notifier_aio_poll(void *opaque)
     VirtQueue *vq = container_of(n, VirtQueue, host_notifier);
     bool progress;
 
-    if (virtio_queue_empty(vq)) {
+    if (!vq->vring.desc || virtio_queue_empty(vq)) {
         return false;
     }
 
