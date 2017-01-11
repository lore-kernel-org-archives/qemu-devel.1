Received: from eggs.gnu.org ([2001:4830:134:3::10]:39320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRBco-0007j6-2b
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRBcn-00087r-6a
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:39:06 -0500
References: <20161220163139.12016-1-famz@redhat.com>
	<20161220163139.12016-2-famz@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <078da452-2793-88e4-7eec-591ba875c13f@weilnetz.de>
Date: Wed, 11 Jan 2017 06:38:55 +0100
MIME-Version: 1.0
In-Reply-To: <20161220163139.12016-2-famz@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] ramblock-notifier: new
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

Hi,

this fails for me when building with XEN support.
I noticed the failure when testing the latest HAXM patches.
See compiler output below.

Regards
Stefan


On 12/20/16 17:31, Fam Zheng wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> This adds a notify interface of ram block additions and removals.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
[...]
> diff --git a/xen-mapcache.c b/xen-mapcache.c
> index 8f3a592..dc9b321 100644
> --- a/xen-mapcache.c
> +++ b/xen-mapcache.c
> @@ -163,6 +163,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
>      err = g_malloc0(nb_pfn * sizeof (int));
>
>      if (entry->vaddr_base != NULL) {
> +        ram_block_removed(entry->vaddr_base, entry->size);
>          if (munmap(entry->vaddr_base, entry->size) != 0) {
>              perror("unmap fails");
>              exit(-1);
> @@ -188,6 +189,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
>      entry->valid_mapping = (unsigned long *) g_malloc0(sizeof(unsigned long) *
>              BITS_TO_LONGS(size >> XC_PAGE_SHIFT));
>
> +    ram_block_added(entry->vaddr_base, entry->size);
>      bitmap_zero(entry->valid_mapping, nb_pfn);
>      for (i = 0; i < nb_pfn; i++) {
>          if (!err[i]) {
> @@ -397,6 +399,7 @@ static void xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
>      }
>
>      pentry->next = entry->next;
> +    ram_block_removed(entry->vaddr_base, entry->size);
>      if (munmap(entry->vaddr_base, entry->size) != 0) {
>          perror("unmap fails");
>          exit(-1);
>

   CC      x86_64-softmmu/xen-mapcache.o
/qemu/xen-mapcache.c: In function 'xen_remap_bucket':
/qemu/xen-mapcache.c:166:9: error: implicit declaration of function 
'ram_block_removed' [-Werror=implicit-function-declaration]
          ram_block_removed(entry->vaddr_base, entry->size);
          ^~~~~~~~~~~~~~~~~
/qemu/xen-mapcache.c:166:9: error: nested extern declaration of 
'ram_block_removed' [-Werror=nested-externs]
/qemu/xen-mapcache.c:192:5: error: implicit declaration of function 
'ram_block_added' [-Werror=implicit-function-declaration]
      ram_block_added(entry->vaddr_base, entry->size);
      ^~~~~~~~~~~~~~~
/qemu/xen-mapcache.c:192:5: error: nested extern declaration of 
'ram_block_added' [-Werror=nested-externs]
cc1: all warnings being treated as errors
/qemu/rules.mak:64: recipe for target 'xen-mapcache.o' failed
make[1]: *** [xen-mapcache.o] Error 1
Makefile:203: recipe for target 'subdir-x86_64-softmmu' failed
make: *** [subdir-x86_64-softmmu] Error 2
