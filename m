Received: from eggs.gnu.org ([209.51.188.92]:34143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gjVyA-0005OC-Ue
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gjVy9-00067o-QT
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:09:58 -0500
MIME-Version: 1.0
References: <d2ae859d3d73ec1897d78131e05a6cf6ba6c94b0.1547255794.git.alistair.francis@wdc.com>
	<56d71bbd-e86b-db1c-8d45-7dd229b87081@redhat.com>
In-Reply-To: <56d71bbd-e86b-db1c-8d45-7dd229b87081@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 15 Jan 2019 13:09:28 -0800
Message-ID: <CAKmqyKN+PEt8=z_OUHngj5w6V6ZQ4r+U4uEDFrFayWXo8S+1tA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] riscv: Ensure the kernel start
 address is correctly cast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "agraf@suse.de" <agraf@suse.de>

On Mon, Jan 14, 2019 at 2:58 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Hi Alistair,
>
> On 1/12/19 2:17 AM, Alistair Francis wrote:
> > Cast the kernel start address to the target bit length.
> >
> > This ensures that we calculate the initrd offset to a valid address for
> > the architecture.
>
> Can you add an example of the failure symptoms?

I can.

>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Suggested-by: Alexander Graf <agraf@suse.de>
> > Reported-by: Alexander Graf <agraf@suse.de>
> > ---
> > v2:
> >  - Remove old comment
> >  hw/riscv/sifive_e.c | 2 +-
> >  hw/riscv/sifive_u.c | 2 +-
> >  hw/riscv/spike.c    | 2 +-
> >  hw/riscv/virt.c     | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> > index 5d9d65ff29..e5d7fc548e 100644
> > --- a/hw/riscv/sifive_e.c
> > +++ b/hw/riscv/sifive_e.c
> > @@ -74,7 +74,7 @@ static const struct MemmapEntry {
> >      [SIFIVE_E_DTIM] =3D     { 0x80000000,     0x4000 }
> >  };
> >
> > -static uint64_t load_kernel(const char *kernel_filename)
> > +static target_ulong load_kernel(const char *kernel_filename)
> >  {
> >      uint64_t kernel_entry, kernel_high;
>
> Shouldn't you update load_elf() and co now to take target_ulong
> arguments? This would fix this error generically for all archs.

That is an option, but as load_elf() is called by every other machine
I don't want to break them. It's entirely possible that other machines
rely on this behaviour and changing it will break them.

Alistair

>
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 3bd3b67507..3b3acec377 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -65,7 +65,7 @@ static const struct MemmapEntry {
> >
> >  #define GEM_REVISION        0x10070109
> >
> > -static uint64_t load_kernel(const char *kernel_filename)
> > +static target_ulong load_kernel(const char *kernel_filename)
> >  {
> >      uint64_t kernel_entry, kernel_high;
> >
> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> > index 268df04c3c..79cb4c1282 100644
> > --- a/hw/riscv/spike.c
> > +++ b/hw/riscv/spike.c
> > @@ -53,7 +53,7 @@ static const struct MemmapEntry {
> >      [SPIKE_DRAM] =3D     { 0x80000000,        0x0 },
> >  };
> >
> > -static uint64_t load_kernel(const char *kernel_filename)
> > +static target_ulong load_kernel(const char *kernel_filename)
> >  {
> >      uint64_t kernel_entry, kernel_high;
> >
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index e7f0716fb6..648462b18c 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -62,7 +62,7 @@ static const struct MemmapEntry {
> >      [VIRT_PCIE_ECAM] =3D   { 0x30000000,    0x10000000 },
> >  };
> >
> > -static uint64_t load_kernel(const char *kernel_filename)
> > +static target_ulong load_kernel(const char *kernel_filename)
> >  {
> >      uint64_t kernel_entry, kernel_high;
> >
> >
