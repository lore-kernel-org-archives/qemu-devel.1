Received: from eggs.gnu.org ([2001:4830:134:3::10]:43748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g00D3-00040r-5m
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g007W-00008V-VB
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:03:33 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:34306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g007W-00008I-OS
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:03:30 -0400
Received: by mail-qt0-x230.google.com with SMTP id m13-v6so963262qth.1
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 01:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <1536729461-2692-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+nhYjE1qCjJBuxePJ2LQkjGfoQF4=J=AdRF9EfJRVnWg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+nhYjE1qCjJBuxePJ2LQkjGfoQF4=J=AdRF9EfJRVnWg@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 12 Sep 2018 16:02:52 +0800
Message-ID: <CAKXe6S+OHNaxaDBORcDno1Wf3WTevgyNRJQTr6SVAXLV7-rFVA@mail.gmail.com>
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
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: mst@redhat.com, ehabkost@redhat.com, Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, richard.henderson@linaro.org, Qemu Developers <qemu-devel@nongnu.org>

Hi,

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> =E4=BA=8E2018=E5=B9=B49=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=883:16=E5=86=99=E9=
=81=93=EF=BC=9A

> Hi
>
> On Wed, Sep 12, 2018 at 9:22 AM Li Qiang <liq3ea@gmail.com> wrote:
> >
> > The write/read should be paired, this can avoid the
> > NULL-deref while the guest reads the fw_cfg port.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
>
> Do you have a reproducer and/or a backtrace?
> memory_region_dispatch_write() checks if ops->write !=3D NULL.
>

As far as I can see, the fw_cfg_mem is not used in x86 and used in arm.
And from my impression, this will NULL read will be a issue. So I just
omit the 'read' field in fw_cfg_comb_mem_ops(this is used for x86) to
emulate the
issue.

When using gdb, I got the following backtrack.

Thread 5 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffca15b700 (LWP 7637)]
0x0000000000000000 in ?? ()
(gdb) bt
#0  0x0000000000000000 in ?? ()
#1  0x0000555555872492 in memory_region_oldmmio_read_accessor
(mr=3D0x5555567fa870, addr=3D1, value=3D0x7fffca158510, size=3D1, shift=3D0=
,
mask=3D255, attrs=3D...) at /home/liqiang02/qemu-devel/qemu/memory.c:409
#2  0x000055555586f2dd in access_with_adjusted_size (addr=3Daddr@entry=3D1,
value=3Dvalue@entry=3D0x7fffca158510, size=3Dsize@entry=3D1,
access_size_min=3D<optimized out>, access_size_max=3D<optimized out>,
    access_fn=3D0x555555872440 <memory_region_oldmmio_read_accessor>,
mr=3D0x5555567fa870, attrs=3D...) at
/home/liqiang02/qemu-devel/qemu/memory.c:593
#3  0x0000555555873e90 in memory_region_dispatch_read1 (attrs=3D..., size=
=3D1,
pval=3D0x7fffca158510, addr=3D1, mr=3D0x5555567fa870) at
/home/liqiang02/qemu-devel/qemu/memory.c:1404
#4  memory_region_dispatch_read (mr=3Dmr@entry=3D0x5555567fa870, addr=3D1,
pval=3Dpval@entry=3D0x7fffca158510, size=3D1, attrs=3Dattrs@entry=3D...) at
/home/liqiang02/qemu-devel/qemu/memory.c:1423
#5  0x0000555555821e42 in flatview_read_continue (fv=3Dfv@entry=3D0x7fffbc0=
3f370,
addr=3Daddr@entry=3D1297, attrs=3D..., buf=3D<optimized out>, buf@entry=3D0=
x7ffff7fee000
"", len=3Dlen@entry=3D1, addr1=3D<optimized out>, l=3D<optimized out>,
mr=3D0x5555567fa870)
    at /home/liqiang02/qemu-devel/qemu/exec.c:3293
#6  0x0000555555822006 in flatview_read (fv=3D0x7fffbc03f370, addr=3D1297,
attrs=3D..., buf=3D0x7ffff7fee000 "", len=3D1) at
/home/liqiang02/qemu-devel/qemu/exec.c:3331
#7  0x000055555582211f in address_space_read_full (as=3D<optimized out>,
addr=3Daddr@entry=3D1297, attrs=3D..., buf=3Dbuf@entry=3D0x7ffff7fee000 "",
len=3Dlen@entry=3D1) at /home/liqiang02/qemu-devel/qemu/exec.c:3344
#8  0x000055555582225a in address_space_rw (as=3D<optimized out>,
addr=3Daddr@entry=3D1297, attrs=3D..., attrs@entry=3D..., buf=3Dbuf@entry=
=3D0x7ffff7fee000
"", len=3Dlen@entry=3D1, is_write=3Dis_write@entry=3Dfalse)
    at /home/liqiang02/qemu-devel/qemu/exec.c:3374
#9  0x0000555555886239 in kvm_handle_io (count=3D1, size=3D1,
direction=3D<optimized out>, data=3D<optimized out>, attrs=3D..., port=3D12=
97) at
/home/liqiang02/qemu-devel/qemu/accel/kvm/kvm-all.c:1731
#10 kvm_cpu_exec (cpu=3Dcpu@entry=3D0x5555566e9990) at
/home/liqiang02/qemu-devel/qemu/accel/kvm/kvm-all.c:1971
#11 0x000055555585d3de in qemu_kvm_cpu_thread_fn (arg=3D0x5555566e9990) at
/home/liqiang02/qemu-devel/qemu/cpus.c:1257
#12 0x00007fffdbd58494 in start_thread () from
/lib/x86_64-linux-gnu/libpthread.so.0
#13 0x00007fffdba9aacf in clone () from /lib/x86_64-linux-gnu/libc.so.6

So I send out this path.

But this time when I not use gdb, there is no segmentation.

So this may not a issue.

If who has a arm environment, he can try this, the PoC is just easy. just
read the 0x510 port with word.

Thanks,
Li Qiang


>
> > ---
> >  hw/nvram/fw_cfg.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> > index d79a568f54..6de7809f1a 100644
> > --- a/hw/nvram/fw_cfg.c
> > +++ b/hw/nvram/fw_cfg.c
> > @@ -434,6 +434,11 @@ static bool fw_cfg_data_mem_valid(void *opaque,
> hwaddr addr,
> >      return addr =3D=3D 0;
> >  }
> >
> > +static uint64_t fw_cfg_ctl_mem_read(void *opaque, hwaddr addr, unsigne=
d
> size)
> > +{
> > +    return 0;
> > +}
> > +
> >  static void fw_cfg_ctl_mem_write(void *opaque, hwaddr addr,
> >                                   uint64_t value, unsigned size)
> >  {
> > @@ -468,6 +473,7 @@ static bool fw_cfg_comb_valid(void *opaque, hwaddr
> addr,
> >  }
> >
> >  static const MemoryRegionOps fw_cfg_ctl_mem_ops =3D {
> > +    .read =3D fw_cfg_ctl_mem_read,
> >      .write =3D fw_cfg_ctl_mem_write,
> >      .endianness =3D DEVICE_BIG_ENDIAN,
> >      .valid.accepts =3D fw_cfg_ctl_mem_valid,
> > --
> > 2.11.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
