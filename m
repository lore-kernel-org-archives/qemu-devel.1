Received: from eggs.gnu.org ([209.51.188.92]:50642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpiB5-0007v1-Bp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gpi2T-0007xe-Te
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:16:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gpi2S-0007nh-Pp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:16:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so7774674wmd.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 15:15:57 -0800 (PST)
References: <154905879413.25667.2843143192142684785.malonedeb@chaenomeles.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a667006b-44e2-f72d-8164-c52a9374cb84@redhat.com>
Date: Sat, 2 Feb 2019 00:15:54 +0100
MIME-Version: 1.0
In-Reply-To: <154905879413.25667.2843143192142684785.malonedeb@chaenomeles.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1814343] [NEW] Initrd not loaded on riscv32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1814343 <1814343@bugs.launchpad.net>, qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Alistair Francis <alistair@alistair23.me>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>

Hi Jonathan,

On 2/1/19 11:06 PM, Jonathan Behrens wrote:
> Public bug reported:
> 
> I attempted to run qemu with a ram disk. However, when reading the
> contents of the disk from within the VM I only get back zeros.
> 
> I was able to trace the issue to a mismatch of expectations on line 93
> of hw/riscv/virt.c. Specifically, when running in 32-bit mode the value
> of kernel_entry is sign extended to 64-bits, but load_image_targphys
> expects the start address to not be sign extended.
> 
> Straw man patch (works for 32-bit but would probably break 64-bit VMs?):
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e7f0716fb6..32216f993c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -90,7 +90,7 @@ static hwaddr load_initrd(const char *filename, uint64_t mem_size,
>       * halfway into RAM, and for boards with 256MB of RAM or more we put
>       * the initrd at 128MB.
>       */
> -    *start = kernel_entry + MIN(mem_size / 2, 128 * MiB);
> +    *start = (kernel_entry & 0xffffffff) + MIN(mem_size / 2, 128 * MiB);
>  
>      size = load_ramdisk(filename, *start, mem_size - *start);
>      if (size == -1) {
> 
> 
> Run command:
> 
> $ qemu/build/riscv32-softmmu/qemu-system-riscv32 -machine virt -kernel
> mykernel.elf -nographic -initrd payload
> 
> Commit hash:
> 
> 3a183e330dbd7dbcac3841737ac874979552cca2
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New

I believe this is fixed by the following patch:
"Ensure the kernel start address is correctly cast"
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg06358.html

Can you test it?
If if works you can reply to it with a
"Tested-by: Jonathan Behrens <your-email>"
to increases the odds it get merged ;)

Thanks,

Phil.
