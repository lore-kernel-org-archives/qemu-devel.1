Received: from eggs.gnu.org ([2001:4830:134:3::10]:46044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29M-0008VH-98
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29L-0002of-CY
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi29L-0002o5-7Q
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:07 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jul 2018 19:34:52 +0100
Message-Id: <20180724183454.120276-6-dgilbert@redhat.com>
In-Reply-To: <20180724183454.120276-1-dgilbert@redhat.com>
References: <20180724183454.120276-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] migration: disallow recovery for release-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, kraxel@redhat.com, lidongchen@tencent.com

From: Peter Xu <peterx@redhat.com>

Postcopy recovery won't work well with release-ram capability since
release-ram will drop the page buffer as long as the page is put into
the send buffer.  So if there is a network failure happened, any page
buffers that have not yet reached the destination VM but have already
been sent from the source VM will be lost forever.  Let's refuse the
client from resuming such a postcopy migration.  Luckily release-ram was
designed to only be used when src and destination VMs are on the same
host, so it should be fine.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180723123305.24792-3-peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index db6bde7453..bfc4d09aae 100644
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
