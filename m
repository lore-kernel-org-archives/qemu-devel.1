Received: from eggs.gnu.org ([2001:4830:134:3::10]:55129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cK07S-00085q-4I
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cK07R-0006Wr-9w
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 04:57:02 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161220163139.12016-1-famz@redhat.com>
	<20161220163139.12016-2-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7a2cfc9-ec55-b50c-d2ea-078d425d94e2@redhat.com>
Date: Thu, 22 Dec 2016 10:56:50 +0100
MIME-Version: 1.0
In-Reply-To: <20161220163139.12016-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>


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

My mistake here, these should be ram_block_notify_{add,remove} instead.

Paolo
