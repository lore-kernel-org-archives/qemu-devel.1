Received: from eggs.gnu.org ([2001:4830:134:3::10]:59654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoG-0004tk-3U
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etWoF-0006CV-5x
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1etWoF-0006C5-1e
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 06:00:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E92AEBFE6
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 11:00:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Mar 2018 11:59:58 +0100
Message-Id: <20180307110010.2205-13-quintela@redhat.com>
In-Reply-To: <20180307110010.2205-1-quintela@redhat.com>
References: <20180307110010.2205-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v10 12/24] migration: Reference counting recv
 channels correctly
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/socket.c | 11 +++++++++++
 migration/socket.h |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/migration/socket.c b/migration/socket.c
index b12b0a462e..26110739cf 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -27,6 +27,17 @@
 #include "io/channel-socket.h"
 #include "trace.h"
 
+int socket_recv_channel_ref(QIOChannel *recv)
+{
+    object_ref(OBJECT(recv));
+    return 0;
+}
+
+int socket_recv_channel_unref(QIOChannel *recv)
+{
+    object_unref(OBJECT(recv));
+    return 0;
+}
 
 static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
 {
diff --git a/migration/socket.h b/migration/socket.h
index 6b91e9db38..638a85255a 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -16,6 +16,13 @@
 
 #ifndef QEMU_MIGRATION_SOCKET_H
 #define QEMU_MIGRATION_SOCKET_H
+
+#include "io/channel.h"
+#include "io/task.h"
+
+int socket_recv_channel_ref(QIOChannel *recv);
+int socket_recv_channel_unref(QIOChannel *recv);
+
 void tcp_start_incoming_migration(const char *host_port, Error **errp);
 
 void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
-- 
2.14.3
