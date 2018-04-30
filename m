Received: from eggs.gnu.org ([2001:4830:134:3::10]:60335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDE1o-00033b-7q
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 15:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDE1k-0007cs-CZ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 15:00:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56042 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDE1k-0007bf-8U
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 14:59:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3785C406C794
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 18:59:50 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 30 Apr 2018 19:59:43 +0100
Message-Id: <20180430185943.35714-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] Migration+TLS: Fix crash due to double cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pkrempa@redhat.com, berrange@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

During a TLS connect we see:
  migration_channel_connect calls
  migration_tls_channel_connect
  (calls after TLS setup)
  migration_channel_connect

My previous error handling fix made migration_channel_connect
call migrate_fd_connect in all cases; unfortunately the above
means it gets called twice and crashes doing double cleanup.

Fixes: 688a3dcba98

Reported-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/channel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index c5eaf0fa0e..7a32b5aca4 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -71,6 +71,15 @@ void migration_channel_connect(MigrationState *s,
             !object_dynamic_cast(OBJECT(ioc),
                                  TYPE_QIO_CHANNEL_TLS)) {
             migration_tls_channel_connect(s, ioc, hostname, &error);
+
+            if (!error) {
+                /* tls_channel_connect will call back to this
+                 * function after the TLS handshake,
+                 * so we mustn't call migrate_fd_connect until then
+                 */
+
+                return;
+            }
         } else {
             QEMUFile *f = qemu_fopen_channel_output(ioc);
 
-- 
2.17.0
