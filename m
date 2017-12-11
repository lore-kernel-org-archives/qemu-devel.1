Received: from eggs.gnu.org ([2001:4830:134:3::10]:56599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOXqd-0001Ll-HD
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 18:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOXqZ-0006Jk-Jq
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 18:50:59 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:43043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eOXqZ-0006JN-Cn
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 18:50:55 -0500
Received: by mail-wm0-f42.google.com with SMTP id n138so17579483wmg.2
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 15:50:55 -0800 (PST)
References: <20171211194610.3962-1-dgilbert@redhat.com>
	<20171211194610.3962-2-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97feaaf8-b08e-2c49-6cdb-b1556f6326cd@redhat.com>
Date: Tue, 12 Dec 2017 00:50:51 +0100
MIME-Version: 1.0
In-Reply-To: <20171211194610.3962-2-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] memory: address_space_iterate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com
Cc: maxime.coquelin@redhat.com, groug@kaod.org, mst@redhat.com

On 11/12/2017 20:46, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Iterate through an address space calling a function for each
> section.  The iteration is done in order.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

It seems to me that you can achieve the same effect by implementing the
region_add and region_nop callbacks, and leaving out region_del.  Am I
missing something?

Thanks,

Paolo

> ---
>  include/exec/memory.h | 23 +++++++++++++++++++++++
>  memory.c              | 22 ++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 5ed4042f87..f5a9df642e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1987,6 +1987,29 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
>      address_space_write(cache->as, cache->xlat + addr, MEMTXATTRS_UNSPECIFIED, buf, len);
>  }
>  
> +/**
> + * ASIterateCallback: Function type called by address_space_iterate
> + *
> + * Return 0 on success or a negative error code.
> + *
> + * @mrs: Memory region section for this range
> + * @opaque: The opaque value passed in to the iterator.
> + */
> +typedef int (*ASIterateCallback)(MemoryRegionSection *mrs, void *opaque);
> +
> +/**
> + * address_space_iterate: Call the function for each address range in the
> + *                        AddressSpace, in sorted order.
> + *
> + * Return 0 on success or a negative error code.
> + *
> + * @as: Address space to iterate over
> + * @cb: Function to call.  If the function returns none-0 the iteration will
> + *     stop.
> + * @opaque: Value to pass to the function
> + */
> +int
> +address_space_iterate(AddressSpace *as, ASIterateCallback cb, void *opaque);
>  #endif
>  
>  #endif
> diff --git a/memory.c b/memory.c
> index e26e5a3b1d..f45137f25e 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2810,6 +2810,28 @@ void address_space_destroy(AddressSpace *as)
>      call_rcu(as, do_address_space_destroy, rcu);
>  }
>  
> +int address_space_iterate(AddressSpace *as, ASIterateCallback cb,
> +                          void *opaque)
> +{
> +    int res = 0;
> +    FlatView *fv = address_space_to_flatview(as);
> +    FlatRange *range;
> +
> +    flatview_ref(fv);
> +
> +    FOR_EACH_FLAT_RANGE(range, fv) {
> +        MemoryRegionSection mrs = section_from_flat_range(range, fv);
> +        res = cb(&mrs, opaque);
> +        if (res) {
> +            break;
> +        }
> +    }
> +
> +    flatview_unref(fv);
> +
> +    return res;
> +}
> +
>  static const char *memory_region_type(MemoryRegion *mr)
>  {
>      if (memory_region_is_ram_device(mr)) {
> 
