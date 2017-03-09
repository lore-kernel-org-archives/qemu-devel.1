Received: from eggs.gnu.org ([2001:4830:134:3::10]:60958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1clwLy-0005z5-7J
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <c.pinto@virtualopensystems.com>) id 1clwLu-0004kj-VU
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:30 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <c.pinto@virtualopensystems.com>)
	id 1clwLu-0004kK-PP
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:35:26 -0500
Received: by mail-wm0-x244.google.com with SMTP id u132so10439156wmg.1
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 03:35:26 -0800 (PST)
From: Christian Pinto <c.pinto@virtualopensystems.com>
Date: Thu,  9 Mar 2017 12:34:35 +0100
Message-Id: <20170309113437.9667-3-c.pinto@virtualopensystems.com>
In-Reply-To: <20170309113437.9667-1-c.pinto@virtualopensystems.com>
References: <57B7F948.9040701@huawei.com>
	<20170309113437.9667-1-c.pinto@virtualopensystems.com>
Subject: [Qemu-devel] [RFC PATCH 2/4] migration/ram: Fix for ARM/ARM64 page
 size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com
Cc: b.reynal@virtualopensystems.com, aarcange@redhat.com, quintela@redhat.com, dgilbert@redhat.com, amit.shah@redhat.com, peter.huangpeng@huawei.com, hanweidong@huawei.com, qemu-devel@nongnu.org, tech@virtualopensystems.com, Christian Pinto <c.pinto@virtualopensystems.com>

Architecture such as ARM use a page size of 1KB, while write protection
is done at the granularity of host pages (generally 4KB).
All addresses must always be aligned to the size of a host page.

Signed-off-by: Christian Pinto <c.pinto@virtualopensystems.com>
Signed-off-by: Baptiste Reynal <b.reynal@virtualopensystems.com>
---
 migration/postcopy-ram.c |  6 +++---
 migration/ram.c          | 18 ++++++++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9c45f1059f..97382067b3 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -373,7 +373,7 @@ int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
     return 0;
 }
 
-int ram_set_pages_wp(uint64_t page_addr,
+int ram_set_pages_wp(ram_addr_t page_addr,
                      uint64_t size,
                      bool remove,
                      int uffd)
@@ -556,10 +556,10 @@ static void *postcopy_ram_fault_thread(void *opaque)
             * will be an deadlock error.
             */
             if (migration_in_setup(ms)) {
-                uint64_t host = msg.arg.pagefault.address;
+                ram_addr_t host = msg.arg.pagefault.address;
 
                 host &= ~(hostpagesize - 1);
-                ret = ram_set_pages_wp(host, getpagesize(), true,
+                ret = ram_set_pages_wp(host, hostpagesize, true,
                                        us->userfault_fd);
                 if (ret < 0) {
                     error_report("Remove page's write-protect failed");
diff --git a/migration/ram.c b/migration/ram.c
index 3417c56f29..7a3b1c7ed3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1383,14 +1383,24 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
             /* For snapshot, we will remove the page write-protect here */
             if (migration_in_snapshot(ms)) {
                 int ret;
-                uint64_t host_addr = (uint64_t)(pss.block->host + pss.offset);
-
+                /*
+                 * Some architectures in QEMU use a smaller memory page size
+                 * with respect to the host page size. ARM as an example
+                 * uses 1K memory pages, while Linux supports pages of minimum
+                 * size of 4K.
+                 * Userfault write protection works at the level of a host page
+                 * and thus one full host page has to be protected/unprotected
+                 * every time.
+                 */
+                ram_addr_t host_addr = (ram_addr_t)(pss.block->host +
+                                    pss.offset) & (~(qemu_host_page_size - 1));
                 ret = ram_set_pages_wp(host_addr, getpagesize(), true,
                                        ms->userfault_state.userfault_fd);
                 if (ret < 0) {
                     error_report("Failed to remove the write-protect for page:"
-                                 "%"PRIx64 " length: %d, block: %s", host_addr,
-                                 getpagesize(), pss.block->idstr);
+                                "%"PRIx64 " length: %d, offset: %"PRIx64
+                                ", block: %s", host_addr, getpagesize(),
+                                pss.offset, pss.block->idstr);
                 }
             }
         }
-- 
2.11.0
