Received: from eggs.gnu.org ([209.51.188.92]:50738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go6Q4-0005vs-Bc
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1go6Q2-000300-G4
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:53:44 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:46833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1go6Q0-0002uZ-Jh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 07:53:42 -0500
Received: by mail-oi1-x232.google.com with SMTP id x202so12869974oif.13
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 04:53:32 -0800 (PST)
MIME-Version: 1.0
References: <1548436676-31749-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548436676-31749-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 12:53:20 +0000
Message-ID: <CAFEAcA_YZMn7pUrB+h4yVcqEzk8o+HqnT1v-ciAhMap_wioKjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/50] Misc patches for 2019-01-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 25 Jan 2019 at 17:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 8b7a3e1e5434b55d7710071b00af97c7086cab7a:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-24 15:04:47 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 357c846440e9423b11f815cbf32441651e4f4835:
>
>   docker: adjust Xen repository for CentOS 7 (2019-01-25 14:38:08 +0100)
>
> ----------------------------------------------------------------
> * cpu-exec fixes (Emilio, Laurent)
> * high address load for linuxboot (Zhijian)
> * PVH support (Liam, Stefano)
> * Linux header update (Paolo)
> * enable vhost-net for all targets that have virtio-net (Paolo)
> * vhost-user-test cleanups (Paolo)
> * misc i386 changes (Paolo, Robert)
> * hexloader-test change to avoid O_NONBLOCK on stdin (Peter)
> * configure tweak for openpty (Thomas)
> * elf2dmp port to Windows (Viktor)

"make check" seems to hang for me on all my build platforms.
The culprit seems to be vhost-user-test.

Backtrace of all the threads in the QEMU binary:
Thread 2 (Thread 0x7f38cdfea700 (LWP 8638)):
#0  0x00007f38e6aba839 in syscall ()
    at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x0000563e422f36ae in qemu_futex_wait (f=0x563e42d087d8
<rcu_call_ready_event>, val=4294967295)
    at /home/petmay01/linaro/qemu-for-merges/include/qemu/futex.h:29
#2  0x0000563e422f3875 in qemu_event_wait (ev=0x563e42d087d8
<rcu_call_ready_event>) at
/home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:442
#3  0x0000563e4230caa8 in call_rcu_thread (opaque=0x0)
    at /home/petmay01/linaro/qemu-for-merges/util/rcu.c:261
#4  0x0000563e422f3a28 in qemu_thread_start (args=0x563e42f59db0)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
#5  0x00007f38e6d976db in start_thread (arg=0x7f38cdfea700)
    at pthread_create.c:463
#6  0x00007f38e6ac088f in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 1 (Thread 0x7f38ef3f0440 (LWP 8636)):
#0  0x00007f38e6da2567 in __libc_recvmsg (fd=10, msg=0x7ffc1b311ff0,
flags=1073741824) at ../sysdeps/unix/sysv/linux/recvmsg.c:28
#1  0x0000563e42271b30 in qio_channel_socket_readv
(ioc=0x563e42f57e40, iov=0x7ffc1b312140, niov=1, fds=0x7ffc1b312120,
nfds=0x7ffc1b312128, errp=0x0)
    at /home/petmay01/linaro/qemu-for-merges/io/channel-socket.c:484
#2  0x0000563e4226ce13 in qio_channel_readv_full (ioc=0x563e42f57e40,
iov=0x7ffc1b312140, niov=1, fds=0x7ffc1b312120, nfds=0x7ffc1b312128,
errp=0x0)
    at /home/petmay01/linaro/qemu-for-merges/io/channel.c:65
#3  0x0000563e42258c0c in tcp_chr_recv (chr=0x563e43016000,
buf=0x7ffc1b312250 "\001", len=12)
    at /home/petmay01/linaro/qemu-for-merges/chardev/char-socket.c:306
#4  0x0000563e42259540 in tcp_chr_sync_read (chr=0x563e43016000,
buf=0x7ffc1b312250 "\001", len=12)
    at /home/petmay01/linaro/qemu-for-merges/chardev/char-socket.c:516
#5  0x0000563e42253742 in qemu_chr_fe_read_all (be=0x563e430e5b50,
buf=0x7ffc1b312250 "\001", len=12)
    at /home/petmay01/linaro/qemu-for-merges/chardev/char-fe.c:72
#6  0x0000563e41deba0d in vhost_user_read (dev=0x563e430e5bc0,
msg=0x7ffc1b312250) at
/home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:224
#7  0x0000563e41ded2fe in vhost_user_get_u64 (dev=0x563e430e5bc0,
request=1, u64=0x7ffc1b312530)
    at /home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:817
#8  0x0000563e41ded3b3 in vhost_user_get_features (dev=0x563e430e5bc0,
features=0x7ffc1b312530)
    at /home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:839
#9  0x0000563e41dee954 in vhost_user_backend_init (dev=0x563e430e5bc0,
opaque=0x563e430a59c0)
    at /home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost-user.c:1352
#10 0x0000563e41de928b in vhost_dev_init (hdev=0x563e430e5bc0,
opaque=0x563e430a59c0, backend_type=VHOST_BACKEND_TYPE_USER,
busyloop_timeout=0)
    at /home/petmay01/linaro/qemu-for-merges/hw/virtio/vhost.c:1193
#11 0x0000563e4202bcfe in vhost_net_init (options=0x7ffc1b312650)
    at /home/petmay01/linaro/qemu-for-merges/hw/net/vhost_net.c:174
#12 0x0000563e42132e7e in vhost_user_start (queues=1,
ncs=0x7ffc1b3126e0, be=0x563e430a59c0) at
/home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:88
#13 0x0000563e421334b4 in net_vhost_user_event (opaque=0x563e430a3f70, event=1)
    at /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:268
#14 0x0000563e4225034d in chr_be_event (s=0x563e43016000, event=1)
    at /home/petmay01/linaro/qemu-for-merges/chardev/char.c:57
#15 0x0000563e422503cc in qemu_chr_be_event (s=0x563e43016000, event=1)
    at /home/petmay01/linaro/qemu-for-merges/chardev/char.c:72
#16 0x0000563e42254060 in qemu_chr_fe_set_handlers (b=0x563e430e5b50,
fd_can_read=0x0, fd_read=0x0, fd_event=0x563e42133392
<net_vhost_user_event>, be_change=0x0, opaque=0x563e430a3f70,
context=0x0, set_open=true)
    at /home/petmay01/linaro/qemu-for-merges/chardev/char-fe.c:289
#17 0x0000563e42133840 in net_vhost_user_init (peer=0x0,
device=0x563e424c3735 "vhost_user", name=0x563e430a4000 "net0",
chr=0x563e43016000, queues=1)
    at /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:344
#18 0x0000563e42133c00 in net_init_vhost_user (netdev=0x563e430a57e0,
name=0x563e430a4000 "net0", peer=0x0, errp=0x7ffc1b314a90)
    at /home/petmay01/linaro/qemu-for-merges/net/vhost-user.c:442
#19 0x0000563e4212a754 in net_client_init1 (object=0x563e430a57e0,
is_netdev=true, errp=0x7ffc1b314a90) at
/home/petmay01/linaro/qemu-for-merges/net/net.c:1060
#20 0x0000563e4212ab53 in net_client_init (opts=0x563e42fe2080,
is_netdev=true, errp=0x7ffc1b314c38) at
/home/petmay01/linaro/qemu-for-merges/net/net.c:1154
#21 0x0000563e4212b793 in net_init_netdev (dummy=0x0,
opts=0x563e42fe2080, errp=0x7ffc1b314c38) at
/home/petmay01/linaro/qemu-for-merges/net/net.c:1491
#22 0x0000563e42307d2d in qemu_opts_foreach (list=0x563e42c9b4e0
<qemu_netdev_opts>, func=0x563e4212b76a <net_init_netdev>, opaque=0x0,
errp=0x7ffc1b314c38)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-option.c:1171
#23 0x0000563e4212ba91 in net_init_clients (errp=0x7ffc1b314c38)
    at /home/petmay01/linaro/qemu-for-merges/net/net.c:1564
#24 0x0000563e41ec5089 in main (argc=25, argv=0x7ffc1b314ea8,
envp=0x7ffc1b314f78) at
/home/petmay01/linaro/qemu-for-merges/vl.c:4423

Ditto, in the vhost-user-test binary:

Thread 4 (Thread 0x7f4510899700 (LWP 8635)):
#0  0x00007f45131ddbf9 in __GI___poll (fds=0x7f4508000b20, nfds=1, timeout=-1)
    at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007f4514681539 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#2  0x00007f45146818d2 in g_main_loop_run ()
   from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#3  0x00005651cb943629 in thread_function (data=0x5651cd1788c0)
    at /home/petmay01/linaro/qemu-for-merges/tests/vhost-user-test.c:315
#4  0x00007f45146a9105 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#5  0x00007f45134c16db in start_thread (arg=0x7f4510899700)
    at pthread_create.c:463
#6  0x00007f45131ea88f in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 3 (Thread 0x7f451109a700 (LWP 8634)):
#0  0x00007f45131ddbf9 in __GI___poll (fds=0x7f4504000b40, nfds=1, timeout=-1)
    at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0x00007f4514681539 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#2  0x00007f45146818d2 in g_main_loop_run ()
   from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#3  0x00005651cb943629 in thread_function (data=0x5651cd1785c0)
    at /home/petmay01/linaro/qemu-for-merges/tests/vhost-user-test.c:315
#4  0x00007f45146a9105 in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#5  0x00007f45134c16db in start_thread (arg=0x7f451109a700)
    at pthread_create.c:463
#6  0x00007f45131ea88f in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 2 (Thread 0x7f451189b700 (LWP 8633)):
#0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
#1  0x00005651cb9a73a0 in qemu_futex_wait (
    f=0x5651cbc16138 <rcu_call_ready_event>, val=4294967295)
    at /home/petmay01/linaro/qemu-for-merges/include/qemu/futex.h:29
#2  0x00005651cb9a7567 in qemu_event_wait (
    ev=0x5651cbc16138 <rcu_call_ready_event>)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:442
#3  0x00005651cb9cbdc8 in call_rcu_thread (opaque=0x0)
    at /home/petmay01/linaro/qemu-for-merges/util/rcu.c:261
#4  0x00005651cb9a771a in qemu_thread_start (args=0x5651cd18d860)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
#5  0x00007f45134c16db in start_thread (arg=0x7f451189b700)
    at pthread_create.c:463
#6  0x00007f45131ea88f in clone ()
    at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

Thread 1 (Thread 0x7f4514d39900 (LWP 8631)):
#0  0x00007f45134cb384 in __libc_read (fd=10, buf=0x7fff4cbfce40, nbytes=1024)
    at ../sysdeps/unix/sysv/linux/read.c:27
#1  0x00005651cb982957 in qtest_recv_line (s=0x5651cd1a6180)
    at /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:379
#2  0x00005651cb982ac8 in qtest_rsp (s=0x5651cd1a6180, expected_args=1)
    at /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:406
#3  0x00005651cb982e3c in qtest_query_target_endianness (s=0x5651cd1a6180)
    at /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:452
#4  0x00005651cb9824ad in qtest_init_without_qmp_handshake (
    extra_args=0x5651cd1a6040 " -m 2 -object
memory-backend-memfd,id=mem,size=2M, -numa node,memdev=mem -chardev
socket,id=chr-src,path=/tmp/vhost-test-8YSOZx/src.sock -netdev
vhost-user,id=net0,chardev=chr-src,vhostforce -device v"...)
    at /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:279
#5  0x00005651cb9824dc in qtest_init (
    extra_args=0x5651cd1a6040 " -m 2 -object
memory-backend-memfd,id=mem,size=2M, -numa node,memdev=mem -chardev
socket,id=chr-src,path=/tmp/vhost-test-8YSOZx/src.sock -netdev
vhost-user,id=net0,chardev=chr-src,vhostforce -device v"...)
    at /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:286
#6  0x00005651cb942d42 in qtest_start (
    args=0x5651cd1a6040 " -m 2 -object
memory-backend-memfd,id=mem,size=2M, -numa node,memdev=mem -chardev
socket,id=chr-src,path=/tmp/vhost-test-8YSOZx/src.sock -netdev
vhost-user,id=net0,chardev=chr-src,vhostforce -device v"...)
    at /home/petmay01/linaro/qemu-for-merges/tests/libqtest.h:579
#7  0x00005651cb94491c in test_migrate ()
    at /home/petmay01/linaro/qemu-for-merges/tests/vhost-user-test.c:744
#8  0x00007f45146a7eba in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#9  0x00007f45146a7deb in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#10 0x00007f45146a7deb in ?? () from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#11 0x00007f45146a8092 in g_test_run_suite ()
   from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#12 0x00007f45146a80b1 in g_test_run ()
   from /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
#13 0x00005651cb94567c in main (argc=1, argv=0x7fff4cbfd838)
    at /home/petmay01/linaro/qemu-for-merges/tests/vhost-user-test.c:1037

thanks
-- PMM
