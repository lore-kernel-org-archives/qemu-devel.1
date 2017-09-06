Received: from eggs.gnu.org ([2001:4830:134:3::10]:51421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpYRx-0001aH-Bn
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:24:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpYRv-0005Du-HL
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:24:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpYRv-0005Db-Bq
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 07:24:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79D3220276
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 11:24:50 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Wed,  6 Sep 2017 13:24:40 +0200
Message-Id: <6f78df0d8af98d89bdae1d189c0e21ba7ca3ead9.1504696921.git.mprivozn@redhat.com>
In-Reply-To: <cover.1504696921.git.mprivozn@redhat.com>
References: <cover.1504696921.git.mprivozn@redhat.com>
In-Reply-To: <cover.1504696921.git.mprivozn@redhat.com>
References: <cover.1504696921.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/3] watchdog: Allow setting action on the
 fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, eblake@redhat.com

Currently, the only time that users can set watchdog action is at
the start as all we expose is this -watchdog-action command line
argument. This is suboptimal when users want to plug the device
later via monitor. Alternatively, they might want to change the
action for already existing device on the fly.

Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1447169

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 hw/watchdog/watchdog.c | 8 +++++++-
 qapi-schema.json       | 9 +++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 547a49a1e4..c49a069cbc 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -29,6 +29,7 @@
 #include "qapi-event.h"
 #include "hw/nmi.h"
 #include "qemu/help_option.h"
+#include "qmp-commands.h"
 
 static WatchdogAction watchdog_action = WATCHDOG_ACTION_RESET;
 static QLIST_HEAD(watchdog_list, WatchdogTimerModel) watchdog_list;
@@ -82,7 +83,7 @@ int select_watchdog_action(const char *p)
     action = qapi_enum_parse(&WatchdogAction_lookup, p, -1, NULL);
     if (action < 0)
         return -1;
-    watchdog_action = action;
+    qmp_watchdog_set_action(action, &error_abort);
     return 0;
 }
 
@@ -139,3 +140,8 @@ void watchdog_perform_action(void)
         assert(0);
     }
 }
+
+void qmp_watchdog_set_action(WatchdogAction action, Error **errp)
+{
+    watchdog_action = action;
+}
diff --git a/qapi-schema.json b/qapi-schema.json
index f3af2cb851..f5db401838 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3143,3 +3143,12 @@
 # Since 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
+##
+# @watchdog-set-action:
+#
+# Set watchdog action
+#
+# Since 2.11
+##
+{ 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
-- 
2.13.5
