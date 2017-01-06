Received: from eggs.gnu.org ([2001:4830:134:3::10]:56954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFi-0002xE-3j
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cPZFh-00046C-9w
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cPZFh-00044c-34
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:28:33 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF600804EB
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 18:28:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  6 Jan 2017 18:28:13 +0000
Message-Id: <20170106182823.1960-6-dgilbert@redhat.com>
In-Reply-To: <20170106182823.1960-1-dgilbert@redhat.com>
References: <20170106182823.1960-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 05/15] postcopy: enhance ram_discard_range for
 hugepages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, amit.shah@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Unfortunately madvise DONTNEED doesn't work on hugepagetlb
so use fallocate(FALLOC_FL_PUNCH_HOLE)
qemu_fd_getpagesize only sets the page based off a file
if the file is from hugetlbfs.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index fe32836..7afabcd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -45,6 +45,10 @@
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
 
+#if defined(CONFIG_FALLOCATE_PUNCH_HOLE)
+#include <linux/falloc.h>
+#endif
+
 #ifdef DEBUG_MIGRATION_RAM
 #define DPRINTF(fmt, ...) \
     do { fprintf(stdout, "migration_ram: " fmt, ## __VA_ARGS__); } while (0)
@@ -1866,7 +1870,7 @@ int ram_discard_range(MigrationIncomingState *mis,
 
     uint8_t *host_startaddr = rb->host + start;
 
-    if ((uintptr_t)host_startaddr & (qemu_host_page_size - 1)) {
+    if ((uintptr_t)host_startaddr & (rb->page_size - 1)) {
         error_report("ram_discard_range: Unaligned start address: %p",
                      host_startaddr);
         goto err;
@@ -1874,15 +1878,27 @@ int ram_discard_range(MigrationIncomingState *mis,
 
     if ((start + length) <= rb->used_length) {
         uint8_t *host_endaddr = host_startaddr + length;
-        if ((uintptr_t)host_endaddr & (qemu_host_page_size - 1)) {
+        if ((uintptr_t)host_endaddr & (rb->page_size - 1)) {
             error_report("ram_discard_range: Unaligned end address: %p",
                          host_endaddr);
             goto err;
         }
-        errno = ENOTSUP;
+        errno = ENOTSUP; /* If we are missing MADVISE etc */
+
+        if (rb->page_size == qemu_host_page_size) {
 #if defined(CONFIG_MADVISE)
-        ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
+            ret = qemu_madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
 #endif
+        } else {
+            /* Huge page case  - unfortunately it can't do DONTNEED, but
+             * it can do the equivalent by FALLOC_FL_PUNCH_HOLE in the
+             * huge page file.
+             */
+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+                            start, length);
+#endif
+        }
         if (ret) {
             error_report("ram_discard_range: Failed to discard  range "
                          "%s:%" PRIx64 " +%zx (%d)",
-- 
2.9.3
