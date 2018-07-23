Received: from eggs.gnu.org ([2001:4830:134:3::10]:38413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fha1f-0003c5-C3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fha1e-0004pO-Da
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fha1e-0004pB-8D
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 08:33:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D895D401EF01
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 12:33:17 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 23 Jul 2018 20:33:03 +0800
Message-Id: <20180723123305.24792-3-peterx@redhat.com>
In-Reply-To: <20180723123305.24792-1-peterx@redhat.com>
References: <20180723123305.24792-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.0 2/4] migration: disallow recovery for
 release-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Postcopy recovery won't work well with release-ram capability since
release-ram will drop the page buffer as long as the page is put into
the send buffer.  So if there is a network failure happened, any page
buffers that have not yet reached the destination VM but have already
been sent from the source VM will be lost forever.  Let's refuse the
client from resuming such a postcopy migration.  Luckily release-ram was
designed to only be used when src and destination VMs are on the same
host, so it should be fine.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 8d56d56930..09447f2bb5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1629,6 +1629,25 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                        "paused migration");
             return false;
         }
+
+        /*
+         * Postcopy recovery won't work well with release-ram
+         * capability since release-ram will drop the page buffer as
+         * long as the page is put into the send buffer.  So if there
+         * is a network failure happened, any page buffers that have
+         * not yet reached the destination VM but have already been
+         * sent from the source VM will be lost forever.  Let's refuse
+         * the client from resuming such a postcopy migration.
+         * Luckily release-ram was designed to only be used when src
+         * and destination VMs are on the same host, so it should be
+         * fine.
+         */
+        if (migrate_release_ram()) {
+            error_setg(errp, "Postcopy recovery cannot work "
+                       "when release-ram capability is set");
+            return false;
+        }
+
         /* This is a resume, skip init status */
         return true;
     }
-- 
2.17.1
