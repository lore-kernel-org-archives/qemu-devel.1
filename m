Received: from eggs.gnu.org ([2001:4830:134:3::10]:49302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJJ-0007dd-7d
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ2-00045x-Hi
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:13 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:51 +0200
Message-Id: <1502117160-24655-48-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 47/56] blockjob: Make BlockJobInfo and
 event offsets unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

File offsets should use QAPI type 'size' (uint64_t).  BlockJobInfo
members @len, offset and parameters @len, @offset of events
BLOCK_JOB_COMPLETED, BLOCK_JOB_CANCELLED, BLOCK_JOB_READY are 'int'
(int64_t).  block_job_query(), block_job_event_completed(),
block_job_event_cancelled(), block_job_event_ready() get them from
BlockJob members @len and @offset, which are int64_t, but should never
be negative.

Change the BlockJobInfo members and the event parameters to 'size',
for QAPI/QMP consistency.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                |  8 ++++----
 qapi/block-core.json | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hmp.c b/hmp.c
index fae974e..867c50b 100644
--- a/hmp.c
+++ b/hmp.c
@@ -966,16 +966,16 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
 
     while (list) {
         if (strcmp(list->value->type, "stream") == 0) {
-            monitor_printf(mon, "Streaming device %s: Completed %" PRId64
-                           " of %" PRId64 " bytes, speed limit %" PRIu64
+            monitor_printf(mon, "Streaming device %s: Completed %" PRIu64
+                           " of %" PRIu64 " bytes, speed limit %" PRIu64
                            " bytes/s\n",
                            list->value->device,
                            list->value->offset,
                            list->value->len,
                            list->value->speed);
         } else {
-            monitor_printf(mon, "Type %s, device %s: Completed %" PRId64
-                           " of %" PRId64 " bytes, speed limit %" PRIu64
+            monitor_printf(mon, "Type %s, device %s: Completed %" PRIu64
+                           " of %" PRIu64 " bytes, speed limit %" PRIu64
                            " bytes/s\n",
                            list->value->type,
                            list->value->device,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9e9f2d8..b8442f3 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -955,8 +955,8 @@
 # Since: 1.1
 ##
 { 'struct': 'BlockJobInfo',
-  'data': {'type': 'str', 'device': 'str', 'len': 'int',
-           'offset': 'int', 'busy': 'bool', 'paused': 'bool',
+  'data': {'type': 'str', 'device': 'str', 'len': 'size',
+           'offset': 'size', 'busy': 'bool', 'paused': 'bool',
            'speed': 'size',
            'io-status': 'BlockDeviceIoStatus', 'ready': 'bool'} }
 
@@ -3606,8 +3606,8 @@
 { 'event': 'BLOCK_JOB_COMPLETED',
   'data': { 'type'  : 'BlockJobType',
             'device': 'str',
-            'len'   : 'int',
-            'offset': 'int',
+            'len'   : 'size',
+            'offset': 'size',
             'speed' : 'size',
             '*error': 'str' } }
 
@@ -3642,8 +3642,8 @@
 { 'event': 'BLOCK_JOB_CANCELLED',
   'data': { 'type'  : 'BlockJobType',
             'device': 'str',
-            'len'   : 'int',
-            'offset': 'int',
+            'len'   : 'size',
+            'offset': 'size',
             'speed' : 'size' } }
 
 ##
@@ -3707,8 +3707,8 @@
 { 'event': 'BLOCK_JOB_READY',
   'data': { 'type'  : 'BlockJobType',
             'device': 'str',
-            'len'   : 'int',
-            'offset': 'int',
+            'len'   : 'size',
+            'offset': 'size',
             'speed' : 'size' } }
 
 ##
-- 
2.7.5
