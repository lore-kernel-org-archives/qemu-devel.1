Received: from eggs.gnu.org ([2001:4830:134:3::10]:45259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFw-0008Co-M1
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFv-0000ds-Sk
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6DFv-0000dO-ML
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A12A6C057FA5
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 09:41:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  4 May 2017 11:40:46 +0200
Message-Id: <20170504094053.2329-4-quintela@redhat.com>
In-Reply-To: <20170504094053.2329-1-quintela@redhat.com>
References: <20170504094053.2329-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 03/10] migration: to_dst_file at that point is
 NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

We have just arrived as:

migration.c: qemu_migrate()
  ....
  s = migrate_init() <- puts it to NULL
  ....
  {tcp,unix}_start_outgoing_migration ->
     socket_outgoing_migration
        migration_channel_connect()
	   sets to_dst_file

if tls is enabled, we do another round through
migrate_channel_tls_connect(), but we only set it up if there is no
error.  So we don't need the assignation.  I am removing it to remove
in the follwing patches the knowledge about MigrationState in that two
files.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/socket.c | 1 -
 migration/tls.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/migration/socket.c b/migration/socket.c
index 13966f1..dc88812 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -79,7 +79,6 @@ static void socket_outgoing_migration(QIOTask *task,
 
     if (qio_task_propagate_error(task, &err)) {
         trace_migration_socket_outgoing_error(error_get_pretty(err));
-        data->s->to_dst_file = NULL;
         migrate_fd_error(data->s, err);
         error_free(err);
     } else {
diff --git a/migration/tls.c b/migration/tls.c
index 45bec44..a33ecb7 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -116,7 +116,6 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
 
     if (qio_task_propagate_error(task, &err)) {
         trace_migration_tls_outgoing_handshake_error(error_get_pretty(err));
-        s->to_dst_file = NULL;
         migrate_fd_error(s, err);
         error_free(err);
     } else {
-- 
2.9.3
