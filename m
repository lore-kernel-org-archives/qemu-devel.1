Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF9-0002eI-CP
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF8-0002zE-HS
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:43 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:49 +0100
Message-Id: <1488901251-16214-26-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 25/27] sheepdog: Support blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d63be0a..9bb7f4a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2124,6 +2124,7 @@
 # @ssh: Since 2.8
 # @iscsi: Since 2.9
 # @rbd: Since 2.9
+# @sheepdog: Since 2.9
 #
 # Since: 2.0
 ##
@@ -2132,8 +2133,8 @@
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
-            'quorum', 'raw', 'rbd', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
-            'vpc', 'vvfat' ] }
+            'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
+            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -2692,6 +2693,26 @@
             '*password-secret': 'str' } }
 
 ##
+# @BlockdevOptionsSheepdog:
+#
+# Driver specific block device options for sheepdog
+#
+# @vdi:         Virtual disk image name
+# @addr:        The Sheepdog server to connect to
+# @snap-id:     Snapshot ID
+# @tag:         Snapshot tag name
+#
+# Only one of @snap-id and @tag may be present.
+#
+# Since: 2.9
+##
+{ 'struct': 'BlockdevOptionsSheepdog',
+  'data': { 'addr': 'SocketAddressFlat',
+            'vdi': 'str',
+            '*snap-id': 'uint32',
+            '*tag': 'str' } }
+
+##
 # @ReplicationMode:
 #
 # An enumeration of replication modes.
@@ -2891,7 +2912,7 @@
       'raw':        'BlockdevOptionsRaw',
       'rbd':        'BlockdevOptionsRbd',
       'replication':'BlockdevOptionsReplication',
-# TODO sheepdog: Wait for structured options
+      'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
       'vdi':        'BlockdevOptionsGenericFormat',
       'vhdx':       'BlockdevOptionsGenericFormat',
-- 
1.8.3.1
