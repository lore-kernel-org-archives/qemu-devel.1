Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd39-0002EZ-IU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYd38-0000dN-Ac
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:51 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYd38-0000bS-4T
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 15:57:50 -0400
Received: by mail-wm0-x233.google.com with SMTP id n17-v6so9744001wmh.2
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 12:57:49 -0700 (PDT)
Received: from 640k.lan ([82.84.124.111]) by smtp.gmail.com with ESMTPSA id
	d102-v6sm12516646wma.10.2018.06.28.12.57.47
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 Jun 2018 12:57:48 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 21:57:38 +0200
Message-Id: <1530215858-1525-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
References: <1530215858-1525-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] pr-manager-helper: report event on
 connection/disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Let management know if there were any problems communicating with
qemu-pr-helper.  The event is edge-triggered, and is sent every time
the connection status of the pr-manager-helper object changes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/block.json          | 24 ++++++++++++++++++++++++
 scsi/pr-manager-helper.c | 14 ++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/qapi/block.json b/qapi/block.json
index 8765c29..11f01f2 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -359,6 +359,30 @@
   'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
 
 ##
+# @PR_MANAGER_STATUS_CHANGED:
+#
+# Emitted whenever the connected status of a persistent reservation
+# manager changes.
+#
+# @id: The id of the PR manager object
+#
+# @connected: true if the PR manager is connected to a backend
+#
+# Since: 3.0
+#
+# Example:
+#
+# <- { "event": "PR_MANAGER_STATUS_CHANGED",
+#      "data": { "id": "pr-helper0",
+#                "connected": true
+#      },
+#      "timestamp": { "seconds": 1519840375, "microseconds": 450486 } }
+#
+##
+{ 'event': 'PR_MANAGER_STATUS_CHANGED',
+  'data': { 'id': 'str', 'connected': 'bool' } }
+
+##
 # @QuorumOpType:
 #
 # An enumeration of the quorum operation types
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index b11481b..519a296 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -17,6 +17,7 @@
 #include "io/channel.h"
 #include "io/channel-socket.h"
 #include "pr-helper.h"
+#include "qapi/qapi-events-block.h"
 
 #include <scsi/sg.h>
 
@@ -38,6 +39,16 @@ typedef struct PRManagerHelper {
     QIOChannel *ioc;
 } PRManagerHelper;
 
+static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
+{
+    char *id = object_get_canonical_path_component(OBJECT(pr_mgr));
+
+    if (id) {
+        qapi_event_send_pr_manager_status_changed(id, !!pr_mgr->ioc,
+                                                  &error_abort);
+    }
+}
+
 /* Called with lock held.  */
 static int pr_manager_helper_read(PRManagerHelper *pr_mgr,
                                   void *buf, int sz, Error **errp)
@@ -47,6 +58,7 @@ static int pr_manager_helper_read(PRManagerHelper *pr_mgr,
     if (r < 0) {
         object_unref(OBJECT(pr_mgr->ioc));
         pr_mgr->ioc = NULL;
+        pr_manager_send_status_changed_event(pr_mgr);
         return -EINVAL;
     }
 
@@ -72,6 +84,7 @@ static int pr_manager_helper_write(PRManagerHelper *pr_mgr,
             assert(n_written != QIO_CHANNEL_ERR_BLOCK);
             object_unref(OBJECT(pr_mgr->ioc));
             pr_mgr->ioc = NULL;
+            pr_manager_send_status_changed_event(pr_mgr);
             return n_written < 0 ? -EINVAL : 0;
         }
 
@@ -127,6 +140,7 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
         goto out_close;
     }
 
+    pr_manager_send_status_changed_event(pr_mgr);
     return 0;
 
 out_close:
-- 
1.8.3.1
