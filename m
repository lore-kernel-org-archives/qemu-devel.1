Received: from eggs.gnu.org ([2001:4830:134:3::10]:51799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gKjfR-0002j1-Ew
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:44:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1gKjfQ-0007UF-9X
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:44:13 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:42778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1gKjfQ-0007SJ-2L
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:44:12 -0500
Received: by mail-qk1-x743.google.com with SMTP id m5so2426906qka.9
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 04:44:07 -0800 (PST)
References: <20181108010258.27010-1-aik@ozlabs.ru>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <03fc996a-7f14-4751-88c2-458c0caa86f0@gmail.com>
Date: Thu, 8 Nov 2018 10:44:02 -0200
MIME-Version: 1.0
In-Reply-To: <20181108010258.27010-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH qemu] hmp: Print if memory section is
 registered in KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org



On 11/7/18 11:02 PM, Alexey Kardashevskiy wrote:
> This adds a "KVM" marker to the "into mtree -f" to tell the user if
> a particular memory section is registered as a KVM memory slot; useful
> for debugging purposes.
>
> Since it is memory sections which get registered in KVM (rather than
> memory regions), this only prints "KVM" for flatviews.
>
> For example:
>   Root memory region: system
>    0000000000000000-00000003ffffffff (prio 0, ram): ppc_spapr.ram KVM
>    0000200000000020-000020000000003f (prio 1, i/o): virtio-pci
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---


Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Tested-by: Daniel Henrique Barboza <danielhb413@gmail.com>


>   include/sysemu/kvm.h |  1 +
>   accel/kvm/kvm-all.c  |  7 +++++++
>   memory.c             | 10 ++++++++++
>   3 files changed, 18 insertions(+)
>
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 97d8d9d0d5..9eab5ac1b1 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -471,6 +471,7 @@ void kvm_set_sigmask_len(KVMState *s, unsigned int sigmask_len);
>   #if !defined(CONFIG_USER_ONLY)
>   int kvm_physical_memory_addr_from_host(KVMState *s, void *ram_addr,
>                                          hwaddr *phys_addr);
> +bool is_kvm_memory(hwaddr start_addr, hwaddr size);
>   #endif
>   
>   #endif /* NEED_CPU_H */
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4880a05399..d72808aaa6 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -216,6 +216,13 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
>       return NULL;
>   }
>   
> +bool is_kvm_memory(hwaddr start_addr, hwaddr size)
> +{
> +    KVMMemoryListener *kml = &kvm_state->memory_listener;
> +
> +    return NULL != kvm_lookup_matching_slot(kml, start_addr, size);
> +}
> +
>   /*
>    * Calculate and align the start address and the size of the section.
>    * Return the size. If the size is 0, the aligned section is empty.
> diff --git a/memory.c b/memory.c
> index 51204aa079..56c733c687 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2916,6 +2916,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>       int n = view->nr;
>       int i;
>       AddressSpace *as;
> +    bool print_kvm = false;
>   
>       p(f, "FlatView #%d\n", fvi->counter);
>       ++fvi->counter;
> @@ -2927,6 +2928,9 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>               p(f, ", alias %s", memory_region_name(as->root->alias));
>           }
>           p(f, "\n");
> +        if (as == &address_space_memory) {
> +            print_kvm = true;
> +        }
>       }
>   
>       p(f, " Root memory region: %s\n",
> @@ -2960,6 +2964,12 @@ static void mtree_print_flatview(gpointer key, gpointer value,
>           if (fvi->owner) {
>               mtree_print_mr_owner(p, f, mr);
>           }
> +
> +        if (kvm_enabled() && print_kvm &&
> +            is_kvm_memory(int128_get64(range->addr.start),
> +                          MR_SIZE(range->addr.size) + 1)) {
> +            p(f, " KVM");
> +        }
>           p(f, "\n");
>           range++;
>       }
