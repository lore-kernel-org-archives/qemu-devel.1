Received: from eggs.gnu.org ([2001:4830:134:3::10]:57500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gRM9r-0006sz-5s
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:03:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gRM9n-0007uR-02
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:02:59 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gRM9m-0007uB-QR
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:02:54 -0500
Received: by mail-pg1-x544.google.com with SMTP id 17so6596588pgg.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:02:54 -0800 (PST)
Date: Mon, 26 Nov 2018 11:02:52 -0800 (PST)
In-Reply-To: <CAKmqyKMdNs4etff7rc0vDy_tmZf5deP1Geu0GchkENu+em5=+w@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-b345219b-56ea-4aee-b25e-95c762c54b49@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: alistair23@gmail.com
Cc: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, agraf@suse.de

On Wed, 21 Nov 2018 18:09:27 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Nov 21, 2018 at 5:58 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Wed, 21 Nov 2018 14:34:44 PST (-0800), Alistair Francis wrote:
>> > Ensure that the calculate initrd offset points to a valid address for
>> > the architecture.
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > Suggested-by: Alexander Graf <agraf@suse.de>
>> > Reported-by: Alexander Graf <agraf@suse.de>
>> > ---
>> >  hw/riscv/virt.c | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> > index 2b38f89070..4467195fac 100644
>> > --- a/hw/riscv/virt.c
>> > +++ b/hw/riscv/virt.c
>> > @@ -85,7 +85,12 @@ static hwaddr load_initrd(const char *filename, uint64_t mem_size,
>> >       * halfway into RAM, and for boards with 256MB of RAM or more we put
>> >       * the initrd at 128MB.
>> >       */
>> > -    *start = kernel_entry + MIN(mem_size / 2, 128 * MiB);
>> > +    /* As hwaddr is a 64-bit number we need to cast it for 32-bit */
>> > +#if defined(TARGET_RISCV32)
>> > +    *start = (uint32_t) (kernel_entry + MIN(mem_size / 2, 128ULL * MiB));
>> > +#elif defined(TARGET_RISCV64)
>> > +    *start = (uint64_t) (kernel_entry + MIN(mem_size / 2, 128 * MiB));
>> > +#endif
>> >
>> >      size = load_ramdisk(filename, *start, mem_size - *start);
>> >      if (size == -1) {
>> > --
>> > 2.19.1
>>
>> Maybe I'm missing something, but wouldn't something like
>>
>>     uint64_t start_unclobbered = kernel_entry + MIN(mem_size / 2, 128ULL * MiB);
>>     assert(start_unclobbered == (hwaddr)start_unclobbered);
>>     *start = (hwaddr)start_unclobbered;
>>
>> work better?  That should actually check this all lines up, as opposed to just
>> silently truncating a bad address.
>
> The problem is that hwaddr is always 64-bit.
>
> Stupidly I forgot about target_ulong, which should work basically the
> same as above. An assert() seems a little harsh though, Alex reported
> problem was fixed with just a cast.

OK, I must be misunderstanding the problem, then.  With the current code, isn't 
it possible to end up causing start to overflow a 32-bit address?  This would 
happen if kernel_entry is high, with IIUC is coming from the ELF to load and is 
therefor user input.  I think that's worth some sort of assertion, as it'll 
definitely blow up trying to enter the kernel (and possible before that, 
assuming there's no target memory where it overflows into).

This won't happen with the default Linux setup, but could happen if users are 
trying to do something weird.
