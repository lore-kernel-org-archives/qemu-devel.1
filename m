Received: from eggs.gnu.org ([209.51.188.92]:49507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gybCY-0001u8-Cy
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gybCW-0002t2-Cp
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:47:10 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:36784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gybCU-0002nr-PF
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:47:08 -0500
Received: by mail-ot1-x330.google.com with SMTP id v62so10811739otb.3
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 03:47:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA-GYE98ceYOHQ5hGwb-Dh8qv=Jvr=EEp_Dk9YLCmQdA4g@mail.gmail.com>
In-Reply-To: <CAFEAcA-GYE98ceYOHQ5hGwb-Dh8qv=Jvr=EEp_Dk9YLCmQdA4g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 11:46:46 +0000
Message-ID: <CAFEAcA9295VBXHWzraE_ykcD+-1cLOMS158Lyf+gQxzumxV=xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] can we disable the migration-test for TCG targets ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 25 Feb 2019 at 14:00, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; the migration-test is failing really frequently for me
> for TCG targets (usually on sparc64 host) -- can we just disable
> it from the test set until we've figured out and implemented a
> fix for the underlying TCG bug, please?

Here's a backtrace from the hang.

Process status:
pm215    125126 35.8  0.0  17896  4008 pts/2    S+   13:51  18:09
            \_ tests/migration-test -m=quick -k --tap
pm215    125450  126  0.2 901808 151184 pts/2   Sl+  13:51  64:17
            |   \_ aarch64-softmmu/qemu-system-aarch64 -qtest
unix:/tmp/qtest-125126.
pm215    125560  0.0  0.1 755368 68960 pts/2    Sl+  13:51   0:00
            |   \_ aarch64-softmmu/qemu-system-aarch64 -qtest
unix:/tmp/qtest-125126.

(This isn't specific to aarch64 guests, I've seen others.)

Backtrace of migration-test:
#0  0xfff8000100f8f9c8 in __GI___nanosleep
(requested_time=0x7feff8c2618, remaining=0x0) at
../sysdeps/unix/sysv/linux/nanosleep.c:28
#1  0xfff8000100fbd1f4 in usleep (useconds=<optimized out>) at
../sysdeps/posix/usleep.c:32
#2  0x000001000000a380 in wait_for_migration_pass (who=0x10000161cd0)
at /home/pm215/qemu/tests/migration-test.c:279
#3  0x000001000000ab44 in migrate_postcopy_prepare
(from_ptr=0x7feff8c2868, to_ptr=0x7feff8c2870, hide_error=<optimized
out>)
    at /home/pm215/qemu/tests/migration-test.c:627
#4  0x000001000000b384 in test_postcopy () at
/home/pm215/qemu/tests/migration-test.c:653
#5  0xfff8000100496370 in ?? () from /usr/lib/sparc64-linux-gnu/libglib-2.0.so.0

Backtrace of process 125450:
Thread 6 (Thread 0xfff800012de0b900 (LWP 127434)):
#0  0xfff80001034c5cdc in futex_abstimed_wait_cancelable (private=0,
abstime=0xfff800012de09f88, expected=0, futex_word=0x10001236574)
    at ../sysdeps/unix/sysv/linux/futex-internal.h:205
#1  0xfff80001034c5cdc in do_futex_wait (sem=0x3c,
abstime=0xfff800012de09f88) at sem_waitcommon.c:111
#2  0xfff80001034c5e00 in __new_sem_wait_slow (sem=0x10001236570,
abstime=0xfff800012de09f88) at sem_waitcommon.c:181
#3  0x000001000091dacc in qemu_sem_timedwait (sem=0x10001236570,
ms=<optimized out>) at /home/pm215/qemu/util/qemu-thread-posix.c:289
#4  0x000001000078ae28 in migration_thread (opaque=0x100012364a0) at
/home/pm215/qemu/migration/migration.c:3125
#5  0x000001000091cdb0 in qemu_thread_start (args=0x1000175e730) at
/home/pm215/qemu/util/qemu-thread-posix.c:502
#6  0xfff80001034bbe68 in start_thread (arg=0xfff800012de0b900) at
pthread_create.c:486
#7  0xfff80001036c00b8 in __thread_start () at
../sysdeps/unix/sysv/linux/sparc/sparc64/clone.S:78

Thread 5 (Thread 0xfff80001139cb900 (LWP 127433)):
#0  0xfff80001034c7e0c in __libc_recvmsg (flags=1073741824,
msg=0xfff80001139c9930, fd=17) at
../sysdeps/unix/sysv/linux/recvmsg.c:28
#1  0xfff80001034c7e0c in __libc_recvmsg (fd=<optimized out>,
msg=0xfff80001139c9930, flags=<optimized out>) at
../sysdeps/unix/sysv/linux/recvmsg.c:25
#2  0x00000100008ae9e0 in qio_channel_socket_readv (ioc=<optimized
out>, iov=<optimized out>, niov=<optimized out>, fds=0x0, nfds=0x0,
errp=0x0)
    at /home/pm215/qemu/io/channel-socket.c:484
#3  0x00000100008ab428 in qio_channel_readv_full (ioc=0x100019f9e00,
iov=0xfff80001139c9b28, niov=1, fds=0x0, nfds=0x0, errp=0x0)
    at /home/pm215/qemu/io/channel.c:65
#4  0x00000100008ab594 in qio_channel_read (ioc=0x100019f9e00,
buf=0x100012ad938 "", buflen=32768, errp=0x0) at
/home/pm215/qemu/io/channel.c:216
#5  0x000001000079bb58 in channel_get_buffer (opaque=0x100019f9e00,
buf=0x100012ad938 "", pos=8, size=32768)
    at /home/pm215/qemu/migration/qemu-file-channel.c:84
#6  0x0000010000799d7c in qemu_fill_buffer (f=0x100012ad900) at
/home/pm215/qemu/migration/qemu-file.c:297
#7  0x000001000079abe4 in qemu_peek_byte (f=0x100012ad900,
offset=<optimized out>) at /home/pm215/qemu/migration/qemu-file.c:557
#8  0x000001000079aef0 in qemu_get_byte (f=0x100012ad900) at
/home/pm215/qemu/migration/qemu-file.c:642
#9  0x000001000079aef0 in qemu_get_be16 (f=0x100012ad900) at
/home/pm215/qemu/migration/qemu-file.c:642
#10 0x000001000078862c in source_return_path_thread
(opaque=0x100012364a0) at /home/pm215/qemu/migration/migration.c:2206
#11 0x000001000091cdb0 in qemu_thread_start (args=0x10001257600) at
/home/pm215/qemu/util/qemu-thread-posix.c:502
#12 0xfff80001034bbe68 in start_thread (arg=0xfff80001139cb900) at
pthread_create.c:486
#13 0xfff80001036c00b8 in __thread_start () at
../sysdeps/unix/sysv/linux/sparc/sparc64/clone.S:78

Thread 4 (Thread 0xfff8000112e83900 (LWP 125524)):
#0  0x000001000039cdec in cpu_physical_memory_get_dirty
(start=54124544, client=<optimized out>, length=1) at
/home/pm215/qemu/include/exec/ram_addr.h:144
#1  0x000001000039eec4 in cpu_physical_memory_get_dirty_flag
(client=1, addr=54124544) at
/home/pm215/qemu/include/exec/ram_addr.h:214
#2  0x000001000039eec4 in cpu_physical_memory_is_clean (addr=54124544)
at /home/pm215/qemu/include/exec/ram_addr.h:214
#3  0x000001000039eec4 in tlb_set_page_with_attrs
    (cpu=<optimized out>, vaddr=<optimized out>, paddr=<optimized
out>, attrs=..., prot=<optimized out>, mmu_idx=<optimized out>,
size=<optimized out>)
    at /home/pm215/qemu/accel/tcg/cputlb.c:819
#4  0x000001000050fb58 in arm_tlb_fill (cs=0x10001258b60,
address=1127866368, access_type=<optimized out>, mmu_idx=<optimized
out>, fi=<optimized out>)
    at /home/pm215/qemu/target/arm/helper.c:11914
#5  0x00000100004f6e1c in tlb_fill
    (cs=0x10001258b60, addr=1127866368, size=<optimized out>,
access_type=<optimized out>, mmu_idx=<optimized out>,
retaddr=18444492278459273036)
    at /home/pm215/qemu/target/arm/op_helper.c:206
#6  0x000001000039f5a8 in helper_ret_ldub_mmu (env=0x10001260fd0,
addr=1127866368, oi=<optimized out>, retaddr=18444492278459273036)
    at /home/pm215/qemu/target/arm/cpu.h:919
#7  0xfff8000110000f54 in code_gen_buffer ()
#8  0x00000100003c0688 in cpu_tb_exec (itb=<optimized out>,
cpu=<optimized out>) at /home/pm215/qemu/accel/tcg/cpu-exec.c:171
#9  0x00000100003c0688 in cpu_loop_exec_tb (tb_exit=<synthetic
pointer>, last_tb=<synthetic pointer>, tb=<optimized out>,
cpu=<optimized out>)
    at /home/pm215/qemu/accel/tcg/cpu-exec.c:618
#10 0x00000100003c0688 in cpu_exec (cpu=<optimized out>) at
/home/pm215/qemu/accel/tcg/cpu-exec.c:729
#11 0x000001000036ae9c in tcg_cpu_exec (cpu=0x10001258b60) at
/home/pm215/qemu/cpus.c:1429
#12 0x000001000036daec in qemu_tcg_cpu_thread_fn (arg=0x10001258b60)
at /home/pm215/qemu/cpus.c:1733
#13 0x000001000036daec in qemu_tcg_cpu_thread_fn (arg=0x10001258b60)
at /home/pm215/qemu/cpus.c:1707
#14 0x000001000091cdb0 in qemu_thread_start (args=0x100012a6670) at
/home/pm215/qemu/util/qemu-thread-posix.c:502
#15 0xfff80001034bbe68 in start_thread (arg=0xfff8000112e83900) at
pthread_create.c:486
#16 0xfff80001036c00b8 in __thread_start () at
../sysdeps/unix/sysv/linux/sparc/sparc64/clone.S:78

Thread 3 (Thread 0xfff800010be17900 (LWP 125519)):
#0  0xfff8000103657bd0 in __GI___libc_malloc (bytes=14) at malloc.c:3034
#1  0xfff8000101984ef0 in g_malloc () at
/usr/lib/sparc64-linux-gnu/libglib-2.0.so.0
#2  0x0000010000910e14 in json_token (type=<optimized out>,
x=<optimized out>, y=<optimized out>, tokstr=0x10001200520)
    at /home/pm215/qemu/qobject/json-parser.c:565
#3  0x000001000090f9a0 in json_message_process_token
(lexer=0x100011b4af8, input=0x10001200520, type=<optimized out>,
x=<optimized out>, y=<optimized out>)
    at /home/pm215/qemu/qobject/json-streamer.c:82
#4  0x000001000093d1c4 in json_lexer_feed_char (lexer=0x100011b4af8,
ch=<optimized out>, flush=<optimized out>)
    at /home/pm215/qemu/qobject/json-lexer.c:313
#5  0x000001000093d340 in json_lexer_feed (lexer=0x100011b4af8,
buffer=<optimized out>, size=<optimized out>) at
/home/pm215/qemu/qobject/json-lexer.c:350
#6  0x0000010000896de8 in qemu_chr_be_write_impl (len=<optimized out>,
buf=0xfff800010be14d38 "{", s=0x100011ecc00) at
/home/pm215/qemu/chardev/char.c:175
#7  0x0000010000896de8 in qemu_chr_be_write (s=0x100011ecc00,
buf=0xfff800010be14d38 "{", len=<optimized out>) at
/home/pm215/qemu/chardev/char.c:187
#8  0x000001000089f608 in tcp_chr_read (chan=<optimized out>,
cond=<optimized out>, opaque=<optimized out>) at
/home/pm215/qemu/chardev/char-socket.c:515
#9  0x00000100008b111c in qio_channel_fd_source_dispatch
(source=0xfff8000114005e40, callback=0x1000089f500 <tcp_chr_read>,
user_data=0x100011ecc00)
    at /home/pm215/qemu/io/channel-watch.c:84
#10 0xfff800010197ed1c in g_main_context_dispatch () at
/usr/lib/sparc64-linux-gnu/libglib-2.0.so.0
#11 0xfff800010197f130 in  () at /usr/lib/sparc64-linux-gnu/libglib-2.0.so.0

Thread 2 (Thread 0xfff800010b615900 (LWP 125511)):
#0  0xfff80001036bc040 in syscall () at
../sysdeps/unix/sysv/linux/sparc/sparc64/syscall.S:33
#1  0x000001000091de6c in qemu_futex_wait (val=<optimized out>,
f=<optimized out>) at /home/pm215/qemu/util/qemu-thread-posix.c:438
#2  0x000001000091de6c in qemu_event_wait (ev=0x100010cc0c8
<rcu_gp_event>) at /home/pm215/qemu/util/qemu-thread-posix.c:442
#3  0x0000010000931e9c in wait_for_readers () at /home/pm215/qemu/util/rcu.c:135
#4  0x0000010000931e9c in synchronize_rcu () at /home/pm215/qemu/util/rcu.c:171
#5  0x00000100009322d4 in call_rcu_thread (opaque=<optimized out>) at
/home/pm215/qemu/util/rcu.c:268
#6  0x000001000091cdb0 in qemu_thread_start (args=0x100010dcc60) at
/home/pm215/qemu/util/qemu-thread-posix.c:502
#7  0xfff80001034bbe68 in start_thread (arg=0xfff800010b615900) at
pthread_create.c:486
#8  0xfff80001036c00b8 in __thread_start () at
../sysdeps/unix/sysv/linux/sparc/sparc64/clone.S:78

Thread 1 (Thread 0xfff800010006e6e0 (LWP 125450)):
#0  0xfff80001036b57f4 in __GI_ppoll (fds=0x10001a08c90, nfds=6,
timeout=<optimized out>, sigmask=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000010000917d6c in ppoll (__ss=0x0, __timeout=0x7feffae6a48,
__nfds=6, __fds=0x10001a08c90) at
/usr/include/sparc64-linux-gnu/bits/poll2.h:77
#2  0x0000010000917d6c in qemu_poll_ns (fds=0x10001a08c90,
nfds=<optimized out>, timeout=<optimized out>) at
/home/pm215/qemu/util/qemu-timer.c:334
#3  0x00000100009191cc in os_host_main_loop_wait (timeout=1000000000)
at /home/pm215/qemu/util/main-loop.c:233
#4  0x00000100009191cc in main_loop_wait (nonblocking=<optimized out>)
at /home/pm215/qemu/util/main-loop.c:514
#5  0x00000100005cbfc4 in main_loop () at /home/pm215/qemu/vl.c:1923
#6  0x00000100003173a0 in main (argc=<optimized out>, argv=<optimized
out>, envp=<optimized out>) at /home/pm215/qemu/vl.c:4578



Backtrace of process 125560:

Thread 4 (Thread 0xfff8000112e83900 (LWP 125642)):
#0  0xfff8000103502bbc in futex_wait_cancelable (private=0,
expected=0, futex_word=0x100012a665c) at
../sysdeps/unix/sysv/linux/futex-internal.h:88
#1  0xfff8000103502bbc in __pthread_cond_wait_common (abstime=0x0,
mutex=0x100010958a0 <qemu_global_mutex>, cond=0x100012a6630) at
pthread_cond_wait.c:502
#2  0xfff8000103502bbc in __pthread_cond_wait (cond=0x100012a6630,
mutex=0x100010958a0 <qemu_global_mutex>) at pthread_cond_wait.c:655
#3  0x000001000091d670 in qemu_cond_wait_impl
    (cond=0x100012a6630, mutex=0x100010958a0 <qemu_global_mutex>,
file=0x100009d4d80 "/home/pm215/qemu/cpus.c", line=<optimized out>)
    at /home/pm215/qemu/util/qemu-thread-posix.c:161
#4  0x000001000036b448 in qemu_wait_io_event (cpu=0x10001258b60) at
/home/pm215/qemu/cpus.c:1242
#5  0x000001000036daa8 in qemu_tcg_cpu_thread_fn (arg=0x10001258b60)
at /home/pm215/qemu/cpus.c:1760
#6  0x000001000036daa8 in qemu_tcg_cpu_thread_fn (arg=0x10001258b60)
at /home/pm215/qemu/cpus.c:1707
#7  0x000001000091cdb0 in qemu_thread_start (args=0x100012a6670) at
/home/pm215/qemu/util/qemu-thread-posix.c:502
#8  0xfff80001034fbe68 in start_thread (arg=0xfff8000112e83900) at
pthread_create.c:486
#9  0xfff80001037000b8 in __thread_start () at
../sysdeps/unix/sysv/linux/sparc/sparc64/clone.S:78

Thread 3 (Thread 0xfff800010be57900 (LWP 125637)):
#0  0xfff80001036f56dc in __GI___poll (fds=0xfff8000114005650, nfds=3,
timeout=<optimized out>) at ../sysdeps/unix/sysv/linux/poll.c:29
#1  0xfff80001019bf0a0 in  () at /usr/lib/sparc64-linux-gnu/libglib-2.0.so.0

Thread 2 (Thread 0xfff800010b655900 (LWP 125629)):
#0  0xfff80001036fc040 in syscall () at
../sysdeps/unix/sysv/linux/sparc/sparc64/syscall.S:33
#1  0x000001000091de6c in qemu_futex_wait (val=<optimized out>,
f=<optimized out>) at /home/pm215/qemu/util/qemu-thread-posix.c:438
#2  0x000001000091de6c in qemu_event_wait (ev=0x100010cc040
<rcu_call_ready_event>) at
/home/pm215/qemu/util/qemu-thread-posix.c:442
#3  0x00000100009322a4 in call_rcu_thread (opaque=<optimized out>) at
/home/pm215/qemu/util/rcu.c:261
#4  0x000001000091cdb0 in qemu_thread_start (args=0x100010dcc60) at
/home/pm215/qemu/util/qemu-thread-posix.c:502
#5  0xfff80001034fbe68 in start_thread (arg=0xfff800010b655900) at
pthread_create.c:486
#6  0xfff80001037000b8 in __thread_start () at
../sysdeps/unix/sysv/linux/sparc/sparc64/clone.S:78

Thread 1 (Thread 0xfff800010006e6e0 (LWP 125560)):
#0  0xfff80001036f57f4 in __GI_ppoll (fds=0x10001a04080, nfds=7,
timeout=<optimized out>, sigmask=0x0) at
../sysdeps/unix/sysv/linux/ppoll.c:39
#1  0x0000010000917d6c in ppoll (__ss=0x0, __timeout=0x7feff8b49f8,
__nfds=7, __fds=0x10001a04080) at
/usr/include/sparc64-linux-gnu/bits/poll2.h:77
#2  0x0000010000917d6c in qemu_poll_ns (fds=0x10001a04080,
nfds=<optimized out>, timeout=<optimized out>) at
/home/pm215/qemu/util/qemu-timer.c:334
#3  0x00000100009191cc in os_host_main_loop_wait (timeout=1000000000)
at /home/pm215/qemu/util/main-loop.c:233
#4  0x00000100009191cc in main_loop_wait (nonblocking=<optimized out>)
at /home/pm215/qemu/util/main-loop.c:514
#5  0x00000100005cbfc4 in main_loop () at /home/pm215/qemu/vl.c:1923
#6  0x00000100003173a0 in main (argc=<optimized out>, argv=<optimized
out>, envp=<optimized out>) at /home/pm215/qemu/vl.c:4578


thanks
-- PMM
