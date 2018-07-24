Received: from eggs.gnu.org ([2001:4830:134:3::10]:35075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fhwF5-0003cn-2d
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fhwF3-0005Ep-1B
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:16:39 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fhwF2-0005EX-R3
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 08:16:36 -0400
Received: by mail-pg1-x544.google.com with SMTP id y4-v6so2781336pgp.9
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 05:16:36 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Tue, 24 Jul 2018 20:16:25 +0800
Message-Id: <1532434585-14732-2-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1532434585-14732-1-git-send-email-lidongchen@tencent.com>
References: <1532434585-14732-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH 2/2] migration: fix duplicate initialization
 for expected_downtime and cleanup_bh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

migrate_fd_connect duplicate initialize expected_downtime and cleanup_bh.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/migration.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index ff05422..b8c4fec 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3032,8 +3032,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     } else {
         /* This is a fresh new migration */
         rate_limit = s->parameters.max_bandwidth / XFER_LIMIT_RATIO;
-        s->expected_downtime = s->parameters.downtime_limit;
-        s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup, s);
 
         /* Notify before starting migration thread */
         notifier_list_notify(&migration_state_notifiers, s);
-- 
1.8.3.1
