Received: from eggs.gnu.org ([2001:4830:134:3::10]:33180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kingtan9527@gmail.com>) id 1e57BZ-0007uK-Gp
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kingtan9527@gmail.com>) id 1e57BV-0005u1-C8
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:32:17 -0400
Received: from mail-it0-x234.google.com ([2607:f8b0:4001:c0b::234]:52359)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kingtan9527@gmail.com>)
	id 1e57BV-0005si-5R
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:32:13 -0400
Received: by mail-it0-x234.google.com with SMTP id j140so9068466itj.1
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:32:11 -0700 (PDT)
MIME-Version: 1.0
From: Wahaha Huang <kingtan9527@gmail.com>
Date: Thu, 19 Oct 2017 17:32:10 +0800
Message-ID: <CALMRoie6DWc0B5Q3ZAbSS7ezFC=tXtNW+eU1T_deJsadO06erQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [Block-io] qemu virtual machine get stuck during
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi there,
I'm a newbie of qemu(2.10.0), when i start a vm from qemu, it sometimes get
stuck,
through gdb debugging, i found aio_worker thread(list below) missing when
vm get stuck,
but i don't know why, does anybody has further idea about this?

(gdb) info threads
>
>   Id   Target Id         Frame
>
>   1    LWP 25451 "qemu-system-x86" 0x00007fc62081dc8b in ppoll () from
>> /lib/libc.so.6
>
>   2    LWP 25452 "qemu-system-x86" 0x00007fc620823ee9 in syscall () from
>> /lib/libc.so.6
>
> * 3    LWP 25495 "qemu-system-x86" 0x00007fc620af8e80 in ?? () from
>> /lib/libpthread.so.0
>
>   4    LWP 25496 "qemu-system-x86" 0x00007fc62081f697 in ioctl () from
>> /lib/libc.so.6
>
>   5    LWP 25497 "qemu-system-x86" 0x00007fc62081f697 in ioctl () from
>> /lib/libc.so.6
>
>   6    LWP 25498 "qemu-system-x86" 0x00007fc62081db9d in poll () from
>> /lib/libc.so.6
>
>   7    LWP 25500 "threaded-ml" 0x00007fc62081db9d in poll () from
>> /lib/libc.so.6
>
>   8    LWP 25501 "qemu-system-x86" 0x00007fc620af5e1d in pthread_cond_wait
>> () from /lib/libpthread.so.0
>
>   9    LWP 25502 "qemu-system-x86" 0x00007fc620af5e1d in pthread_cond_wait
>> () from /lib/libpthread.so.0
>
> (gdb) bt
>
> #0  0x00007fc620af8e80 in  () at /lib/libpthread.so.0
>
> #1  0x00007fc620af8f5f in  () at /lib/libpthread.so.0
>
> #2  0x00007fc620af906f in sem_timedwait () at /lib/libpthread.so.0
>
> #3  0x000055b66332e585 in qemu_sem_timedwait (sem=0x55b664e6c868,
>> ms=10000) at util/qemu-thread-posix.c:289
>
> #4  0x000055b6633279b6 in worker_thread (opaque=0x55b664e6c7f0) at
>> util/thread-pool.c:102
>
> #5  0x00007fc620aef767 in  () at /lib/libpthread.so.0
>
> #6  0x00007fc62082985f in clone () at /lib/libc.so.6
>
>
