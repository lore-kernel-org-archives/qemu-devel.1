Received: from eggs.gnu.org ([2001:4830:134:3::10]:60325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cyIi3-00078V-EZ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cyIi2-0004cN-Ea
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:53:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cyIi2-0004bz-8V
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:53:22 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Apr 2017 15:53:11 +0200
Message-Id: <20170412135312.1686-2-lvivier@redhat.com>
In-Reply-To: <20170412135312.1686-1-lvivier@redhat.com>
References: <20170412135312.1686-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] migration: don't close a file
 descriptor while it can be in use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org

If we close the QEMUFile descriptor in process_incoming_migration_co()
while it has been stopped by an error, the postcopy_ram_listen_thread()
can try to continue to use it. And as the memory has been freed
it is working with an invalid pointer and crashes.

Fix this by releasing the memory after having managed the error
case (which, in fact, calls exit())

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 migration/migration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ad4036f..e024e0a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -436,9 +436,6 @@ static void process_incoming_migration_co(void *opaque)
         qemu_thread_join(&mis->colo_incoming_thread);
     }
 
-    qemu_fclose(f);
-    free_xbzrle_decoded_buf();
-
     if (ret < 0) {
         migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                           MIGRATION_STATUS_FAILED);
@@ -447,6 +444,9 @@ static void process_incoming_migration_co(void *opaque)
         exit(EXIT_FAILURE);
     }
 
+    qemu_fclose(f);
+    free_xbzrle_decoded_buf();
+
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
     qemu_bh_schedule(mis->bh);
 }
-- 
2.9.3
