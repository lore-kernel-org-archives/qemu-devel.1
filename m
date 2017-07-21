Received: from eggs.gnu.org ([2001:4830:134:3::10]:40063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=368c2a73c=igor.druzhinin@citrix.com>)
	id 1dYcmE-00016f-N8
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=368c2a73c=igor.druzhinin@citrix.com>)
	id 1dYcmB-0005fk-JH
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:35:50 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:29445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=368c2a73c=igor.druzhinin@citrix.com>)
	id 1dYcmB-0005dy-3M
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:35:47 -0400
References: <alpine.DEB.2.10.1707181519030.17537@sstabellini-ThinkPad-X260>
	<1500416562-27337-1-git-send-email-sstabellini@kernel.org>
	<1500416562-27337-6-git-send-email-sstabellini@kernel.org>
	<20170721135057.GJ1587@perard.uk.xensource.com>
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <c5ef20f3-a5c5-5245-77e3-19111c7e4488@citrix.com>
Date: Fri, 21 Jul 2017 19:35:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170721135057.GJ1587@perard.uk.xensource.com>
Content-Type: multipart/mixed; boundary="------------9F9B41A6A0434498943244AD"
Content-Language: en-US
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
To: Anthony PERARD <anthony.perard@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

--------------9F9B41A6A0434498943244AD
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/17 14:50, Anthony PERARD wrote:
> On Tue, Jul 18, 2017 at 03:22:41PM -0700, Stefano Stabellini wrote:
>> From: Igor Druzhinin <igor.druzhinin@citrix.com>
> 
> ...
> 
>> +static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
>> +                                                 hwaddr new_phys_addr,
>> +                                                 hwaddr size)
>> +{
>> +    MapCacheEntry *entry;
>> +    hwaddr address_index, address_offset;
>> +    hwaddr test_bit_size, cache_size = size;
>> +
>> +    address_index  = old_phys_addr >> MCACHE_BUCKET_SHIFT;
>> +    address_offset = old_phys_addr & (MCACHE_BUCKET_SIZE - 1);
>> +
>> +    assert(size);
>> +    /* test_bit_size is always a multiple of XC_PAGE_SIZE */
>> +    test_bit_size = size + (old_phys_addr & (XC_PAGE_SIZE - 1));
>> +    if (test_bit_size % XC_PAGE_SIZE) {
>> +        test_bit_size += XC_PAGE_SIZE - (test_bit_size % XC_PAGE_SIZE);
>> +    }
>> +    cache_size = size + address_offset;
>> +    if (cache_size % MCACHE_BUCKET_SIZE) {
>> +        cache_size += MCACHE_BUCKET_SIZE - (cache_size % MCACHE_BUCKET_SIZE);
>> +    }
>> +
>> +    entry = &mapcache->entry[address_index % mapcache->nr_buckets];
>> +    while (entry && !(entry->paddr_index == address_index &&
>> +                      entry->size == cache_size)) {
>> +        entry = entry->next;
>> +    }
>> +    if (!entry) {
>> +        DPRINTF("Trying to update an entry for %lx " \
>> +                "that is not in the mapcache!\n", old_phys_addr);
>> +        return NULL;
>> +    }
>> +
>> +    address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
>> +    address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
>> +
>> +    fprintf(stderr, "Replacing a dummy mapcache entry for %lx with %lx\n",
>> +            old_phys_addr, new_phys_addr);
> 
> Looks likes this does not build on 32bits.
> in: http://logs.test-lab.xenproject.org/osstest/logs/112041/build-i386/6.ts-xen-build.log
> 
> /home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c: In function 'xen_replace_cache_entry_unlocked':
> /home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c:539:13: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'hwaddr' [-Werror=format=]
>               old_phys_addr, new_phys_addr);
>               ^
> /home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/hw/i386/xen/xen-mapcache.c:539:13: error: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'hwaddr' [-Werror=format=]
> cc1: all warnings being treated as errors
>    CC      i386-softmmu/target/i386/gdbstub.o
> /home/osstest/build.112041.build-i386/xen/tools/qemu-xen-dir/rules.mak:66: recipe for target 'hw/i386/xen/xen-mapcache.o' failed
> 
>> +
>> +    xen_remap_bucket(entry, entry->vaddr_base,
>> +                     cache_size, address_index, false);
>> +    if (!test_bits(address_offset >> XC_PAGE_SHIFT,
>> +                test_bit_size >> XC_PAGE_SHIFT,
>> +                entry->valid_mapping)) {
>> +        DPRINTF("Unable to update a mapcache entry for %lx!\n", old_phys_addr);
>> +        return NULL;
>> +    }
>> +
>> +    return entry->vaddr_base + address_offset;
>> +}
>> +
> 

Please, accept the attached patch to fix the issue.

Igor

--------------9F9B41A6A0434498943244AD
Content-Type: text/x-patch;
	name="0001-xen-fix-compilation-on-32-bit-hosts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-xen-fix-compilation-on-32-bit-hosts.patch"

>From 69a3afa453e283e92ddfd76109b203a20a02524c Mon Sep 17 00:00:00 2001
From: Igor Druzhinin <igor.druzhinin@citrix.com>
Date: Fri, 21 Jul 2017 19:27:41 +0100
Subject: [PATCH] xen: fix compilation on 32-bit hosts

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
---
 hw/i386/xen/xen-mapcache.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
index 84cc4a2..540406a 100644
--- a/hw/i386/xen/xen-mapcache.c
+++ b/hw/i386/xen/xen-mapcache.c
@@ -529,7 +529,7 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
         entry = entry->next;
     }
     if (!entry) {
-        DPRINTF("Trying to update an entry for %lx " \
+        DPRINTF("Trying to update an entry for "TARGET_FMT_plx \
                 "that is not in the mapcache!\n", old_phys_addr);
         return NULL;
     }
@@ -537,15 +537,16 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
     address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
     address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
 
-    fprintf(stderr, "Replacing a dummy mapcache entry for %lx with %lx\n",
-            old_phys_addr, new_phys_addr);
+    fprintf(stderr, "Replacing a dummy mapcache entry for "TARGET_FMT_plx \
+            " with "TARGET_FMT_plx"\n", old_phys_addr, new_phys_addr);
 
     xen_remap_bucket(entry, entry->vaddr_base,
                      cache_size, address_index, false);
     if(!test_bits(address_offset >> XC_PAGE_SHIFT,
                 test_bit_size >> XC_PAGE_SHIFT,
                 entry->valid_mapping)) {
-        DPRINTF("Unable to update a mapcache entry for %lx!\n", old_phys_addr);
+        DPRINTF("Unable to update a mapcache entry for "TARGET_FMT_plx"!\n",
+                old_phys_addr);
         return NULL;
     }
 
-- 
2.7.4


--------------9F9B41A6A0434498943244AD--
