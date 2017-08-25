Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dlAj6-0002rV-Kj
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dlAj3-0001aq-Dh
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:16:28 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:38577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dlAj3-0001Zc-5F
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:16:25 -0400
Received: by mail-pg0-x22d.google.com with SMTP id b8so11958089pgn.5
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 02:16:25 -0700 (PDT)
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
	<256c5d79-d940-3a7c-89e2-19a6140f5ccd@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6da6cc43-216d-75af-4610-6939a2fbfefd@ozlabs.ru>
Date: Fri, 25 Aug 2017 19:16:18 +1000
MIME-Version: 1.0
In-Reply-To: <256c5d79-d940-3a7c-89e2-19a6140f5ccd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

On 25/08/17 19:01, Paolo Bonzini wrote:
> On 25/08/2017 10:31, Alexey Kardashevskiy wrote:
>> Each address_space_init() updates topology for _every_ address space.
> 
> And finally, does this patch help with the above?
> 
> diff --git a/memory.c b/memory.c
> index c0adc35..97c16cc 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2607,10 +2607,16 @@ void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
>                            RUN_ON_CPU_HOST_PTR(invalidate_data));
>  }
>  
> +static void address_space_rebuild(AddressSpace *as)
> +{
> +    MEMORY_LISTENER_CALL(as, begin, Forward);
> +    address_space_update_topology(as);
> +    MEMORY_LISTENER_CALL(as, commit, Forward);
> +}
> +
>  void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>  {
>      memory_region_ref(root);
> -    memory_region_transaction_begin();
>      as->ref_count = 1;
>      as->root = root;
>      as->malloced = false;
> @@ -2622,8 +2628,7 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
>      as->name = g_strdup(name ? name : "anonymous");
>      address_space_init_dispatch(as);
> -    memory_region_update_pending |= root->enabled;
> -    memory_region_transaction_commit();
> +    address_space_rebuild(as);
>  }
>  
>  static void do_address_space_destroy(AddressSpace *as)
> 
> 
> Completely untested because vacation is coming.


Friday night arrived here already ;)


The patch did not help though (I also had to define section-less
MEMORY_LISTENER_CALL()). I'll look into your first suggestion on Monday.



-- 
Alexey
