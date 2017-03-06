Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsT-000489-Aa
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsS-0004lS-2Y
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:01 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 20:00:49 +0100
Message-Id: <1488826849-32384-16-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-1-git-send-email-armbru@redhat.com>
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/15] sheepdog: Support blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
2.7.4
