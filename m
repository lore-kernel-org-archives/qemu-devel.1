Received: from eggs.gnu.org ([2001:4830:134:3::10]:36230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1WUR-0001UE-Ci
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d1WUO-00020Q-7E
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:12:39 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 21 Apr 2017 12:12:20 +0100
Message-Id: <20170421111220.32673-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: setup bi-directional I/O channel
 for exec: protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

Historically the migration data channel has only needed to be
unidirectional. Thus the 'exec:' protocol was requesting an
I/O channel with O_RDONLY on incoming side, and O_WRONLY on
the outgoing side.

This is fine for classic migration, but if you then try to run
TLS over it, this fails because the TLS handshake requires a
bi-directional channel.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
