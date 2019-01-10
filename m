Received: from eggs.gnu.org ([209.51.188.92]:60181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ghQcT-0004aL-4Y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1ghQcR-0007jg-NR
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 22:02:57 -0500
MIME-Version: 1.0
References: <1540876720-9574-1-git-send-email-liq3ea@gmail.com>
	<1540876720-9574-3-git-send-email-liq3ea@gmail.com>
	<b445d1bd-48ad-82a7-9775-53419ce1a4a2@redhat.com>
In-Reply-To: <b445d1bd-48ad-82a7-9775-53419ce1a4a2@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 10 Jan 2019 11:02:14 +0800
Message-ID: <CAKXe6SLhRoOj8OtZ4m6h0y=Bnid2aU1Apk_bcrrFAJNSsCr4mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] nvme: ensure the num_queues is not zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: keith.busch@intel.com, kwolf@redhat.com, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

Max Reitz <mreitz@redhat.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:38=E5=86=99=E9=81=93=EF=BC=9A

> On 30.10.18 06:18, Li Qiang wrote:
> > When it is zero, it causes segv. Backtrack:
> > Thread 5 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7fffc6c17700 (LWP 51808)]
> > 0x0000555555acbd90 in nvme_start_ctrl (n=3D0x6240000c8100) at
> hw/block/nvme.c:820
> > warning: Source file is more recent than executable.
> > 820       if (unlikely(n->cq[0])) {
> > (gdb) bt
> > 0  0x0000555555acbd90 in nvme_start_ctrl (n=3D0x6240000c8100) at
> hw/block/nvme.c:820
> > 1  0x0000555555accdbc in nvme_write_bar (n=3D0x6240000c8100, offset=3D2=
0,
> data=3D4587521, size=3D4) at hw/block/nvme.c:964
> > 2  0x0000555555acdd2b in nvme_mmio_write (opaque=3D0x6240000c8100,
> addr=3D20, data=3D4587521, size=3D4) at hw/block/nvme.c:1158
> > 3  0x00005555558973ed in memory_region_write_accessor
> (mr=3D0x6240000c89e0, addr=3D20, value=3D0x7fffc6c14428, size=3D4, shift=
=3D0,
> mask=3D4294967295, attrs=3D...) at
> /home/liqiang02/qemu-upstream/qemu/memory.c:500
> > 4  0x0000555555897600 in access_with_adjusted_size (addr=3D20,
> value=3D0x7fffc6c14428, size=3D4, access_size_min=3D2, access_size_max=3D=
8,
> access_fn=3D0x555555897304 <memory_region_write_accessor>, mr=3D0x6240000=
c89e0,
> attrs=3D...) at /home/liqiang02/qemu-upstream/qemu/memory.c:566
> > 5  0x000055555589a200 in memory_region_dispatch_write
> (mr=3D0x6240000c89e0, addr=3D20, data=3D4587521, size=3D4, attrs=3D...) a=
t
> /home/liqiang02/qemu-upstream/qemu/memory.c:1442
> > 6  0x0000555555835151 in flatview_write_continue (fv=3D0x6060000e6fc0,
> addr=3D4273930260, attrs=3D..., buf=3D0x7fffc8a18028 "\001", len=3D4, add=
r1=3D20,
> l=3D4, mr=3D0x6240000c89e0) at /home/liqiang02/qemu-upstream/qemu/exec.c:=
3233
> > 7  0x000055555583529b in flatview_write (fv=3D0x6060000e6fc0,
> addr=3D4273930260, attrs=3D..., buf=3D0x7fffc8a18028 "\001", len=3D4) at
> /home/liqiang02/qemu-upstream/qemu/exec.c:3272
> > 8  0x00005555558355a1 in address_space_write (as=3D0x55555683ade0
> <address_space_memory>, addr=3D4273930260, attrs=3D..., buf=3D0x7fffc8a18=
028
> "\001", len=3D4) at /home/liqiang02/qemu-upstream/qemu/exec.c:3362
> > 9  0x00005555558355f2 in address_space_rw (as=3D0x55555683ade0
> <address_space_memory>, addr=3D4273930260, attrs=3D..., buf=3D0x7fffc8a18=
028
> "\001", len=3D4, is_write=3Dtrue) at
> /home/liqiang02/qemu-upstream/qemu/exec.c:3373
> > 10 0x00005555558b66ac in kvm_cpu_exec (cpu=3D0x631000014800) at
> /home/liqiang02/qemu-upstream/qemu/accel/kvm/kvm-all.c:2031
> > 11 0x000055555587c3ac in qemu_kvm_cpu_thread_fn (arg=3D0x631000014800) =
at
> /home/liqiang02/qemu-upstream/qemu/cpus.c:1277
> > 12 0x0000555555e54ae6 in qemu_thread_start (args=3D0x60300002c170) at
> util/qemu-thread-posix.c:504
> > 13 0x00007fffdadbd494 in start_thread () from
> /lib/x86_64-linux-gnu/libpthread.so.0
> > 14 0x00007fffdaaffacf in clone () from /lib/x86_64-linux-gnu/libc.so.6
> > (gdb) q
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  hw/block/nvme.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 676cc48..72c9644 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1221,6 +1221,10 @@ static void nvme_realize(PCIDevice *pci_dev,
> Error **errp)
> >          error_setg(errp, "serial property not set");
> >          return;
> >      }
> > +
> > +    if (!n->num_queues) {
> > +        error_setg(errp, "num_queues can't be zero");
>
> I think we should return here.
>
>
Ok, forget this. will make a revised version later.

Thanks,
Li Qiang


> (Sorry for the late review...)
>
> Max
>
> > +    }
> >      blkconf_blocksizes(&n->conf);
> >      if (!blkconf_apply_backend_options(&n->conf,
> blk_is_read_only(n->conf.blk),
> >                                         false, errp)) {
> >
>
>
>
