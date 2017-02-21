Received: from eggs.gnu.org ([2001:4830:134:3::10]:37235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgFb4-0007Eq-A0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cgFb3-0006r8-DC
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cgFb3-0006qH-4V
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 13:55:33 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27D98C04B956
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 18:55:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 21 Feb 2017 18:55:26 +0000
Message-Id: <20170221185527.3901-3-dgilbert@redhat.com>
In-Reply-To: <20170221185527.3901-1-dgilbert@redhat.com>
References: <20170221185527.3901-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] monitor: add poll-* properties into
 query-iothreads result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, phrdina@redhat.com, thuth@redhat.com

From: Pavel Hrdina <phrdina@redhat.com>

IOthreads were recently extended by new properties that can
enable/disable and configure aio polling.  This will also allow
other tools that uses QEMU to probe for existence of those new
properties via query-qmp-schema.

Signed-off-by: Pavel Hrdina <phrdina@redhat.com>
Message-Id: <3163c16d6ab4257f7be9ad44fe9cc0ce8c359e5a.1486718555.git.phrdina@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c            |  9 +++++++--
 iothread.c       |  3 +++
 qapi-schema.json | 15 ++++++++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 0c80596..8b0c2b0 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2149,10 +2149,15 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
 {
     IOThreadInfoList *info_list = qmp_query_iothreads(NULL);
     IOThreadInfoList *info;
+    IOThreadInfo *value;
 
     for (info = info_list; info; info = info->next) {
-        monitor_printf(mon, "%s: thread_id=%" PRId64 "\n",
-                       info->value->id, info->value->thread_id);
+        value = info->value;
+        monitor_printf(mon, "%s:\n", value->id);
+        monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
+        monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
+        monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
+        monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
     }
 
     qapi_free_IOThreadInfoList(info_list);
diff --git a/iothread.c b/iothread.c
index 257b01d..beeb870 100644
--- a/iothread.c
+++ b/iothread.c
@@ -268,6 +268,9 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->poll_max_ns = iothread->poll_max_ns;
+    info->poll_grow = iothread->poll_grow;
+    info->poll_shrink = iothread->poll_shrink;
 
     elem = g_new0(IOThreadInfoList, 1);
     elem->value = info;
diff --git a/qapi-schema.json b/qapi-schema.json
index e9a6364..f6ca18c 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1427,10 +1427,23 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @poll-max-ns: maximum polling time in ns, 0 means polling is disabled
+#               (since 2.9)
+#
+# @poll-grow: how many ns will be added to polling time, 0 means that it's not
+#             configured (since 2.9)
+#
+# @poll-shrink: how many ns will be removed from polling time, 0 means that
+#               it's not configured (since 2.9)
+#
 # Since: 2.0
 ##
 { 'struct': 'IOThreadInfo',
-  'data': {'id': 'str', 'thread-id': 'int'} }
+  'data': {'id': 'str',
+           'thread-id': 'int',
+           'poll-max-ns': 'int',
+           'poll-grow': 'int',
+           'poll-shrink': 'int' } }
 
 ##
 # @query-iothreads:
-- 
2.9.3
