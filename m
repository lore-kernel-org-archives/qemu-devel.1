Received: from eggs.gnu.org ([2001:4830:134:3::10]:44079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kingtan9527@gmail.com>) id 1e5MSm-0007uW-Hf
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kingtan9527@gmail.com>) id 1e5MSk-0000VM-Km
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:51:04 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:45847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kingtan9527@gmail.com>)
	id 1e5MSk-0000U8-Da
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:51:02 -0400
Received: by mail-io0-x22c.google.com with SMTP id i38so11814582iod.2
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 18:51:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171019132907.GF6205@stefanha-x1.localdomain>
References: <CALMRoie6DWc0B5Q3ZAbSS7ezFC=tXtNW+eU1T_deJsadO06erQ@mail.gmail.com>
	<20171019132907.GF6205@stefanha-x1.localdomain>
From: Wahaha Huang <kingtan9527@gmail.com>
Date: Fri, 20 Oct 2017 09:51:01 +0800
Message-ID: <CALMRoic6qk5xTyRBw_g4WbxuAFkaudZom1dU_aXYBKoc9kNrcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Block-io] qemu virtual machine get stuck during
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org

Sorry for the late reply.
Unfortunately, when it gets stuck(block at the windows welcome screen),
there are no any error messages print out, with cpu usage 9%.
I'm not quite sure whether the QEMU monitor is still work

Here is some more infomation:

1. QEMU command-line:
qemu-system-x86_64 -enable-kvm -full-screen -soundhw hda -soundhw ac97 -m
2816 -smp 2,sockets=1,cores=2,threads=1 -vga qxl -localtime -rtc
clock=vm,base=localtime -net
nic,addr=0x03,model=virtio,macaddr=C0:B1:A2:83:84:18 -net tap,ifname=b908v
-device nec-usb-xhci,id=ehci -device nec-usb-xhci,id=ehci2 -boot d -smbios
type=1,manufacturer=microcloud,product=cloudbox,version=2015,serial=microcloud,uuid=1f8e6f8e-5b74-4780-89c1-464dc1e7f319
-usbdevice tablet -display gtk -cpu host -drive
file=/pcvdata/vmtogo/user_images/9cc7-9ebee790f514a6dab92.img,cache=writeback,serial=9cc7-9ebee790f514a6dab92
-drive
file=/pcvdata/vmtogo/pri_desk/updbcc7-9ebee790f514a6dab92.img,cache=writeback,snapshot=off,serial=pridisk
-device virtio-serial,id=ser0 -chardev
socket,path=/tmp/virtio10280,server,nowait,id=virtio10280 -device
virtserialport,bus=ser0.0,chardev=virtio10280,name=com.microcloud.0 -device
virtio-serial,id=ser1 -chardev spicevmc,id=vdagent,name=vdagent -device
virtserialport,bus=ser1.0,chardev=vdagent,name=com.redhat.spice.0 -chardev
socket,path=/tmp/monitor10280,server,nowait,id=monitor10280 -mon
chardev=monitor10280,mode=readline -serial /dev/ttyS0

2. GDB info:
The 3rd thread missing as mentioned earlier
(gdb) info threads
  Id   Target Id         Frame
* 1    LWP 21315 "qemu-system-x86" 0x00007f9a24739c8b in ppoll () from
/lib/libc.so.6
  2    LWP 21316 "qemu-system-x86" 0x00007f9a2473fee9 in syscall () from
/lib/libc.so.6
  3    LWP 21369 "qemu-system-x86" 0x00007f9a2473b697 in ioctl () from
/lib/libc.so.6
  4    LWP 21370 "qemu-system-x86" 0x00007f9a2473b697 in ioctl () from
/lib/libc.so.6
  5    LWP 21371 "qemu-system-x86" 0x00007f9a24739b9d in poll () from
/lib/libc.so.6
  6    LWP 21373 "threaded-ml" 0x00007f9a24739b9d in poll () from
/lib/libc.so.6
  7    LWP 21374 "qemu-system-x86" 0x00007f9a24a11e1d in pthread_cond_wait
() from /lib/libpthread.so.0
  8    LWP 21375 "qemu-system-x86" 0x00007f9a24a11e1d in pthread_cond_wait
() from /lib/libpthread.so.0


2017-10-19 21:29 GMT+08:00 Stefan Hajnoczi <stefanha@gmail.com>:

> On Thu, Oct 19, 2017 at 05:32:10PM +0800, Wahaha Huang wrote:
> > Hi there,
> > I'm a newbie of qemu(2.10.0), when i start a vm from qemu, it sometimes
> get
> > stuck,
>
> Please post your QEMU command-line and describe the behavior when it
> gets stuck.
>
> Are there any error messages?  Does the QEMU monitor still work?  Is the
> QEMU process running at 100% CPU?  etc
>
> > through gdb debugging, i found aio_worker thread(list below) missing when
> > vm get stuck,
> > but i don't know why, does anybody has further idea about this?
>
> Worker threads are temporary threads.  If there is no work to do then
> they terminate.  New worker threads are started as needed.  Therefore
> you can't assume that a specific number of worker threads exists.
>
> > (gdb) info threads
> > >
> > >   Id   Target Id         Frame
> > >
> > >   1    LWP 25451 "qemu-system-x86" 0x00007fc62081dc8b in ppoll () from
> > >> /lib/libc.so.6
> > >
> > >   2    LWP 25452 "qemu-system-x86" 0x00007fc620823ee9 in syscall ()
> from
> > >> /lib/libc.so.6
> > >
> > > * 3    LWP 25495 "qemu-system-x86" 0x00007fc620af8e80 in ?? () from
> > >> /lib/libpthread.so.0
> > >
> > >   4    LWP 25496 "qemu-system-x86" 0x00007fc62081f697 in ioctl () from
> > >> /lib/libc.so.6
> > >
> > >   5    LWP 25497 "qemu-system-x86" 0x00007fc62081f697 in ioctl () from
> > >> /lib/libc.so.6
> > >
> > >   6    LWP 25498 "qemu-system-x86" 0x00007fc62081db9d in poll () from
> > >> /lib/libc.so.6
> > >
> > >   7    LWP 25500 "threaded-ml" 0x00007fc62081db9d in poll () from
> > >> /lib/libc.so.6
>
> This looks like PulseAudio.  I suggest disabling audio and checking if
> the hang still occurs.
>
> > >
> > >   8    LWP 25501 "qemu-system-x86" 0x00007fc620af5e1d in
> pthread_cond_wait
> > >> () from /lib/libpthread.so.0
> > >
> > >   9    LWP 25502 "qemu-system-x86" 0x00007fc620af5e1d in
> pthread_cond_wait
> > >> () from /lib/libpthread.so.0
> > >
> > > (gdb) bt
> > >
> > > #0  0x00007fc620af8e80 in  () at /lib/libpthread.so.0
> > >
> > > #1  0x00007fc620af8f5f in  () at /lib/libpthread.so.0
> > >
> > > #2  0x00007fc620af906f in sem_timedwait () at /lib/libpthread.so.0
> > >
> > > #3  0x000055b66332e585 in qemu_sem_timedwait (sem=0x55b664e6c868,
> > >> ms=10000) at util/qemu-thread-posix.c:289
> > >
> > > #4  0x000055b6633279b6 in worker_thread (opaque=0x55b664e6c7f0) at
> > >> util/thread-pool.c:102
> > >
> > > #5  0x00007fc620aef767 in  () at /lib/libpthread.so.0
> > >
> > > #6  0x00007fc62082985f in clone () at /lib/libc.so.6
>
> This is a worker thread waiting for more work to do.  It's normal.
>
