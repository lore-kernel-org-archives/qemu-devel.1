Received: from eggs.gnu.org ([2001:4830:134:3::10]:56540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLP-0004Ts-L7
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cnPLM-0005xy-TU
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cnPLM-0005xZ-NT
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 08:44:56 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D49C04DD44
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 12:44:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 13 Mar 2017 13:44:30 +0100
Message-Id: <20170313124434.1043-13-quintela@redhat.com>
In-Reply-To: <20170313124434.1043-1-quintela@redhat.com>
References: <20170313124434.1043-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 12/16] migration: Send the fd number which we
 are going to use for this page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com

We are still sending the page through the main channel, that would
change later in the series

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 4914240..6f5ca50 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -577,7 +577,7 @@ static int multifd_send_page(uint8_t *address)
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
-    return 0;
+    return i;
 }
 
 struct MultiFDRecvParams {
@@ -1139,6 +1139,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
                             bool last_stage, uint64_t *bytes_transferred)
 {
     int pages;
+    uint16_t fd_num;
     uint8_t *p;
     RAMBlock *block = pss->block;
     ram_addr_t offset = pss->offset;
@@ -1152,8 +1153,10 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
     if (pages == -1) {
         *bytes_transferred +=
             save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
+        fd_num = multifd_send_page(p);
+        qemu_put_be16(f, fd_num);
+        *bytes_transferred += 2; /* size of fd_num */
         qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
-        multifd_send_page(p);
         *bytes_transferred += TARGET_PAGE_SIZE;
         pages = 1;
         acct_info.norm_pages++;
@@ -2898,6 +2901,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     while (!postcopy_running && !ret && !(flags & RAM_SAVE_FLAG_EOS)) {
         ram_addr_t addr, total_ram_bytes;
         void *host = NULL;
+        uint16_t fd_num;
         uint8_t ch;
 
         addr = qemu_get_be64(f);
@@ -3007,6 +3011,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
2.9.3
