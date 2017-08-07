Received: from eggs.gnu.org ([2001:4830:134:3::10]:49099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJA-0007Rd-3k
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIu-0003ym-GP
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:41 +0200
Message-Id: <1502117160-24655-38-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 37/56] blockjob: Make BlockJobInfo and
 event speed unsigned in QAPI/QMP
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

Byte rates should use QAPI type 'size' (uint64_t).  BlockJobInfo
member @speed and parameter @speed of events BLOCK_JOB_COMPLETED,
BLOCK_JOB_CANCELLED, BLOCK_JOB_READY are 'int' (int64_t).

block_job_query(), block_job_event_completed(),
block_job_event_cancelled(), block_job_event_ready() all get it from
BlockJob member @speed, implicitly converting from uint64_t (since the
commit before previous).  The conversion is safe, because
block_job_set_speed() won't set speeds above INT_MAX.

Change the BlockJobInfo member and the event parameters to 'size', for
QAPI/QMP consistency.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hmp.c                | 4 ++--
 qapi/block-core.json | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hmp.c b/hmp.c
index ecacb7f..fae974e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -967,7 +967,7 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
     while (list) {
         if (strcmp(list->value->type, "stream") == 0) {
             monitor_printf(mon, "Streaming device %s: Completed %" PRId64
-                           " of %" PRId64 " bytes, speed limit %" PRId64
+                           " of %" PRId64 " bytes, speed limit %" PRIu64
                            " bytes/s\n",
                            list->value->device,
                            list->value->offset,
@@ -975,7 +975,7 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
                            list->value->speed);
         } else {
             monitor_printf(mon, "Type %s, device %s: Completed %" PRId64
-                           " of %" PRId64 " bytes, speed limit %" PRId64
+                           " of %" PRId64 " bytes, speed limit %" PRIu64
                            " bytes/s\n",
                            list->value->type,
                            list->value->device,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1d68669..ceaab43 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -956,7 +956,8 @@
 ##
 { 'struct': 'BlockJobInfo',
   'data': {'type': 'str', 'device': 'str', 'len': 'int',
-           'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
+           'offset': 'int', 'busy': 'bool', 'paused': 'bool',
+           'speed': 'size',
            'io-status': 'BlockDeviceIoStatus', 'ready': 'bool'} }
 
 ##
@@ -3607,7 +3608,7 @@
             'device': 'str',
             'len'   : 'int',
             'offset': 'int',
-            'speed' : 'int',
+            'speed' : 'size',
             '*error': 'str' } }
 
 ##
@@ -3643,7 +3644,7 @@
             'device': 'str',
             'len'   : 'int',
             'offset': 'int',
-            'speed' : 'int' } }
+            'speed' : 'size' } }
 
 ##
 # @BLOCK_JOB_ERROR:
@@ -3708,7 +3709,7 @@
             'device': 'str',
             'len'   : 'int',
             'offset': 'int',
-            'speed' : 'int' } }
+            'speed' : 'size' } }
 
 ##
 # @PreallocMode:
-- 
2.7.5
