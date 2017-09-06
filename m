Received: from eggs.gnu.org ([2001:4830:134:3::10]:57710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGr-000359-I3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpfGo-0001rl-Ej
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpfGo-0001rF-8x
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:41:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29868C04B941
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 18:41:49 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Sep 2017 19:41:31 +0100
Message-Id: <20170906184133.25524-7-dgilbert@redhat.com>
In-Reply-To: <20170906184133.25524-1-dgilbert@redhat.com>
References: <20170906184133.25524-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] migration: Reset rather than destroy
 main_thread_load_event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, armbru@redhat.com, kwolf@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

migration_incoming_state_destroy doesn't really destroy, it cleans up.
After a loadvm it's called, but the loadvm command can be run twice,
and so destroying an init-once mutex breaks on the second loadvm.

Reported-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20170825141940.20740-2-dgilbert@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1a2b3ebd1a..9838ccc885 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -166,7 +166,7 @@ void migration_incoming_state_destroy(void)
         mis->from_src_file = NULL;
     }
 
-    qemu_event_destroy(&mis->main_thread_load_event);
+    qemu_event_reset(&mis->main_thread_load_event);
 }
 
 static void migrate_generate_event(int new_state)
-- 
2.13.5
