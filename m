Received: from eggs.gnu.org ([2001:4830:134:3::10]:38613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dYiHM-0002Q6-Ao
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dYiHJ-0002s3-6a
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dYiHI-0002qG-Uu
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 20:28:17 -0400
Date: Fri, 21 Jul 2017 17:28:12 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <c5ef20f3-a5c5-5245-77e3-19111c7e4488@citrix.com>
Message-ID: <alpine.DEB.2.10.1707211727540.22381@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
	<1500416562-27337-1-git-send-email-sstabellini@kernel.org>
	<1500416562-27337-6-git-send-email-sstabellini@kernel.org>
	<20170721135057.GJ1587@perard.uk.xensource.com>
	<c5ef20f3-a5c5-5245-77e3-19111c7e4488@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Igor Druzhinin <igor.druzhinin@citrix.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Fri, 21 Jul 2017, Igor Druzhinin wrote:
> On 21/07/17 14:50, Anthony PERARD wrote:
> > On Tue, Jul 18, 2017 at 03:22:41PM -0700, Stefano Stabellini wrote:
> > > From: Igor Druzhinin <igor.druzhinin@citrix.com>
> > 
> > ...
> > 
> > > +static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
> > > +                                                 hwaddr new_phys_addr,
> > > +                                                 hwaddr size)
> > > +{
> > > +    MapCacheEntry *entry;
> > > +    hwaddr address_index, address_offset;
> > > +    hwaddr test_bit_size, cache_size = size;
> > > +
> > > +    address_index  = old_phys_addr >> MCACHE_BUCKET_SHIFT;
> > > +    address_offset = old_phys_addr & (MCACHE_BUCKET_SIZE - 1);
> > > +
> > > +    assert(size);
> > > +    /* test_bit_size is always a multiple of XC_PAGE_SIZE */
> > > +    test_bit_size = size + (old_phys_addr & (XC_PAGE_SIZE - 1));
> > > +    if (test_bit_size % XC_PAGE_SIZE) {
> > > +        test_bit_size += XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZE);
> > > +    }
> > > +    cache_size = size + address_offset;
> > > +    if (cache_size % MCACHE_BUCKET_SIZE) {
> > > +        cache_size += MCACHE_BUCKET_SIZE - (cache_size %
> > > MCACHE_BUCKET_SIZE);
> > > +    }
> > > +
> > > +    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
> > > +    while (entry && !(entry->paddr_index == address_index &&
> > > +                      entry->size == cache_size)) {
> > > +        entry = entry->next;
> > > +    }
> > > +    if (!entry) {
> > > +        DPRINTF("Trying to update an entry for %lx " \
> > > +                "that is not in the mapcache!\n", old_phys_addr);
> > > +        return NULL;
> > > +    }
> > > +
> > > +    address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
> > > +    address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
> > > +
> > > +    fprintf(stderr, "Replacing a dummy mapcache entry for %lx with
> > > %lx\n",
> > > +            old_phys_addr, new_phys_addr);
> > 
> > Looks likes this does not build on 32bits.
> > in:
> > http://logs.test-lab.xenproject.org/osstest/logs/112041/build-i386/6.ts-xen-build.log
> > 
> > /home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c:
> > In function 'xen_replace_cache_entry_unlocked':
> > /home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c:539:13:
> > error: format '%lx' expects argument of type 'long unsigned int', but
> > argument 3 has type 'hwaddr' [-Werror=format=]
> >               old_phys_addr, new_phys_addr);
> >               ^
> > /home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c:539:13:
> > error: format '%lx' expects argument of type 'long unsigned int', but
> > argument 4 has type 'hwaddr' [-Werror=format=]
> > cc1: all warnings being treated as errors
> >    CC      i386-softmmu/target/i386/gdbstub.o
> > /home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/rules.mak:66:
> > recipe for target 'hw/i386/xen/xen-mapcache.o' failed
> > 
> > > +
> > > +    xen_remap_bucket(entry, entry->vaddr_base,
> > > +                     cache_size, address_index, false);
> > > +    if (!test_bits(address_offset >> XC_PAGE_SHIFT,
> > > +                test_bit_size >> XC_PAGE_SHIFT,
> > > +                entry->valid_mapping)) {
> > > +        DPRINTF("Unable to update a mapcache entry for %lx!\n",
> > > old_phys_addr);
> > > +        return NULL;
> > > +    }
> > > +
> > > +    return entry->vaddr_base + address_offset;
> > > +}
> > > +
> > 
> 
> Please, accept the attached patch to fix the issue.

The patch looks good to me. I'll send it upstream.
