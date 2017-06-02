Received: from eggs.gnu.org ([2001:4830:134:3::10]:39315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dGmei-0000fy-FN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dGmeh-0004xF-EI
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:30:20 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dGmeh-0004wF-7p
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:30:19 -0400
Received: by mail-wm0-x242.google.com with SMTP id b84so19048018wmh.0
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:30:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <311628499.16967933.1496398433571.JavaMail.zimbra@redhat.com>
References: <20170602095424.9064-1-stefanha@redhat.com>
	<311628499.16967933.1496398433571.JavaMail.zimbra@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 2 Jun 2017 14:30:17 +0100
Message-ID: <CAJSP0QVWi+D6o9yHobHtEP8bA=RsgLbxQwbjwyTSjbr-fKwTag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] virtio-serial: fix segfault on disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Ladi Prosek <lprosek@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Amit Shah <amit@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Jun 2, 2017 at 11:13 AM, Pankaj Gupta <pagupta@redhat.com> wrote:
>> Since commit d4c19cdeeb2f1e474bc426a6da261f1d7346eb5b ("virtio-serial:
>> add missing virtio_detach_element() call") the following commands may
>> cause QEMU to segfault:
>>
>>   $ qemu -M accel=kvm -cpu host -m 1G \
>>          -drive if=virtio,file=test.img,format=raw \
>>          -device virtio-serial-pci,id=virtio-serial0 \
>>          -chardev socket,id=channel1,path=/tmp/chardev.sock,server,nowait \
>>          -device
>>          virtserialport,chardev=channel1,bus=virtio-serial0.0,id=port1
>>   $ nc -U /tmp/chardev.sock
>>   ^C
>>
>>   (guest)$ cat /dev/zero >/dev/vport0p1
>>
>> The segfault is non-deterministic: if the event loop notices the socket
>> has been closed then there is no crash.  The disconnect has to happen
>> right before QEMU attempts to write data to the socket.
>>
>> The backtrace is as follows:
>>
>>   Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>>   0x00005555557e0698 in do_flush_queued_data (port=0x5555582cedf0,
>>   vq=0x7fffcc854290, vdev=0x55555807b1d0) at hw/char/virtio-serial-bus.c:180
>>   180           for (i = port->iov_idx; i < port->elem->out_num; i++) {
>>   #1  0x000055555580d363 in virtio_queue_notify_vq (vq=0x7fffcc854290) at
>>   hw/virtio/virtio.c:1524
>>   #2  0x000055555580d363 in virtio_queue_host_notifier_read
>>   (n=0x7fffcc8542f8) at hw/virtio/virtio.c:2430
>>   #3  0x0000555555b3482c in aio_dispatch_handlers
>>   (ctx=ctx@entry=0x5555566b8c80) at util/aio-posix.c:399
>>   #4  0x0000555555b350d8 in aio_dispatch (ctx=0x5555566b8c80) at
>>   util/aio-posix.c:430
>>   #5  0x0000555555b3212e in aio_ctx_dispatch (source=<optimized out>,
>>   callback=<optimized out>, user_data=<optimized out>) at util/async.c:261
>>   #6  0x00007fffde71de52 in g_main_context_dispatch () at
>>   /lib64/libglib-2.0.so.0
>>   #7  0x0000555555b34353 in glib_pollfds_poll () at util/main-loop.c:213
>>   #8  0x0000555555b34353 in os_host_main_loop_wait (timeout=<optimized out>)
>>   at util/main-loop.c:261
>>   #9  0x0000555555b34353 in main_loop_wait (nonblocking=<optimized out>) at
>>   util/main-loop.c:517
>>   #10 0x0000555555773207 in main_loop () at vl.c:1917
>>   #11 0x0000555555773207 in main (argc=<optimized out>, argv=<optimized out>,
>>   envp=<optimized out>) at vl.c:4751
>>
>> The do_flush_queued_data() function does not anticipate chardev close
>> events during vsc->have_data().  It expects port->elem to remain
>> non-NULL for the duration its for loop.
>
> Just thinking if there is still data to flush, should we close/free the port.
> Or it can get close automatically.
>
> Or I am missing anything here?

virtio_serial_close() was already called by
virtio-console.c:chr_event().  Both port->elem and the entire output
virtqueue have been discarded.  No further data will be transferred
and do_flush_queued_data() doesn't need to do anything.

Stefan
