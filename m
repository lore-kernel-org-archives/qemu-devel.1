Received: from eggs.gnu.org ([2001:4830:134:3::10]:45238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFv-0008C5-2Z
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6DFu-0000cs-7l
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6DFu-0000cS-1P
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:41:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBFC961D15
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 09:41:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  4 May 2017 11:40:45 +0200
Message-Id: <20170504094053.2329-3-quintela@redhat.com>
In-Reply-To: <20170504094053.2329-1-quintela@redhat.com>
References: <20170504094053.2329-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 02/10] migration: setup bi-directional I/O
 channel for exec: protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

Historically the migration data channel has only needed to be
unidirectional. Thus the 'exec:' protocol was requesting an
I/O channel with O_RDONLY on incoming side, and O_WRONLY on
the outgoing side.

This is fine for classic migration, but if you then try to run
TLS over it, this fails because the TLS handshake requires a
bi-directional channel.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 9157721..aba9089 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -32,7 +32,7 @@ void exec_start_outgoing_migration(MigrationState *s, const char *command, Error
 
     trace_migration_exec_outgoing(command);
     ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_WRONLY,
+                                                    O_RDWR,
                                                     errp));
     if (!ioc) {
         return;
@@ -59,7 +59,7 @@ void exec_start_incoming_migration(const char *command, Error **errp)
 
     trace_migration_exec_incoming(command);
     ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDONLY,
+                                                    O_RDWR,
                                                     errp));
     if (!ioc) {
         return;
-- 
2.9.3
