Received: from eggs.gnu.org ([2001:4830:134:3::10]:53701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fXsZL-0003Ie-Uo
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fXsZL-0001o4-34
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fXsZK-0001nu-UP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 14:19:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97FC1818F02E
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 18:19:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 26 Jun 2018 20:19:32 +0200
Message-Id: <20180626181932.11909-14-quintela@redhat.com>
In-Reply-To: <20180626181932.11909-1-quintela@redhat.com>
References: <20180626181932.11909-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v16 14/14] migration: Stop sending whole pages
 through main channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We have to flush() the QEMUFile because now we sent really few data
through that channel.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 61f7313093..7d23b472cb 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1817,15 +1817,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
 static int ram_save_multifd_page(RAMState *rs, RAMBlock *block,
                                  ram_addr_t offset)
 {
-    uint8_t *p;
-
-    p = block->host + offset;
-
-    ram_counters.transferred += save_page_header(rs, rs->f, block,
-                                                 offset | RAM_SAVE_FLAG_PAGE);
     multifd_queue_page(block, offset);
-    qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
-    ram_counters.transferred += TARGET_PAGE_SIZE;
     ram_counters.normal++;
 
     return 1;
@@ -3066,6 +3058,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     multifd_send_sync_main();
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+    qemu_fflush(f);
 
     return 0;
 }
@@ -3148,6 +3141,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     multifd_send_sync_main();
 out:
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+    qemu_fflush(f);
     ram_counters.transferred += 8;
 
     ret = qemu_file_get_error(f);
@@ -3201,6 +3195,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     multifd_send_sync_main();
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+    qemu_fflush(f);
 
     return 0;
 }
-- 
2.17.1
