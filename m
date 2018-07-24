Received: from eggs.gnu.org ([2001:4830:134:3::10]:46121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29Q-00007q-Kc
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fi29N-0002rG-L2
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fi29N-0002qr-Fc
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 14:35:09 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 24 Jul 2018 19:34:54 +0100
Message-Id: <20180724183454.120276-8-dgilbert@redhat.com>
In-Reply-To: <20180724183454.120276-1-dgilbert@redhat.com>
References: <20180724183454.120276-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 7/7] migration: fix duplicate initialization for
 expected_downtime and cleanup_bh
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

From: Lidong Chen <jemmy858585@gmail.com>

migrate_fd_connect duplicate initialize expected_downtime and cleanup_bh.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Message-Id: <1532434585-14732-2-git-send-email-lidongchen@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index bfc4d09aae..b7d9854bda 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3052,8 +3052,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     } else {
         /* This is a fresh new migration */
         rate_limit = s->parameters.max_bandwidth / XFER_LIMIT_RATIO;
-        s->expected_downtime = s->parameters.downtime_limit;
-        s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
 
         /* Notify before starting migration thread */
         notifier_list_notify(&migration_state_notifiers, s);
-- 
2.17.1
