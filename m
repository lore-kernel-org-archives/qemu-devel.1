Received: from eggs.gnu.org ([2001:4830:134:3::10]:46005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAz-0001OD-Hk
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSvAx-0001eo-Uo
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:06:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 12 Jun 2018 22:06:12 -0400
Message-Id: <20180613020613.1343-10-jsnow@redhat.com>
In-Reply-To: <20180613020613.1343-1-jsnow@redhat.com>
References: <20180613020613.1343-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/10] qapi: add bitmap info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

Add some of the necessary scaffolding for reporting bitmap information.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block-core.json | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index fff23fc82b..da82a82779 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -34,6 +34,65 @@
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
+# @unknown: This bitmap is an unknown/reserved type.
+#
+# Since: 3.0
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
+#
+# @extra-data-compatible: The extra data associated with this bitmap can be
+#                         safely ignored if it is opaque to the reader. If
+#                         this flag is absent while extra data is present and
+#                         opaque to the reader, the bitmap must not be used.
+#
+# @reserved: This bitmap has reserved flags set.
+#
+# Since: 3.0
+##
+{ 'enum': 'BitmapFlagEnum', 'data': [ 'in-use', 'auto',
+                                      'extra-data-compatible', 'reserved' ] }
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
+# @extra-data: True if this bitmap has extra data attached.
+#
+# @flags: Bitmap flags, if any.
+#
+# Since: 3.0
+#
+##
+{ 'struct': 'BitmapInfo',
+  'data': { 'name': 'str', 'type': 'BitmapTypeEnum', 'granularity': 'int',
+            'count': 'int', 'extra-data': 'bool', '*flags': ['BitmapFlagEnum']
+  }
+}
+
 ##
 # @ImageInfoSpecificQCow2EncryptionBase:
 #
@@ -70,6 +129,8 @@
 # @encrypt: details about encryption parameters; only set if image
 #           is encrypted (since 2.10)
 #
+# @bitmaps: list of image bitmaps (since 3.0)
+#
 # Since: 1.7
 ##
 { 'struct': 'ImageInfoSpecificQCow2',
@@ -78,7 +139,8 @@
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
