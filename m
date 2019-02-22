Received: from eggs.gnu.org ([209.51.188.92]:34801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCHG-0000QT-TW
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCF7-0007kU-EP
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gxCF7-0006j9-2x
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:01 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Feb 2019 22:55:15 +0800
Message-Id: <1550847320-25110-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] qmp: Add announce-self command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Add a qmp command that can trigger guest announcements.

It uses its own announce-timer instance, and parameters
passed to it explicitly in the command.

Like most qmp commands, it's in the main thread/bql, so
there's no racing with any outstanding timer.

Based on work of Germano Veit Michel <germano@redhat.com> and
                 Vladislav Yasevich <vyasevic@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/announce.c |  7 +++++++
 qapi/net.json  | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/announce.c b/net/announce.c
index 070f37a..91e9a6e 100644
--- a/net/announce.c
+++ b/net/announce.c
@@ -12,6 +12,7 @@
 #include "net/net.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-visit-net.h"
+#include "qapi/qapi-commands-net.h"
 #include "trace.h"
 
 int64_t qemu_announce_timer_step(AnnounceTimer *timer)
@@ -131,3 +132,9 @@ void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *params)
         qemu_announce_timer_del(timer);
     }
 }
+
+void qmp_announce_self(AnnounceParameters *params, Error **errp)
+{
+    static AnnounceTimer announce_timer;
+    qemu_announce_self(&announce_timer, params);
+}
diff --git a/qapi/net.json b/qapi/net.json
index 5face0c..c093087 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -707,3 +707,23 @@
             'max': 'int',
             'rounds': 'int',
             'step': 'int' } }
+
+##
+# @announce-self:
+#
+# Trigger generation of broadcast RARP frames to update network switches.
+# This can be useful when network bonds fail-over the active slave.
+#
+# @params: AnnounceParameters giving timing and repetition count of announce
+#
+# Example:
+#
+# -> { "execute": "announce-self"
+#      "arguments": { "params:" {
+#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } } }
+# <- { "return": {} }
+#
+# Since: 4.0
+##
+{ 'command': 'announce-self',
+  'data' : {'params': 'AnnounceParameters'} }
-- 
2.5.0
