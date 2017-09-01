Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUq-0000PK-GT
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUj-0007N6-QQ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUj-0007Lb-C2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:51 +0200
Message-Id: <20170901125611.29295-28-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/47] qapi-schema: Move block events from
 event.json to block.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>

Cc: Alberto Garcia <berto@igalia.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-13-git-send-email-armbru@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/block.json | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 qapi/event.json | 68 ---------------------------------------------------=
------
 2 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 414b61bde7..8ce335739f 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -277,3 +277,71 @@
 ##
 { 'enum': 'QuorumOpType',
   'data': [ 'read', 'write', 'flush' ] }
+
+##
+# @QUORUM_FAILURE:
+#
+# Emitted by the Quorum block driver if it fails to establish a quorum
+#
+# @reference: device name if defined else node name
+#
+# @sector-num: number of the first sector of the failed read operation
+#
+# @sectors-count: failed read operation sector count
+#
+# Note: This event is rate-limited.
+#
+# Since: 2.0
+#
+# Example:
+#
+# <- { "event": "QUORUM_FAILURE",
+#      "data": { "reference": "usr1", "sector-num": 345435, "sectors-cou=
nt": 5 },
+#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+##
+{ 'event': 'QUORUM_FAILURE',
+  'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'i=
nt' } }
+
+##
+# @QUORUM_REPORT_BAD:
+#
+# Emitted to report a corruption of a Quorum file
+#
+# @type: quorum operation type (Since 2.6)
+#
+# @error: error message. Only present on failure. This field
+#         contains a human-readable error message. There are no semantic=
s other
+#         than that the block layer reported an error and clients should=
 not
+#         try to interpret the error string.
+#
+# @node-name: the graph node name of the block driver state
+#
+# @sector-num: number of the first sector of the failed read operation
+#
+# @sectors-count: failed read operation sector count
+#
+# Note: This event is rate-limited.
+#
+# Since: 2.0
+#
+# Example:
+#
+# 1. Read operation
+#
+# { "event": "QUORUM_REPORT_BAD",
+#      "data": { "node-name": "node0", "sector-num": 345435, "sectors-co=
unt": 5,
+#                "type": "read" },
+#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+# 2. Flush operation
+#
+# { "event": "QUORUM_REPORT_BAD",
+#      "data": { "node-name": "node0", "sector-num": 0, "sectors-count":=
 2097120,
+#                "type": "flush", "error": "Broken pipe" },
+#      "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
+#
+##
+{ 'event': 'QUORUM_REPORT_BAD',
+  'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
+            'sector-num': 'int', 'sectors-count': 'int' } }
diff --git a/qapi/event.json b/qapi/event.json
index a043de4cd8..48a5d8fb21 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -92,74 +92,6 @@
   'data': { 'actual': 'int' } }
=20
 ##
-# @QUORUM_FAILURE:
-#
-# Emitted by the Quorum block driver if it fails to establish a quorum
-#
-# @reference: device name if defined else node name
-#
-# @sector-num: number of the first sector of the failed read operation
-#
-# @sectors-count: failed read operation sector count
-#
-# Note: This event is rate-limited.
-#
-# Since: 2.0
-#
-# Example:
-#
-# <- { "event": "QUORUM_FAILURE",
-#      "data": { "reference": "usr1", "sector-num": 345435, "sectors-cou=
nt": 5 },
-#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
-#
-##
-{ 'event': 'QUORUM_FAILURE',
-  'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'i=
nt' } }
-
-##
-# @QUORUM_REPORT_BAD:
-#
-# Emitted to report a corruption of a Quorum file
-#
-# @type: quorum operation type (Since 2.6)
-#
-# @error: error message. Only present on failure. This field
-#         contains a human-readable error message. There are no semantic=
s other
-#         than that the block layer reported an error and clients should=
 not
-#         try to interpret the error string.
-#
-# @node-name: the graph node name of the block driver state
-#
-# @sector-num: number of the first sector of the failed read operation
-#
-# @sectors-count: failed read operation sector count
-#
-# Note: This event is rate-limited.
-#
-# Since: 2.0
-#
-# Example:
-#
-# 1. Read operation
-#
-# { "event": "QUORUM_REPORT_BAD",
-#      "data": { "node-name": "node0", "sector-num": 345435, "sectors-co=
unt": 5,
-#                "type": "read" },
-#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
-#
-# 2. Flush operation
-#
-# { "event": "QUORUM_REPORT_BAD",
-#      "data": { "node-name": "node0", "sector-num": 0, "sectors-count":=
 2097120,
-#                "type": "flush", "error": "Broken pipe" },
-#      "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
-#
-##
-{ 'event': 'QUORUM_REPORT_BAD',
-  'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
-            'sector-num': 'int', 'sectors-count': 'int' } }
-
-##
 # @MEM_UNPLUG_ERROR:
 #
 # Emitted when memory hot unplug error occurs.
--=20
2.13.5
