Received: from eggs.gnu.org ([2001:4830:134:3::10]:38385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noirfate@gmail.com>) id 1gMPUN-00083O-DK
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noirfate@gmail.com>) id 1gMPUK-0005bT-ET
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:35:43 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <noirfate@gmail.com>) id 1gMPUK-0005a6-0V
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 22:35:40 -0500
Received: by mail-pf1-x443.google.com with SMTP id u3-v6so2640878pfm.4
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 19:35:37 -0800 (PST)
MIME-Version: 1.0
References: <154155007870.439125.16160474206652257208.stgit@bahia.lan>
	<CACcO5F4FBW9QiaTA1w61z5pwt6Z3F1n73=rL4Af=6-K5zq0-EQ@mail.gmail.com>
	<20181112110021.734d25d5@bahia.lan>
	<CACcO5F6YsaQX80cn-wxcreDNRcKKKqEaT65Ax4AaBCKMwC2JNw@mail.gmail.com>
	<20181112121929.1344f12d@bahia.lan> <20181112153911.08842765@bahia.lan>
In-Reply-To: <20181112153911.08842765@bahia.lan>
From: zhibin hu <noirfate@gmail.com>
Date: Tue, 13 Nov 2018 11:35:23 +0800
Message-ID: <CACcO5F4nx051=TAssH-Br2UopS0OkzW5F3nws412ZhXpnGtHYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] 9p: write lock path in v9fs_co_open2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: qemu-devel@nongnu.org, prasad@redhat.com

Sorry, i have no time to make poc recently.

IMHO, the implementation of v9fs_path_copy is not secure, it first free the
original value and than copy the new value, there is a race.

So each caller must ensure the synchronization, maybe more locks are needed.

thanks.


On Mon, Nov 12, 2018 at 10:39 PM Greg Kurz <groug@kaod.org> wrote:

> On Mon, 12 Nov 2018 12:19:29 +0100
> Greg Kurz <groug@kaod.org> wrote:
>
> > On Mon, 12 Nov 2018 19:05:59 +0800
> > zhibin hu <noirfate@gmail.com> wrote:
> >
> > > yes, and this :
> > >
> >
> > Yeah, all call sites of v9fs_path_copy() in v9fs_create() are called in
> the
> > context of the main thread. They may race with any other access to the
> fid
> > path performed by some other command in the context of a worker thread.
> My
> > first guess is that v9fs_create() should take the write lock before
> writing
> > to the fid path.
> >
>
> I think this call to v9fs_path_copy() in v9fs_walk() can also race:
>
>     if (fid == newfid) {
>         if (fidp->fid_type != P9_FID_NONE) {
>             err = -EINVAL;
>             goto out;
>         }
>         v9fs_path_copy(&fidp->path, &path);
>     } else {
>
>
> Worse, since v9fs_co_open2() may overwrite the fid path from a worker
> thread, it seems that some more code might require to run with the read
> lock taken...
>
> > BTW, if you could share all the reproducers you already have for these
> > heap-use-after-free issues, it would be appreciated, and probably speed
> > up the fixing.
> >
> > > ==6094==ERROR: AddressSanitizer: heap-use-after-free on address
> > > 0x6020000e6751 at pc 0x562a8dc492b8 bp 0x7f6805d2fa10 sp 0x7f6805d2fa00
> > > READ of size 1 at 0x6020000e6751 thread T21
> > >     #0 0x562a8dc492b7 in local_open_nofollow hw/9pfs/9p-local.c:59
> > >     #1 0x562a8dc49361 in local_opendir_nofollow hw/9pfs/9p-local.c:92
> > >     #2 0x562a8dc4bd6e in local_mknod hw/9pfs/9p-local.c:662
> > >     #3 0x562a8dc521de in v9fs_co_mknod hw/9pfs/cofs.c:200
> > >     #4 0x562a8dc4413e in v9fs_mknod hw/9pfs/9p.c:3044
> > >     #5 0x562a8e600976 in coroutine_trampoline
> util/coroutine-ucontext.c:116
> > >     #6 0x7f68713635ff in __correctly_grouped_prefixwc
> > > (/lib64/libc.so.6+0x4c5ff)
> > >
> > > 0x6020000e6751 is located 1 bytes inside of 2-byte region
> > > [0x6020000e6750,0x6020000e6752)
> > > freed by thread T0 here:
> > >     #0 0x7f687cdb9880 in __interceptor_free
> (/lib64/libasan.so.5+0xee880)
> > >     #1 0x7f687c1494d1 in g_free (/lib64/libglib-2.0.so.0+0x524d1)
> > >     #2 0x562a8dc30ce4 in v9fs_path_copy hw/9pfs/9p.c:195
> > >     #3 0x562a8dc3f0f3 in v9fs_create hw/9pfs/9p.c:2286
> > >     #4 0x562a8e600976 in coroutine_trampoline
> util/coroutine-ucontext.c:116
> > >     #5 0x7f68713635ff in __correctly_grouped_prefixwc
> > > (/lib64/libc.so.6+0x4c5ff)
> > >
> > > previously allocated by thread T5 here:
> > >     #0 0x7f687cdb9c48 in malloc (/lib64/libasan.so.5+0xeec48)
> > >     #1 0x7f6871421c37 in __GI___vasprintf_chk
> (/lib64/libc.so.6+0x10ac37)
> > >
> > > Thread T21 created by T0 here:
> > >     #0 0x7f687cd16443 in pthread_create (/lib64/libasan.so.5+0x4b443)
> > >     #1 0x562a8e5bf61e in qemu_thread_create
> util/qemu-thread-posix.c:534
> > >     #2 0x562a8e5adbe4 in do_spawn_thread util/thread-pool.c:135
> > >     #3 0x562a8e5adc73 in spawn_thread_bh_fn util/thread-pool.c:143
> > >     #4 0x562a8e5aa4d0 in aio_bh_call util/async.c:90
> > >     #5 0x562a8e5aa787 in aio_bh_poll util/async.c:118
> > >     #6 0x562a8e5b65bd in aio_dispatch util/aio-posix.c:436
> > >     #7 0x562a8e5ab26f in aio_ctx_dispatch util/async.c:261
> > >     #8 0x7f687c1438ac in g_main_context_dispatch
> > > (/lib64/libglib-2.0.so.0+0x4c8ac)
> > >
> > > Thread T5 created by T0 here:
> > >     #0 0x7f687cd16443 in pthread_create (/lib64/libasan.so.5+0x4b443)
> > >     #1 0x562a8e5bf61e in qemu_thread_create
> util/qemu-thread-posix.c:534
> > >     #2 0x562a8d7a2258 in qemu_kvm_start_vcpu
> /root/qemu-3.0.0/cpus.c:1935
> > >     #3 0x562a8d7a2a0b in qemu_init_vcpu /root/qemu-3.0.0/cpus.c:2001
> > >     #4 0x562a8da3ef0c in x86_cpu_realizefn
> > > /root/qemu-3.0.0/target/i386/cpu.c:4996
> > >     #5 0x562a8dd3a1e8 in device_set_realized hw/core/qdev.c:826
> > >     #6 0x562a8e2a1e62 in property_set_bool qom/object.c:1984
> > >     #7 0x562a8e29db0e in object_property_set qom/object.c:1176
> > >     #8 0x562a8e2a4b00 in object_property_set_qobject
> qom/qom-qobject.c:27
> > >     #9 0x562a8e29de2b in object_property_set_bool qom/object.c:1242
> > >     #10 0x562a8d9ad452 in pc_new_cpu /root/qemu-3.0.0/hw/i386/pc.c:1107
> > >     #11 0x562a8d9ad993 in pc_cpus_init
> /root/qemu-3.0.0/hw/i386/pc.c:1155
> > >     #12 0x562a8d9b79cb in pc_init1
> /root/qemu-3.0.0/hw/i386/pc_piix.c:153
> > >     #13 0x562a8d9b981d in pc_init_v3_0
> > > /root/qemu-3.0.0/hw/i386/pc_piix.c:438
> > >     #14 0x562a8dd4bf29 in machine_run_board_init hw/core/machine.c:830
> > >     #15 0x562a8db8d46e in main /root/qemu-3.0.0/vl.c:4516
> > >     #16 0x7f687133a11a in __libc_start_main (/lib64/libc.so.6+0x2311a)
> > >
> > > SUMMARY: AddressSanitizer: heap-use-after-free hw/9pfs/9p-local.c:59 in
> > > local_open_nofollow
> > > Shadow bytes around the buggy address:
> > >   0x0c0480014c90: fa fa fd fa fa fa fa fa fa fa fa fa fa fa fa fa
> > >   0x0c0480014ca0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> > >   0x0c0480014cb0: fa fa fa fa fa fa fd fd fa fa fd fa fa fa fd fa
> > >   0x0c0480014cc0: fa fa fa fa fa fa fa fa fa fa fd fd fa fa fd fa
> > >   0x0c0480014cd0: fa fa fa fa fa fa fa fa fa fa fd fa fa fa fd fd
> > > =>0x0c0480014ce0: fa fa fa fa fa fa fd fa fa fa[fd]fa fa fa fa fa
> > >   0x0c0480014cf0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fd fd
> > >   0x0c0480014d00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> > >   0x0c0480014d10: fa fa fd fa fa fa fd fd fa fa fa fa fa fa fa fa
> > >   0x0c0480014d20: fa fa fa fa fa fa fd fa fa fa fa fa fa fa fd fa
> > >   0x0c0480014d30: fa fa fa fa fa fa fd fd fa fa fa fa fa fa fa fa
> > > Shadow byte legend (one shadow byte represents 8 application bytes):
> > >   Addressable:           00
> > >   Partially addressable: 01 02 03 04 05 06 07
> > >   Heap left redzone:       fa
> > >   Freed heap region:       fd
> > >   Stack left redzone:      f1
> > >   Stack mid redzone:       f2
> > >   Stack right redzone:     f3
> > >   Stack after return:      f5
> > >   Stack use after scope:   f8
> > >   Global redzone:          f9
> > >   Global init order:       f6
> > >   Poisoned by user:        f7
> > >   Container overflow:      fc
> > >   Array cookie:            ac
> > >   Intra object redzone:    bb
> > >   ASan internal:           fe
> > >   Left alloca redzone:     ca
> > >   Right alloca redzone:    cb
> > > ==6094==ABORTING
> > >
> > > thanks.
> > >
> > > On Mon, Nov 12, 2018 at 6:00 PM Greg Kurz <groug@kaod.org> wrote:
> > >
> > > > On Mon, 12 Nov 2018 16:28:28 +0800
> > > > zhibin hu <noirfate@gmail.com> wrote:
> > > >
> > > > > hi,
> > > > >
> > > > > i use this patch with qemu 3.0.0 and it seems not fix completely.
> > > > >
> > > > > [root@localhost ~]# ./qemu-system-x86_64 -snapshot -m 1024 -smp 2
> > > > > -enable-kvm -net nic,model=e1000 -net
> > > > > tap,helper=/usr/libexec/qemu-bridge-helper -hda
> > > > > /var/lib/libvirt/images/test.qcow2 -fsdev
> > > > > local,id=test_dev,path=/tmp,security_model=none -device
> > > > > virtio-9p-pci,fsdev=test_dev,mount_tag=test_mount -vnc 0.0.0.0:1
> > > > > ==5014==WARNING: ASan doesn't fully support makecontext/swapcontext
> > > > > functions and may produce false positives in some cases!
> > > > > =================================================================
> > > > > ==5014==ERROR: AddressSanitizer: heap-use-after-free on address
> > > > > 0x60200014fc50 at pc 0x7f90c908697d bp 0x7f9053444970 sp
> 0x7f9053444118
> > > > > READ of size 2 at 0x60200014fc50 thread T17
> > > > >     #0 0x7f90c908697c  (/lib64/libasan.so.5+0x9997c)
> > > > >     #1 0x7f90c8452693 in g_path_get_basename
> > > > > (/lib64/libglib-2.0.so.0+0x39693)
> > > > >     #2 0x559c1b78eb56 in local_lstat hw/9pfs/9p-local.c:182
> > > > >     #3 0x559c1b799628 in v9fs_co_lstat hw/9pfs/cofile.c:53
> > > > >     #4 0x559c1b777ee1 in fid_to_qid hw/9pfs/9p.c:598
> > > > >     #5 0x559c1b77aeae in v9fs_attach hw/9pfs/9p.c:1017
> > > > >     #6 0x559c1c145976 in coroutine_trampoline
> > > > util/coroutine-ucontext.c:116
> > > > >     #7 0x7f90bd6855ff in __correctly_grouped_prefixwc
> > > > > (/lib64/libc.so.6+0x4c5ff)
> > > > >
> > > > > 0x60200014fc50 is located 0 bytes inside of 2-byte region
> > > > > [0x60200014fc50,0x60200014fc52)
> > > > > freed by thread T0 here:
> > > > >     #0 0x7f90c90db880 in __interceptor_free
> (/lib64/libasan.so.5+0xee880)
> > > > >     #1 0x7f90c846b4d1 in g_free (/lib64/libglib-2.0.so.0+0x524d1)
> > > > >     #2 0x559c1b775ce4 in v9fs_path_copy hw/9pfs/9p.c:195
> > > > >     #3 0x559c1b78425d in v9fs_create hw/9pfs/9p.c:2297
> > > >
> > > > Ah, so we have a similar issue when creating files with the older
> > > > 9p2000 and 9p2000.u protocols... I'll try to come up with a fix.
> > > >
> > > > Cheers,
> > > >
> > > > --
> > > > Greg
> > > >
> > > > >     #4 0x559c1c145976 in coroutine_trampoline
> > > > util/coroutine-ucontext.c:116
> > > > >     #5 0x7f90bd6855ff in __correctly_grouped_prefixwc
> > > > > (/lib64/libc.so.6+0x4c5ff)
> > > > >
> > > > > previously allocated by thread T4 here:
> > > > >     #0 0x7f90c90dbc48 in malloc (/lib64/libasan.so.5+0xeec48)
> > > > >     #1 0x7f90bd743c37 in __GI___vasprintf_chk
> (/lib64/libc.so.6+0x10ac37)
> > > > >
> > > > > Thread T17 created by T16 here:
> > > > >     #0 0x7f90c9038443 in pthread_create
> (/lib64/libasan.so.5+0x4b443)
> > > > >     #1 0x559c1c10461e in qemu_thread_create
> util/qemu-thread-posix.c:534
> > > > >     #2 0x559c1c0f2be4 in do_spawn_thread util/thread-pool.c:135
> > > > >     #3 0x559c1c0f2498 in worker_thread util/thread-pool.c:83
> > > > >     #4 0x559c1c1043e0 in qemu_thread_start
> util/qemu-thread-posix.c:504
> > > > >     #5 0x7f90bd9ff593 in start_thread
> (/lib64/libpthread.so.0+0x7593)
> > > > >
> > > > > Thread T16 created by T0 here:
> > > > >     #0 0x7f90c9038443 in pthread_create
> (/lib64/libasan.so.5+0x4b443)
> > > > >     #1 0x559c1c10461e in qemu_thread_create
> util/qemu-thread-posix.c:534
> > > > >     #2 0x559c1c0f2be4 in do_spawn_thread util/thread-pool.c:135
> > > > >     #3 0x559c1c0f2c73 in spawn_thread_bh_fn util/thread-pool.c:143
> > > > >     #4 0x559c1c0ef4d0 in aio_bh_call util/async.c:90
> > > > >     #5 0x559c1c0ef787 in aio_bh_poll util/async.c:118
> > > > >     #6 0x559c1c0fb5bd in aio_dispatch util/aio-posix.c:436
> > > > >     #7 0x559c1c0f026f in aio_ctx_dispatch util/async.c:261
> > > > >     #8 0x7f90c84658ac in g_main_context_dispatch
> > > > > (/lib64/libglib-2.0.so.0+0x4c8ac)
> > > > >
> > > > > Thread T4 created by T0 here:
> > > > >     #0 0x7f90c9038443 in pthread_create
> (/lib64/libasan.so.5+0x4b443)
> > > > >     #1 0x559c1c10461e in qemu_thread_create
> util/qemu-thread-posix.c:534
> > > > >     #2 0x559c1b2e7258 in qemu_kvm_start_vcpu
> /root/qemu-3.0.0/cpus.c:1935
> > > > >     #3 0x559c1b2e7a0b in qemu_init_vcpu
> /root/qemu-3.0.0/cpus.c:2001
> > > > >     #4 0x559c1b583f0c in x86_cpu_realizefn
> > > > > /root/qemu-3.0.0/target/i386/cpu.c:4996
> > > > >     #5 0x559c1b87f1e8 in device_set_realized hw/core/qdev.c:826
> > > > >     #6 0x559c1bde6e62 in property_set_bool qom/object.c:1984
> > > > >     #7 0x559c1bde2b0e in object_property_set qom/object.c:1176
> > > > >     #8 0x559c1bde9b00 in object_property_set_qobject
> qom/qom-qobject.c:27
> > > > >     #9 0x559c1bde2e2b in object_property_set_bool qom/object.c:1242
> > > > >     #10 0x559c1b4f2452 in pc_new_cpu
> /root/qemu-3.0.0/hw/i386/pc.c:1107
> > > > >     #11 0x559c1b4f2993 in pc_cpus_init
> /root/qemu-3.0.0/hw/i386/pc.c:1155
> > > > >     #12 0x559c1b4fc9cb in pc_init1
> /root/qemu-3.0.0/hw/i386/pc_piix.c:153
> > > > >     #13 0x559c1b4fe81d in pc_init_v3_0
> > > > > /root/qemu-3.0.0/hw/i386/pc_piix.c:438
> > > > >     #14 0x559c1b890f29 in machine_run_board_init
> hw/core/machine.c:830
> > > > >     #15 0x559c1b6d246e in main /root/qemu-3.0.0/vl.c:4516
> > > > >     #16 0x7f90bd65c11a in __libc_start_main
> (/lib64/libc.so.6+0x2311a)
> > > > >
> > > > > SUMMARY: AddressSanitizer: heap-use-after-free
> > > > > (/lib64/libasan.so.5+0x9997c)
> > > > > Shadow bytes around the buggy address:
> > > > >   0x0c0480021f30: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> > > > >   0x0c0480021f40: fa fa fd fa fa fa fd fd fa fa fa fa fa fa fa fa
> > > > >   0x0c0480021f50: fa fa fa fa fa fa fa fa fa fa fd fa fa fa fd fd
> > > > >   0x0c0480021f60: fa fa fd fa fa fa fa fa fa fa fd fa fa fa fa fa
> > > > >   0x0c0480021f70: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fd fa
> > > > > =>0x0c0480021f80: fa fa fa fa fa fa fd fa fa fa[fd]fa fa fa fd fa
> > > > >   0x0c0480021f90: fa fa fd fd fa fa fd fa fa fa fa fa fa fa fd fa
> > > > >   0x0c0480021fa0: fa fa fd fa fa fa fd fa fa fa fd fa fa fa fa fa
> > > > >   0x0c0480021fb0: fa fa fd fa fa fa fa fa fa fa fa fa fa fa fd fd
> > > > >   0x0c0480021fc0: fa fa fd fa fa fa fa fa fa fa fa fa fa fa fd fa
> > > > >   0x0c0480021fd0: fa fa fd fa fa fa fd fa fa fa fa fa fa fa fd fa
> > > > > Shadow byte legend (one shadow byte represents 8 application
> bytes):
> > > > >   Addressable:           00
> > > > >   Partially addressable: 01 02 03 04 05 06 07
> > > > >   Heap left redzone:       fa
> > > > >   Freed heap region:       fd
> > > > >   Stack left redzone:      f1
> > > > >   Stack mid redzone:       f2
> > > > >   Stack right redzone:     f3
> > > > >   Stack after return:      f5
> > > > >   Stack use after scope:   f8
> > > > >   Global redzone:          f9
> > > > >   Global init order:       f6
> > > > >   Poisoned by user:        f7
> > > > >   Container overflow:      fc
> > > > >   Array cookie:            ac
> > > > >   Intra object redzone:    bb
> > > > >   ASan internal:           fe
> > > > >   Left alloca redzone:     ca
> > > > >   Right alloca redzone:    cb
> > > > > ==5014==ABORTING
> > > > >
> > > > > thanks.
> > > > >
> > > > > On Wed, Nov 7, 2018 at 8:21 AM Greg Kurz <groug@kaod.org> wrote:
> > > > >
> > > > > > The assumption that the fid cannot be used by any other
> operation is
> > > > > > wrong. At least, nothing prevents a misbehaving client to create
> a
> > > > > > file with a given fid, and to pass this fid to some other
> operation
> > > > > > at the same time (ie, without waiting for the response to the
> creation
> > > > > > request). The call to v9fs_path_copy() performed by the worker
> thread
> > > > > > after the file was created can race with any access to the fid
> path
> > > > > > performed by some other thread. This causes use-after-free
> issues that
> > > > > > can be detected by ASAN with a custom 9p client.
> > > > > >
> > > > > > Unlike other operations that only read the fid path,
> v9fs_co_open2()
> > > > > > does modify it. It should hence take the write lock.
> > > > > >
> > > > > > Cc: P J P <ppandit@redhat.com>
> > > > > > Reported-by: zhibin hu <noirfate@gmail.com>
> > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > > ---
> > > > > >  hw/9pfs/cofile.c |    6 +++---
> > > > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
> > > > > > index 88791bc327ac..9c22837cda32 100644
> > > > > > --- a/hw/9pfs/cofile.c
> > > > > > +++ b/hw/9pfs/cofile.c
> > > > > > @@ -140,10 +140,10 @@ int coroutine_fn v9fs_co_open2(V9fsPDU
> *pdu,
> > > > > > V9fsFidState *fidp,
> > > > > >      cred.fc_gid = gid;
> > > > > >      /*
> > > > > >       * Hold the directory fid lock so that directory path name
> > > > > > -     * don't change. Read lock is fine because this fid cannot
> > > > > > -     * be used by any other operation.
> > > > > > +     * don't change. Take the write lock to be sure this fid
> > > > > > +     * cannot be used by another operation.
> > > > > >       */
> > > > > > -    v9fs_path_read_lock(s);
> > > > > > +    v9fs_path_write_lock(s);
> > > > > >      v9fs_co_run_in_worker(
> > > > > >          {
> > > > > >              err = s->ops->open2(&s->ctx, &fidp->path,
> > > > > >
> > > > > >
> > > >
> > > >
> >
>
>
