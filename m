Received: from eggs.gnu.org ([2001:4830:134:3::10]:47213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyyd3-00057R-1g
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyyd0-0001bh-VX
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyyd0-0001at-Q3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:11:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF1F2356D7
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 11:11:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 13:11:11 +0200
Message-Id: <20171002111111.26932-4-armbru@redhat.com>
In-Reply-To: <20171002111111.26932-1-armbru@redhat.com>
References: <20171002111111.26932-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 3/3] watchdog: Allow setting action on the fly
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
List-ID: <qemu-devel.nongnu.org>

From: Michal Privoznik <mprivozn@redhat.com>

Currently, the only time that users can set watchdog action is at
the start as all we expose is this -watchdog-action command line
argument. This is suboptimal when users want to plug the device
later via monitor. Alternatively, they might want to change the
action for already existing device on the fly.

Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1447169

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
Message-Id: <35d6ce6fe3d357122d73b8272bc8198134c74104.1504771369.git.mprivozn@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
[Missing colon in doc comment fixed]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/watchdog/watchdog.c | 8 +++++++-
 qapi-schema.json       | 9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 0d3eeed187..670114ecfe 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -29,6 +29,7 @@
 #include "qapi-event.h"
 #include "hw/nmi.h"
 #include "qemu/help_option.h"
+#include "qmp-commands.h"
 
 static WatchdogAction watchdog_action = WATCHDOG_ACTION_RESET;
 static QLIST_HEAD(watchdog_list, WatchdogTimerModel) watchdog_list;
@@ -85,7 +86,7 @@ int select_watchdog_action(const char *p)
     g_free(qapi_value);
     if (action < 0)
         return -1;
-    watchdog_action = action;
+    qmp_watchdog_set_action(action, &error_abort);
     return 0;
 }
 
@@ -142,3 +143,8 @@ void watchdog_perform_action(void)
         assert(0);
     }
 }
+
+void qmp_watchdog_set_action(WatchdogAction action, Error **errp)
+{
+    watchdog_action = action;
+}
diff --git a/qapi-schema.json b/qapi-schema.json
index a3ba1c9a1c..a9dd043f65 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3191,3 +3191,12 @@
 # Since 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
+##
+# @watchdog-set-action:
+#
+# Set watchdog action
+#
+# Since: 2.11
+##
+{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
-- 
2.13.6
