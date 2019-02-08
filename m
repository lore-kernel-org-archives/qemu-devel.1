Received: from eggs.gnu.org ([209.51.188.92]:40007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gs4aX-0005Lr-CF
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gs4aV-0005br-Or
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:44:57 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:37639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gs4aV-0005bD-D3
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:44:55 -0500
Received: by mail-ot1-x32f.google.com with SMTP id s13so5345575otq.4
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 03:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20190207160617.1142-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190207160617.1142-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Feb 2019 11:44:42 +0000
Message-ID: <CAFEAcA9hWXR6ynuX8CvFA6AspAgruYiUsQYM0pJ0nNG4b1281w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] Chardev patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 7 Feb 2019 at 16:06, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit 632351e0e1a861f2eaf709b053c53f96a12258=
25:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request' i=
nto staging (2019-02-07 14:20:46 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/elmarco/qemu.git tags/chardev-pull-request
>
> for you to fetch changes up to df3afdedd23ade0c9de55cadeb1d85055689023f:
>
>   tests/test-char: add muxed chardev testing for open/close (2019-02-07 1=
6:18:25 +0100)
>
> ----------------------------------------------------------------
> Various chardev fixes
>
> ----------------------------------------------------------------

This seems to result in 'make check' failures on some platforms.
I saw this on s390 and aarch32, I think.

MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
tests/test-char -m=3Dquick -k --tap < /dev/null |
./scripts/tap-driver.pl --test-name=3D"test-char
"
PASS 1 test-char /char/null
PASS 2 test-char /char/invalid
PASS 3 test-char /char/ringbuf
PASS 4 test-char /char/mux
PASS 5 test-char /char/stdio
PASS 6 test-char /char/pipe
PASS 7 test-char /char/file
PASS 8 test-char /char/file-fifo
PASS 9 test-char /char/udp
PASS 10 test-char /char/serial
PASS 11 test-char /char/hotswap
PASS 12 test-char /char/websocket
PASS 13 test-char /char/socket/server/mainloop/tcp
PASS 14 test-char /char/socket/server/mainloop/unix
PASS 15 test-char /char/socket/server/wait-conn/tcp
PASS 16 test-char /char/socket/server/wait-conn/unix
PASS 17 test-char /char/socket/server/mainloop-fdpass/tcp
PASS 18 test-char /char/socket/server/mainloop-fdpass/unix
PASS 19 test-char /char/socket/server/wait-conn-fdpass/tcp
PASS 20 test-char /char/socket/server/wait-conn-fdpass/unix
PASS 21 test-char /char/socket/client/mainloop/tcp
PASS 22 test-char /char/socket/client/mainloop/unix
qemu: qemu_mutex_destroy: Device or resource busy
PASS 23 test-char /char/socket/client/wait-conn/tcp
PASS 24 test-char /char/socket/client/wait-conn/unix
Aborted (core dumped)
ERROR - too few tests run (expected 32, got 24)

Here's a backtrace from running tests/test-char under gdb.
Looks like a race condition between a thread trying to
destroy a mutex and a different thread that is still
using it.

qemu: qemu_mutex_destroy: Device or resource busy
test-char: /home/linux1/qemu/util/qemu-thread-posix.c:92:
qemu_mutex_unlock_impl: Assertion `mutex->initialized' failed.

(gdb) thread apply all bt

Thread 17 (Thread 0x3fff77ff910 (LWP 35364)):
#0  0x000003fffd7381b8 in __GI_raise (sig=3Dsig@entry=3D6) at
../sysdeps/unix/sysv/linux/raise.c:54
#1  0x000003fffd739726 in __GI_abort () at abort.c:89
#2  0x000003fffd7300d6 in __assert_fail_base (fmt=3D0x3fffd84d18c
"%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=3D0x1000918d2
"mutex->initialized",
    file=3D0x1000918a6 "/home/linux1/qemu/util/qemu-thread-posix.c",
line=3D<optimized out>,
    function=3D0x100091bb2 <__PRETTY_FUNCTION__.18115>
"qemu_mutex_unlock_impl") at assert.c:92
#3  0x000003fffd730164 in __GI___assert_fail (assertion=3D0x1000918d2
"mutex->initialized", file=3D0x1000918a6
"/home/linux1/qemu/util/qemu-thread-posix.c",
    line=3D<optimized out>, function=3D0x100091bb2
<__PRETTY_FUNCTION__.18115> "qemu_mutex_unlock_impl") at assert.c:101
#4  0x000000010005db16 in qemu_mutex_unlock_impl (mutex=3D<optimized
out>, file=3D<optimized out>, line=3D<optimized out>)
    at /home/linux1/qemu/util/qemu-thread-posix.c:92
#5  0x00000001000257cc in qio_task_thread_worker
(opaque=3Dopaque@entry=3D0x1000f1370) at /home/linux1/qemu/io/task.c:141
#6  0x000000010005d640 in qemu_thread_start (args=3D<optimized out>) at
/home/linux1/qemu/util/qemu-thread-posix.c:502
#7  0x000003fffd907934 in start_thread (arg=3D0x3fff77ff910) at
pthread_create.c:335
#8  0x000003fffd7edce2 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:74

Thread 16 (Thread 0x3fff7fff910 (LWP 35363)):
#0  0x000003fffd911774 in __libc_recvmsg (fd=3D<optimized out>,
msg=3D0x3fff7ffe7d0, flags=3D<optimized out>) at
../sysdeps/unix/sysv/linux/recvmsg.c:33
#1  0x000000010001fab6 in qio_channel_socket_readv (ioc=3D<optimized
out>, iov=3D<optimized out>, niov=3D<optimized out>, fds=3D0x0, nfds=3D0x0,
    errp=3D0x1000c0320 <error_abort>) at /home/linux1/qemu/io/channel-socke=
t.c:484
#2  0x000000010001ca04 in qio_channel_readv_full (ioc=3D0x3fff00008c0,
iov=3D0x3fff00012b0, niov=3D1, fds=3D0x0, nfds=3D0x0, errp=3D0x1000c0320
<error_abort>)
    at /home/linux1/qemu/io/channel.c:65
#3  0x000000010001d478 in qio_channel_readv (errp=3D0x1000c0320
<error_abort>, niov=3D<optimized out>, iov=3D<optimized out>,
ioc=3D0x3fff00008c0)
    at /home/linux1/qemu/io/channel.c:197
#4  qio_channel_readv_all_eof (ioc=3D0x3fff00008c0, iov=3D<optimized out>,
niov=3D<optimized out>, errp=3Derrp@entry=3D0x1000c0320 <error_abort>)
    at /home/linux1/qemu/io/channel.c:106
#5  0x000000010001d576 in qio_channel_readv_all (ioc=3D<optimized out>,
iov=3D<optimized out>, niov=3D<optimized out>, errp=3D0x1000c0320
<error_abort>)
    at /home/linux1/qemu/io/channel.c:142
#6  0x000000010001d602 in qio_channel_read_all (ioc=3D<optimized out>,
buf=3D<optimized out>, buflen=3D<optimized out>, errp=3D<optimized out>)
    at /home/linux1/qemu/io/channel.c:246
#7  0x000000010001c3e0 in char_socket_ping_pong (ioc=3D0x3fff00008c0) at
/home/linux1/qemu/tests/test-char.c:706
#8  0x000000010001c4a8 in char_socket_client_server_thread
(data=3Ddata@entry=3D0x1000f2730) at
/home/linux1/qemu/tests/test-char.c:859
#9  0x000000010005d640 in qemu_thread_start (args=3D<optimized out>) at
/home/linux1/qemu/util/qemu-thread-posix.c:502
#10 0x000003fffd907934 in start_thread (arg=3D0x3fff7fff910) at
pthread_create.c:335
#11 0x000003fffd7edce2 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:74

Thread 3 (Thread 0x3fffc9ff910 (LWP 35350)):
#0  0x000003fffd7e3e54 in ?? () at
../sysdeps/unix/syscall-template.S:84 from
/lib/s390x-linux-gnu/libc.so.6
#1  0x000003fffddd06ee in ?? () from /lib/s390x-linux-gnu/libglib-2.0.so.0
#2  0x000003fffddd087c in g_main_context_iteration () from
/lib/s390x-linux-gnu/libglib-2.0.so.0
#3  0x000003fffddd08cc in ?? () from /lib/s390x-linux-gnu/libglib-2.0.so.0
#4  0x000003fffddfaba4 in ?? () from /lib/s390x-linux-gnu/libglib-2.0.so.0
#5  0x000003fffd907934 in start_thread (arg=3D0x3fffc9ff910) at
pthread_create.c:335
#6  0x000003fffd7edce2 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:74

Thread 2 (Thread 0x3fffd1ff910 (LWP 35346)):
#0  syscall () at ../sysdeps/unix/sysv/linux/s390/s390-64/syscall.S:58
#1  0x000000010005e3ca in qemu_futex_wait (val=3D<optimized out>,
f=3D<optimized out>) at /home/linux1/qemu/include/qemu/futex.h:29
#2  qemu_event_wait (ev=3D0x1000c17f0 <rcu_call_ready_event>) at
/home/linux1/qemu/util/qemu-thread-posix.c:442
#3  0x000000010007d524 in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) at
/home/linux1/qemu/util/rcu.c:261
#4  0x000000010005d640 in qemu_thread_start (args=3D<optimized out>) at
/home/linux1/qemu/util/qemu-thread-posix.c:502
#5  0x000003fffd907934 in start_thread (arg=3D0x3fffd1ff910) at
pthread_create.c:335
#6  0x000003fffd7edce2 in thread_start () at
../sysdeps/unix/sysv/linux/s390/s390-64/clone.S:74

Thread 1 (Thread 0x3fffdff3920 (LWP 35343)):
#0  0x000003fffd7381b8 in __GI_raise (sig=3Dsig@entry=3D6) at
../sysdeps/unix/sysv/linux/raise.c:54
#1  0x000003fffd739726 in __GI_abort () at abort.c:89
#2  0x0000000100017444 in error_exit (err=3D<optimized out>,
msg=3Dmsg@entry=3D0x100091c26 <__func__.18092> "qemu_mutex_destroy")
    at /home/linux1/qemu/util/qemu-thread-posix.c:36
#3  0x000000010005d772 in qemu_mutex_destroy (mutex=3D<optimized out>)
at /home/linux1/qemu/util/qemu-thread-posix.c:57
#4  0x0000000100025c36 in qio_task_free (task=3D0x1000f1370) at
/home/linux1/qemu/io/task.c:97
#5  qio_task_complete (task=3Dtask@entry=3D0x1000f1370) at
/home/linux1/qemu/io/task.c:196
#6  0x0000000100025d0e in qio_task_thread_result (opaque=3D0x1000f1370)
at /home/linux1/qemu/io/task.c:110
#7  0x000003fffddd03ce in g_main_context_dispatch () from
/lib/s390x-linux-gnu/libglib-2.0.so.0
#8  0x000000010005a16a in glib_pollfds_poll () at
/home/linux1/qemu/util/main-loop.c:215
#9  os_host_main_loop_wait (timeout=3D<optimized out>) at
/home/linux1/qemu/util/main-loop.c:238
#10 main_loop_wait (nonblocking=3D<optimized out>) at
/home/linux1/qemu/util/main-loop.c:514
#11 0x00000001000190c2 in char_socket_client_test (opaque=3D<optimized
out>) at /home/linux1/qemu/tests/test-char.c:962
#12 0x000003fffddf9756 in ?? () from /lib/s390x-linux-gnu/libglib-2.0.so.0
#13 0x000003fffddf9934 in ?? () from /lib/s390x-linux-gnu/libglib-2.0.so.0
#14 0x000003fffddf9934 in ?? () from /lib/s390x-linux-gnu/libglib-2.0.so.0
#15 0x000003fffddf9934 in ?? () from /lib/s390x-linux-gnu/libglib-2.0.so.0
#16 0x000003fffddf9934 in ?? () from /lib/s390x-linux-gnu/libglib-2.0.so.0
#17 0x000003fffddf9b5e in g_test_run_suite () from
/lib/s390x-linux-gnu/libglib-2.0.so.0
#18 0x000003fffddf9b80 in g_test_run () from
/lib/s390x-linux-gnu/libglib-2.0.so.0
#19 0x0000000100017a28 in main (argc=3D1, argv=3D0x3fffffff578) at
/home/linux1/qemu/tests/test-char.c:1358

On some other hosts I saw a similar
"qemu: qemu_mutex_destroy: Device or resource busy" and core dump in the
migration tests, I think, which is probably the same underlying bug.

thanks
-- PMM
