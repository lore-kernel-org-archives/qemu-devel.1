Received: from eggs.gnu.org ([2001:4830:134:3::10]:47262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=3683a44df=anthony.perard@citrix.com>)
	id 1dYYKe-00061q-NM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:51:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=3683a44df=anthony.perard@citrix.com>)
	id 1dYYKa-0002Y3-Pr
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:51:04 -0400
Received: from smtp.citrix.com ([66.165.176.89]:8350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=3683a44df=anthony.perard@citrix.com>)
	id 1dYYKa-0002X2-JQ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 09:51:00 -0400
Date: Fri, 21 Jul 2017 14:50:57 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170721135057.GJ1587@perard.uk.xensource.com>
References: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
	<1500416562-27337-1-git-send-email-sstabellini@kernel.org>
	<1500416562-27337-6-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1500416562-27337-6-git-send-email-sstabellini@kernel.org>
Subject: Re: [Qemu-devel] [PULL for-2.10 6/7] xen/mapcache: introduce
 xen_replace_cache_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Igor Druzhinin <igor.druzhinin@citrix.com>

On Tue, Jul 18, 2017 at 03:22:41PM -0700, Stefano Stabellini wrote:
> From: Igor Druzhinin <igor.druzhinin@citrix.com>

...

> +static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
> +                                                 hwaddr new_phys_addr,
> +                                                 hwaddr size)
> +{
> +    MapCacheEntry *entry;
> +    hwaddr address_index, address_offset;
> +    hwaddr test_bit_size, cache_size = size;
> +
> +    address_index  = old_phys_addr >> MCACHE_BUCKET_SHIFT;
> +    address_offset = old_phys_addr & (MCACHE_BUCKET_SIZE - 1);
> +
> +    assert(size);
> +    /* test_bit_size is always a multiple of XC_PAGE_SIZE */
> +    test_bit_size = size + (old_phys_addr & (XC_PAGE_SIZE - 1));
> +    if (test_bit_size % XC_PAGE_SIZE) {
> +        test_bit_size += XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZE);
> +    }
> +    cache_size = size + address_offset;
> +    if (cache_size % MCACHE_BUCKET_SIZE) {
> +        cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
> +    }
> +
> +    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
> +    while (entry && !(entry->paddr_index == address_index &&
> +                      entry->size == cache_size)) {
> +        entry = entry->next;
> +    }
> +    if (!entry) {
> +        DPRINTF("Trying to update an entry for %lx " \
> +                "that is not in the mapcache!\n", old_phys_addr);
> +        return NULL;
> +    }
> +
> +    address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
> +    address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
> +
> +    fprintf(stderr, "Replacing a dummy mapcache entry for %lx with %lx\n",
> +            old_phys_addr, new_phys_addr);

Looks likes this does not build on 32bits.
in: http://logs.test-lab.xenproject.org/osstest/logs/112041/build-i386/6.ts-xen-build.log

/home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c: In function 'xen_replace_cache_entry_unlocked':
/home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c:539:13: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'hwaddr' [-Werror=format=]
             old_phys_addr, new_phys_addr);
             ^
/home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c:539:13: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'hwaddr' [-Werror=format=]
cc1: all warnings being treated as errors
  CC      i386-softmmu/target/i386/gdbstub.o
/home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/rules.mak:66: recipe for target 'hw/i386/xen/xen-mapcache.o' failed

> +
> +    xen_remap_bucket(entry, entry->vaddr_base,
> +                     cache_size, address_index, false);
> +    if (!test_bits(address_offset >> XC_PAGE_SHIFT,
> +                test_bit_size >> XC_PAGE_SHIFT,
> +                entry->valid_mapping)) {
> +        DPRINTF("Unable to update a mapcache entry for %lx!\n", old_phys_addr);
> +        return NULL;
> +    }
> +
> +    return entry->vaddr_base + address_offset;
> +}
> +

-- 
Anthony PERARD
