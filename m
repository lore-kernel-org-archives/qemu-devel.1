Received: from eggs.gnu.org ([2001:4830:134:3::10]:40362)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ettZK-0004Xo-Vf
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ettZJ-00021T-1A
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:42 -0500
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:41508 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ettZI-00020b-Ou
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:18:40 -0500
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 8 Mar 2018 12:18:28 +0100
From: Peter Lieven <pl@kamp.de>
Date: Thu,  8 Mar 2018 12:18:24 +0100
Message-Id: <1520507908-16743-2-git-send-email-pl@kamp.de>
In-Reply-To: <1520507908-16743-1-git-send-email-pl@kamp.de>
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 1/5] migration: do not transfer ram during bulk
 storage migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com, Peter Lieven <pl@kamp.de>

this patch makes the bulk phase of a block migration to take
place before we start transferring ram. As the bulk block migration
can take a long time its pointless to transfer ram during that phase.

Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/ram.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 5e33e5c..42468ee 100644
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
2.7.4
