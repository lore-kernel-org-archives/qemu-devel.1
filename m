Received: from eggs.gnu.org ([2001:4830:134:3::10]:59854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1cc7hk-0003XY-Q3
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1cc7hg-00037i-S4
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:41:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1cc7hg-00037F-Ml
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:41:20 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC55C201FB
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 09:41:19 +0000 (UTC)
From: Pavel Hrdina <phrdina@redhat.com>
Date: Fri, 10 Feb 2017 10:41:17 +0100
Message-Id: <3163c16d6ab4257f7be9ad44fe9cc0ce8c359e5a.1486718555.git.phrdina@redhat.com>
Subject: [Qemu-devel] [PATCH] monitor: add poll-* properties into
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
Cc: dgilbert@redhat.com, eblake@redhat.com, armbru@redhat.com

IOthreads were recently extended by new properties that can
enable/disable and configure aio polling.  This will also allow
other tools that uses QEMU to probe for existence of those new
properties via query-qmp-schema.

Signed-off-by: Pavel Hrdina <phrdina@redhat.com>
---

The other possible way would be to introduce object-list-properties
which I think would be good in general for the same reason why
device-list-properties exists.

 hmp.c            |  9 +++++++--
 iothread.c       |  3 +++
 qapi-schema.json | 15 ++++++++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index 2bc4f062bb..d713151cbc 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2148,10 +2148,15 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
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
index 257b01d5f1..beeb870534 100644
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
index cbdffddbc6..a97a054c81 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1422,10 +1422,23 @@
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
2.11.1
