Received: from eggs.gnu.org ([2001:4830:134:3::10]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JC-0004Nx-Px
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX6JB-0005XF-VA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX6JB-0005Ww-PJ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B03497CB88
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 13:43:32 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 17 Jul 2017 15:42:33 +0200
Message-Id: <20170717134238.1966-13-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-1-quintela@redhat.com>
References: <20170717134238.1966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v5 12/17] migration: Send the fd number which
 we are going to use for this page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

We are still sending the page through the main channel, that would
change later in the series

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 90e1bcb..ac0742f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -568,7 +568,7 @@ static int multifd_send_page(uint8_t *address)
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
-    return 0;
+    return i;
 }
 
 struct MultiFDRecvParams {
@@ -1143,6 +1143,7 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
                             bool last_stage)
 {
     int pages;
+    uint16_t fd_num;
     uint8_t *p;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
@@ -1154,8 +1155,10 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
         ram_counters.transferred +=
             save_page_header(rs, rs->f, block,
                              offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
+        fd_num = multifd_send_page(p);
+        qemu_put_be16(rs->f, fd_num);
+        ram_counters.transferred += 2; /* size of fd_num */
         qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
-        multifd_send_page(p);
         ram_counters.transferred += TARGET_PAGE_SIZE;
         pages = 1;
         ram_counters.normal++;
@@ -2905,6 +2908,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
         void *host = NULL;
+        uint16_t fd_num;
         uint8_t ch;
 
         addr = qemu_get_be64(f);
@@ -3015,6 +3019,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
             break;
 
         case RAM_SAVE_FLAG_MULTIFD_PAGE:
+            fd_num = qemu_get_be16(f);
+            if (fd_num != 0) {
+                /* this is yet an unused variable, changed later */
+                fd_num = fd_num;
+            }
             qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
             break;
 
-- 
2.9.4
