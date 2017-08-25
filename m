Received: from eggs.gnu.org ([2001:4830:134:3::10]:57701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlFSg-0002LQ-3Y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlFSe-0002FH-Rn
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:19:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dlFSe-0002F6-Li
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:19:48 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 25 Aug 2017 15:19:39 +0100
Message-Id: <20170825141940.20740-2-dgilbert@redhat.com>
In-Reply-To: <20170825141940.20740-1-dgilbert@redhat.com>
References: <20170825141940.20740-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] migration: Reset rather than destroy
 main_thread_load_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shorne@gmail.com, quintela@redhat.com, mreitz@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

migration_incoming_state_destroy doesn't really destroy, it cleans up.
After a loadvm it's called, but the loadvm command can be run twice,
and so destroying an init-once mutex breaks on the second loadvm.

Reported-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index c3fe0ed9ca..a625551ce5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -167,7 +167,7 @@ void migration_incoming_state_destroy(void)
         mis->from_src_file = NULL;
     }
 
-    qemu_event_destroy(&mis->main_thread_load_event);
+    qemu_event_reset(&mis->main_thread_load_event);
 }
 
 static void migrate_generate_event(int new_state)
-- 
2.13.5
