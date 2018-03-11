Received: from eggs.gnu.org ([2001:4830:134:3::10]:54619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1euuwB-00069r-Kz
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 01:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <debby83729@gmail.com>) id 1euuwA-0002jM-Ly
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 01:58:31 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:53915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <debby83729@gmail.com>)
	id 1euuwA-0002ix-9j
	for qemu-devel@nongnu.org; Sun, 11 Mar 2018 01:58:30 -0500
Received: by mail-wm0-x229.google.com with SMTP id e194so10661317wmd.3
	for <qemu-devel@nongnu.org>; Sat, 10 Mar 2018 22:58:30 -0800 (PST)
MIME-Version: 1.0
From: Eva Chen <debby83729@gmail.com>
Date: Sun, 11 Mar 2018 14:58:08 +0800
Message-ID: <CAG0V3WTKdkyxZE=pJ1Y=+DmLRD1Dv1qfJ3X8d8TJ=isMUcc-WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu 2.10.2 : util/qemu-thread-posix.c: 64:
 qemu_mutex_lock: Assertion 'mutex->initialized' failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I am working on compiling QEMU 2.10.2 to a static library.

Everything works fine in compiling QEMU to an execution
file(qemu-system-aarch64), but after I link all .o and .a file to create a
QEMU library and write a c file to call qemu_main() in qemu/util/vl.c(I
have changed the name "main()" into "qemu_main()"), then it shows this
error message.

util/qemu-thread-posix.c: 64: qemu_mutex_lock: Assertion
'mutex->initialized' failed.
Abort (core dumped)


The information of gdb's backtrace is shown as bellow
(gdb) bt

*#o Ox00007ffff05b31f7 in raise () at /usr/lib64/libc.so.6 #1
0x00007ffff05b48e8 in abort () at /usr/lib64/libc.s0.6 #2
0x00007ffff05ac266 in assert fail base () at /usr/lib64/libc.so.6 #3
0x00007ffff05ac312 in 0 at /usr/lib64/libc.so.6 #4 0x00000000005c47e3 in
qemu_mutex_lock (mutex=3Dmutex@entry=3D0xd84be0 <rcu_registry lock>) at
util/qemu -thread-posix.c:64 #5 0x00000000005d5b46 in rcu_register_thread
() at util/rcu.c:290, #6 0x00007ffff5a790de in rcu_init_complete () at
util/rcu.c:318, #7 Ox00007ffff7dea503 in _dl_init_internal () at
/lib64/ld.linux-x86-64.50.2 #8 0x00007ffff7ddclaa in _dl_start_user () at
/lib64/ld.linux - x86-64.so.2, #9 0x0000000000000014 in ()*

I found out that it aborted before conducted to the main function in QEMU
Also,  I use si and n in gdb to see what happened in this QEMU library
it showed  that the address and content of *rcu_registry_lock* would change
when it executed qemu_thread_create() in util/rcu.c:315

$ qemu_thread_create(&thread, "cal_rcu", call_rcu_thread, NULL,
QEMU_THREAD_DETACHED)

This change caused the failure of assert(mutex->initialized) in
qemu_mutex_lock (which called by rcu_register_thread() in call_rcu_thread()=
)


The method that compiling the execution file into a library success on QEMU
2.2.1, but failed on QEMU 2.10.2
Will this error message related to the rcu? Or is there anything suggestion
to solve this error?


I will be grateful for any help.


Eva


*=E2=80=8B*
