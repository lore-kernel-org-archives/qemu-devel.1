Received: from eggs.gnu.org ([2001:4830:134:3::10]:35455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjaaW-00055j-F8
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:56:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjaaR-0001br-Iy
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:56:48 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cjaaR-0001bM-Dh
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 18:56:43 -0500
Received: by mail-qk0-x241.google.com with SMTP id j127so5135567qke.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 15:56:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170302215603.27630-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fbe823b1-538c-6551-9fa6-4ea4967f1bd4@amsat.org>
Date: Thu, 2 Mar 2017 20:56:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170302215603.27630-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] memory: show region offset and ROM/RAM
 type in "info mtree -f"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: William Tambe <tambewilliam@gmail.com>, Peter Xu <peterx@redhat.com>

On 03/02/2017 06:56 PM, Paolo Bonzini wrote:
> "info mtree -f" output is currently hard to use for large RAM regions, because
> there is no hint as to what part of the region is being mapped.  Add the offset
> if it is nonzero.
>
> Secondly, FlatView has a readonly field, that can override the MemoryRegion
> in the presence of aliases.  Take it into account.
>
> Together, with this patch this:
>
> address-space (flat view): KVM-SMRAM
>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram
>   00000000000c0000-00000000000c9fff (prio 0, ram): pc.ram
>   00000000000ca000-00000000000ccfff (prio 0, ram): pc.ram
>   00000000000cd000-00000000000ebfff (prio 0, ram): pc.ram
>   00000000000ec000-00000000000effff (prio 0, ram): pc.ram
>   00000000000f0000-00000000000fffff (prio 0, ram): pc.ram
>   0000000000100000-00000000bfffffff (prio 0, ram): pc.ram
>   00000000fd000000-00000000fdffffff (prio 1, ram): vga.vram
>   00000000febc0000-00000000febdffff (prio 1, i/o): e1000-mmio
>   00000000febf0400-00000000febf041f (prio 0, i/o): vga ioports remapped
>   00000000febf0500-00000000febf0515 (prio 0, i/o): bochs dispi interface
>   00000000febf0600-00000000febf0607 (prio 0, i/o): qemu extended regs
>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>   0000000100000000-000000013fffffff (prio 0, ram): pc.ram
>
> becomes this:
>
> address-space (flat view): KVM-SMRAM
>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram
>   00000000000c0000-00000000000c9fff (prio 0, rom): pc.ram @00000000000c0000
>   00000000000ca000-00000000000ccfff (prio 0, ram): pc.ram @00000000000ca000
>   00000000000cd000-00000000000ebfff (prio 0, rom): pc.ram @00000000000cd000
>   00000000000ec000-00000000000effff (prio 0, ram): pc.ram @00000000000ec000
>   00000000000f0000-00000000000fffff (prio 0, rom): pc.ram @00000000000f0000
>   0000000000100000-00000000bfffffff (prio 0, ram): pc.ram @0000000000100000
>   00000000fd000000-00000000fdffffff (prio 1, ram): vga.vram
>   00000000febc0000-00000000febdffff (prio 1, i/o): e1000-mmio
>   00000000febf0400-00000000febf041f (prio 0, i/o): vga ioports remapped
>   00000000febf0500-00000000febf0515 (prio 0, i/o): bochs dispi interface
>   00000000febf0600-00000000febf0607 (prio 0, i/o): qemu extended regs
>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios
>   0000000100000000-000000013fffffff (prio 0, ram): pc.ram @00000000c0000000

nice! the last line specially :)

>
> This should make it easier to understand what's going on.
>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: "William Tambe" <tambewilliam@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  memory.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/memory.c b/memory.c
> index d61caee..44700c3 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2588,13 +2588,24 @@ static void mtree_print_flatview(fprintf_function p, void *f,
>
>      while (n--) {
>          mr = range->mr;
> -        p(f, MTREE_INDENT TARGET_FMT_plx "-"
> -          TARGET_FMT_plx " (prio %d, %s): %s\n",
> -          int128_get64(range->addr.start),
> -          int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
> -          mr->priority,
> -          memory_region_type(mr),
> -          memory_region_name(mr));
> +        if (range->offset_in_region) {
> +            p(f, MTREE_INDENT TARGET_FMT_plx "-"
> +              TARGET_FMT_plx " (prio %d, %s): %s @" TARGET_FMT_plx "\n",
> +              int128_get64(range->addr.start),
> +              int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
> +              mr->priority,
> +              memory_region_type(mr),
> +              memory_region_name(mr),
> +              range->offset_in_region);
> +        } else {
> +            p(f, MTREE_INDENT TARGET_FMT_plx "-"
> +              TARGET_FMT_plx " (prio %d, %s): %s\n",
> +              int128_get64(range->addr.start),
> +              int128_get64(range->addr.start) + MR_SIZE(range->addr.size),
> +              mr->priority,
> +              memory_region_type(mr),
> +              memory_region_name(mr));
> +        }
>          range++;
>      }
>
>
