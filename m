Received: from eggs.gnu.org ([2001:4830:134:3::10]:39119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEN-00083H-Kd
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1euMEM-0003LR-Le
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:54:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1euMEM-0003LG-Ga
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:54:58 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri,  9 Mar 2018 17:54:49 +0000
Message-Id: <20180309175453.41548-3-dgilbert@redhat.com>
In-Reply-To: <20180309175453.41548-1-dgilbert@redhat.com>
References: <20180309175453.41548-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] migration: do not transfer ram during bulk
 storage migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pl@kamp.de, peterx@redhat.com, quintela@redhat.com

From: Peter Lieven <pl@kamp.de>

this patch makes the bulk phase of a block migration to take
place before we start transferring ram. As the bulk block migration
can take a long time its pointless to transfer ram during that phase.

Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <1520507908-16743-2-git-send-email-pl@kamp.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 3b6c077964..7266351fd0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2258,6 +2258,13 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     int64_t t0;
     int done = 0;
 
+    if (blk_mig_bulk_active()) {
+        /* Avoid transferring ram during bulk phase of block migration as
+         * the bulk phase will usually take a long time and transferring
+         * ram updates during that time is pointless. */
+        goto out;
+    }
+
     rcu_read_lock();
     if (ram_list.version != rs->last_version) {
         ram_state_reset(rs);
@@ -2304,6 +2311,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      */
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
 
+out:
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ram_counters.transferred += 8;
 
-- 
2.14.3
