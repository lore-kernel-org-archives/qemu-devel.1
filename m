Received: from eggs.gnu.org ([2001:4830:134:3::10]:40256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI9-0006Me-Rq
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI8-0006Ui-Ek
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:31 -0400
Message-Id: <20180512012537.22478-7-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 06/12] qapi: add bitmap info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

Add some of the necessary scaffolding for reporting bitmap information.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c50517bff3..8f33f41ce7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -33,6 +33,61 @@
             'date-sec': 'int', 'date-nsec': 'int',
             'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
 
+##
+# @BitmapTypeEnum:
+#
+# An enumeration of possible serialized bitmap types.
+#
+# @dirty-tracking: This bitmap records information on dirty
+#                  segments within the file.
+#
+# @unknown: This bitmap is of an unknown or reserved type.
+#
+# Since: 2.13
+##
+{ 'enum': 'BitmapTypeEnum', 'data': [ 'dirty-tracking', 'unknown' ] }
+
+##
+# @BitmapFlagEnum:
+#
+# An enumeration of possible flags for serialized bitmaps.
+#
+# @in-use: This bitmap is considered to be in-use, and may now be inconsistent.
+#
+# @auto: This bitmap must reflect any and all changes to the file it describes.
+#        The type of this bitmap must be @DirtyTrackingBitmap.
+#
+# @extra-data-compatible: This bitmap has extra information associated with it.
+#
+# @unknown: This bitmap has unknown or reserved properties.
+#
+# Since: 2.13
+##
+{ 'enum': 'BitmapFlagEnum', 'data': [ 'in-use', 'auto',
+                                      'extra-data-compatible', 'unknown' ] }
+
+##
+# @BitmapInfo:
+#
+# @name: The name of the bitmap.
+#
+# @type: The type of bitmap.
+#
+# @granularity: Bitmap granularity, in bytes.
+#
+# @count: Overall bitmap dirtiness, in bytes.
+#
+# @flags: Bitmap flags, if any.
+#
+# Since: 2.13
+#
+##
+{ 'struct': 'BitmapInfo',
+  'data': { 'name': 'str', 'type': 'BitmapTypeEnum', 'granularity': 'int',
+            'count': 'int', '*flags': ['BitmapFlagEnum']
+  }
+}
+
 ##
 # @ImageInfoSpecificQCow2EncryptionBase:
 #
@@ -69,6 +124,8 @@
 # @encrypt: details about encryption parameters; only set if image
 #           is encrypted (since 2.10)
 #
+# @bitmaps: list of image bitmaps (since 2.13)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -77,7 +134,8 @@
       '*lazy-refcounts': 'bool',
       '*corrupt': 'bool',
       'refcount-bits': 'int',
-      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
+      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
+      '*bitmaps': ['BitmapInfo']
   } }
 
 ##
-- 
2.14.3
