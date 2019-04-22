Received: from eggs.gnu.org ([209.51.188.92]:46274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINeM-0005oi-GV
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hINeL-0003EH-83
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:21:38 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:43960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hINeL-0003Dp-1T
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 21:21:37 -0400
Received: by mail-oi1-x22b.google.com with SMTP id t81so7435727oig.10
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 18:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190420161446.2274-1-liq3ea@163.com>
	<20190420161446.2274-4-liq3ea@163.com>
	<4eb444fe-7e45-1072-770b-17f0db493b6d@redhat.com>
In-Reply-To: <4eb444fe-7e45-1072-770b-17f0db493b6d@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 22 Apr 2019 09:21:00 +0800
Message-ID: <CAKXe6SKKkao0gnGdvDWXbs9AG6uXLkeMybLH-7AP2-CiP7EEdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] edu: uses uint64_t in dma operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, Jiri Slaby <jslaby@suse.cz>, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=
=9C=8821=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:32=E5=86=99=E9=81=
=93=EF=BC=9A

> On 4/20/19 6:14 PM, Li Qiang wrote:
> > The dma related variable is dma_addr_t, it is uint64_t in
> > x64 platform. Change these usage from uint32_to uint64_t to
> > avoid trancation.
>
> "to avoid address truncation"?
>
>

The dma.dst/src/cnt..is from guest and is 64-bits. But in 'edu_dma_timer',
it is assigned to uint32_t, If it is 0xffffffff 00000000, it will be ok by
the check
but it is of course not allowed.

Though this is just an edu device, I think we should avoid this.

Thanks,
Li Qiang



> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> > Change since v1:
> > Fix format compile error on Windows
> >
> >  hw/misc/edu.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> > index 4018dddcb8..f4a6d5f1c5 100644
> > --- a/hw/misc/edu.c
> > +++ b/hw/misc/edu.c
> > @@ -98,23 +98,24 @@ static void edu_lower_irq(EduState *edu, uint32_t
> val)
> >      }
> >  }
> >
> > -static bool within(uint32_t addr, uint32_t start, uint32_t end)
> > +static bool within(uint64_t addr, uint64_t start, uint64_t end)
>
> OK.
>
> >  {
> >      return start <=3D addr && addr < end;
> >  }
> >
> > -static void edu_check_range(uint32_t addr, uint32_t size1, uint32_t
> start,
> > +static void edu_check_range(uint64_t addr, uint64_t size1, uint64_t
> start,
> >                  uint32_t size2)
>
> OK for addr. MMIO range is 1MiB so you can keep uint32_t for
> size1/size2. Up to the maintainer (personally I'd prefer keep u32).
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> >  {
> > -    uint32_t end1 =3D addr + size1;
> > -    uint32_t end2 =3D start + size2;
> > +    uint64_t end1 =3D addr + size1;
> > +    uint64_t end2 =3D start + size2;
> >
> >      if (within(addr, start, end2) &&
> >              end1 > addr && within(end1, start, end2)) {
> >          return;
> >      }
> >
> > -    hw_error("EDU: DMA range 0x%.8x-0x%.8x out of bounds
> (0x%.8x-0x%.8x)!",
> > +    hw_error("EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
> > +             " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
> >              addr, end1 - 1, start, end2 - 1);
> >  }
> >
> > @@ -139,13 +140,13 @@ static void edu_dma_timer(void *opaque)
> >      }
> >
> >      if (EDU_DMA_DIR(edu->dma.cmd) =3D=3D EDU_DMA_FROM_PCI) {
> > -        uint32_t dst =3D edu->dma.dst;
> > +        uint64_t dst =3D edu->dma.dst;
> >          edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
> >          dst -=3D DMA_START;
> >          pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
> >                  edu->dma_buf + dst, edu->dma.cnt);
> >      } else {
> > -        uint32_t src =3D edu->dma.src;
> > +        uint64_t src =3D edu->dma.src;
> >          edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
> >          src -=3D DMA_START;
> >          pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
> >
>
