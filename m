Received: from eggs.gnu.org ([2001:4830:134:3::10]:51944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2bcz-00038F-43
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d2bcu-0006RD-7r
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d2bct-0006Pu-UP
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:53:52 -0400
Date: Mon, 24 Apr 2017 11:53:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170424105344.GF2362@work-vm>
References: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <70ef6f1f-27f4-133f-ab33-03a30f19867b@de.ibm.com>
Subject: Re: [Qemu-devel] postcopy migration hangs while loading virtio state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

* Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> David, Juan,
>=20
> I can trigger a hang of postcopy migration (when I do it early) so that
> both sides are in paused state. Looks like one thread is still loading
> vmstates for virtio and this load accesses guest memory and triggers
> a userfault.=20

It's perfectly legal for the destination to cause a userfault as it loads t=
he
virtio queue - the virtio queue should be being loaded by the main thread
=66rom the buffer while the 'listening' thread is waiting for the incoming
page data.

Can you turn on the following tracing please:
  destination:
    postcopy_ram_fault_thread_request
    postcopy_place_page
    postcopy_place_page_zero

  source:
    migrate_handle_rp_req_pages
    ram_save_queue_pages

You should see:
    virtio does the access
    userfault generates a fault
    postcopy_ram_fault_thread_request sends the request to the source

    the source sees migrate_handle_rp_req_pages
    queues it with ram_save_queue_pages

    the destination sees the page arrive and
    postcopy_place_page or postcopy_place_page_zero

some of that might disappear if the page was already on it's way.

Dave

> Thread 1 (Thread 0x3ffa2f45f00 (LWP 21122)):
> #0  0x0000000001017130 in lduw_he_p (ptr=3D0x3ff498d9002) at /root/qemu/i=
nclude/qemu/bswap.h:317
> 		<---- according to the host kernel this threads hangs in handle_userfau=
lt.
> #1  0x0000000001017342 in lduw_le_p (ptr=3D0x3ff498d9002) at /root/qemu/i=
nclude/qemu/bswap.h:359
> #2  0x0000000001025840 in address_space_lduw_internal_cached (cache=3D0x2=
83491d0, addr=3D2, attrs=3D..., result=3D0x0, endian=3DDEVICE_LITTLE_ENDIAN=
) at /root/qemu/memory_ldst.inc.c:284
> #3  0x00000000010259a6 in address_space_lduw_le_cached (cache=3D0x283491d=
0, addr=3D2, attrs=3D..., result=3D0x0) at /root/qemu/memory_ldst.inc.c:315
> #4  0x0000000001025ad6 in lduw_le_phys_cached (cache=3D0x283491d0, addr=
=3D2) at /root/qemu/memory_ldst.inc.c:334
> #5  0x0000000001116c10 in virtio_lduw_phys_cached (vdev=3D0x28275090, cac=
he=3D0x283491d0, pa=3D2) at /root/qemu/include/hw/virtio/virtio-access.h:166
> #6  0x0000000001117940 in vring_used_idx (vq=3D0x3ffa2e1c090) at /root/qe=
mu/hw/virtio/virtio.c:263
> #7  0x000000000111daea in virtio_load (vdev=3D0x28275090, f=3D0x28353600,=
 version_id=3D2) at /root/qemu/hw/virtio/virtio.c:2168
> #8  0x000000000111d0cc in virtio_device_get (f=3D0x28353600, opaque=3D0x2=
8275090, size=3D0, field=3D0x16adf38 <__compound_literal.0>) at /root/qemu/=
hw/virtio/virtio.c:1975
> #9  0x00000000012a7f50 in vmstate_load_state (f=3D0x28353600, vmsd=3D0x14=
db480 <vmstate_virtio_blk>, opaque=3D0x28275090, version_id=3D2) at /root/q=
emu/migration/vmstate.c:128
> #10 0x00000000010cbc08 in vmstate_load (f=3D0x28353600, se=3D0x28279e60, =
version_id=3D2) at /root/qemu/migration/savevm.c:732
> #11 0x00000000010ced6e in qemu_loadvm_section_start_full (f=3D0x28353600,=
 mis=3D0x17169a8 <mis_current>) at /root/qemu/migration/savevm.c:1890
> #12 0x00000000010cf00c in qemu_loadvm_state_main (f=3D0x28353600, mis=3D0=
x17169a8 <mis_current>) at /root/qemu/migration/savevm.c:1947
> #13 0x00000000010ce5bc in loadvm_handle_cmd_packaged (mis=3D0x17169a8 <mi=
s_current>) at /root/qemu/migration/savevm.c:1707
> #14 0x00000000010ce87e in loadvm_process_command (f=3D0x282c7d20) at /roo=
t/qemu/migration/savevm.c:1770
> #15 0x00000000010cf056 in qemu_loadvm_state_main (f=3D0x282c7d20, mis=3D0=
x17169a8 <mis_current>) at /root/qemu/migration/savevm.c:1960
> #16 0x00000000010cf2b6 in qemu_loadvm_state (f=3D0x282c7d20) at /root/qem=
u/migration/savevm.c:2020
> #17 0x000000000129d234 in process_incoming_migration_co (opaque=3D0x282c7=
d20) at /root/qemu/migration/migration.c:404
> #18 0x00000000014b6ca2 in coroutine_trampoline (i0=3D0, i1=3D674533168) a=
t /root/qemu/util/coroutine-ucontext.c:79
> #19 0x000003ff8de530ea in __makecontext_ret () from target:/lib64/libc.so=
=2E6
>=20
> Thread 8 (Thread 0x3ff40b38910 (LWP 21165)):
> #0  0x000003ff8df04336 in syscall () from target:/lib64/libc.so.6
> #1  0x00000000014933ce in qemu_futex_wait (f=3D0x17169b0 <mis_current+8>,=
 val=3D4294967295) at /root/qemu/include/qemu/futex.h:26
> #2  0x00000000014935d0 in qemu_event_wait (ev=3D0x17169b0 <mis_current+8>=
) at /root/qemu/util/qemu-thread-posix.c:399
> #3  0x00000000010ce094 in postcopy_ram_listen_thread (opaque=3D0x282c7d20=
) at /root/qemu/migration/savevm.c:1532
> #4  0x000003ff8e007bc4 in start_thread () from target:/lib64/libpthread.s=
o.0
> #5  0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>=20
> Thread 7 (Thread 0x3ff41338910 (LWP 21164)):
> #0  0x000003ff8defd72c in ?? () from target:/lib64/libc.so.6
> #1  0x00000000012af920 in postcopy_ram_fault_thread (opaque=3D0x17169a8 <=
mis_current>) at /root/qemu/migration/postcopy-ram.c:437
> #2  0x000003ff8e007bc4 in start_thread () from target:/lib64/libpthread.s=
o.0
> #3  0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>=20
> Thread 6 (Thread 0x3ff41b38910 (LWP 21163)):
> #0  0x000003ff8e00d450 in pthread_cond_wait@@GLIBC_2.3.2 () from target:/=
lib64/libpthread.so.0
> #1  0x0000000001492d66 in qemu_cond_wait (cond=3D0x28302408, mutex=3D0x28=
3023e0) at /root/qemu/util/qemu-thread-posix.c:133
> #2  0x00000000010c6080 in do_data_decompress (opaque=3D0x283023d8) at /ro=
ot/qemu/migration/ram.c:2277
> #3  0x000003ff8e007bc4 in start_thread () from target:/lib64/libpthread.s=
o.0
> #4  0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>=20
> Thread 5 (Thread 0x3ff42338910 (LWP 21162)):
> #0  0x000003ff8e00d450 in pthread_cond_wait@@GLIBC_2.3.2 () from target:/=
lib64/libpthread.so.0
> #1  0x0000000001492d66 in qemu_cond_wait (cond=3D0x28302390, mutex=3D0x28=
302368) at /root/qemu/util/qemu-thread-posix.c:133
> #2  0x00000000010c6080 in do_data_decompress (opaque=3D0x28302360) at /ro=
ot/qemu/migration/ram.c:2277
> #3  0x000003ff8e007bc4 in start_thread () from target:/lib64/libpthread.s=
o.0
> #4  0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>=20
> Thread 4 (Thread 0x3ff89287910 (LWP 21148)):
> #0  0x000003ff8e010abc in __lll_lock_wait () from target:/lib64/libpthrea=
d.so.0
> #1  0x000003ff8e00bcb6 in __pthread_mutex_cond_lock () from target:/lib64=
/libpthread.so.0
> #2  0x000003ff8e00d4ee in pthread_cond_wait@@GLIBC_2.3.2 () from target:/=
lib64/libpthread.so.0
> #3  0x0000000001492d66 in qemu_cond_wait (cond=3D0x2831eb00, mutex=3D0x17=
11688 <qemu_global_mutex>) at /root/qemu/util/qemu-thread-posix.c:133
> #4  0x000000000107720e in qemu_kvm_wait_io_event (cpu=3D0x282e09b0) at /r=
oot/qemu/cpus.c:1085
> #5  0x00000000010773aa in qemu_kvm_cpu_thread_fn (arg=3D0x282e09b0) at /r=
oot/qemu/cpus.c:1123
> #6  0x000003ff8e007bc4 in start_thread () from target:/lib64/libpthread.s=
o.0
> #7  0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>=20
> Thread 3 (Thread 0x3ff8a7ff910 (LWP 21145)):
> #0  0x000003ff8defd832 in ppoll () from target:/lib64/libc.so.6
> #1  0x000000000148b092 in qemu_poll_ns (fds=3D0x3ff840008c0, nfds=3D1, ti=
meout=3D-1) at /root/qemu/util/qemu-timer.c:322
> #2  0x000000000148f46a in aio_poll (ctx=3D0x2827e7b0, blocking=3Dtrue) at=
 /root/qemu/util/aio-posix.c:622
> #3  0x00000000011a78f6 in iothread_run (opaque=3D0x2827d740) at /root/qem=
u/iothread.c:59
> #4  0x000003ff8e007bc4 in start_thread () from target:/lib64/libpthread.s=
o.0
> #5  0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>=20
> Thread 2 (Thread 0x3ff8afff910 (LWP 21142)):
> #0  0x000003ff8df04336 in syscall () from target:/lib64/libc.so.6
> #1  0x00000000014933ce in qemu_futex_wait (f=3D0x1b2b9b4 <rcu_call_ready_=
event>, val=3D4294967295) at /root/qemu/include/qemu/futex.h:26
> #2  0x00000000014935d0 in qemu_event_wait (ev=3D0x1b2b9b4 <rcu_call_ready=
_event>) at /root/qemu/util/qemu-thread-posix.c:399
> #3  0x00000000014b3e40 in call_rcu_thread (opaque=3D0x0) at /root/qemu/ut=
il/rcu.c:249
> #4  0x000003ff8e007bc4 in start_thread () from target:/lib64/libpthread.s=
o.0
> #5  0x000003ff8df0a9f2 in thread_start () from target:/lib64/libc.so.6
>=20
>=20
> Looks like that this
>     <qemu:arg value=3D'-drive'/>
>     <qemu:arg value=3D'driver=3Dnull-aio,id=3Dnull1,if=3Dnone,size=3D100G=
'/>
>     <qemu:arg value=3D'-device'/>
>     <qemu:arg value=3D'virtio-blk-ccw,scsi=3Doff,drive=3Dnull1,serial=3Dn=
ull1,num-queues=3D4'/>
>=20
> is necessary to trigger the hang, with nun-qeues=3D1 everything seems to =
work fine, so it might
> be a virtio issue after all?
>=20
> Any idea?
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
