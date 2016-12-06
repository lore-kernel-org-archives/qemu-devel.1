Received: from eggs.gnu.org ([2001:4830:134:3::10]:59152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cEDNj-0005LC-Sx
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cEDNe-0007n2-SM
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:53:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cEDNe-0007mo-JS
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:53:50 -0500
Date: Tue, 6 Dec 2016 10:53:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161206105344.GD2125@work-vm>
References: <20161202174015.GE15373@work-vm>
	<1480926783.28320.9.camel@redhat.com>
	<20161205094646.GA2508@work-vm>
	<62f28da2-a81b-e0f8-32b7-6e75f197750b@redhat.com>
	<1481007570.20373.3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481007570.20373.3.camel@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] Postcopy+spice crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: uril@redhat.com, qemu-devel@nongnu.org, spice-devel <spice-devel@freedesktop.org>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
> 
> > >> On a quick glance I'd blame the guest for sending corrupted commands.
> > >> Strange though that it happens on migration only, so there could be
> > >> a host issue too.  Or a timing issue triggered by migration.
> > >>
> > >> Which migration phase?
> > >
> > > This is the point at which it switches over in postcopy.
> > 
> > It looks like it's the vmstate (post) load phase of the qxl device on
> > destination host.
> 
> Dave, can you try "thread apply all bt" so we see the other threads too?
> That should show whenever it happens in post_load

Yes, I already have the full set of threads; you can see the qxl_post_load in
thread 1.

red_dispatcher_loadvm_commands: 
id 0, group 0, virt start 0, virt end ffffffffffffffff, generation 0, delta 0
id 1, group 1, virt start 7fbe83c00000, virt end 7fbe87bfe000, generation 0, delta 7fbe83c00000
id 2, group 1, virt start 7fbe7fa00000, virt end 7fbe83a00000, generation 0, delta 7fbe7fa00000
(./x86_64-softmmu/qemu-system-x86_64:22376): Spice-CRITICAL **: red_memslots.c:123:get_virt: slot_id 128 too big, addr=8000000000000000
Thread 12 (Thread 0x7fc0a0df2700 (LWP 22377)):
#0  0x00007fc0aa42f1bd in __lll_lock_wait () from /lib64/libpthread.so.0
#1  0x00007fc0aa42ad02 in _L_lock_791 () from /lib64/libpthread.so.0
#2  0x00007fc0aa42ac08 in pthread_mutex_lock () from /lib64/libpthread.so.0
#3  0x0000556465736839 in qemu_mutex_lock (mutex=mutex@entry=0x556465d76120 <qemu_global_mutex>) at /root/git/qemu/util/qemu-thread-posix.c:64
#4  0x00005564653e69d6 in qemu_mutex_lock_iothread () at /root/git/qemu/cpus.c:1296
#5  0x000055646574596e in call_rcu_thread (opaque=<optimized out>) at /root/git/qemu/util/rcu.c:257
#6  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#7  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 11 (Thread 0x7fc09f304700 (LWP 22379)):
#0  0x00007fc0aa42c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000556465736999 in qemu_cond_wait (cond=<optimized out>, mutex=mutex@entry=0x556465d76120 <qemu_global_mutex>) at /root/git/qemu/util/qemu-thread-posix.c:137
#2  0x00005564653e6fe3 in qemu_kvm_wait_io_event (cpu=<optimized out>) at /root/git/qemu/cpus.c:964
#3  qemu_kvm_cpu_thread_fn (arg=0x556466688740) at /root/git/qemu/cpus.c:1003
#4  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 10 (Thread 0x7fc09eb03700 (LWP 22380)):
#0  0x00007fc0aa42c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000556465736999 in qemu_cond_wait (cond=<optimized out>, mutex=mutex@entry=0x556465d76120 <qemu_global_mutex>) at /root/git/qemu/util/qemu-thread-posix.c:137
#2  0x00005564653e6fe3 in qemu_kvm_wait_io_event (cpu=<optimized out>) at /root/git/qemu/cpus.c:964
#3  qemu_kvm_cpu_thread_fn (arg=0x5564666ea960) at /root/git/qemu/cpus.c:1003
#4  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 9 (Thread 0x7fc09e302700 (LWP 22381)):
#0  0x00007fc0aa42c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000556465736999 in qemu_cond_wait (cond=<optimized out>, mutex=mutex@entry=0x556465d76120 <qemu_global_mutex>) at /root/git/qemu/util/qemu-thread-posix.c:137
#2  0x00005564653e6fe3 in qemu_kvm_wait_io_event (cpu=<optimized out>) at /root/git/qemu/cpus.c:964
#3  qemu_kvm_cpu_thread_fn (arg=0x55646670a120) at /root/git/qemu/cpus.c:1003
#4  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 8 (Thread 0x7fc09db01700 (LWP 22382)):
#0  0x00007fc0aa42c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000556465736999 in qemu_cond_wait (cond=<optimized out>, mutex=mutex@entry=0x556465d76120 <qemu_global_mutex>) at /root/git/qemu/util/qemu-thread-posix.c:137
#2  0x00005564653e6fe3 in qemu_kvm_wait_io_event (cpu=<optimized out>) at /root/git/qemu/cpus.c:964
#3  qemu_kvm_cpu_thread_fn (arg=0x5564667298d0) at /root/git/qemu/cpus.c:1003
#4  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 7 (Thread 0x7fbe7f9ff700 (LWP 22383)):
#0  0x00007fc0aa42f49d in read () from /lib64/libpthread.so.0
#1  0x00007fc0a8c36c01 in spice_backtrace_gstack () from /lib64/libspice-server.so.1
#2  0x00007fc0a8c3e4f7 in spice_logv () from /lib64/libspice-server.so.1
#3  0x00007fc0a8c3e655 in spice_log () from /lib64/libspice-server.so.1
#4  0x00007fc0a8bfc6de in get_virt () from /lib64/libspice-server.so.1
#5  0x00007fc0a8bfcb73 in red_get_data_chunks_ptr () from /lib64/libspice-server.so.1
#6  0x00007fc0a8bff3fa in red_get_cursor_cmd () from /lib64/libspice-server.so.1
#7  0x00007fc0a8c0fd79 in handle_dev_loadvm_commands () from /lib64/libspice-server.so.1
#8  0x00007fc0a8bf9523 in dispatcher_handle_recv_read () from /lib64/libspice-server.so.1
#9  0x00007fc0a8c1d5a5 in red_worker_main () from /lib64/libspice-server.so.1
#10 0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#11 0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 6 (Thread 0x7fbe7efff700 (LWP 22385)):
#0  0x00007fc0aa42c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000556465736999 in qemu_cond_wait (cond=cond@entry=0x556466ecde00, mutex=mutex@entry=0x556466ecde30) at /root/git/qemu/util/qemu-thread-posix.c:137
#2  0x0000556465680c5b in vnc_worker_thread_loop (queue=queue@entry=0x556466ecde00) at /root/git/qemu/ui/vnc-jobs.c:228
#3  0x0000556465681198 in vnc_worker_thread (arg=0x556466ecde00) at /root/git/qemu/ui/vnc-jobs.c:335
#4  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 5 (Thread 0x7fc0a05f1700 (LWP 22958)):
#0  0x00007fc0aa42c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000556465736999 in qemu_cond_wait (cond=cond@entry=0x556467b89730, mutex=mutex@entry=0x556467b89708) at /root/git/qemu/util/qemu-thread-posix.c:137
#2  0x000055646540a643 in do_data_decompress (opaque=0x556467b89700) at /root/git/qemu/migration/ram.c:2284
#3  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 4 (Thread 0x7fbe7dfff700 (LWP 22959)):
#0  0x00007fc0aa42c6d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64/libpthread.so.0
#1  0x0000556465736999 in qemu_cond_wait (cond=cond@entry=0x556467b897a8, mutex=mutex@entry=0x556467b89780) at /root/git/qemu/util/qemu-thread-posix.c:137
#2  0x000055646540a643 in do_data_decompress (opaque=0x556467b89778) at /root/git/qemu/migration/ram.c:2284
#3  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 3 (Thread 0x7fbe7d7fe700 (LWP 22967)):
#0  0x00007fc0a616ddad in poll () from /lib64/libc.so.6
#1  0x0000556465631868 in poll (__timeout=-1, __nfds=2, __fds=0x7fbe7d7fd990) at /usr/include/bits/poll2.h:46
#2  postcopy_ram_fault_thread (opaque=0x556466c93f10) at /root/git/qemu/migration/postcopy-ram.c:405
#3  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#4  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 2 (Thread 0x7fbe7cffd700 (LWP 22968)):
#0  0x00007fc0a6172ba9 in syscall () from /lib64/libc.so.6
#1  0x0000556465736ca6 in futex_wait (val=<optimized out>, ev=<optimized out>) at /root/git/qemu/util/qemu-thread-posix.c:306
#2  qemu_event_wait (ev=ev@entry=0x556466c93f18) at /root/git/qemu/util/qemu-thread-posix.c:422
#3  0x000055646541044d in postcopy_ram_listen_thread (opaque=0x556467e45740) at /root/git/qemu/migration/savevm.c:1485
#4  0x00007fc0aa428dc5 in start_thread () from /lib64/libpthread.so.0
#5  0x00007fc0a61786ed in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7fc0aead5c40 (LWP 22376)):
#0  0x00007fc0aa42f49d in read () from /lib64/libpthread.so.0
#1  0x00007fc0a8bf9264 in read_safe () from /lib64/libspice-server.so.1
#2  0x00007fc0a8bf9717 in dispatcher_send_message () from /lib64/libspice-server.so.1
#3  0x00007fc0a8bfa0c2 in red_dispatcher_loadvm_commands () from /lib64/libspice-server.so.1
#4  0x000055646556c03d in qxl_spice_loadvm_commands (qxl=qxl@entry=0x55646755b8c0, ext=ext@entry=0x556467a895a0, count=2) at /root/git/qemu/hw/display/qxl.c:219
#5  0x000055646556d15f in qxl_post_load (opaque=0x55646755b8c0, version=<optimized out>) at /root/git/qemu/hw/display/qxl.c:2212
#6  0x000055646562f1b8 in vmstate_load_state (f=f@entry=0x5564666347d0, vmsd=<optimized out>, opaque=0x55646755b8c0, version_id=version_id@entry=21) at /root/git/qemu/migration/vmstate.c:151
#7  0x000055646540f4a1 in vmstate_load (f=0x5564666347d0, se=0x5564676f90a0, version_id=21) at /root/git/qemu/migration/savevm.c:690
#8  0x000055646540f6db in qemu_loadvm_section_start_full (f=f@entry=0x5564666347d0, mis=mis@entry=0x556466c93f10) at /root/git/qemu/migration/savevm.c:1843
#9  0x000055646540f9ac in qemu_loadvm_state_main (f=f@entry=0x5564666347d0, mis=mis@entry=0x556466c93f10) at /root/git/qemu/migration/savevm.c:1900
#10 0x000055646540fd8f in loadvm_handle_cmd_packaged (mis=0x556466c93f10) at /root/git/qemu/migration/savevm.c:1660
#11 loadvm_process_command (f=0x556467e45740) at /root/git/qemu/migration/savevm.c:1723
#12 qemu_loadvm_state_main (f=f@entry=0x556467e45740, mis=mis@entry=0x556466c93f10) at /root/git/qemu/migration/savevm.c:1913
#13 0x0000556465412546 in qemu_loadvm_state (f=f@entry=0x556467e45740) at /root/git/qemu/migration/savevm.c:1973
#14 0x000055646562b4e8 in process_incoming_migration_co (opaque=0x556467e45740) at /root/git/qemu/migration/migration.c:394
#15 0x0000556465746ada in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at /root/git/qemu/util/coroutine-ucontext.c:79
#16 0x00007fc0a60c7cf0 in ?? () from /lib64/libc.so.6
#17 0x00007ffe14885180 in ?? ()
#18 0x0000000000000000 in ?? ()

> > Maybe if you trace qxl device save/load related functions
> > on both src and dst hosts you'll see a difference.
> 
> qxl keeps references to certain commands (create surface for example) in
> qxl device memory, so it can replay them in post_load.  That possibly
> doesn't work correctly with postcopy.

It should; the device memory is just a RAMBlock that's migrated, so if it's
not arrived yet from the source the qxl code will block until postcopy
drags it across; assuming that is that the qxl code on the source isn't
still trying to write to it's copy at the same time, which at this
point it shouldn't.

Dave

> cheers,
>   Gerd
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
