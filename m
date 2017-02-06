Received: from eggs.gnu.org ([2001:4830:134:3::10]:45302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canA8-0003sV-MA
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1canA7-0006OJ-St
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1canA7-0006OB-MR
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 12:33:11 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D98C681222
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 17:33:11 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon,  6 Feb 2017 17:32:52 +0000
Message-Id: <20170206173306.20603-3-dgilbert@redhat.com>
In-Reply-To: <20170206173306.20603-1-dgilbert@redhat.com>
References: <20170206173306.20603-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/16] postcopy: Transmit and compare
 individual page sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: aarcange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When using postcopy with hugepages, we require the source
and destination page sizes for any RAMBlock to match; note
that different RAMBlocks in the same VM can have different
page sizes.

Transmit them as part of the RAM information header and
fail if there's a difference.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index b405e4a..5726563 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1979,6 +1979,9 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         qemu_put_byte(f, strlen(block->idstr));
         qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
         qemu_put_be64(f, block->used_length);
+        if (migrate_postcopy_ram() && block->page_size != qemu_host_page_size) {
+            qemu_put_be64(f, block->page_size);
+        }
     }
 
     rcu_read_unlock();
@@ -2480,6 +2483,8 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
      * be atomic
      */
     bool postcopy_running = postcopy_state_get() >= POSTCOPY_INCOMING_LISTENING;
+    /* ADVISE is earlier, it shows the source has the postcopy capability on */
+    bool postcopy_advised = postcopy_state_get() >= POSTCOPY_INCOMING_ADVISE;
 
     seq_iter++;
 
@@ -2544,6 +2549,18 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
                             error_report_err(local_err);
                         }
                     }
+                    /* For postcopy we need to check hugepage sizes match */
+                    if (postcopy_advised &&
+                        block->page_size != qemu_host_page_size) {
+                        uint64_t remote_page_size = qemu_get_be64(f);
+                        if (remote_page_size != block->page_size) {
+                            error_report("Mismatched RAM page size %s "
+                                         "(local) %zd != %" PRId64,
+                                         id, block->page_size,
+                                         remote_page_size);
+                            ret = -EINVAL;
+                        }
+                    }
                     ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
                                           block->idstr);
                 } else {
-- 
2.9.3
