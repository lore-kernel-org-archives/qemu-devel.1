Received: from eggs.gnu.org ([2001:4830:134:3::10]:52834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRb9R-0000Mr-4t
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRb9N-0001nd-Si
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:54:29 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRb9N-0001nE-Ln
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 03:54:25 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so2158230wmr.3
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 00:54:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1482307137-5106-1-git-send-email-peterx@redhat.com>
	<1482307137-5106-2-git-send-email-peterx@redhat.com>
	<f6e71117-81ce-db81-d469-d0b48b7cc794@redhat.com>
	<20170112055027.GK4450@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37865480-14d1-3a13-c083-013e834de1fc@redhat.com>
Date: Thu, 12 Jan 2017 09:54:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170112055027.GK4450@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] memory: provide common macros for
 mtree_print_mr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org



On 12/01/2017 06:50, Peter Xu wrote:
> On Wed, Jan 11, 2017 at 06:21:46PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 21/12/2016 08:58, Peter Xu wrote:
>>> -                   mr->romd_mode ? 'R' : '-',
>>> -                   !mr->readonly && !(mr->rom_device && mr->romd_mode) ? 'W'
>>> -                                                                       : '-',
>>> +                   MR_CHAR_RD(mr),
>>> +                   MR_CHAR_WR(mr),
>>
>> An alternative definition could be
>>
>> 	memory_access_is_direct(mr, false) ? 'R' : '-'
>> 	memory_access_is_direct(mr, true) ? 'W' : '-'
>>
>> for MR_CHAR_RD and MR_CHAR_WR.  With this change, I think the small code
>> duplication in the "? :" operator is tolerable and the code is clearer.
> 
> memory_access_is_direct() will check against whether mr is RAM, is
> that what we want here? In that case we'll get most of the regions as
> "--" as long as they are not RAM, while in fact IMHO we should want to
> know the rw permission for all cases.

Indeed.  My idea was that the RW permission is not well defined for
non-RAM memory regions, and ROMD regions in MMIO mode shows as "--"
while MMIO regions show as "RW".  But perhaps it's confusing.

What about writing one of "ram", "rom", "ramd", "romd", "i/o" (with I/O
also covering rom_device && !romd_mode)?

If you disagree, the below patch looks good.

Paolo

> --------8<--------
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index bec9756..50974c8 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1619,14 +1619,27 @@ MemTxResult address_space_read_full(AddressSpace *as, hwaddr addr,
>                                      MemTxAttrs attrs, uint8_t *buf, int len);
>  void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
> 
> +static inline bool memory_region_is_readable(MemoryRegion *mr)
> +{
> +    return mr->rom_device ? mr->romd_mode : true;
> +}
> +
> +static inline bool memory_region_is_writable(MemoryRegion *mr)
> +{
> +    return !mr->rom_device && !mr->readonly;
> +}
> +
> +static inline bool memory_region_is_direct(MemoryRegion *mr)
> +{
> +    return memory_region_is_ram(mr) && !memory_region_is_ram_device(mr);
> +}
> +
>  static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
>  {
>      if (is_write) {
> -        return memory_region_is_ram(mr) &&
> -               !mr->readonly && !memory_region_is_ram_device(mr);
> +        return memory_region_is_direct(mr) && memory_region_is_writable(mr);
>      } else {
> -        return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||
> -               memory_region_is_romd(mr);
> +        return memory_region_is_direct(mr) && memory_region_is_readable(mr);
>      }
>  }
> -------->8--------
> 
> Then, I can throw away MR_CHAR_* macros and use:
> 
>     memory_access_is_readable(mr, false) ? 'R' : '-'
>     memory_access_is_writable(mr, true) ? 'W' : '-'
> 
> Do you like this approach?
> 
> -- peterx
> 
> 
