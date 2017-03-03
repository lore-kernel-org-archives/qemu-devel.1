Received: from eggs.gnu.org ([2001:4830:134:3::10]:58724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cjf81-0007g8-83
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cjf7y-0004zo-59
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:47:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cjf7x-0004zI-Tl
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 23:47:38 -0500
Date: Fri, 3 Mar 2017 12:47:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170303044731.GC20768@pxdev.xzpeter.org>
References: <20170302215603.27630-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170302215603.27630-1-pbonzini@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, William Tambe <tambewilliam@gmail.com>

On Thu, Mar 02, 2017 at 10:56:03PM +0100, Paolo Bonzini wrote:
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
> 
> This should make it easier to understand what's going on.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: "William Tambe" <tambewilliam@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

A nit: if we are only appending a new optional addr to be printed, we
may just avoid printing the last "\n", then optinally print the last
address, so that common codes can still be shared. But not worth a
repost. :) Thanks,

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
> -- 
> 2.9.3
> 

-- peterx
