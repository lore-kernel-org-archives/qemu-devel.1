Received: from eggs.gnu.org ([2001:4830:134:3::10]:36261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZhd1-0003x0-4H
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:26:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZhcw-0002qA-M9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:26:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZhcw-0002q4-Fm
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 12:26:26 -0500
References: <1486141597-13941-1-git-send-email-fred.konrad@greensocs.com>
	<1486141597-13941-5-git-send-email-fred.konrad@greensocs.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d64a7dfd-cb55-ba59-9731-282bb98cf20e@redhat.com>
Date: Fri, 3 Feb 2017 09:26:19 -0800
MIME-Version: 1.0
In-Reply-To: <1486141597-13941-5-git-send-email-fred.konrad@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/5] exec: allow to get a pointer for some
 mmio memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fred.konrad@greensocs.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com, alistair.francis@xilinx.com, clg@kaod.org, mark.burton@greensocs.com



On 03/02/2017 09:06, fred.konrad@greensocs.com wrote:
> +    host = mr->ops->request_ptr(mr->opaque, addr - mr->addr, &size, &offset);
> +
> +    if (!host || !size) {
> +        memory_region_transaction_commit();
> +        return false;
> +    }
> +
> +    sub = g_new(MemoryRegion, 1);
> +    memory_region_init_ram_ptr(sub, OBJECT(mr), "mmio-map", size, host);
> +    memory_region_add_subregion(mr, offset, sub);
> +    memory_region_transaction_commit();
> +    return true;
> +}
> +
> +void memory_region_invalidate_mmio_ptr(MemoryRegion *mr, hwaddr offset,
> +                                       unsigned size)
> +{
> +    MemoryRegionSection section = memory_region_find(mr, offset, size);
> +
> +    if (section.mr != mr) {
> +        memory_region_del_subregion(mr, section.mr);
> +        /* memory_region_find add a ref on section.mr */
> +        memory_region_unref(section.mr);
> +        object_unparent(OBJECT(section.mr));

I think this would cause a use-after-free when using MTTCG.  In general,
creating and dropping MemoryRegions dynamically can cause bugs that are
nondeterministic and hard to fix without rewriting everything.

An alternative design could be:

- memory_region_request_mmio_ptr returns a MemoryRegionCache instead of
a pointer, so that the device can map a subset of the device (e.g. a
single page)

- memory_region_request_mmio_ptr and MemoryRegionOps.request_ptr accept
a Notifier

- the device adds the Notifier to a NotifierList.  Before invalidating,
it invokes the Notifier and empties the NotifierList.

- for the TLB case, the Notifier calls tlb_flush_page.

I like the general idea though!

Paolo

> +    }
> +}
