Received: from eggs.gnu.org ([2001:4830:134:3::10]:41675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRBn8-0003Mc-Uf
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRBn3-0003d0-V9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:49:46 -0500
Received: from [2a03:4000:1::4e2f:c7ac:d] (port=55288 helo=mail.weilnetz.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cRBn3-0003ce-Ou
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 00:49:41 -0500
References: <20161220163139.12016-1-famz@redhat.com>
	<20161220163139.12016-2-famz@redhat.com>
	<078da452-2793-88e4-7eec-591ba875c13f@weilnetz.de>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <127070fc-ded9-04aa-bbc8-2f96f1c9fed7@weilnetz.de>
Date: Wed, 11 Jan 2017 06:48:32 +0100
MIME-Version: 1.0
In-Reply-To: <078da452-2793-88e4-7eec-591ba875c13f@weilnetz.de>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>

On 01/11/17 06:38, Stefan Weil wrote:
> Hi,
>
> this fails for me when building with XEN support.
> I noticed the failure when testing the latest HAXM patches.
> See compiler output below.
>
> Regards
> Stefan

The patch compiles with this modification:


diff --git a/xen-mapcache.c b/xen-mapcache.c
index dc9b321491..31debdfb2c 100644
--- a/xen-mapcache.c
+++ b/xen-mapcache.c
@@ -163,7 +163,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
      err = g_malloc0(nb_pfn * sizeof (int));

      if (entry->vaddr_base != NULL) {
-        ram_block_removed(entry->vaddr_base, entry->size);
+        ram_block_notify_remove(entry->vaddr_base, entry->size);
          if (munmap(entry->vaddr_base, entry->size) != 0) {
              perror("unmap fails");
              exit(-1);
@@ -189,7 +189,7 @@ static void xen_remap_bucket(MapCacheEntry *entry,
      entry->valid_mapping = (unsigned long *) g_malloc0(sizeof(unsigned 
long) *
              BITS_TO_LONGS(size >> XC_PAGE_SHIFT));

-    ram_block_added(entry->vaddr_base, entry->size);
+    ram_block_notify_add(entry->vaddr_base, entry->size);
      bitmap_zero(entry->valid_mapping, nb_pfn);
      for (i = 0; i < nb_pfn; i++) {
          if (!err[i]) {
@@ -399,7 +399,7 @@ static void 
xen_invalidate_map_cache_entry_unlocked(uint8_t *buffer)
      }

      pentry->next = entry->next;
-    ram_block_removed(entry->vaddr_base, entry->size);
+    ram_block_notify_remove(entry->vaddr_base, entry->size);
      if (munmap(entry->vaddr_base, entry->size) != 0) {
          perror("unmap fails");
          exit(-1);
