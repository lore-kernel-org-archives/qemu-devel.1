Received: from eggs.gnu.org ([2001:4830:134:3::10]:38074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eIFJl-0001vB-Ty
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eIFJh-0003K6-1O
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:51:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eIFJg-0003JN-Ne
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:50:56 -0500
Date: Fri, 24 Nov 2017 15:50:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171124155053.2e219cea@redhat.com>
In-Reply-To: <02ac211d-d78f-4639-a8a9-b9d0a6497f3d@redhat.com>
References: <20171124135729.60ceff1e@redhat.com>
	<02ac211d-d78f-4639-a8a9-b9d0a6497f3d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Windows 10 guest hang during 'info mem'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, kvm@vger.kernel.org, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Fri, 24 Nov 2017 15:05:24 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 24/11/2017 13:57, Igor Mammedov wrote:
> > I've stumbled on WS2016 hang when trying to list memory map in QEMU.
> > 
> > Steps to reproduce:
> >   qemu-system-x86_64 -monitor stdio -enable-kvm -m 1G ws2016x64.img
> >  wait till guest boots and execute in monitor 
> >   (qemu) info mem
> > 
> > qemu will hang while printing mappings, consuming 100% cpu and not
> > responding to ^C.
> > 
> > I've also tried with old (2.8) and current qemu master and today's
> > upstream kernel where it also doesn't work but WS2012R2x64 guest
> > works just fine.
> > 
> > PS:
> > CCing KVM list as the issue happens only when KVM is enabled.  
> 
> "info mem" code sucks and is unreadable.  We really should rewrite the
> MMU stuff in TCG. :(
> 
> But, what is the backtrace?

it seems to be stuck in mem_info_la48()

(gdb) thread apply all bt

Thread 4 (Thread 0x7f74f3da0700 (LWP 3866)):
#0  0x00007f74f89dfc89 in syscall () from /lib64/libc.so.6
#1  0x000055b9c76d44e8 in qemu_futex_wait (f=0x55b9c841cfd4 <rcu_call_ready_event>, val=0xffffffff)
    at qemu/include/qemu/futex.h:29
#2  0x000055b9c76d46b1 in qemu_event_wait (ev=0x55b9c841cfd4 <rcu_call_ready_event>)
    at qemu/util/qemu-thread-posix.c:442
#3  0x000055b9c76ec511 in call_rcu_thread (opaque=0x0) at qemu/util/rcu.c:249
#4  0x00007f74f8cbbdd5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f74f89e594d in clone () from /lib64/libc.so.6

Thread 3 (Thread 0x7f74f2696700 (LWP 3870)):
#0  0x00007f74f89dc3b7 in ioctl () from /lib64/libc.so.6
#1  0x000055b9c7228f87 in kvm_vcpu_ioctl (cpu=0x55b9c8903bb0, type=0xae80)
    at qemu/accel/kvm/kvm-all.c:2050
#2  0x000055b9c722884e in kvm_cpu_exec (cpu=0x55b9c8903bb0) at qemu/accel/kvm/kvm-all.c:1887
#3  0x000055b9c71f7c54 in qemu_kvm_cpu_thread_fn (arg=0x55b9c8903bb0) at qemu/cpus.c:1128
#4  0x00007f74f8cbbdd5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f74f89e594d in clone () from /lib64/libc.so.6

Thread 2 (Thread 0x7f74abdff700 (LWP 3872)):
#0  0x00007f74f8cbf8f5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x000055b9c76d4094 in qemu_cond_wait (cond=0x55b9c902f010, mutex=0x55b9c902f048)
    at qemu/util/qemu-thread-posix.c:161
#2  0x000055b9c75b5149 in vnc_worker_thread_loop (queue=0x55b9c902f010)
    at qemu/ui/vnc-jobs.c:205
#3  0x000055b9c75b568c in vnc_worker_thread (arg=0x55b9c902f010) at qemu/ui/vnc-jobs.c:312
#4  0x00007f74f8cbbdd5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007f74f89e594d in clone () from /lib64/libc.so.6

Thread 1 (Thread 0x7f74fdf24c80 (LWP 3865)):
#0  flatview_read_full (fv=0x7f74ec325eb0, addr=0x201520, attrs=..., buf=0x7ffcdf8a9040 "!\001\200", len=0x8)
    at qemu/exec.c:3114
#1  0x000055b9c71c2225 in flatview_read (len=0x8, buf=0x7ffcdf8a9040 "!\001\200", attrs=..., addr=0x201520,
    fv=0x7f74ec325eb0) at qemu/include/exec/memory.h:1946
#2  flatview_rw (fv=0x7f74ec325eb0, addr=0x201520, attrs=..., buf=0x7ffcdf8a9040 "!\001\200", len=0x8, is_write=0x0)
    at qemu/exec.c:3131
#3  0x000055b9c71c2294 in address_space_rw (as=0x55b9c7fbefe0 <address_space_memory>, addr=0x201520, attrs=...,
    buf=0x7ffcdf8a9040 "!\001\200", len=0x8, is_write=0x0) at qemu/exec.c:3139
#4  0x000055b9c71c22ef in cpu_physical_memory_rw (addr=0x201520, buf=0x7ffcdf8a9040 "!\001\200", len=0x8,
    is_write=0x0) at qemu/exec.c:3146
#5  0x000055b9c732c4c4 in cpu_physical_memory_read (addr=0x201520, buf=0x7ffcdf8a9040, len=0x8)
    at qemu/include/exec/cpu-common.h:83
#6  0x000055b9c732d770 in mem_info_la48 (mon=0x55b9c86b7610, env=0x55b9c890be50)
    at qemu/target/i386/monitor.c:402
#7  0x000055b9c732dfb0 in hmp_info_mem (mon=0x55b9c86b7610, qdict=0x55b9c94d0e00)
    at qemu/target/i386/monitor.c:551
#8  0x000055b9c7200fbb in handle_hmp_command (mon=0x55b9c86b7610, cmdline=0x55b9c8721028 "")
    at qemu/monitor.c:3110
#9  0x000055b9c7203168 in monitor_command_cb (opaque=0x55b9c86b7610, cmdline=0x55b9c8721020 "info mem",
    readline_opaque=0x0) at qemu/monitor.c:3913
#10 0x000055b9c76ebe4b in readline_handle_byte (rs=0x55b9c8721020, ch=0xd)
    at qemu/util/readline.c:393
#11 0x000055b9c72030c2 in monitor_read (opaque=0x55b9c86b7610, buf=0x7ffcdf8a9260 "\r", size=0x1)
    at qemu/monitor.c:3896
#12 0x000055b9c765b11c in qemu_chr_be_write_impl (s=0x55b9c86a4ed0, buf=0x7ffcdf8a9260 "\r", len=0x1)
    at qemu/chardev/char.c:167
#13 0x000055b9c765b184 in qemu_chr_be_write (s=0x55b9c86a4ed0, buf=0x7ffcdf8a9260 "\r", len=0x1)
    at qemu/chardev/char.c:179
#14 0x000055b9c765d828 in fd_chr_read (chan=0x55b9c86a50d0, cond=G_IO_IN, opaque=0x55b9c86a4ed0)
    at qemu/chardev/char-fd.c:66
#15 0x000055b9c76783c5 in qio_channel_fd_source_dispatch (source=0x55b9c94ba330,
    callback=0x55b9c765d6c9 <fd_chr_read>, user_data=0x55b9c86a4ed0)
    at qemu/io/channel-watch.c:84
#16 0x00007f74fd4188f9 in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
#17 0x000055b9c76cf9b0 in glib_pollfds_poll () at qemu/util/main-loop.c:214
#18 0x000055b9c76cfaa1 in os_host_main_loop_wait (timeout=0xecc848)
    at qemu/util/main-loop.c:261
#19 0x000055b9c76cfb5d in main_loop_wait (nonblocking=0x0) at qemu/util/main-loop.c:515
#20 0x000055b9c734b2bc in main_loop () at qemu/vl.c:1995
#21 0x000055b9c735314f in main (argc=0x8, argv=0x7ffcdf8aa808, envp=0x7ffcdf8aa850)
    at qemu/vl.c:4911


> 
> Paolo
> 
