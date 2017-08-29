Received: from eggs.gnu.org ([2001:4830:134:3::10]:49228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUD1-00020W-1O
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCx-0006Nm-Rq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58369
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCx-0006NS-Ke
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E8J5099513
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:43 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmr22ykuc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:43 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:42 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:43 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-9-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 08/79] migration: setup bi-directional I/O
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
Cc: qemu-stable@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>

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
(cherry picked from commit 062d81f0e968fe1597474735f3ea038065027372)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.7.4
