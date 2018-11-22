Received: from eggs.gnu.org ([2001:4830:134:3::10]:43086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPeRJ-0004SV-MG
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gPeRI-0000T5-Sj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 21:09:57 -0500
MIME-Version: 1.0
References: <6559716eae4b53d2cad39ec6011cdd7b1b32138a.1542839652.git.alistair.francis@wdc.com>
	<mhng-3aa4aa94-927c-4ff8-867b-10d341c90d52@palmer-si-x1c4>
In-Reply-To: <mhng-3aa4aa94-927c-4ff8-867b-10d341c90d52@palmer-si-x1c4>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 21 Nov 2018 18:09:27 -0800
Message-ID: <CAKmqyKMdNs4etff7rc0vDy_tmZf5deP1Geu0GchkENu+em5=+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] riscv: virt: Cast the initrd start
 address to target bit length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org, Alexander Graf <agraf@suse.de>

On Wed, Nov 21, 2018 at 5:58 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 21 Nov 2018 14:34:44 PST (-0800), Alistair Francis wrote:
> > Ensure that the calculate initrd offset points to a valid address for
> > the architecture.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Suggested-by: Alexander Graf <agraf@suse.de>
> > Reported-by: Alexander Graf <agraf@suse.de>
> > ---
> >  hw/riscv/virt.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 2b38f89070..4467195fac 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -85,7 +85,12 @@ static hwaddr load_initrd(const char *filename, uint64_t mem_size,
> >       * halfway into RAM, and for boards with 256MB of RAM or more we put
> >       * the initrd at 128MB.
> >       */
> > -    *start = kernel_entry + MIN(mem_size / 2, 128 * MiB);
> > +    /* As hwaddr is a 64-bit number we need to cast it for 32-bit */
> > +#if defined(TARGET_RISCV32)
> > +    *start = (uint32_t) (kernel_entry + MIN(mem_size / 2, 128ULL * MiB));
> > +#elif defined(TARGET_RISCV64)
> > +    *start = (uint64_t) (kernel_entry + MIN(mem_size / 2, 128 * MiB));
> > +#endif
> >
> >      size = load_ramdisk(filename, *start, mem_size - *start);
> >      if (size == -1) {
> > --
> > 2.19.1
>
> Maybe I'm missing something, but wouldn't something like
>
>     uint64_t start_unclobbered = kernel_entry + MIN(mem_size / 2, 128ULL * MiB);
>     assert(start_unclobbered == (hwaddr)start_unclobbered);
>     *start = (hwaddr)start_unclobbered;
>
> work better?  That should actually check this all lines up, as opposed to just
> silently truncating a bad address.

The problem is that hwaddr is always 64-bit.

Stupidly I forgot about target_ulong, which should work basically the
same as above. An assert() seems a little harsh though, Alex reported
problem was fixed with just a cast.

Alistair
