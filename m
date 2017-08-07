Received: from eggs.gnu.org ([2001:4830:134:3::10]:49310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJJ-0007fG-K4
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJ4-00047H-9J
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:13 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:57 +0200
Message-Id: <1502117160-24655-54-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 53/56] block: Make blockdev-add byte counts
 unsigned in QAPI/QMP
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

File offsets, sizes and alignments should use QAPI type 'size'
(uint64_t).  blockdev-add parameters are 'int' (int64_t):
BlockdevOptionsNull member @size; BlockdevOptionsQcow2 members
@cache-size, @l2-cache-size, @refcount-cache-size; BlockdevOptionsNfs
members @readahead-size, @page-cache-size; BlockdevOptionsCurlBase
member @readahead; BlockdevOptionsRaw members @offset, @size.

The block drivers get their values with qemu_opt_get_size(), which
returns uint64_t.  They store them in uint64_t variables, except for
the null driver, which stores in BDRVNullState member int64_t length.

Change these BlockdevOptionsFOO members to 'size'.

Change BDRVNullState member length to uint64_t.  This moves the
implicit conversion to int64_t from null_file_open() to
null_getlength().  No worse than before.

blockdev-add and -blockdev now accept values between 2^63 and 2^64-1.
They accept negative values as before, because that's how the QObject
input visitor works for backward compatibility.

Values above 2^63 are unlikely to actually work; the block subsystem
isn't prepared for them.  Again, no worse than before.

Aside: we call the same thing @readahead-size in one place, and
@readahead in another place.  Sad.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/null.c         |  2 +-
 qapi/block-core.json | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/null.c b/block/null.c
index 876f909..2ab0e70 100644
--- a/block/null.c
+++ b/block/null.c
@@ -20,7 +20,7 @@
 #define NULL_OPT_ZEROES  "read-zeroes"
 
 typedef struct {
-    int64_t length;
+    uint64_t length;
     int64_t latency_ns;
     bool read_zeroes;
 } BDRVNullState;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 64b84a5..3482f8c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2189,7 +2189,7 @@
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNull',
-  'data': { '*size': 'int', '*latency-ns': 'uint64' } }
+  'data': { '*size': 'size', '*latency-ns': 'uint64' } }
 
 ##
 # @BlockdevOptionsVVFAT:
@@ -2421,9 +2421,9 @@
             '*pass-discard-snapshot': 'bool',
             '*pass-discard-other': 'bool',
             '*overlap-check': 'Qcow2OverlapChecks',
-            '*cache-size': 'int',
-            '*l2-cache-size': 'int',
-            '*refcount-cache-size': 'int',
+            '*cache-size': 'size',
+            '*l2-cache-size': 'size',
+            '*refcount-cache-size': 'size',
             '*cache-clean-interval': 'int',
             '*encrypt': 'BlockdevQcow2Encryption' } }
 
@@ -2568,9 +2568,9 @@
 { 'struct': 'BlockdevOptionsBlkdebug',
   'data': { 'image': 'BlockdevRef',
             '*config': 'str',
-            '*align': 'int', '*max-transfer': 'int32',
-            '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
-            '*opt-discard': 'int32', '*max-discard': 'int32',
+            '*align': 'size', '*max-transfer': 'size',
+            '*opt-write-zero': 'size', '*max-write-zero': 'size',
+            '*opt-discard': 'size', '*max-discard': 'size',
             '*inject-error': ['BlkdebugInjectErrorOptions'],
             '*set-state': ['BlkdebugSetStateOptions'] } }
 
@@ -2862,8 +2862,8 @@
             '*user': 'int',
             '*group': 'int',
             '*tcp-syn-count': 'int',
-            '*readahead-size': 'int',
-            '*page-cache-size': 'int',
+            '*readahead-size': 'size',
+            '*page-cache-size': 'size',
             '*debug': 'int' } }
 
 ##
@@ -2893,7 +2893,7 @@
 ##
 { 'struct': 'BlockdevOptionsCurlBase',
   'data': { 'url': 'str',
-            '*readahead': 'int',
+            '*readahead': 'size',
             '*timeout': 'int',
             '*username': 'str',
             '*password-secret': 'str',
@@ -3001,7 +3001,7 @@
 ##
 { 'struct': 'BlockdevOptionsRaw',
   'base': 'BlockdevOptionsGenericFormat',
-  'data': { '*offset': 'int', '*size': 'int' } }
+  'data': { '*offset': 'size', '*size': 'size' } }
 
 ##
 # @BlockdevOptionsVxHS:
-- 
2.7.5
