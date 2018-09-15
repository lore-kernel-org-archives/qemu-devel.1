Received: from eggs.gnu.org ([2001:4830:134:3::10]:42051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1g1FVt-00008o-8F
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 14:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lfy@google.com>) id 1g1FVs-0002u8-Eu
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 14:41:49 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:43706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lfy@google.com>) id 1g1FVs-0002ss-2P
	for qemu-devel@nongnu.org; Sat, 15 Sep 2018 14:41:48 -0400
Received: by mail-lj1-x22a.google.com with SMTP id m84-v6so10005193lje.10
	for <qemu-devel@nongnu.org>; Sat, 15 Sep 2018 11:41:47 -0700 (PDT)
MIME-Version: 1.0
From: Frank Yang <lfy@google.com>
Date: Sat, 15 Sep 2018 11:41:34 -0700
Message-ID: <CAEkmjvVMvbEzO3rT2nV0vURM0qatjoXm+GvxQfMD78HCuUdNog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Freeze / spin in virtio blk...flatview do translate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi qemu-devel,

So we're using QEMU 2.12 for recent Android Emulator canaryies, and we're
seeing a lot of hangs on mac in flatview_translate in qemu 2.12.

What would be some pointers for diagnosing excessive I/O?

Especially, metrics to see if a system is on the verge of getting into main
loop spins.

We have not reproduced this hang so far, this is from user crash reports
that triggered our hang detector (where 15+ seconds pass without main loop
/ VCPU threads being able to go back and ping their loopers in main loop /
vcpu threads.

0x00000001024e9fcb(qemu-system-x86_64 -exec.c:511)flatview_translate
0x00000001024f2390(qemu-system-x86_64
-memory.h:1865)address_space_lduw_internal_cached
0x000000010246ff11(qemu-system-x86_64
-virtio-access.h:166)virtio_queue_set_notification
0x00000001024fa2c9(qemu-system-x86_64+ 0x000a72c9)virtio_blk_handle_vq
0x00000001024746ee(qemu-system-x86_64
-virtio.c:1521)virtio_queue_host_notifier_aio_read
0x0000000103a5ed8a(qemu-system-x86_64 -aio-posix.c:406)aio_dispatch_handlers
0x0000000103a5ecc8(qemu-system-x86_64 -aio-posix.c:437)aio_dispatch
0x0000000103a5c158(qemu-system-x86_64 -async.c:261)aio_ctx_dispatch
0x0000000103a92103(qemu-system-x86_64 -gmain.c:3072)g_main_context_dispatch
0x0000000103a5e4ad(qemu-system-x86_64 -main-loop.c:224)main_loop_wait
0x0000000102468ab8(qemu-system-x86_64 -vl.c:2172)main_impl
0x0000000102461a3a(qemu-system-x86_64 -vl.c:3332)run_qemu_main
0x000000010246eef3(qemu-system-x86_64
-main.cpp:577)enter_qemu_main_loop(int, char**)
0x00000001062b63a9(libQt5Core.5.dylib
-qthread_unix.cpp:344)QThreadPrivate::start(void*)
0x00007fff65118660
0x00007fff6511850c
0x00007fff65117bf8
0x00000001062b623f(libQt5Core.5.dylib+ 0x0002623f)

Thanks,

Frank
