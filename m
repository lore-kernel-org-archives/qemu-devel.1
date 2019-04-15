Received: from eggs.gnu.org ([209.51.188.92]:42666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1ds-0004jE-Tp
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hG1dr-00055i-4r
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 09:27:24 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Mon, 15 Apr 2019 15:27:21 +0200
Message-Id: <1555334842-195718-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
References: <1555334842-195718-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/5] memory: make MemoryRegion alias
 migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Helge Deller <deller@gmx.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

use qemu_ram_alloc_from_ptr() to create aliased RAMBlock
to the part of original memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 exec.c   | 7 ++++---
 memory.c | 5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/exec.c b/exec.c
index 6ab62f4..0fc10d1 100644
--- a/exec.c
+++ b/exec.c
@@ -2255,7 +2255,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
                                         new_block->used_length,
                                         DIRTY_CLIENTS_ALL);
 
-    if (new_block->host) {
+    if (new_block->host && !new_block->mr->alias) {
         qemu_ram_setup_dump(new_block->host, new_block->max_length);
         qemu_madvise(new_block->host, new_block->max_length, QEMU_MADV_HUGEPAGE);
         /* MADV_DONTFORK is also needed by KVM in absence of synchronous MMU */
@@ -2613,7 +2613,8 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
 
     rcu_read_lock();
     block = atomic_rcu_read(&ram_list.mru_block);
-    if (block && block->host && host - block->host < block->max_length) {
+    if (block && !block->mr->alias && block->host &&
+        host - block->host < block->max_length) {
         goto found;
     }
 
@@ -2622,7 +2623,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
         if (block->host == NULL) {
             continue;
         }
-        if (host - block->host < block->max_length) {
+        if (!block->mr->alias && host - block->host < block->max_length) {
             goto found;
         }
     }
diff --git a/memory.c b/memory.c
index 9fbca52..687a147 100644
--- a/memory.c
+++ b/memory.c
@@ -1672,6 +1672,11 @@ void memory_region_init_alias(MemoryRegion *mr,
     memory_region_init(mr, owner, name, size);
     mr->alias = orig;
     mr->alias_offset = offset;
+    if (orig->ram_block && size) {
+        mr->ram_block = qemu_ram_alloc_from_ptr(size,
+                                                orig->ram_block->host + offset,
+                                                mr, &error_fatal);
+    }
 }
 
 void memory_region_init_rom_nomigrate(MemoryRegion *mr,
-- 
2.7.4
