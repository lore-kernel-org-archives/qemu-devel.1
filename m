Received: from eggs.gnu.org ([209.51.188.92]:43580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gmUJr-0000vs-TE
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gmUJq-0000hr-4M
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:00:39 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gmUJp-0000gh-TZ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:00:38 -0500
Received: by mail-pf1-x443.google.com with SMTP id b7so2150238pfi.8
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 18:00:36 -0800 (PST)
Date: Wed, 23 Jan 2019 18:00:33 -0800 (PST)
In-Reply-To: <CAKmqyKN+PEt8=z_OUHngj5w6V6ZQ4r+U4uEDFrFayWXo8S+1tA@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-283ef773-6344-48c3-a18d-c321084aba4d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: alistair23@gmail.com
Cc: philmd@redhat.com, qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, agraf@suse.de

On Tue, 15 Jan 2019 13:09:28 PST (-0800), alistair23@gmail.com wrote:
> On Mon, Jan 14, 2019 at 2:58 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> Hi Alistair,
>>
>> On 1/12/19 2:17 AM, Alistair Francis wrote:
>> > Cast the kernel start address to the target bit length.
>> >
>> > This ensures that we calculate the initrd offset to a valid address for
>> > the architecture.
>>
>> Can you add an example of the failure symptoms?
>
> I can.

Should I be waiting for a v3?

>
>>
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > Suggested-by: Alexander Graf <agraf@suse.de>
>> > Reported-by: Alexander Graf <agraf@suse.de>
>> > ---
>> > v2:
>> >  - Remove old comment
>> >  hw/riscv/sifive_e.c | 2 +-
>> >  hw/riscv/sifive_u.c | 2 +-
>> >  hw/riscv/spike.c    | 2 +-
>> >  hw/riscv/virt.c     | 2 +-
>> >  4 files changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>> > index 5d9d65ff29..e5d7fc548e 100644
>> > --- a/hw/riscv/sifive_e.c
>> > +++ b/hw/riscv/sifive_e.c
>> > @@ -74,7 +74,7 @@ static const struct MemmapEntry {
>> >      [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
>> >  };
>> >
>> > -static uint64_t load_kernel(const char *kernel_filename)
>> > +static target_ulong load_kernel(const char *kernel_filename)
>> >  {
>> >      uint64_t kernel_entry, kernel_high;
>>
>> Shouldn't you update load_elf() and co now to take target_ulong
>> arguments? This would fix this error generically for all archs.
>
> That is an option, but as load_elf() is called by every other machine
> I don't want to break them. It's entirely possible that other machines
> rely on this behaviour and changing it will break them.
>
> Alistair
>
>>
>> >
>> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
>> > index 3bd3b67507..3b3acec377 100644
>> > --- a/hw/riscv/sifive_u.c
>> > +++ b/hw/riscv/sifive_u.c
>> > @@ -65,7 +65,7 @@ static const struct MemmapEntry {
>> >
>> >  #define GEM_REVISION        0x10070109
>> >
>> > -static uint64_t load_kernel(const char *kernel_filename)
>> > +static target_ulong load_kernel(const char *kernel_filename)
>> >  {
>> >      uint64_t kernel_entry, kernel_high;
>> >
>> > diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
>> > index 268df04c3c..79cb4c1282 100644
>> > --- a/hw/riscv/spike.c
>> > +++ b/hw/riscv/spike.c
>> > @@ -53,7 +53,7 @@ static const struct MemmapEntry {
>> >      [SPIKE_DRAM] =     { 0x80000000,        0x0 },
>> >  };
>> >
>> > -static uint64_t load_kernel(const char *kernel_filename)
>> > +static target_ulong load_kernel(const char *kernel_filename)
>> >  {
>> >      uint64_t kernel_entry, kernel_high;
>> >
>> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> > index e7f0716fb6..648462b18c 100644
>> > --- a/hw/riscv/virt.c
>> > +++ b/hw/riscv/virt.c
>> > @@ -62,7 +62,7 @@ static const struct MemmapEntry {
>> >      [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
>> >  };
>> >
>> > -static uint64_t load_kernel(const char *kernel_filename)
>> > +static target_ulong load_kernel(const char *kernel_filename)
>> >  {
>> >      uint64_t kernel_entry, kernel_high;
>> >
>> >
