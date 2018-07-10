Received: from eggs.gnu.org ([2001:4830:134:3::10]:40801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuaz-00038v-QF
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuay-0003NK-QQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60500 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcuay-0003N0-MM
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A3DC40214E2
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:28 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:07 +0100
Message-Id: <20180710153016.131258-7-dgilbert@redhat.com>
In-Reply-To: <20180710153016.131258-1-dgilbert@redhat.com>
References: <20180710153016.131258-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] migration: loosen recovery check when
 load vm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: Peter Xu <peterx@redhat.com>

We were checking against -EIO, assuming that it will cover all IO
failures.  But actually it is not.  One example is that in
qemu_loadvm_section_start_full() we can have tons of places that will
return -EINVAL even if the error is caused by IO failures on the
network.

Let's loosen the recovery check logic here to cover all the error cases
happened by removing the explicit check against -EIO.  After all we
won't lose anything here if any other failure happened.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180710091902.28780-3-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/savevm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 851d74e8b6..efcc795071 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2276,18 +2276,14 @@ out:
         qemu_file_set_error(f, ret);
 
         /*
-         * Detect whether it is:
-         *
-         * 1. postcopy running (after receiving all device data, which
-         *    must be in POSTCOPY_INCOMING_RUNNING state.  Note that
-         *    POSTCOPY_INCOMING_LISTENING is still not enough, it's
-         *    still receiving device states).
-         * 2. network failure (-EIO)
-         *
-         * If so, we try to wait for a recovery.
+         * If we are during an active postcopy, then we pause instead
+         * of bail out to at least keep the VM's dirty data.  Note
+         * that POSTCOPY_INCOMING_LISTENING stage is still not enough,
+         * during which we're still receiving device states and we
+         * still haven't yet started the VM on destination.
          */
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
-            ret == -EIO && postcopy_pause_incoming(mis)) {
+            postcopy_pause_incoming(mis)) {
             /* Reset f to point to the newly created channel */
             f = mis->from_src_file;
             goto retry;
-- 
2.17.1
