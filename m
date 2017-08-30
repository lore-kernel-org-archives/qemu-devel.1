Received: from eggs.gnu.org ([2001:4830:134:3::10]:60004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6NV-0001pZ-Oq
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dn6NR-0000P3-6v
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:02:09 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 30 Aug 2017 13:01:41 -0400
Message-Id: <fc2539281a00353777c10f37dea6ccdb6aae4285.1504112256.git.jcody@redhat.com>
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
In-Reply-To: <cover.1504112256.git.jcody@redhat.com>
References: <cover.1504112256.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/3] block-jobs: Optionally unregister live
 block operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, dgilbert@redhat.com, mrezanin@redhat.com, ehabkost@redhat.com, peterx@redhat.com, jsnow@redhat.com

From: Jeffrey Cody <jcody@redhat.com>

If configured without live block operations enabled, unregister the
live block operation commands.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 monitor.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/monitor.c b/monitor.c
index e0f8801..de0a70e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -998,6 +998,22 @@ static void qmp_unregister_commands_hack(void)
     && !defined(TARGET_S390X)
     qmp_unregister_command(&qmp_commands, "query-cpu-definitions");
 #endif
+#ifndef CONFIG_LIVE_BLOCK_OPS
+    qmp_unregister_command(&qmp_commands, "block-stream");
+    qmp_unregister_command(&qmp_commands, "block-commit");
+    qmp_unregister_command(&qmp_commands, "drive-mirror");
+    qmp_unregister_command(&qmp_commands, "blockdev-mirror");
+    qmp_unregister_command(&qmp_commands, "drive-backup");
+    qmp_unregister_command(&qmp_commands, "blockdev-backup");
+    qmp_unregister_command(&qmp_commands, "blockdev-snapshot");
+    qmp_unregister_command(&qmp_commands, "blockdev-snapshot-sync");
+    qmp_unregister_command(&qmp_commands, "block-job-set-speed");
+    qmp_unregister_command(&qmp_commands, "block-job-cancel");
+    qmp_unregister_command(&qmp_commands, "block-job-pause");
+    qmp_unregister_command(&qmp_commands, "block-job-resume");
+    qmp_unregister_command(&qmp_commands, "block-job-complete");
+    qmp_unregister_command(&qmp_commands, "query-block-jobs");
+#endif
 }
 
 void monitor_init_qmp_commands(void)
-- 
2.9.5
