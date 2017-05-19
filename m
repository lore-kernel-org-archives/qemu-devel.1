Received: from eggs.gnu.org ([2001:4830:134:3::10]:45916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBeEu-0005AR-2z
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBeEq-00052t-6U
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:30:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBeEp-00052j-Ue
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:30:24 -0400
References: <1494972923-31756-1-git-send-email-anthony.xu@intel.com>
	<20170517112756.74cf6e47@nial.brq.redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1ACB970@ORSMSX112.amr.corp.intel.com>
	<6eff688c-b62e-8796-f852-a855079f3175@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1ACCB4D@ORSMSX112.amr.corp.intel.com>
	<3a55757b-fcdb-0829-c23d-68b1d416599f@redhat.com>
	<4712D8F4B26E034E80552F30A67BE0B1ACCCA9@ORSMSX112.amr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <551f2d35-53d3-1eda-9f39-d8b3f466f25a@redhat.com>
Date: Fri, 19 May 2017 11:30:17 +0200
MIME-Version: 1.0
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1ACCCA9@ORSMSX112.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Memory: use memory address space for
 cpu-memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 19/05/2017 01:28, Xu, Anthony wrote:
>> On 18/05/2017 23:48, Xu, Anthony wrote:
>>>> It should be called.  Alternatively you could try adding a new function
>>>> to mark address_space_memory as a never-destroyed AddressSpace:
>>>>
>>> This patch would do it, could you please submit this patch?
>>
>> If you have tested it (together with the change in the initialization of
>> address_space_memory), I can do that.
>>
> 
> Based on your patch, I added the change in the initialization of 
> address_space_memory. It works well in my setup, cpu-memory
> address space doesn't show up as we expected.

Thanks.

I am also thinking of resolving aliases early, and sharing the
AddressSpaceDispatch if the root memory region is the same.  This
hopefully will also reduce memory consumption and speed up AddressSpace
updates.

Paolo

> Anthony
> 
> diff --git a/exec.c b/exec.c
> index 96e3ac9..746dbbc 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2712,7 +2712,7 @@ static void memory_map_init(void)
>      system_memory = g_malloc(sizeof(*system_memory));
> 
>      memory_region_init(system_memory, NULL, "system", UINT64_MAX);
> -    address_space_init(&address_space_memory, system_memory, "memory");
> +    address_space_init_static(&address_space_memory, system_memory, "memory");
> 
>      system_io = g_malloc(sizeof(*system_io));
>      memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io",
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index b27b288..6f44b79 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1395,6 +1395,17 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
>  void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
> 
>  /**
> + * address_space_init_static: initializes an static address space
> + *
> + * @as: an uninitialized #AddressSpace
> + * @root: a #MemoryRegion that routes addresses for the address space
> + * @name: an address space name.  The name is only used for debugging
> + *        output.
> + */
> +void address_space_init_static(AddressSpace *as, MemoryRegion *root,
> +       const char *name);
> +
> +/**
>   * address_space_init_shareable: return an address space for a memory region,
>   *                               creating it if it does not already exist
>   *
> diff --git a/memory.c b/memory.c
> index 190cd3d..6c933d8 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2461,7 +2461,8 @@ static void do_address_space_destroy(AddressSpace *as)
>      }
>  }
> 
> -void address_space_init_static(AddressSpace *as, MemoryRegion *root, const char *name)
> +void address_space_init_static(AddressSpace *as, MemoryRegion *root,
> +       const char *name)
>  {
>      address_space_init(as, root, name);
>      as->shared = true;
> 
