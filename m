Received: from eggs.gnu.org ([2001:4830:134:3::10]:34492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt3-0003Z7-H2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dSSt2-0001Ok-H7
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dSSt2-0001O7-BR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:49:24 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  4 Jul 2017 19:49:12 +0100
Message-Id: <20170704184915.31586-3-dgilbert@redhat.com>
In-Reply-To: <20170704184915.31586-1-dgilbert@redhat.com>
References: <20170704184915.31586-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] migration: Close file on failed migration
 load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, michael@hinespot.com, quintela@redhat.com, peterx@redhat.com, lvivier@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Closing the file before exit on a failure allows
the source to cleanup better, especially with RDMA.

Partial fix for https://bugs.launchpad.net/qemu/+bug/1545052

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/migration.c b/migration/migration.c
index 51ccd1a4c5..21d6902a29 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -355,6 +355,7 @@ static void process_incoming_migration_co(void *opaque)
                           MIGRATION_STATUS_FAILED);
         error_report("load of migration failed: %s", strerror(-ret));
         migrate_decompress_threads_join();
+        qemu_fclose(mis->from_src_file);
         exit(EXIT_FAILURE);
     }
 
-- 
2.13.0
