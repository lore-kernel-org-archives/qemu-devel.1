Received: from eggs.gnu.org ([2001:4830:134:3::10]:48819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0aVG-0004Zh-D9
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 18:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f0aVE-0001Ud-Oa
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 18:22:10 -0400
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:36393)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f0aVE-0001UG-Hz
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 18:22:08 -0400
Received: by mail-ot0-x22c.google.com with SMTP id n40-v6so5504418otd.3
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 15:22:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA87phZ=TvT_p0YO0b4q3F6c1UCiQUe-opoiuo3KadMQ9w@mail.gmail.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
	<1521915220-65389-2-git-send-email-mjc@sifive.com>
	<CAFEAcA9zMy1hp1dWoyQPsyzC9VWpdxz3KKWTu4fsVCvAk6CSrA@mail.gmail.com>
	<CAHNT7NuPLa7GWD_WRUYDm+ZUAh9GYir2wxJr9hw=JNGXrdBkXw@mail.gmail.com>
	<CAFEAcA87phZ=TvT_p0YO0b4q3F6c1UCiQUe-opoiuo3KadMQ9w@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Mon, 26 Mar 2018 15:22:07 -0700
Message-ID: <CAHNT7NtTeNvFUSSydxN4cw5kXp9=DuOWgUT62JmoCE1_EVpUJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 06/26] RISC-V: Mark ROM read-only after
 copying in code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, RISC-V Patches <patches@groups.riscv.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On Sun, Mar 25, 2018 at 5:47 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 25 March 2018 at 00:23, Michael Clark <mjc@sifive.com> wrote:
> >
> >
> > On Sat, Mar 24, 2018 at 2:23 PM, Peter Maydell <peter.maydell@linaro.org
> >
> > wrote:
> >>
> >> On 24 March 2018 at 18:13, Michael Clark <mjc@sifive.com> wrote:
> >> > The sifive_u machine already marks its ROM readonly. This fixes
> >> > the remaining boards.
> >> >
> >> > Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> >> > Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> >> > Signed-off-by: Michael Clark <mjc@sifive.com>
> >> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> >> > ---
> >> >  hw/riscv/sifive_u.c      |  9 +++++----
> >> >  hw/riscv/spike.c         | 18 ++++++++++--------
> >> >  hw/riscv/virt.c          |  7 ++++---
> >> >  include/hw/riscv/spike.h |  8 --------
> >> >  4 files changed, 19 insertions(+), 23 deletions(-)
> >> >
> >> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> >> > index 6116c38..25df16c 100644
> >> > --- a/hw/riscv/sifive_u.c
> >> > +++ b/hw/riscv/sifive_u.c
> >> > @@ -223,7 +223,7 @@ static void riscv_sifive_u_init(MachineState
> >> > *machine)
> >> >      SiFiveUState *s = g_new0(SiFiveUState, 1);
> >> >      MemoryRegion *sys_memory = get_system_memory();
> >> >      MemoryRegion *main_mem = g_new(MemoryRegion, 1);
> >> > -    MemoryRegion *boot_rom = g_new(MemoryRegion, 1);
> >> > +    MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
> >> >
> >> >      /* Initialize SOC */
> >> >      object_initialize(&s->soc, sizeof(s->soc),
> TYPE_RISCV_HART_ARRAY);
> >> > @@ -246,10 +246,10 @@ static void riscv_sifive_u_init(MachineState
> >> > *machine)
> >> >      create_fdt(s, memmap, machine->ram_size,
> machine->kernel_cmdline);
> >> >
> >> >      /* boot rom */
> >> > -    memory_region_init_ram(boot_rom, NULL, "riscv.sifive.u.mrom",
> >> > +    memory_region_init_ram(mask_rom, NULL, "riscv.sifive.u.mrom",
> >> >                             memmap[SIFIVE_U_MROM].base, &error_fatal);
> >> > -    memory_region_set_readonly(boot_rom, true);
> >> > -    memory_region_add_subregion(sys_memory, 0x0, boot_rom);
> >> > +    memory_region_set_readonly(mask_rom, true);
> >> > +    memory_region_add_subregion(sys_memory, 0x0, mask_rom);
> >>
> >> memory_region_init_ram + memory_region_set_readonly is
> >> equivalent to memory_region_init_rom.
> >>
> >> >      if (machine->kernel_filename) {
> >> >          load_kernel(machine->kernel_filename);
> >> > @@ -279,6 +279,7 @@ static void riscv_sifive_u_init(MachineState
> >> > *machine)
> >> >      qemu_fdt_dumpdtb(s->fdt, s->fdt_size);
> >> >      cpu_physical_memory_write(memmap[SIFIVE_U_MROM].base +
> >> >          sizeof(reset_vec), s->fdt, s->fdt_size);
> >> > +    memory_region_set_readonly(mask_rom, true);
> >>
> >> Rather than doing this, you should use
> >> rom_add_blob_fixed(). That works even on ROMs which
> >> means you can just create them as read-only from the
> >> start rather than waiting til you've written to them
> >> and then marking them read-only. It also means that
> >> you get the contents correctly reset on reset, even
> >> if the user has been messing with their contents
> >> via the debugger or something.
> >>
> >> hw/arm/boot.c has code which (among a lot of other
> >> things) loads initial kernels and dtb images into
> >> guest memory. You can also find ppc code doing
> >> similar things.
> >
> >
> > I don't mind to make this change, however it is a case of good vs
> perfect.
> > Currently we have some machines with writable ROM sections, this change
> > fixes it and has been tested.
>
> Yes, I would put this on your set of things to
> address for 2.13.
>

Okay. It's on my list...

I will be replying to the other thread with a list of the oustanding
patches, whether they are bug fixes vs cleanups, and whether they are
reviewed.

The mstatus.FS fix is relatively critical and Igor's cpu init actually
fixes a bug with -cpu list. In any case I'll send a list shortly...
