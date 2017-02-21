Received: from eggs.gnu.org ([2001:4830:134:3::10]:47552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgEdm-0007Kc-8J
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cgEdj-0005Tf-0q
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:54:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cgEdi-0005TS-Ks
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:54:14 -0500
References: <1487361200-29966-1-git-send-email-mst@redhat.com>
	<1487361200-29966-13-git-send-email-mst@redhat.com>
	<1487681835.2694.76.camel@redhat.com>
	<c0d16fc6-e149-861d-8f82-5a96619606bd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <83a2d0c9-23a4-32b1-ffe7-b33bbe9ea25d@redhat.com>
Date: Tue, 21 Feb 2017 18:54:09 +0100
MIME-Version: 1.0
In-Reply-To: <c0d16fc6-e149-861d-8f82-5a96619606bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 12/23] virtio: use VRingMemoryRegionCaches
 for avail and used rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 02/21/17 17:25, Laszlo Ersek wrote:
> On 02/21/17 13:57, Gerd Hoffmann wrote:
>> On Fr, 2017-02-17 at 21:54 +0200, Michael S. Tsirkin wrote:
>>> From: Paolo Bonzini <pbonzini@redhat.com>
>>>
>>> The virtio-net change is necessary because it uses virtqueue_fill
>>> and virtqueue_flush instead of the more convenient virtqueue_push.
>>>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> This change breaks ovmf for me, although it isn't obvious to me why.
>> Bisect landed here, and reverting indeed makes things going again.
>=20
> I looked at the patch (on the list) and I don't have the slightest idea
> what's going on. I read the word "cache" in it, so I guess it introduce=
s
> (or exposes) some cache coherency issue.
>=20
>> Using q35 machine type, pcie virtio devices, with the rhel ovmf build
>> (OVMF-20160608b-1.git988715a.el7.noarch).
>>
>> First thing I've tried is swapping virtio-net for another nic,
>> suspecting this change might trigger a bug in the ovmf virtio-net
>> driver, but that didn't change things.
>>
>> Effect is that qemu just exits, without logging some error, looks like=
 a
>> normal guest shutdown.
>=20
> That's very strange (especially given the OVMF log below).
>=20
>> Firmware log doesn't give a clue either, it just
>> stops at some point, again without any error message.  Here are the la=
st
>> lines of the log:
>>
>> SataControllerStart START
>> SataControllerStart error return status =3D Already started
>> SetPciIntLine: [00:1C.0] PciRoot(0x0)/Pci(0x1C,0x0) -> 0x0A
>> SetPciIntLine: [01:00.0] PciRoot(0x0)/Pci(0x1C,0x0)/Pci(0x0,0x0) -> 0x=
0A
>> SetPciIntLine: [00:1C.1] PciRoot(0x0)/Pci(0x1C,0x1) -> 0x0A
>> SetPciIntLine: [02:00.0] PciRoot(0x0)/Pci(0x1C,0x1)/Pci(0x0,0x0) -> 0x=
0A
>> SetPciIntLine: [00:1C.2] PciRoot(0x0)/Pci(0x1C,0x2) -> 0x0A
>> SetPciIntLine: [00:1C.3] PciRoot(0x0)/Pci(0x1C,0x3) -> 0x0A
>> SetPciIntLine: [00:1C.4] PciRoot(0x0)/Pci(0x1C,0x4) -> 0x0A
>> SetPciIntLine: [05:00.0] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x0) -> 0x=
0A
>> SetPciIntLine: [05:00.1] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x1) -> 0x=
0A
>> SetPciIntLine: [05:00.2] PciRoot(0x0)/Pci(0x1C,0x4)/Pci(0x0,0x2) -> 0x=
0A
>> SetPciIntLine: [00:1C.5] PciRoot(0x0)/Pci(0x1C,0x5) -> 0x0A
>> SetPciIntLine: [06:00.0] PciRoot(0x0)/Pci(0x1C,0x5)/Pci(0x0,0x0) -> 0x=
0A
>> SetPciIntLine: [00:1C.6] PciRoot(0x0)/Pci(0x1C,0x6) -> 0x0A
>> SetPciIntLine: [00:1C.7] PciRoot(0x0)/Pci(0x1C,0x7) -> 0x0A
>> SetPciIntLine: [00:1F.2] PciRoot(0x0)/Pci(0x1F,0x2) -> 0x0A
>> SetPciIntLine: [00:1F.3] PciRoot(0x0)/Pci(0x1F,0x3) -> 0x0A
>> Select Item: 0x8
>> Select Item: 0x17
>> qemu -kernel was not used.
>=20
> The next action would be the EfiBootManagerRefreshAllBootOption()
> function call in PlatformBootManagerAfterConsole(), in file
> "OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c".
>=20
> That function (from "MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c")
> "enumerates all boot options, creates them and registers them in the
> BootOrder variable". While doing that, it definitely looks (indirectly)
> at any UEFI-bootable virtio-scsi or virtio-blk device.
>=20
> The direct symptom you are seeing ("qemu just exits / shuts down") is
> inexplicable. If there were a virtio-de-sync between guest and host, I'=
d
> expect OVMF to hang, and/or emit error messages.

Actually, QEMU segfaults. From the dmesg:

[Tue Feb 21 18:47:28 2017] CPU 0/KVM[8298]: segfault at 48 ip 00007fcb5dd=
02105 sp 00007fcb49efc270 error 4 in qemu-system-x86_64[7fcb5dae3000+9050=
00]

Complete backtrace below. (Thread 11 seems to be the one segfaulting.)

Thanks
Laszlo

> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7f651dcbb700 (LWP 8553)]
> 0x00007f6531ac0105 in address_space_translate_cached (cache=3D0x38, add=
r=3D2, xlat=3D0x7f651dcba2d0, plen=3D0x7f651dcba2d8,
>     is_write=3Dfalse) at .../exec.c:3181
> 3181        assert(addr < cache->len && *plen <=3D cache->len - addr);
> (gdb) thread apply all bt full
>
> Thread 13 (Thread 0x7f651f5d8700 (LWP 8549)):
> #0  0x00007f6528937bdd in nanosleep () from /lib64/libpthread.so.0
> No symbol table info available.
> #1  0x00007f6526f316f8 in g_usleep () from /lib64/libglib-2.0.so.0
> No symbol table info available.
> #2  0x00007f6531f8791e in call_rcu_thread (opaque=3D0x0) at .../util/rc=
u.c:244
>         tries =3D 1
>         n =3D 1
>         node =3D 0x7f65180053b0
> #3  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #4  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 12 (Thread 0x7f651ebc4700 (LWP 8551)):
> #0  0x00007f65289369b1 in do_futex_wait () from /lib64/libpthread.so.0
> No symbol table info available.
> #1  0x00007f6528936a77 in __new_sem_wait_slow () from /lib64/libpthread=
.so.0
> No symbol table info available.
> #2  0x00007f6528936b15 in sem_timedwait () from /lib64/libpthread.so.0
> No symbol table info available.
> #3  0x00007f6531f7249a in qemu_sem_timedwait (sem=3D0x7f6532c1f488, ms=3D=
10000) at .../util/qemu-thread-posix.c:255
>         rc =3D 0
>         ts =3D {tv_sec =3D 1487699392, tv_nsec =3D 569220000}
>         __func__ =3D "qemu_sem_timedwait"
> #4  0x00007f6531f6c7a4 in worker_thread (opaque=3D0x7f6532c1f420) at ..=
./util/thread-pool.c:92
>         req =3D 0x7f65184f1a20
>         ret =3D 0
>         pool =3D 0x7f6532c1f420
> #5  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #6  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 11 (Thread 0x7f651dcbb700 (LWP 8553)):
> #0  0x00007f6531ac0105 in address_space_translate_cached (cache=3D0x38,=
 addr=3D2, xlat=3D0x7f651dcba2d0, plen=3D0x7f651dcba2d8, is_write=3Dfalse=
) at .../exec.c:3181
>         __PRETTY_FUNCTION__ =3D "address_space_translate_cached"
> #1  0x00007f6531ac07aa in address_space_lduw_internal_cached (cache=3D0=
x38, addr=3D2, attrs=3D..., result=3D0x0, endian=3DDEVICE_LITTLE_ENDIAN) =
at .../memory_ldst.inc.c:264
>         ptr =3D 0x7f6476c73802 "H\004"
>         val =3D 1096
>         mr =3D 0x7f6532d91260
>         l =3D 2
>         addr1 =3D 3202824194
>         r =3D 0
>         release_lock =3D false
> #2  0x00007f6531ac0917 in address_space_lduw_le_cached (cache=3D0x38, a=
ddr=3D2, attrs=3D..., result=3D0x0) at .../memory_ldst.inc.c:315
> No locals.
> #3  0x00007f6531ac09c3 in lduw_le_phys_cached (cache=3D0x38, addr=3D2) =
at .../memory_ldst.inc.c:334
> No locals.
> #4  0x00007f6531b737b1 in virtio_lduw_phys_cached (vdev=3D0x7f65343fa4e=
0, cache=3D0x38, pa=3D2) at .../include/hw/virtio/virtio-access.h:166
> No locals.
> #5  0x00007f6531b73d40 in vring_avail_idx (vq=3D0x7f651c09c090) at .../=
hw/virtio/virtio.c:201
>         caches =3D 0x0
>         pa =3D 2
> #6  0x00007f6531b7421f in virtio_queue_empty (vq=3D0x7f651c09c090) at .=
../hw/virtio/virtio.c:332
>         empty =3D true
> #7  0x00007f6531b78b82 in virtio_queue_host_notifier_aio_poll (opaque=3D=
0x7f651c09c0f8) at .../hw/virtio/virtio.c:2294
>         n =3D 0x7f651c09c0f8
>         vq =3D 0x7f651c09c090
>         progress =3D false
> #8  0x00007f6531f6fe2c in run_poll_handlers_once (ctx=3D0x7f6532bcd940)=
 at .../util/aio-posix.c:490
>         progress =3D false
>         node =3D 0x7f6518478650
> #9  0x00007f6531f7002d in try_poll_mode (ctx=3D0x7f6532bcd940, blocking=
=3Dtrue) at .../util/aio-posix.c:566
> No locals.
> #10 0x00007f6531f700c1 in aio_poll (ctx=3D0x7f6532bcd940, blocking=3Dtr=
ue) at .../util/aio-posix.c:595
>         node =3D 0x7f6531ed48fc <aio_context_in_iothread+17>
>         i =3D 32613
>         ret =3D 0
>         progress =3D false
>         timeout =3D 140072268314064
>         start =3D 0
>         __PRETTY_FUNCTION__ =3D "aio_poll"
> #11 0x00007f6531ed6157 in blk_prw (blk=3D0x7f6532bf7ee0, offset=3D16896=
, buf=3D0x7f650d404200 " ", bytes=3D512, co_entry=3D0x7f6531ed5fe3 <blk_w=
rite_entry>, flags=3D0) at .../block/block-backend.c:905
>         waited_ =3D false
>         bs_ =3D 0x7f6532c07980
>         ctx_ =3D 0x7f6532bcd940
>         co =3D 0x7f6518184010
>         qiov =3D {iov =3D 0x7f651dcba600, niov =3D 1, nalloc =3D -1, si=
ze =3D 512}
>         iov =3D {iov_base =3D 0x7f650d404200, iov_len =3D 512}
>         rwco =3D {blk =3D 0x7f6532bf7ee0, offset =3D 16896, qiov =3D 0x=
7f651dcba610, ret =3D 2147483647, flags =3D 0}
>         __PRETTY_FUNCTION__ =3D "blk_prw"
> #12 0x00007f6531ed67c3 in blk_pwrite (blk=3D0x7f6532bf7ee0, offset=3D16=
896, buf=3D0x7f650d404200, count=3D512, flags=3D0) at .../block/block-bac=
kend.c:1064
>         ret =3D 0
> #13 0x00007f6531cad498 in pflash_update (pfl=3D0x7f6532e5fbb0, offset=3D=
16896, size=3D1) at .../hw/block/pflash_cfi01.c:420
>         offset_end =3D 17408
> #14 0x00007f6531cad8e8 in pflash_write (pfl=3D0x7f6532e5fbb0, offset=3D=
17378, value=3D62, width=3D1, be=3D0) at .../hw/block/pflash_cfi01.c:545
>         p =3D 0x7f651dcba760 "=C2=B0=C2=A7=C3=8B\035e\177"
>         cmd =3D 62 '>'
>         __func__ =3D "pflash_write"
> #15 0x00007f6531caddbd in pflash_mem_write_with_attrs (opaque=3D0x7f653=
2e5fbb0, addr=3D17378, value=3D62, len=3D1, attrs=3D...) at .../hw/block/=
pflash_cfi01.c:691
>         pfl =3D 0x7f6532e5fbb0
>         be =3D false
> #16 0x00007f6531b10524 in memory_region_write_with_attrs_accessor (mr=3D=
0x7f6532e5ff50, addr=3D17378, value=3D0x7f651dcba838, size=3D1, shift=3D0=
, mask=3D255, attrs=3D...) at .../memory.c:552
>         tmp =3D 62
> #17 0x00007f6531b10643 in access_with_adjusted_size (addr=3D17378, valu=
e=3D0x7f651dcba838, size=3D1, access_size_min=3D1, access_size_max=3D4, a=
ccess=3D0x7f6531b1043f <memory_region_write_with_attrs_accessor>, mr=3D0x=
7f6532e5ff50, attrs=3D...) at .../memory.c:592
>         access_mask =3D 255
>         access_size =3D 1
>         i =3D 0
>         r =3D 0
> #18 0x00007f6531b12ca3 in memory_region_dispatch_write (mr=3D0x7f6532e5=
ff50, addr=3D17378, data=3D62, size=3D1, attrs=3D...) at .../memory.c:132=
9
> No locals.
> #19 0x00007f6531abdbff in address_space_write_continue (as=3D0x7f65325d=
dd80 <address_space_memory>, addr=3D4292887522, attrs=3D..., buf=3D0x7f65=
31894028 ">\020", len=3D1, addr1=3D17378, l=3D1, mr=3D0x7f6532e5ff50) at =
.../exec.c:2647
>         ptr =3D 0x0
>         val =3D 62
>         result =3D 0
>         release_lock =3D true
> #20 0x00007f6531abdd4e in address_space_write (as=3D0x7f65325ddd80 <add=
ress_space_memory>, addr=3D4292887522, attrs=3D..., buf=3D0x7f6531894028 =
">\020", len=3D1) at .../exec.c:2692
>         l =3D 1
>         addr1 =3D 17378
>         mr =3D 0x7f6532e5ff50
>         result =3D 0
> #21 0x00007f6531abe078 in address_space_rw (as=3D0x7f65325ddd80 <addres=
s_space_memory>, addr=3D4292887522, attrs=3D..., buf=3D0x7f6531894028 ">\=
020", len=3D1, is_write=3Dtrue) at .../exec.c:2794
> No locals.
> #22 0x00007f6531b0d039 in kvm_cpu_exec (cpu=3D0x7f6532c4f9b0) at .../kv=
m-all.c:1968
>         attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, request=
er_id =3D 0}
>         run =3D 0x7f6531894000
>         ret =3D 0
>         run_ret =3D 0
> #23 0x00007f6531af4f0a in qemu_kvm_cpu_thread_fn (arg=3D0x7f6532c4f9b0)=
 at .../cpus.c:1000
>         cpu =3D 0x7f6532c4f9b0
>         r =3D 0
> #24 0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #25 0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 10 (Thread 0x7f651d4ba700 (LWP 8554)):
> #0  0x00007f6525ba4507 in ioctl () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007f6531b0d526 in kvm_vcpu_ioctl (cpu=3D0x7f6532cb2810, type=3D=
44672) at .../kvm-all.c:2080
>         ret =3D 32613
>         arg =3D 0x0
>         ap =3D {{gp_offset =3D 24, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f651d4b99b0, reg_save_area =3D 0x7f651d4b98f0}}
> #2  0x00007f6531b0cede in kvm_cpu_exec (cpu=3D0x7f6532cb2810) at .../kv=
m-all.c:1929
>         attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, request=
er_id =3D 29500}
>         run =3D 0x7f6531891000
>         ret =3D 32613
>         run_ret =3D 32613
> #3  0x00007f6531af4f0a in qemu_kvm_cpu_thread_fn (arg=3D0x7f6532cb2810)=
 at .../cpus.c:1000
>         cpu =3D 0x7f6532cb2810
>         r =3D 65536
> #4  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #5  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 9 (Thread 0x7f651ccb9700 (LWP 8555)):
> #0  0x00007f6525ba4507 in ioctl () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007f6531b0d526 in kvm_vcpu_ioctl (cpu=3D0x7f6532cd2310, type=3D=
44672) at .../kvm-all.c:2080
>         ret =3D 32613
>         arg =3D 0x0
>         ap =3D {{gp_offset =3D 24, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f651ccb89b0, reg_save_area =3D 0x7f651ccb88f0}}
> #2  0x00007f6531b0cede in kvm_cpu_exec (cpu=3D0x7f6532cd2310) at .../kv=
m-all.c:1929
>         attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, request=
er_id =3D 28988}
>         run =3D 0x7f653188e000
>         ret =3D 32613
>         run_ret =3D 32613
> #3  0x00007f6531af4f0a in qemu_kvm_cpu_thread_fn (arg=3D0x7f6532cd2310)=
 at .../cpus.c:1000
>         cpu =3D 0x7f6532cd2310
>         r =3D 65536
> #4  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #5  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 8 (Thread 0x7f650ffff700 (LWP 8556)):
> #0  0x00007f6525ba4507 in ioctl () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007f6531b0d526 in kvm_vcpu_ioctl (cpu=3D0x7f6532cf1e40, type=3D=
44672) at .../kvm-all.c:2080
>         ret =3D 32613
>         arg =3D 0x0
>         ap =3D {{gp_offset =3D 24, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f650fffe9b0, reg_save_area =3D 0x7f650fffe8f0}}
> #2  0x00007f6531b0cede in kvm_cpu_exec (cpu=3D0x7f6532cf1e40) at .../kv=
m-all.c:1929
>         attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, request=
er_id =3D 64828}
>         run =3D 0x7f653188b000
>         ret =3D 32613
>         run_ret =3D 32613
> #3  0x00007f6531af4f0a in qemu_kvm_cpu_thread_fn (arg=3D0x7f6532cf1e40)=
 at .../cpus.c:1000
>         cpu =3D 0x7f6532cf1e40
>         r =3D 65536
> #4  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #5  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 7 (Thread 0x7f650f7fe700 (LWP 8557)):
> #0  0x00007f6525ba4507 in ioctl () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007f6531b0d526 in kvm_vcpu_ioctl (cpu=3D0x7f6532d11750, type=3D=
44672) at .../kvm-all.c:2080
>         ret =3D 32613
>         arg =3D 0x0
>         ap =3D {{gp_offset =3D 24, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f650f7fd9b0, reg_save_area =3D 0x7f650f7fd8f0}}
> #2  0x00007f6531b0cede in kvm_cpu_exec (cpu=3D0x7f6532d11750) at .../kv=
m-all.c:1929
>         attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, request=
er_id =3D 64316}
>         run =3D 0x7f6531888000
>         ret =3D 32613
>         run_ret =3D 32613
> #3  0x00007f6531af4f0a in qemu_kvm_cpu_thread_fn (arg=3D0x7f6532d11750)=
 at .../cpus.c:1000
>         cpu =3D 0x7f6532d11750
>         r =3D 65536
> #4  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #5  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 6 (Thread 0x7f650effd700 (LWP 8558)):
> #0  0x00007f6525ba4507 in ioctl () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007f6531b0d526 in kvm_vcpu_ioctl (cpu=3D0x7f6532d31060, type=3D=
44672) at .../kvm-all.c:2080
>         ret =3D 32613
>         arg =3D 0x0
>         ap =3D {{gp_offset =3D 24, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f650effc9b0, reg_save_area =3D 0x7f650effc8f0}}
> #2  0x00007f6531b0cede in kvm_cpu_exec (cpu=3D0x7f6532d31060) at .../kv=
m-all.c:1929
>         attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, request=
er_id =3D 63804}
>         run =3D 0x7f6531885000
>         ret =3D 32613
>         run_ret =3D 32613
> #3  0x00007f6531af4f0a in qemu_kvm_cpu_thread_fn (arg=3D0x7f6532d31060)=
 at .../cpus.c:1000
>         cpu =3D 0x7f6532d31060
>         r =3D 65536
> #4  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #5  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 5 (Thread 0x7f650e7fc700 (LWP 8559)):
> #0  0x00007f6525ba4507 in ioctl () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007f6531b0d526 in kvm_vcpu_ioctl (cpu=3D0x7f6532d51190, type=3D=
44672) at .../kvm-all.c:2080
>         ret =3D 32613
>         arg =3D 0x0
>         ap =3D {{gp_offset =3D 24, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f650e7fb9b0, reg_save_area =3D 0x7f650e7fb8f0}}
> #2  0x00007f6531b0cede in kvm_cpu_exec (cpu=3D0x7f6532d51190) at .../kv=
m-all.c:1929
>         attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, request=
er_id =3D 63292}
>         run =3D 0x7f6531882000
>         ret =3D 32613
>         run_ret =3D 32613
> #3  0x00007f6531af4f0a in qemu_kvm_cpu_thread_fn (arg=3D0x7f6532d51190)=
 at .../cpus.c:1000
>         cpu =3D 0x7f6532d51190
>         r =3D 65536
> #4  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #5  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 4 (Thread 0x7f650dffb700 (LWP 8560)):
> #0  0x00007f6525ba4507 in ioctl () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007f6531b0d526 in kvm_vcpu_ioctl (cpu=3D0x7f6532d70a90, type=3D=
44672) at .../kvm-all.c:2080
>         ret =3D 32613
>         arg =3D 0x0
>         ap =3D {{gp_offset =3D 24, fp_offset =3D 48, overflow_arg_area =
=3D 0x7f650dffa9b0, reg_save_area =3D 0x7f650dffa8f0}}
> #2  0x00007f6531b0cede in kvm_cpu_exec (cpu=3D0x7f6532d70a90) at .../kv=
m-all.c:1929
>         attrs =3D {unspecified =3D 0, secure =3D 0, user =3D 0, request=
er_id =3D 62780}
>         run =3D 0x7f653187f000
>         ret =3D 32613
>         run_ret =3D 32613
> #3  0x00007f6531af4f0a in qemu_kvm_cpu_thread_fn (arg=3D0x7f6532d70a90)=
 at .../cpus.c:1000
>         cpu =3D 0x7f6532d70a90
>         r =3D 65536
> #4  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #5  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 3 (Thread 0x7f63af22c700 (LWP 8562)):
> #0  0x00007f6525ba2dfd in poll () from /lib64/libc.so.6
> No symbol table info available.
> #1  0x00007f652744a327 in red_worker_main () from /lib64/libspice-serve=
r.so.1
> No symbol table info available.
> #2  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #3  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 2 (Thread 0x7f63ae9ff700 (LWP 8563)):
> #0  0x00007f65289346d5 in pthread_cond_wait@@GLIBC_2.3.2 () from /lib64=
/libpthread.so.0
> No symbol table info available.
> #1  0x00007f6531f72293 in qemu_cond_wait (cond=3D0x7f653443c710, mutex=3D=
0x7f653443c740) at .../util/qemu-thread-posix.c:133
>         err =3D 32613
>         __func__ =3D "qemu_cond_wait"
> #2  0x00007f6531e7fd47 in vnc_worker_thread_loop (queue=3D0x7f653443c71=
0) at .../ui/vnc-jobs.c:205
>         job =3D 0x7f6534ca4700
>         entry =3D 0x0
>         tmp =3D 0x0
>         vs =3D {sioc =3D 0x0, ioc =3D 0x0, ioc_tag =3D 0, disconnecting=
 =3D 0,
>         dirty =3D {{0, 0, 0} <repeats 2048 times>}, lossy_rect =3D 0x0,=
 vd =3D 0x0,
>         need_update =3D 0, force_update =3D 0, has_dirty =3D 0, feature=
s =3D 0, absolute
>         =3D 0, last_x =3D 0, last_y =3D 0, last_bmask =3D 0, client_wid=
th =3D 0,
>         client_height =3D 0, share_mode =3D 0, vnc_encoding =3D 0, majo=
r =3D 0, minor =3D
>         0, auth =3D 0, subauth =3D 0, challenge =3D '\000' <repeats 15 =
times>, tls =3D
>         0x0, sasl =3D {conn =3D 0x0, wantSSF =3D false, runSSF =3D fals=
e, waitWriteSSF =3D
>         0, encoded =3D 0x0, encodedLength =3D 0, encodedOffset =3D 0, u=
sername =3D 0x0,
>         mechlist =3D 0x0}, encode_ws =3D false, websocket =3D false, in=
fo =3D 0x0,
>         output =3D {name =3D 0x0, capacity =3D 0, offset =3D 0, avg_siz=
e =3D 0, buffer =3D
>         0x0}, input =3D {name =3D 0x0, capacity =3D 0, offset =3D 0, av=
g_size =3D 0,
>         buffer =3D 0x0}, write_pixels =3D 0x0, client_pf =3D {bits_per_=
pixel =3D 0
>         '\000', bytes_per_pixel =3D 0 '\000', depth =3D 0 '\000', rmask=
 =3D 0, gmask =3D
>         0, bmask =3D 0, amask =3D 0, rshift =3D 0 '\000', gshift =3D 0 =
'\000', bshift =3D
>         0 '\000', ashift =3D 0 '\000', rmax =3D 0 '\000', gmax =3D 0 '\=
000', bmax =3D 0
>         '\000', amax =3D 0 '\000', rbits =3D 0 '\000', gbits =3D 0 '\00=
0', bbits =3D 0
>         '\000', abits =3D 0 '\000'}, client_format =3D 0, client_be =3D=
 false,
>         audio_cap =3D 0x0, as =3D {freq =3D 0, nchannels =3D 0, fmt =3D=
 AUD_FMT_U8,
>         endianness =3D 0}, read_handler =3D 0x0, read_handler_expect =3D=
 0,
>         modifiers_state =3D '\000' <repeats 255 times>, abort =3D false=
,
>         output_mutex =3D {lock =3D {__data =3D {__lock =3D 0, __count =3D=
 0, __owner =3D 0,
>         __nusers =3D 0, __kind =3D 0, __spins =3D 0, __list =3D {__prev=
 =3D 0x0, __next =3D
>         0x0}}, __size =3D '\000' <repeats 39 times>, __align =3D 0}}, b=
h =3D 0x0,
>         jobs_buffer =3D {name =3D 0x0, capacity =3D 0, offset =3D 0, av=
g_size =3D 0,
>         buffer =3D 0x0}, tight =3D {type =3D 0, quality =3D 0 '\000', c=
ompression =3D 0
>         '\000', pixel24 =3D 0 '\000', tight =3D {name =3D 0x0, capacity=
 =3D 0, offset =3D
>         0, avg_size =3D 0, buffer =3D 0x0}, tmp =3D {name =3D 0x0, capa=
city =3D 0, offset
>         =3D 0, avg_size =3D 0, buffer =3D 0x0}, zlib =3D {name =3D 0x0,=
 capacity =3D 0,
>         offset =3D 0, avg_size =3D 0, buffer =3D 0x0}, gradient =3D {na=
me =3D 0x0,
>         capacity =3D 0, offset =3D 0, avg_size =3D 0, buffer =3D 0x0}, =
jpeg =3D {name =3D
>         0x0, capacity =3D 0, offset =3D 0, avg_size =3D 0, buffer =3D 0=
x0}, png =3D {name
>         =3D 0x0, capacity =3D 0, offset =3D 0, avg_size =3D 0, buffer =3D=
 0x0}, levels =3D
>         {0, 0, 0, 0}, stream =3D {{next_in =3D 0x0, avail_in =3D 0, tot=
al_in =3D 0,
>         next_out =3D 0x0, avail_out =3D 0, total_out =3D 0, msg =3D 0x0=
, state =3D 0x0,
>         zalloc =3D 0x0, zfree =3D 0x0, opaque =3D 0x0, data_type =3D 0,=
 adler =3D 0,
>         reserved =3D 0}, {next_in =3D 0x0, avail_in =3D 0, total_in =3D=
 0, next_out =3D
>         0x0, avail_out =3D 0, total_out =3D 0, msg =3D 0x0, state =3D 0=
x0, zalloc =3D 0x0,
>         zfree =3D 0x0, opaque =3D 0x0, data_type =3D 0, adler =3D 0, re=
served =3D 0},
>         {next_in =3D 0x0, avail_in =3D 0, total_in =3D 0, next_out =3D =
0x0, avail_out =3D
>         0, total_out =3D 0, msg =3D 0x0, state =3D 0x0, zalloc =3D 0x0,=
 zfree =3D 0x0,
>         opaque =3D 0x0, data_type =3D 0, adler =3D 0, reserved =3D 0}, =
{next_in =3D 0x0,
>         avail_in =3D 0, total_in =3D 0, next_out =3D 0x0, avail_out =3D=
 0, total_out =3D
>         0, msg =3D 0x0, state =3D 0x0, zalloc =3D 0x0, zfree =3D 0x0, o=
paque =3D 0x0,
>         data_type =3D 0, adler =3D 0, reserved =3D 0}}}, zlib =3D {zlib=
 =3D {name =3D 0x0,
>         capacity =3D 0, offset =3D 0, avg_size =3D 0, buffer =3D 0x0}, =
tmp =3D {name =3D
>         0x0, capacity =3D 0, offset =3D 0, avg_size =3D 0, buffer =3D 0=
x0}, stream =3D
>         {next_in =3D 0x0, avail_in =3D 0, total_in =3D 0, next_out =3D =
0x0, avail_out =3D
>         0, total_out =3D 0, msg =3D 0x0, state =3D 0x0, zalloc =3D 0x0,=
 zfree =3D 0x0,
>         opaque =3D 0x0, data_type =3D 0, adler =3D 0, reserved =3D 0}, =
level =3D 0},
>         hextile =3D {send_tile =3D 0x0}, zrle =3D {type =3D 0, fb =3D {=
name =3D 0x0,
>         capacity =3D 0, offset =3D 0, avg_size =3D 0, buffer =3D 0x0}, =
zrle =3D {name =3D
>         0x0, capacity =3D 0, offset =3D 0, avg_size =3D 0, buffer =3D 0=
x0}, tmp =3D {name
>         =3D 0x0, capacity =3D 0, offset =3D 0, avg_size =3D 0, buffer =3D=
 0x0}, zlib =3D
>         {name =3D 0x0, capacity =3D 0, offset =3D 0, avg_size =3D 0, bu=
ffer =3D 0x0},
>         stream =3D {next_in =3D 0x0, avail_in =3D 0, total_in =3D 0, ne=
xt_out =3D 0x0,
>         avail_out =3D 0, total_out =3D 0, msg =3D 0x0, state =3D 0x0, z=
alloc =3D 0x0,
>         zfree =3D 0x0, opaque =3D 0x0, data_type =3D 0, adler =3D 0, re=
served =3D 0},
>         palette =3D {pool =3D {{idx =3D 0, color =3D 0, next =3D {le_ne=
xt =3D 0x0, le_prev =3D
>         0x0}} <repeats 256 times>}, size =3D 0, max =3D 0, bpp =3D 0, t=
able =3D
>         {{lh_first =3D 0x0} <repeats 256 times>}}}, zywrle =3D {buf =3D=
 {0 <repeats
>         4096 times>}}, mouse_mode_notifier =3D {notify =3D 0x0, node =3D=
 {le_next =3D
>         0x0, le_prev =3D 0x0}}, next =3D {tqe_next =3D 0x0, tqe_prev =3D=
 0x0}}
>         n_rectangles =3D 4
>         saved_offset =3D 2
> #3  0x00007f6531e801cb in vnc_worker_thread (arg=3D0x7f653443c710) at .=
../ui/vnc-jobs.c:312
>         queue =3D 0x7f653443c710
> #4  0x00007f6528930dc5 in start_thread () from /lib64/libpthread.so.0
> No symbol table info available.
> #5  0x00007f6525bad73d in clone () from /lib64/libc.so.6
> No symbol table info available.
>
> Thread 1 (Thread 0x7f6531835c40 (LWP 8527)):
> #0  0x00007f65289371bd in __lll_lock_wait () from /lib64/libpthread.so.=
0
> No symbol table info available.
> #1  0x00007f6528932d02 in _L_lock_791 () from /lib64/libpthread.so.0
> No symbol table info available.
> #2  0x00007f6528932c08 in pthread_mutex_lock () from /lib64/libpthread.=
so.0
> No symbol table info available.
> #3  0x00007f6531f720cd in qemu_mutex_lock (mutex=3D0x7f6532606940 <qemu=
_global_mutex>) at .../util/qemu-thread-posix.c:60
>         err =3D 0
>         __func__ =3D "qemu_mutex_lock"
> #4  0x00007f6531af5830 in qemu_mutex_lock_iothread () at .../cpus.c:135=
1
> No locals.
> #5  0x00007f6531f6e8af in os_host_main_loop_wait (timeout=3D902507) at =
.../util/main-loop.c:257
>         ret =3D 1
>         spin_counter =3D 0
> #6  0x00007f6531f6e955 in main_loop_wait (nonblocking=3D0) at .../util/=
main-loop.c:508
>         ret =3D 0
>         timeout =3D 4294967295
>         timeout_ns =3D 902507
> #7  0x00007f6531c2bd89 in main_loop () at .../vl.c:1877
>         nonblocking =3D false
>         last_io =3D 0
> #8  0x00007f6531c335e0 in main (argc=3D88, argv=3D0x7ffd256a2918, envp=3D=
0x7ffd256a2be0) at .../vl.c:4628
>         i =3D 32613
>         snapshot =3D 0
>         linux_boot =3D 0
>         initrd_filename =3D 0x0
>         kernel_filename =3D 0x0
>         kernel_cmdline =3D 0x7f6531fc713e ""
>         boot_order =3D 0x7f6531faf741 "cad"
>         boot_once =3D 0x0
>         ds =3D 0x7f6534ca4120
>         cyls =3D 0
>         heads =3D 0
>         secs =3D 0
>         translation =3D 0
>         hda_opts =3D 0x0
>         opts =3D 0x7f6532b6ec50
>         machine_opts =3D 0x7f6532b6d840
>         icount_opts =3D 0x0
>         olist =3D 0x7f65324903a0 <qemu_machine_opts>
>         optind =3D 88
>         optarg =3D 0x7ffd256a4f54 "timestamp=3Don"
>         loadvm =3D 0x0
>         machine_class =3D 0x7f6532b96800
>         cpu_model =3D 0x7ffd256a464a "Haswell-noTSX,+vmx"
>         vga_model =3D 0x0
>         qtest_chrdev =3D 0x0
>         qtest_log =3D 0x0
>         pid_file =3D 0x0
>         incoming =3D 0x0
>         defconfig =3D true
>         userconfig =3D false
>         nographic =3D false
>         display_type =3D DT_DEFAULT
>         display_remote =3D 1
>         log_mask =3D 0x0
>         log_file =3D 0x0
>         trace_file =3D 0x0
>         maxram_size =3D 5368709120
>         ram_slots =3D 0
>         vmstate_dump_file =3D 0x0
>         main_loop_err =3D 0x0
>         err =3D 0x0
>         list_data_dirs =3D false
>         __func__ =3D "main"
>         __FUNCTION__ =3D "main"
