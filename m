Received: from eggs.gnu.org ([2001:4830:134:3::10]:35188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWI-0005a6-Hy
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWH-0002so-Kc
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  2 Mar 2017 22:44:06 +0100
Message-Id: <1488491046-2549-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 15/15] sheepdog: Support blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/block-core.json | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 28f1b10..3b1e4ad 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2111,6 +2111,7 @@
 # @replication: Since 2.8
 # @ssh: Since 2.8
 # @iscsi: Since 2.9
+# @sheepdog: Since 2.9
 #
 # Since: 2.0
 ##
@@ -2119,8 +2120,8 @@
             'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
             'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
             'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed',
-            'quorum', 'raw', 'replication', 'ssh', 'vdi', 'vhdx', 'vmdk',
-            'vpc', 'vvfat' ] }
+            'quorum', 'raw', 'replication', 'sheepdog', 'ssh', 'vdi',
+            'vhdx', 'vmdk', 'vpc', 'vvfat' ] }
 
 ##
 # @BlockdevOptionsFile:
@@ -2622,6 +2623,26 @@
             '*timeout': 'int' } }
 
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
@@ -2821,7 +2842,7 @@
       'raw':        'BlockdevOptionsRaw',
 # TODO rbd: Wait for structured options
       'replication':'BlockdevOptionsReplication',
-# TODO sheepdog: Wait for structured options
+      'sheepdog':   'BlockdevOptionsSheepdog',
       'ssh':        'BlockdevOptionsSsh',
       'vdi':        'BlockdevOptionsGenericFormat',
       'vhdx':       'BlockdevOptionsGenericFormat',
-- 
2.7.4
