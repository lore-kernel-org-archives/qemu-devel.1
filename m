Received: from eggs.gnu.org ([2001:4830:134:3::10]:57562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejrnm-0002pP-2r
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ejrnk-0000l7-RT
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:24:10 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Feb 2018 20:23:03 +0100
Message-Id: <20180208192328.16550-3-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-1-kwolf@redhat.com>
References: <20180208192328.16550-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 02/27] block/qapi: Add qcow2 create options to
 schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b59b1430bb..aade602a04 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3338,6 +3338,49 @@
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
 
 ##
+# @BlockdevQcow2Version:
+#
+# @v2:  The original QCOW2 format as introduced in qemu 0.10 (version 2)
+# @v3:  The extended QCOW2 format as introduced in qemu 1.1 (version 3)
+#
+# Since: 2.12
+##
+{ 'enum': 'BlockdevQcow2Version',
+  'data': [ 'v2', 'v3' ] }
+
+
+##
+# @BlockdevCreateOptionsQcow2:
+#
+# Driver specific image creation options for qcow2.
+#
+# @file             Node to create the image format on
+# @size             Size of the virtual disk in bytes
+# @version          Compatibility level (default: v3)
+# @backing-file     File name of the backing file if a backing file
+#                   should be used
+# @backing-fmt      Name of the block driver to use for the backing file
+# @encrypt          Encryption options if the image should be encrypted
+# @cluster-size     qcow2 cluster size in bytes (default: 65536)
+# @preallocation    Preallocation mode for the new image (default: off)
+# @lazy-refcounts   True if refcounts may be updated lazily (default: off)
+# @refcount-bits    Width of reference counts in bits (default: 16)
+#
+# Since: 2.12
+##
+{ 'struct': 'BlockdevCreateOptionsQcow2',
+  'data': { 'file':             'BlockdevRef',
+            'size':             'size',
+            '*version':         'BlockdevQcow2Version',
+            '*backing-file':    'str',
+            '*backing-fmt':     'BlockdevDriver',
+            '*encrypt':         'QCryptoBlockCreateOptions',
+            '*cluster-size':    'size',
+            '*preallocation':   'PreallocMode',
+            '*lazy-refcounts':  'bool',
+            '*refcount-bits':   'int' } }
+
+##
 # @BlockdevCreateNotSupported:
 #
 # This is used for all drivers that don't support creating images.
@@ -3380,7 +3423,7 @@
       'null-aio':       'BlockdevCreateNotSupported',
       'null-co':        'BlockdevCreateNotSupported',
       'parallels':      'BlockdevCreateNotSupported',
-      'qcow2':          'BlockdevCreateNotSupported',
+      'qcow2':          'BlockdevCreateOptionsQcow2',
       'qcow':           'BlockdevCreateNotSupported',
       'qed':            'BlockdevCreateNotSupported',
       'quorum':         'BlockdevCreateNotSupported',
-- 
2.13.6
