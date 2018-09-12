Received: from eggs.gnu.org ([2001:4830:134:3::10]:54225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g04Kz-0003wl-SD
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g04Kx-0003E2-C3
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:33:41 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:33532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g04Kx-0003Dl-5a
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 08:33:39 -0400
Received: by mail-qt0-x234.google.com with SMTP id r37-v6so1638701qtc.0
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 05:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <1536729461-2692-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+nhYjE1qCjJBuxePJ2LQkjGfoQF4=J=AdRF9EfJRVnWg@mail.gmail.com>
	<CAKXe6S+OHNaxaDBORcDno1Wf3WTevgyNRJQTr6SVAXLV7-rFVA@mail.gmail.com>
	<84da6f02-1f60-4bc7-92da-6a7f74deded3@redhat.com>
In-Reply-To: <84da6f02-1f60-4bc7-92da-6a7f74deded3@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 12 Sep 2018 20:33:01 +0800
Message-ID: <CAKXe6SJjxne34PvxrbLKE3mz+XCowLxo_MSngPTazsVkPRqJUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg_mem: add read memory region callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, mst@redhat.com, ehabkost@redhat.com, Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, Qemu Developers <qemu-devel@nongnu.org>

Hi Laszlo,

Laszlo Ersek <lersek@redhat.com> =E4=BA=8E2018=E5=B9=B49=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:36=E5=86=99=E9=81=93=EF=BC=9A

> On 09/12/18 10:02, Li Qiang wrote:
> > Hi,
> >
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> =E4=BA=8E2018=E5=B9=
=B49=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:16=E5=86=99=
=E9=81=93=EF=BC=9A
> >
> >> Hi
> >>
> >> On Wed, Sep 12, 2018 at 9:22 AM Li Qiang <liq3ea@gmail.com> wrote:
> >>>
> >>> The write/read should be paired, this can avoid the
> >>> NULL-deref while the guest reads the fw_cfg port.
> >>>
> >>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> >>
> >> Do you have a reproducer and/or a backtrace?
> >> memory_region_dispatch_write() checks if ops->write !=3D NULL.
> >>
> >
> > As far as I can see, the fw_cfg_mem is not used in x86 and used in arm.
> > And from my impression, this will NULL read will be a issue. So I just
> > omit the 'read' field in fw_cfg_comb_mem_ops(this is used for x86) to
> > emulate the
> > issue.
> >
> > When using gdb, I got the following backtrack.
> >
> > Thread 5 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7fffca15b700 (LWP 7637)]
> > 0x0000000000000000 in ?? ()
> > (gdb) bt
> > #0  0x0000000000000000 in ?? ()
> > #1  0x0000555555872492 in memory_region_oldmmio_read_accessor
> > (mr=3D0x5555567fa870, addr=3D1, value=3D0x7fffca158510, size=3D1, shift=
=3D0,
> > mask=3D255, attrs=3D...) at /home/liqiang02/qemu-devel/qemu/memory.c:40=
9
> > #2  0x000055555586f2dd in access_with_adjusted_size (addr=3Daddr@entry=
=3D1,
> > value=3Dvalue@entry=3D0x7fffca158510, size=3Dsize@entry=3D1,
> > access_size_min=3D<optimized out>, access_size_max=3D<optimized out>,
> >     access_fn=3D0x555555872440 <memory_region_oldmmio_read_accessor>,
> > mr=3D0x5555567fa870, attrs=3D...) at
> > /home/liqiang02/qemu-devel/qemu/memory.c:593
> > #3  0x0000555555873e90 in memory_region_dispatch_read1 (attrs=3D...,
> size=3D1,
> > pval=3D0x7fffca158510, addr=3D1, mr=3D0x5555567fa870) at
> > /home/liqiang02/qemu-devel/qemu/memory.c:1404
> > #4  memory_region_dispatch_read (mr=3Dmr@entry=3D0x5555567fa870, addr=
=3D1,
> > pval=3Dpval@entry=3D0x7fffca158510, size=3D1, attrs=3Dattrs@entry=3D...=
) at
> > /home/liqiang02/qemu-devel/qemu/memory.c:1423
> > #5  0x0000555555821e42 in flatview_read_continue (fv=3Dfv@entry
> =3D0x7fffbc03f370,
> > addr=3Daddr@entry=3D1297, attrs=3D..., buf=3D<optimized out>, buf@entry
> =3D0x7ffff7fee000
> > "", len=3Dlen@entry=3D1, addr1=3D<optimized out>, l=3D<optimized out>,
> > mr=3D0x5555567fa870)
> >     at /home/liqiang02/qemu-devel/qemu/exec.c:3293
> > #6  0x0000555555822006 in flatview_read (fv=3D0x7fffbc03f370, addr=3D12=
97,
> > attrs=3D..., buf=3D0x7ffff7fee000 "", len=3D1) at
> > /home/liqiang02/qemu-devel/qemu/exec.c:3331
> > #7  0x000055555582211f in address_space_read_full (as=3D<optimized out>=
,
> > addr=3Daddr@entry=3D1297, attrs=3D..., buf=3Dbuf@entry=3D0x7ffff7fee000=
 "",
> > len=3Dlen@entry=3D1) at /home/liqiang02/qemu-devel/qemu/exec.c:3344
> > #8  0x000055555582225a in address_space_rw (as=3D<optimized out>,
> > addr=3Daddr@entry=3D1297, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@ent=
ry
> =3D0x7ffff7fee000
> > "", len=3Dlen@entry=3D1, is_write=3Dis_write@entry=3Dfalse)
> >     at /home/liqiang02/qemu-devel/qemu/exec.c:3374
> > #9  0x0000555555886239 in kvm_handle_io (count=3D1, size=3D1,
> > direction=3D<optimized out>, data=3D<optimized out>, attrs=3D..., port=
=3D1297) at
> > /home/liqiang02/qemu-devel/qemu/accel/kvm/kvm-all.c:1731
> > #10 kvm_cpu_exec (cpu=3Dcpu@entry=3D0x5555566e9990) at
> > /home/liqiang02/qemu-devel/qemu/accel/kvm/kvm-all.c:1971
> > #11 0x000055555585d3de in qemu_kvm_cpu_thread_fn (arg=3D0x5555566e9990)=
 at
> > /home/liqiang02/qemu-devel/qemu/cpus.c:1257
> > #12 0x00007fffdbd58494 in start_thread () from
> > /lib/x86_64-linux-gnu/libpthread.so.0
> > #13 0x00007fffdba9aacf in clone () from /lib/x86_64-linux-gnu/libc.so.6
> >
> > So I send out this path.
> >
> > But this time when I not use gdb, there is no segmentation.
> >
> > So this may not a issue.
> >
> > If who has a arm environment, he can try this, the PoC is just easy. ju=
st
> > read the 0x510 port with word.
>
> I don't understand your description of how you managed to trigger this
> SIGSEGV.
>
> FWIW, looking at the codebase, there's a good number of static
> MemoryRegionOps structures for which the "read_with_attrs" and "read"
> members are default-initialized to NULL. It seems unlikely they are all
> wrong.
>
>
I uses the debugexit.

QEMU command: gdb --args qemu-system-x86_64  -m 2048 -hda
/home/liqiang02/ubuntu1801.img -enable-kvm  -vnc :100 -device isa-debug-exi=
t

guest: inw(0x501)

We can get the following backtrack.

Starting program: /usr/local/bin/qemu-system-x86_64 -m 2048 -hda
/home/liqiang02/ubuntu1801.img -enable-kvm -vnc :100 -device isa-debug-exit
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[New Thread 0x7fffcde12700 (LWP 52824)]
[New Thread 0x7fffcd41f700 (LWP 52825)]
WARNING: Image format was not specified for
'/home/liqiang02/ubuntu1801.img' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
[New Thread 0x7fffcca3c700 (LWP 52826)]
[New Thread 0x7fff463ff700 (LWP 52828)]
[Thread 0x7fffcd41f700 (LWP 52825) exited]
[New Thread 0x7fffcd41f700 (LWP 52857)]
[Thread 0x7fffcd41f700 (LWP 52857) exited]
[New Thread 0x7fffcd41f700 (LWP 52935)]

Thread 4 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffcca3c700 (LWP 52826)]
0x0000000000000000 in ?? ()
(gdb) bt
#0  0x0000000000000000 in ?? ()
#1  0x00005555557c1f81 in memory_region_oldmmio_read_accessor
(mr=3D0x5555577b32b0, addr=3D0, value=3D0x7fffcca39568, size=3D2, shift=3D0=
,
mask=3D65535, attrs=3D...) at /home/liqiang02/qemu_max_cpu/qemu-2.8/memory.=
c:409
#2  0x00005555557c2697 in access_with_adjusted_size (addr=3D0,
value=3D0x7fffcca39568, size=3D2, access_size_min=3D1, access_size_max=3D4,
access=3D0x5555557c1f31 <memory_region_oldmmio_read_accessor>,
mr=3D0x5555577b32b0, attrs=3D...)
    at /home/liqiang02/qemu_max_cpu/qemu-2.8/memory.c:592
#3  0x00005555557c4aa2 in memory_region_dispatch_read1 (mr=3D0x5555577b32b0=
,
addr=3D0, pval=3D0x7fffcca39568, size=3D2, attrs=3D...) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/memory.c:1254
#4  0x00005555557c4b26 in memory_region_dispatch_read (mr=3D0x5555577b32b0,
addr=3D0, pval=3D0x7fffcca39568, size=3D2, attrs=3D...) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/memory.c:1273
#5  0x00005555557708ba in address_space_read_continue (as=3D0x5555562cc760
<address_space_io>, addr=3D1281, attrs=3D..., buf=3D0x7ffff7fee000 "", len=
=3D2,
addr1=3D0, l=3D2, mr=3D0x5555577b32b0) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/exec.c:2692
#6  0x0000555555770a53 in address_space_read_full (as=3D0x5555562cc760
<address_space_io>, addr=3D1281, attrs=3D..., buf=3D0x7ffff7fee000 "", len=
=3D2) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/exec.c:2743
#7  0x0000555555770b15 in address_space_read (len=3D2, buf=3D0x7ffff7fee000=
 "",
attrs=3D..., addr=3D1281, as=3D0x5555562cc760 <address_space_io>) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/include/exec/memory.h:1527
#8  address_space_rw (as=3D0x5555562cc760 <address_space_io>, addr=3D1281,
attrs=3D..., buf=3D0x7ffff7fee000 "", len=3D2, is_write=3Dfalse) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/exec.c:2757
#9  0x00005555557bea59 in kvm_handle_io (port=3D1281, attrs=3D...,
data=3D0x7ffff7fee000, direction=3D0, size=3D2, count=3D1) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/kvm-all.c:1800
#10 0x00005555557bef5f in kvm_cpu_exec (cpu=3D0x5555568279c0) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/kvm-all.c:1958
#11 0x00005555557a5d5f in qemu_kvm_cpu_thread_fn (arg=3D0x5555568279c0) at
/home/liqiang02/qemu_max_cpu/qemu-2.8/cpus.c:998
#12 0x00007fffdbf89494 in start_thread () from
/lib/x86_64-linux-gnu/libpthread.so.0
#13 0x00007fffdbccbacf in clone () from /lib/x86_64-linux-gnu/libc.so.6
(gdb)

Seems the root cause is in 'memory_region_oldmmio_read_accessor '.
Anyway I have sent out another patch to address issue.

Thanks,
Li Qiang



> - exec.c:                    notdirty_mem_ops, readonly_mem_ops
> - hw/misc/debugexit.c:       debug_exit_ops
> - hw/misc/hyperv_testdev.c:  synic_test_sint_ops
> - hw/misc/pc-testdev.c:      test_irq_ops, test_flush_ops
> - hw/pci-host/designware.c:  designware_pci_host_msi_ops
> - hw/rdma/vmw/pvrdma_main.c: uar_ops
> - hw/sparc64/sun4u.c:        power_mem_ops
>
> Laszlo
>
